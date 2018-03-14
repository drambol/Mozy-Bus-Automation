Given /^I am at dom selection point:$/ do
	@phoenix_site = PhoenixSite.new
	@phoenix_site.select_dom.load
	# pending - add step here
end