module Aria
  # This class provides actions for accounts page
  class AccountsPage < SiteHelper::Page

    set_url("#{ARIA_ENV['host']}/AdminTools.php/Accounts/show")

    iframe(:outer_if, OuterIframe, :id, 'outerFrame')

  end
end