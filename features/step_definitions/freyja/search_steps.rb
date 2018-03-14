
# enter search keyword
When /^I enter search (file|folder) keyword in search box$/ do |document_choice|
  @user.search_file_keyword = QA_ENV[@user.partnerType+'_search_'+document_choice+'_keyword']
  @freyja_site.search_page.input_search(@user.search_file_keyword)

end

And /^I click search$/ do
    @freyja_site.search_page.execute_search
end

Then /^search results is displayed$/ do
  @freyja_site.search_page.verify_search_result(@user.search_file_keyword).should be_true
end