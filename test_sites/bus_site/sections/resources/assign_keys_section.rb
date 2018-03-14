module Bus

  # This class provides actions for assign keys section
  class AssignKeysSection < SiteHelper::Section

    # Private elements
    #
    elements(:assign_key_summary_spans, xpath: "//div[@class='show-details']/div/div/span[@class='label' or @class='value']")

    def click_user_group(user_group)
      find(:xpath, "//a[text()='#{user_group}']").click
    end

    def resources_general_info_hash
      array = assign_key_summary_spans.map{ |span| span.text }
      Hash[*array]
    end

  end
end
