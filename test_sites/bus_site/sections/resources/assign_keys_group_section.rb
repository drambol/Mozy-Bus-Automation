module Bus

  # This class provides actions for assign keys group section
  class AssignKeysGroupSection < SiteHelper::Section

    # Private elements
    #
    element(:assign_btn, xpath: "//input[@value='Assign']")

    def assign_keys_to_email(type, email)
      find(:xpath, "//td[text()='#{type}']//../td[4]/input[contains(@id,'key_email')]").type_text(email)
      assign_btn.click
      wait_until { !locate_link("clear").nil? }
      find(:xpath, "//td[text()='#{type}']//../../tr[1]/td[2]").text
    end

  end
end
