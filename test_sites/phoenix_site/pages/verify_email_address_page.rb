module Phoenix
  class AccountVerification < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}")

    # Private elements
    #
    # Select dom page
    #
    element(:form_title, css: "div.center-form-box > h2")
    element(:form_message, css: "p.notice")

    def form_title_txt
      form_title.text
    end

    def form_message_txt
      form_message.text
    end

  end
end
