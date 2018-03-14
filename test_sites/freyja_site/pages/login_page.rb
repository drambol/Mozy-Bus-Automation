module Freyja

  class LoginPage < SiteHelper::Page

    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:home_login_btn, css: "input.img-button")
    element(:login_btn, css: "span.login_button")
    element(:restore_link, xpath: "//a[contains(text(),'Restore Files')]")
    element(:ent_restore_link, css: "i.icon-folder-open-alt.icon-2x")
    element(:ent_restore_link_stag, xpath: "//*[@id='account-index-content']/table/tbody/tr[1]/td[6]/a")
    element(:ent_restore_link_ckey, xpath:"//*[@id='account-index-content']/table/tbody/tr[1]/td[5]/a/i")#css: "i.icon-folder-open-alt.icon-2x")
    element(:ent_restore_link_ckey1, xpath:"//*[@id='account-index-content']/table/tbody/tr[1]/td[6]/a/i")
    element(:username_freyja, css: "span.text.username")
    element(:set_dialect_select, id: "set_dialect")

    # Public: open login page
    #
    # Example
    #   @freyja_site.login_page.load
    #
    # Returns nothing
    def initialize(user)
      partnerType = user.partnerType
      keyType = user.keyType
      case  keyType
        when  'private_key'
          case partnerType
            when 'home'
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}/login")
            else
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}")
          end
        when  'ckey'
          case partnerType
            when 'home'
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}/login")
            else
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}")
          end
        else
          case partnerType
            when 'home'
              self.class.set_url("#{QA_ENV[partnerType+'_url']}/login")
            else
              self.class.set_url("#{QA_ENV[partnerType+'_url']}")
          end
      end
    end

    # Public: enter username and password, click to confirm
    #
    # Example
    #   @freyja_site.login_page.UserLogin(user)
    #
    # Returns nothing
    def UserLogin(user)
      choose_language(user.language)
      username_tb.type_text(user.username)
      password_tb.type_text(user.password)
      partnerType = user.partnerType
      case partnerType
        when 'home'
          home_login_btn.click
        when 'pro'
          login_btn.click
          ent_restore_link.click
        when 'ent'
          login_btn.click
          #if (user.keyType == 'ckey')
          #  if ("#{QA_ENV['environment']}" == "staging")
          #    ent_restore_link_ckey.click
          #  else  if ("#{QA_ENV['environment']}" == "production")
          #          ent_restore_link_ckey1.click
          #        end
          #  end
          #end

          if ("#{QA_ENV['environment']}" == "staging")
            if (user.keyType == 'ckey')
              ent_restore_link_ckey.click
            else
            ent_restore_link_stag.click
            end
          else  if ("#{QA_ENV['environment']}" == "production")
                  if (user.keyType == 'ckey')
                    ent_restore_link_ckey1.click
                  else
                    ent_restore_link.click
                  end

          else
            ent_restore_link.click
          end
          end

        when 'oem'
          login_btn.click
          ent_restore_link.click
      end
      #puts "**********"
      #puts page.response_headers()
      #puts `pwd`
    end

    def login_verify
      username_freyja.visible?
    end


    def UserLogin_language(user, language)
      partnerType = user.partnerType
      choose_language(language)
      username_tb.type_text(user.username)
      password_tb.type_text(user.password)
      case partnerType
        when 'home'
          home_login_btn.click
        when 'pro'
          login_btn.click
          ent_restore_link.click
        when 'ent'
          login_btn.click
          ent_restore_link.click
        when 'oem'
          login_btn.click
          ent_restore_link.click
      end
    end

    def verify_localization(language)
      username_freyja.visible?
      page.has_content?(language)
    end

    def choose_language(language)
      #If the elemenet exists then select English
      using_wait_time 3 do
        if page.has_css?('#set_dialect')
          set_dialect_select.select(language)
          sleep 2
        end
      end
    end

  end

end