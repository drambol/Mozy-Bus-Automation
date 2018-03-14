module Bus
  # This class provides actions for managing on Add New Promotion section
  class PromotionDetailsViewSection < SiteHelper::Section

    element(:promp_description, id: 'promotion_description')
    element(:promo_code, id: 'promotion_code')
    element(:promo_discount_type, id: 'promotion_promo_type')
    element(:promo_discount_value, id: 'promotion_promo_value')
    element(:promo_eff_date, id: 'promotion_effective_date')
    element(:promo_expire_date, id: 'promotion_expiration_date')
    element(:promo_subscription_Monthly, id: 'sp_M')
    element(:promo_subscription_1_Year, id: 'sp_Y')
    element(:promo_subscription_2_Year, id: 'sp_2')
    element(:promo_valid_domains_COM, xpath: '//input[@value="COM"]')
    element(:promo_valid_domains_UK, xpath: '//input[@value="UK"]')
    element(:promo_valid_domains_IE, xpath: '//input[@value="IE"]')
    element(:promo_valid_domains_FR, xpath: '//input[@value="FR"]')
    element(:promo_valid_domains_DE, xpath: '//input[@value="DE"]')
    element(:promo_times, id: 'promotion_times')
    element(:promo_valid_on_renewal_true, id: 'promotion_valid_on_renewal_true')
    element(:promo_valid_on_renewal_false, id: 'promotion_valid_on_renewal_false')
    element(:promo_save_changes, id: 'commit')

    element(:success_msg, xpath:'//div[contains(@id,"promotion-show-")]//ul[@class="flash successes"]/li')

    element(:delete_promotion_btn, xpath:'//a[text()="Delete Promotion"]')

  #=======================================================================================

    #======================================================
    # Public : Update an existing promotion
    # params : in hash format, from the top to the bottom/from left to right -
    #  |description|promo code|discount type|discount value|valid from|Monthly|1 Year|2 Year|through|COM|UK|IE|FR|DE|code usage limit|valid on renewal|
    #
    # Return : None
    #======================================================
    def update_promotion(hashes)

      unless hashes['description'].nil?
        Log.debug 'LogQA: update description'
        Log.debug 'LogQA: [Decription] is - ' + hashes['description']
        promp_description.type_text(hashes['description']);
      end

      unless hashes['promo code'].nil?
        Log.debug 'LogQA: update prom code'
        Log.debug 'LogQA: [Promo Code] is - ' + hashes['promo code']
        promo_code.type_text(hashes['promo code'])
      end

      unless hashes['discount type'].nil?
        Log.debug 'LogQA: update discounts type'
        Log.debug 'LogQA: [Discount Type] is - ' + hashes['discount type']
        promo_discount_type.select(hashes['discount type'])
      end

      unless hashes['discount value'].nil?
        Log.debug 'LogQA: update discounts value'
        Log.debug 'LogQA: [Discount Value] is - ' + hashes['discount value']
        promo_discount_value.type_text(hashes['discount value'])
      end

      unless hashes['valid from'].nil?
        Log.debug 'LogQA: update valid from'
        Log.debug 'LogQA: [Discount Value] is - ' + hashes['valid from']
        promo_eff_date.type_text(hashes['valid from'])
      end

      if hashes['Monthly'] == 'Yes'
        Log.debug 'LogQA: update good for product(s)/subscription(s) - Monthly'
        Log.debug 'LogQA: [Monthly] is - ' + hashes['Monthly'] + ' , [Monthly] is checked.'
        promo_subscription_Monthly.set(true)
      elsif hashes['Monthly'] == 'No'
        Log.debug 'LogQA: update good for product(s)/subscription(s) - Monthly'
        Log.debug 'LogQA: [Monthly] is - ' + hashes['Monthly'] + ' , [Monthly] is unchecked.'
        promo_subscription_Monthly.set(false)
      end

      if hashes['1 Year'] == 'Yes'
        Log.debug 'LogQA: update good for product(s)/subscription(s) - 1 Year'
        Log.debug 'LogQA: [1 Year] is - ' + hashes['1 Year'] + ' , [1 Year] is checked.'
        promo_subscription_1_Year.set(true)
      elsif hashes['1 Year'] == 'No'
        Log.debug 'LogQA: update good for product(s)/subscription(s) - 1 Year'
        Log.debug 'LogQA: [1 Year] is - ' + hashes['1 Year'] + ' , [1 Year] is unchecked.'
        promo_subscription_1_Year.set(false)
      end

      if hashes['2 Year'] == 'Yes'
        Log.debug 'LogQA: update good for product(s)/subscription(s) - 2 Year'
        Log.debug 'LogQA: [2 Year] is - ' + hashes['2 Year'] + ' , [2 Year] is checked.'
        promo_subscription_2_Year.set(true)
      elsif hashes['2 Year'] == 'No'
        Log.debug 'LogQA: update good for product(s)/subscription(s) - 2 Year'
        Log.debug 'LogQA: [2 Year] is - ' + hashes['2 Year'] + ' , [2 Year] is unchecked.'
        promo_subscription_2_Year.set(false)
      end

      unless hashes['through'].nil?
        Log.debug 'LogQA: update through'
        Log.debug 'LogQA: [through] is - ' + hashes['through']
        promo_expire_date.type_text(hashes['through'])
      end

      if hashes['COM'] == 'Yes'
        Log.debug 'LogQA: update good for domain(s) - COM'
        Log.debug 'LogQA: [COM] is - ' + hashes['COM'] + ' , [COM] is checked.'
        promo_valid_domains_COM.set(true)
      elsif hashes['COM'] == 'No'
        Log.debug 'LogQA: update good for domain(s) - COM'
        Log.debug 'LogQA: [COM] is - ' + hashes['COM'] + ' , [COM] is unchecked.'
        promo_valid_domains_COM.set(false)
      end

      if hashes['UK'] == 'Yes'
        Log.debug 'LogQA: update good for domain(s) - UK'
        Log.debug 'LogQA: [UK] is - ' + hashes['UK'] + ' , [UK] is checked.'
        promo_valid_domains_UK.set(true)
      elsif hashes['UK'] == 'No'
        Log.debug 'LogQA: update good for domain(s) - UK'
        Log.debug 'LogQA: [UK] is - ' + hashes['UK'] + ' , [UK] is unchecked.'
        promo_valid_domains_UK.set(false)
      end

      if hashes['IE'] == 'Yes'
        Log.debug 'LogQA: update good for domain(s) - IE'
        Log.debug 'LogQA: [IE] is - ' + hashes['IE'] + ' , [IE] is checked.'
        promo_valid_domains_IE.set(true)
      elsif hashes['IE'] == 'No'
        Log.debug 'LogQA: update good for domain(s) - IE'
        Log.debug 'LogQA: [IE] is - ' + hashes['IE'] + ' , [IE] is unchecked.'
        promo_valid_domains_IE.set(false)
      end

      if hashes['FR'] == 'Yes'
        Log.debug 'LogQA: update good for domain(s) - FR'
        Log.debug 'LogQA: [FR] is - ' + hashes['FR'] + ' , [FR] is checked.'
        promo_valid_domains_FR.set(true)
      elsif hashes['FR'] == 'No'
        Log.debug 'LogQA: update good for domain(s) - FR'
        Log.debug 'LogQA: [FR] is - ' + hashes['FR'] + ' , [FR] is unchecked.'
        promo_valid_domains_FR.set(false)
      end

      if hashes['DE'] == 'Yes'
        Log.debug 'LogQA: update good for domain(s) - DE'
        Log.debug 'LogQA: [DE] is - ' + hashes['DE'] + ' , [DE] is checked.'
        promo_valid_domains_DE.set(true)
      elsif hashes['DE'] == 'No'
        Log.debug 'LogQA: update good for domain(s) - DE'
        Log.debug 'LogQA: [DE] is - ' + hashes['DE'] + ' , [DE] is unchecked.'
        promo_valid_domains_DE.set(false)
      end

      unless hashes['code usage limit'].nil?
        Log.debug 'LogQA: update code useage limit'
        Log.debug 'LogQA: [Code usage limit] is ' + hashes['code usage limit']
        promo_times.type_text(hashes['code usage limit'])
      end

      if hashes['valid on renewal'] == 'Yes'
        Log.debug 'LogQA: update valid no renewal'
        Log.debug 'LogQA: [Valid on renewal] is - ' + hashes['valid on renewal'] + ' , [valid on renewal] is true.'
        promo_valid_on_renewal_true.click
      elsif hashes['valid on renewal'] == 'No'
        Log.debug 'LogQA: update valid no renewal'
        Log.debug 'LogQA: [Valid on renewal] is - ' + hashes['valid on renewal'] + ' , [valid on renewal] is false.'
        promo_valid_on_renewal_false.click
      end

      Log.debug 'LogQA: save changes'
      promo_save_changes.click

    end

    #======================================================
    # Public : Get Success Message once updating promotion successfully
    # return : success message
    #======================================================
    def get_update_success_message
      Log.debug "LogQA: returned text is - " + success_msg.text()
      return success_msg.text()
    end

    #======================================================
    # Public : Delete a promotion
    # return : None
    #======================================================
    def delete_promotion
      delete_promotion_btn.click
      alert_accept
      sleep(2)
    end

    def delete_promtion_btn_visible
      return delete_promotion_btn.visible?
    end

  end
end