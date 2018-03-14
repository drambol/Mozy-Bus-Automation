module Bus
  # This class provides actions for list admins section
  class ListAdminsSection < SiteHelper::Section

    element(:list_admins_table, xpath: "//div[@id='admin-list']//table[@id='tree_all']")

    def view_admin(admin)
      find(:xpath, "//a[text()='#{admin}']").click
    end

    def list_admins_table_hashes
      list_admins_table.rows_text
    end
  end
end