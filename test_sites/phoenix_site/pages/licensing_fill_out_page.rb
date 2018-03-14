# encoding: utf-8
module Phoenix
  class NewPartnerLicensingFillout < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}")

    # Private elements
    #
    # Licensing Page Info
    #
    element(:base_plan_radio, id: "base_product_")
    element(:billing_period_radio, id: "interval_")
    # changed to xpath ref - pending resolution of https://redmine.mozycorp.com/issues/90134
    # then will change back to proper css: "label.add_on_name" reference afterwards
    element(:server_add_on_lbl, xpath: "//td[@id='add_on_list']/div[1]/label")
    element(:server_add_on_cb, id: :"add_id_")
    element(:vat_number_tb, id: "vat_num")
    element(:coupon_code_tb, id: "coupon_code")
    element(:error_message, css: "p.error")
    element(:vat_error_message, xpath: "//dd[@class='error left']")
    # home specific items
    element(:add_storage_tb, id: "additional_storage")
    element(:add_machine_select, id: "extra_machine_count")
    element(:promo_cde_tb, id: "promo_code")
    element(:plan_summary_table, css: "table.summary")
    element(:plan_summary_tbl_body, css: "table.summary > tbody")
    #
    # Various elements
    #
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    element(:page_banner, css: "div.center-form-box > h2")

    # Public
    #
    # Licensing Page Fillout
    #
    # Code stub
    #

    # vat fill out
    #   check if mozy pro or home, code applied to pro
    #     unless partner.company_info.country = US
    #       fills in vat_number.text_box with number provided
    #
    def vat_fill_out(partner)
      if partner.partner_info.type.eql?("MozyPro")
        unless partner.partner_info.parent == 'MozyPro' || partner.partner_info.parent == 'MozyPro Ireland'
          vat_number_tb.type_text(partner.company_info.vat_num)
        end
      end
    end

    #   rows
    #
    def plan_summary_table_rows
      plan_summary_tbl_body.rows_text
    end

    # run retrieval method for info
    # put results to window for checking
    #
    def get_plan_summary(partner)
      unless partner.partner_info.type.eql?("MozyPro")
        # for pro, we do not show a plan summary on licensing page
        # for home, we show plan summary on licensing page
        # this code attempts to get it for verification
        plan_summary_table_rows
        # TODO: Use Plan summary to verify the expected plan summary on licensing filling page
        # sample output: {"Total Storage:" => "50 GB", "Total Computers:" => "1", "Discounts:" => "-", "Total Price: $5.99" => nil}
        partner.plan_summary = Hash[plan_summary_table_rows[1..4]]
        puts plan_summary_table_rows.to_s
      end
    end

    # fill base plan
    #   fill_base_plan(partner.base_plan) where base plan = 50 gb
    #     instructs code to find 50gb field and click it
    #     jm: code change for FR dom
    def fill_base_plan(base_plan)
      base_plan_words = base_plan.split(/[[:space:]]+/)
      correct_label =  all('label').select do |label|
        base_plan_words.all?{|word| label.text.include?(word)}
      end
      find_by_id(correct_label[0][:for]).click
    end

    # fill subscription period
    #   fill_subscription_period(partner.subscription_period) where period = monthly
    #     instructs code to find monthly field and click it
    #     home pre-processes this via case statement and changes entry to "M", "Y", "2"
    #
    def fill_subscription_period(partner)
      if partner.partner_info.type.eql?("MozyPro")
        find_by_id("interval_#{partner.subscription_period}").click
      else
        find_by_id("period_#{partner.subscription_period}").click
      end
    end

    # filling out additional computers
    #   mozyhome customers have the option of selecting to add a few computers
    #   to their plan, the plan starts with - 50gb - 1, 125gb - 3
    #   total max value for computers allowed on account = 5
    def fill_additional_computers(partner)
      add_machine_select.select(partner.additional_computers)
    end

    # filling out additional storage
    #   max avail = 99, so by entering 'max' can auto set it to max val
    #   otherwise, it will be what you decide in the setup
    #   so total max possible = 125gb + (99x20 gb=1980 gb) = 2.1 tb
    def fill_additional_storage(partner)
      if partner.additional_storage.eql?("max")
        add_storage_tb.type_text("99")
      else
        add_storage_tb.type_text(partner.additional_storage)
      end
    end

    # server plan fill out
    #   server_plan_fill_out(partner.has_server_plan) checks whether value is set to false
    #     if it is - it moves on, otherwise it clicks the server plan label wich set the plan = true
    #
    def server_plan_fill_out(partner)
      unless partner.has_server_plan.eql?(false)
        # code selects server add-on
        server_add_on_lbl.click
      end
    end

    # coupon code fill out
    #   coupon_code_fill_out(partner.partner_info.coupon_code) check if coupon code is a nil value
    #     if so - no coupon / pro code, it then moves on
    #       if not, based on the plan type, it fills in the coupon / promo code text box w/ value specified
    #
    def coupon_code_fill_out(partner)
      unless partner.partner_info.coupon_code.nil?
        if partner.partner_info.type.eql?("MozyPro")
          coupon_code_tb.type_text(partner.partner_info.coupon_code)
        else
          promo_cde_tb.type_text(partner.partner_info.coupon_code)
        end
      end
    end

    # licensing page fill out section
    #   calls specific methods passing partner data, then clicks continue button
    #
    def licensing_billing_fillout(partner)
      # wait_until { !first(:id, "conti_button").nil? | !first(:id, "submit_button").nil?}
      # define base plan
      fill_base_plan(partner.base_plan)
      # define base plan subscription period
      fill_subscription_period(partner)
      # home specific items
      if partner.partner_info.type.eql?("MozyHome")
        fill_additional_storage(partner)
        fill_additional_computers(partner)
      else
      end
      # server add-on
      server_plan_fill_out(partner)
      # coupon code
      coupon_code_fill_out(partner)
      # emea-vat number
      vat_fill_out(partner)
      # home-get plan summary
      get_plan_summary(partner)
      continue_btn.click
    end

    # Public: This is for cases when MozyHome Plan error
    #
    # Example
    #  @phoenix_site.licensing_fill_out.stuck_on_mozyhome_plan?
    #
    # Returns true or false
    def stuck_on_mozy_plan?
      sleep 2
      msg1 = "MozyHome Plan"
      msg2 = "Choose a Plan"
      msg3 = "MozyHome Tarif"
      msg4 = "Plan MozyHome"
      msg5 = "Choisir un plan"
      msg6 = "Plan auswählen"

      page_banner.text == msg1 || page_banner.text == msg2 || page_banner.text == msg3 || page_banner.text == msg4 || page_banner.text == msg5 || page_banner.text == msg6
    end

    # Public: Error Messages for apply Promotional Code
    #
    # Example
    #  @phoenix_site.licensing_fill_out.pc_error_messages
    #  # => "The promotion code 5percentoff is invalid or has expired."
    #
    # Returns success or error message text
    def pc_error_messages
      error_message.text
    end

    # Public: Error Messages for apply Promotional Code
    #
    # Example
    #  @phoenix_site.licensing_fill_out.pro_pc_error_messages
    #  # => "The promotion code 5percentoff is invalid or has expired."
    #
    # Returns success or error message text
    def vat_error_messages
      vat_error_message.text
    end
  end
end
