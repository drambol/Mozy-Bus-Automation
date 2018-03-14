When /^an Auto Grow Org is created$/ do
  step %{I log in bus admin console as administrator}
  step %{I add a new Reseller partner:}, table(%{
  | period | reseller type | reseller quota | server plan |
  | 12     | Silver        | 20             | yes         |
  })
  step %{New partner should be created}
  step %{I get the partner_id}
  step %{I Enable partner details autogrow}
  step %{I act as newly created partner}
  step %{I navigate to Billing Information section from bus admin console page}
  step %{I add a new Bundled user group:}, table(%{
      | name        | storage_type | assigned_quota | server_support |
      | Assigned UG | Assigned     | 5              | yes            |
  })
  step %{Assigned UG user group should be created}
  step %{I add a new Bundled user group:}, table(%{
      | name      | storage_type | server_support |
      | Shared UG | Shared       | yes            |
  })
  step %{Shared UG user group should be created}
  step %{I add a new Bundled user group:}, table(%{
      | name       | storage_type | limited_quota | server_support |
      | Limited UG | Limited      | 3             | yes            |
  })
  step %{Limited UG user group should be created}
  step %{I add new user(s):}, table(%{
      | name          | user_group  | storage_type | devices |
      | Jane Assigned | Assigned UG | Desktop      | 1       |
  })
  step %{1 new user should be created}
  step %{I add new user(s):}, table(%{
      | name        | user_group | storage_type | devices |
      | John Shared | Shared UG  | Server       | 1       |
  })
  step %{1 new user should be created}
  step %{I add new user(s):}, table(%{
      | name         | user_group | storage_type | devices |
      | Jane Limited | Limited UG | Desktop      | 1       |
  })
  step %{1 new user should be created}
end
