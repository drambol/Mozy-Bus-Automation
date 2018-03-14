module Bus
  # This class provides actions for admin console branding section
  class ConsoleIframe < SiteHelper::Iframe

    #tabs
    element(:tab_titles, css: '#site_branding-console-tabs > ul.tab-titles')
    element(:text_tab, css: '#site_branding-console-tabs > ul.tab-titles > li:nth-child(4)')

    #text items
    element(:text_header_link, xpath: "//ul[@id='site_sections_bus']//a[text()='Header']")

    #text area
    element(:dashboard_link_text, id: 'sc_BUS_HEADER_DASHBOARD_LINK_TEXT')

    # save change button
    element(:save_changes_btn, css: "#site_branding-console-tabs input[value='Save Changes']")

    def select_tab(tab_name)
      tab_titles.child.each do |c|
        c.click if c.text == tab_name
      end
    end

    def open_header_text
      text_header_link.click
    end

    def input_dashboard_link_text(text = '')
      dashboard_link_text.type_text(text)
      save_changes_btn.click
    end

  end
end
