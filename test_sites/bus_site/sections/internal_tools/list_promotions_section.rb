module Bus
  # This class provides actions for managing on Add New Promotion section
  class ListPromotionsSection < SiteHelper::Section

    #======================================================
    # Public: Search promotion by the given name and page by page till the end
    # params: promotion name
    # return: None
    # Note   : the method will take some time due to the code will looking for the ui element through the entire html code page.
    #          Maybe we need try antoher way if the method takes too long time.
    #======================================================
    def search_promotion(promo_name)
      @promo_name = promo_name
      Log.debug "LogQA: search promotion - #@promo_name"
      wait_until_bus_section_load
      # get initialized pages number. e.g., Pages: 1 2 3 4 … 26, search the promotion name one by one and page by page
      pages = all(:xpath, '//div[@id="promotion-list"]/div/div/div/p[3]/a')
      Log.debug "LogQA: page count is - " + pages.size().to_s
      @page_index = 1
      lagest_page_num = pages[pages.size() - 1].text()
      Log.debug "LogQA: Begin to search the promotion from page " + @page_index.to_s
      Log.debug "LogQA: Search will end at page " + lagest_page_num

      find_promo = false
      while (!find_promo || @current_page_index > lagest_page_num) do
        Log.debug "LogQA: search the promotion name - " + promo_name
        begin
          find(:xpath, "//a[text()= '#@promo_name']").click
          find_promo = true
          Log.debug "LogQA: find the promotion"
          break
        rescue
          Log.debug "LogQA: Can't find promotion on current page."
          Log.debug "LogQA: Try next page or exit."
        end
        Log.debug "LogQA: =================================================================="
        Log.debug "LogQA: Don't find the promotion name on current page, go to the next page"
        @page_index = @page_index + 1
        find(:xpath, "//a[@always_link='true' and text()='#{@page_index.to_s}']").click
        wait_until_bus_section_load
      end
    end

  end
end