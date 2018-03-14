module Bus
  # This class provides actions for partner invoice page
  class PartnerInvoicePage < SiteHelper::Page

    # Private elements
    #
    element(:billing_detail_table, xpath: "//div[@id='content']/table[4]")
    element(:exchange_rates_table, xpath: "//div[@id='content']/table[5]")
    element(:partner_details_td, xpath: "//div[@id='content']/table[3]/tbody/tr/td[1]")

    # Public: Get partner details table
    #
    def partner_info
      partner_details_td.text
    end

    # Public: Get billing detail table
    #
    def billing_detail_table_rows
      return nil unless has_billing_detail_table?
      billing_detail_table.rows_text
    end

    # Public: Get exchange rates table
    #
    def exchange_rates_table_rows()
      return nil unless has_exchange_rates_table?
      exchange_rates_table.rows_text
    end
  end
end
