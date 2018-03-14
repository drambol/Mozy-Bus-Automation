# encoding: utf-8

module Phoenix
  class HomeInvoice < SiteHelper::Page

    #set_url('file:///Users/zengz2/Documents/Code/tmp/bus-web-auto-test/downloads/mozyhome_invoice')

    element(:billing_detail_table, xpath: "//div/div[6]/table")
    element(:exchange_rate_table, xpath: "//div/div[7]/table")
    element(:vat_charged_txt, xpath: "//div/div[7]/b")
    element(:mozy_vat_no_txt, xpath: "//div/div[4]/p[2]")
    element(:information_link, xpath: "//div/div[4]/p[3]/a")
    element(:user_info_txt, xpath: "//div/div[3]")
    element(:invoice_info_table, xpath: "//table[@id='invoice_info']")

    def invoice_page(page_path)
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.navigate.to("file://#{page_path}")
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
        invoice_info_table.text
      else
        raise 'You must use Selenium Driver'
      end

    end


    def close_page
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.execute_script "window.close();"
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      else
        raise 'You must use Selenium Driver'
      end
    end


    def vat_charged
      vat_charged_txt.text
    end

    def user_info
      user_info_txt.text
    end


    def billing_detail_table_rows
      billing_detail_table.rows_text
    end

    def exchange_rate_table_rows
      return nil unless has_exchange_rate_table?
      exchange_rate_table.rows_text
    end




  end
end