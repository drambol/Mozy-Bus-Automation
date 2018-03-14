module Email
  require 'gmail'
  require 'viewpoint'
  require 'gibberish'

  class GmailBox
    include Singleton

    def find_emails(query,_=nil)
      found = nil
      Gmail.new(CONFIGS['gmail']['username'],CONFIGS['gmail']['password']) do |gmail|
        found = gmail.mailbox('[Gmail]/All Mail').emails(query)
      end  #Returning after so the connection is closed properly
      found
    end

    def find_email_content(query,attach = nil)
      file_name = ''
      content = nil
      Gmail.new(CONFIGS['gmail']['username'],CONFIGS['gmail']['password']) do |gmail|
        content = gmail.mailbox('[Gmail]/All Mail').emails(query)[-1].body
        unless attach.nil?
          content.parts.attachments.each do |attachment|
            file_name = attachment.filename
            File.open("#{default_download_path}/" + attachment.filename,"w+") { |file|
              file.write(attachment.body.decoded)
            }
          end
        end
      end
      if attach.nil?
        return content
      else
        return file_name
      end
    end


    def count_licenses_from_email(email_body)
      #pu = past unactivated, d = desktop, s = server, u = unactivated, a = activated
      pu,du,da,su,sa = false,0,0,0,0
      email_body.to_s.each_line do |line|
        pu = true if line.include?("<span class='label'>Activated</span></div>")
        if line.include?("</td><td>Desktop</td></tr>")
          (pu ? da += line.scan('Desktop').length : du += line.scan('Desktop').length )
        elsif line.include?("</td><td>Server</td></tr>")
          (pu ? sa += line.scan('Server').length : su += line.scan('Server').length )
        end
      end
      #puts "du:#{du} su:#{su} da:#{da} sa:#{sa} pu:#{pu}"
      return [du,su,da,sa]
    end
  end

  class Outlook
    include Viewpoint::EWS
    include Singleton

    def initialize
      endpoint = CONFIGS['outlook']['endpoint']
      user = CONFIGS['outlook']['username']
      f = File.open(CONFIGS['outlook']['password'], 'r')
      encrypted = f.read
      f.close
      f = File.open(CONFIGS['rsa']['private_key'], 'r')
      private_key = f.read
      f.close
      cipher = Gibberish::RSA.new(private_key)
      pass = cipher.decrypt(encrypted)
      @client = Viewpoint::EWSClient.new endpoint, user, pass, server_version: SOAP::ExchangeWebService::VERSION_2010_SP1, http_opts: {ssl_verify_mode: 0}
      @inbox = @client.get_folder_by_name 'Inbox', :act_as => CONFIGS['outlook']['mailbox']
      @found = nil
    end

    def find_emails(query,_=nil)
      @found = []
      start = Time.now
      while Time.now - start < 90
        begin
          ten_minutes_ago = Time.now - 10*60
          Log.debug("Search email in outlook in the period from:#{ten_minutes_ago} to:#{Time.now}")
          items = @inbox.items_since(DateTime.parse(ten_minutes_ago.to_s))
          items.each {  |item|
            email = @client.get_item item.id
            query.each_index {|index| query[index]=query[index].downcase if index%2 == 0}
            # Log.info("=====================================================")
            # Log.info("From: " + email.from.email_address)
            # Log.info("To: " + (email.to_recipients.collect {|recipient| recipient.email_address}).join(', '))
            subject = email.subject
            # Log.info("Subject: " + email.subject)
            # first_name = "N/A"
            # first_name = email.body.to_s.split("Dear ")[1].split(" ")[0] if !email.body.to_s.match("Dear ").nil?
            # first_name = email.body.to_s.split("Hi, ")[1].split(":<")[0] if !email.body.to_s.match("Hi, ").nil?
            # Log.info("First Name: " + first_name)

            to_match = from_match = content_match = subject_match = true

            if query.include?('to')
              flag = false
              email.to_recipients.each {|recipient|
                if recipient.email_address.eql? query[query.index('to')+1]
                   flag = true
                   break
                end
              }
              to_match = flag
            end
            next if !to_match

            from_match = false if query.include?('from') && !(email.from.email_address.eql? query[query.index('from')+1])
            next if !from_match

            subject_match = false if query.include?('subject') && !(subject.include? query[query.index('subject')+1])
            next if !subject_match

            if query.include?('body')
              content = email.body
              body_pattern = query[query.index('body')+1]
              if body_pattern.split(/,/).length == 1 # if the search pattern is email address or full name
                content_match &&= !content.match(body_pattern.gsub('+','\\\+')).nil?
              else                           # else the search patter should be license key array
                query_arr = eval body_pattern
                query_arr.each do |q|
                  content_match &&= !content.match(q).nil?
                end
              end
            end
            next if !content_match
            @found << email
            Log.info("Email Count: " + @found.size.to_s)
         }
        rescue Exception => ex
          Log.debug ex
        ensure
          sleep 10
        end
        break if @found.size > 0
      end
      @found
    end

    def find_email_content(query, attach = nil)
      content = nil
      find_emails query if @found.nil?
      content = @found[0].body if !@found.nil?
      Log.debug("Found email was sent at:#{@found[0].date_time_sent}") if !@found.nil?
      puts("Found email was sent at:#{@found[0].date_time_sent}") if !@found.nil?
      filename = ''
      unless attach.nil?
        message = @found[0]
        message.attachments.each do |attachment|
          filename = attachment.file_name
          filepath = "#{default_download_path}/" + filename
          filepath.gsub!('/', '\\') if OS.windows?
          File.open("#{filepath}", 'w+') do |f|
            f.write(Base64.decode64(attachment.content))
          end
        end
      end
      if attach.nil?
        return content
      else
        return filename
      end
    end

    def empty_folder
      resp = @client.ews.empty_folder(
        opts = {
            :folder_ids   => [:id => @inbox.id],
            :delete_type  => 'HardDelete',
            :delete_sub_folders => true
        }
      )

      if resp.success?
        true
      else
        raise EwsError, "Could not empty folder. #{resp.code}: #{resp.message}"
      end

    end
  end

  def create_user_email
    "#{CONFIGS['global']['email_prefix']}+#{Forgery(:basic).password(:at_least => 9, :at_most => 12)}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def create_admin_email(first_name,last_name)
    "#{CONFIGS['global']['email_prefix']}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def find_emails(query, _=nil)
    if MAILBOX.eql? 'outlook'
      email = Outlook.instance
    else
      email = GmailBox.instance
    end
    email.find_emails(query)
  end

  def find_email_content(query, attach = nil)
    if MAILBOX.eql? 'outlook'
      email = Outlook.instance
    else
      email = GmailBox.instance
    end
    email.find_email_content(query, attach)
  end

  def count_licenses_from_email(email_body)
    #pu = past unactivated, d = desktop, s = server, u = unactivated, a = activated
    pu,du,da,su,sa = false,0,0,0,0
    email_body.to_s.each_line do |line|
      pu = true if line.include?("<span class=\"label\">Activated</span></div>")
      if line.include?("<td>Desktop</td>")
        (pu ? da += line.scan('Desktop').length : du += line.scan('Desktop').length )
      elsif line.include?("<td>Server</td>")
        (pu ? sa += line.scan('Server').length : su += line.scan('Server').length )
      end
    end
    #puts "du:#{du} su:#{su} da:#{da} sa:#{sa} pu:#{pu}"
    return [du,su,da,sa]
  end

end
