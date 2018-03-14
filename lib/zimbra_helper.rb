module Zimbra
  module Inbox

    # Find email content by mail item id
    #
    # @return [string]
    def find_email_content(id, format='jason')
      url = "#{ZIMBRA_ENV['host']}/zimbra/home/#{ZIMBRA_ENV['username']}/inbox?id=#{id}&fmt=#{format}&auth=qp&zauthtoken=#{auth_token}"
      RestClient.get(url)
    end

    def find_emails(query, format='xml')
      url = "#{ZIMBRA_ENV['host']}/zimbra/home/#{ZIMBRA_ENV['username']}/inbox?fmt=#{format}&query=#{query}&auth=qp&zauthtoken=#{auth_token}"
      response = RestClient.get(URI.escape(url))
      parse_email_obj(response.body)
    end

    def get_html_from_email(id, format='jason')
      mail_content = find_email_content(id, format)
      mail_content[(4 + mail_content.index("\r\n\r\n"))..-1]
    end

    def send_request(url)
      RestClient.get(url)
    end

    private

    # Private: Get auth token
    #
    def auth_token
      RestClient.post(
          ZIMBRA_ENV['host'],
          { :loginOp => 'login',:username => ZIMBRA_ENV['username'], :password => ZIMBRA_ENV['password'], :client => 'preferred' },
          { :cookies => { :ZM_TEST => 'true' } }
      ){ |response, request, result, &block|
        if [301, 302, 307].include? response.code
          response.follow_redirection(request, result, &block)
          return response.headers[:set_cookie][0].match(/ZM_AUTH_TOKEN=([^;]+)/)[1]
        else
          response.return!(request, result, &block)
        end
      }
    end

    # Private: Parse zimbra mail xml to object
    #
    # Example:
    #
    #   Source xml:
    #   <m id=\"64738\" f=\"u\" rev=\"72148\" d=\"1345542459000\" s=\"2493\" l=\"2\" cid=\"64739\">
    #     <e d=\"redacted-3364\" t=\"f\" a=\"redacted-3364@notarealdomain.mozy.com\"/>
    #     <su>MozyPro License Keys Assigned for Data Shuttle</su>
    #     <fr>The following MozyPro license keys are assigned to users and the users have been notified. These keys are marked for use with the Data Shuttle ...</fr>
    #   </m>
    #
    def parse_email_obj(body_xml)
      xml_doc = Nokogiri::XML(body_xml)
      nodes = xml_doc.xpath("items/m")

      mails = []
      nodes.each do |node|
        mail = Struct.new(:id, :from, :subject, :fragment)
        mails << mail.new(node.attribute('id').text,node.xpath('./e').attribute('a').text,node.xpath('./su').text,node.xpath('./fr').text)
      end
      mails
    end

  end
end