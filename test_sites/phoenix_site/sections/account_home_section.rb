module Phoenix
  class AccountDetailSection < SiteHelper::Page

    element(:plan_dtl_table, css: "table.key_value_table.fixed")

    #	Returns nothing
    def navigate_to_link(link)
      find_link(link).click
    end

    # public method for clicking/selecting specific items based on locale
    def localized_click(partner, loc_click)
      navigate_to_link("#{LANG[partner.company_info.country][partner.partner_info.type][loc_click]}")	;end
    def localized_select(loc_item, partner, loc_select)
      loc_item.select("#{LANG[partner.company_info.country][partner.partner_info.type][loc_select]}")	;end

    def load_acct_home_section(partner)
      localized_click(partner, 'go_to_acct')
      plan_detail_info_get
    end

    def plan_detail_info_get
      plan_dtl_table.visible?
      plan_details_headers
      plan_details_rows
    end


    def plan_details_headers
      plan_dtl_table.headers_text
    end

    def plan_details_rows
      plan_dtl_table.rows_text
    end
  end
end