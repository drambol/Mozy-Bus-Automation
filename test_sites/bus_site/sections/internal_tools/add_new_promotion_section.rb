module Bus
  # This class provides actions for managing on Add New Promotion section
  class AddNewPromotionSection < SiteHelper::Section

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

    element(:success_msg, xpath:'//div[@id="promotion-new"]//ul[@class="flash successes"]/li')

    #======================================================
    # Public: create a new promotion
    # params: in hash format, from the top to the bottom/from left to right -
    #  |description|promo code|discount type|discount value|valid from|Monthly|1 Year|2 Year|through|COM|UK|IE|FR|DE|code usage limit|valid on renewal|
    # return: None
    #======================================================
    def new_promotion(hashes)

      log('set description')
      unless hashes['description'].nil?
        log('[Decription] is ' + hashes['description'])
        promp_description.type_text(hashes['description']);
      end

      log('set prom code')
      unless hashes['promo code'].nil?
        log('[Promo Code] is ' + hashes['promo code'])
        promo_code.type_text(hashes['promo code'])
      end

      log('set discounts type')
      unless hashes['discount type'].nil?
        log('[Discount Type] is ' + hashes['discount type'])
        promo_discount_type.select(hashes['discount type'])
      end

      log('set discounts value')
      unless hashes['discount value'].nil?
        log('[Discount Value] is - ' + hashes['discount value'])
        promo_discount_value.type_text(hashes['discount value'])
      end

      log('set valid from')
      unless hashes['valid from'].nil?
        log('[Discount Value] is - ' + hashes['valid from'])
        promo_eff_date.type_text(hashes['valid from'])
      end

      log('set good for product(s)/subscription(s) - Monthly')
      if hashes['Monthly'] == 'Yes'
        log('[Monthly] is - ' + hashes['Monthly'] + ' , [Monthly] is checked.')
        promo_subscription_Monthly.set(true)
      elsif hashes['Monthly'] == 'No'
        log('[Monthly] is - ' + hashes['Monthly'] + ' , [Monthly] is unchecked.')
        promo_subscription_Monthly.set(false)
      else
        log('[Monthly] is by default.')
      end

      log('set good for product(s)/subscription(s) - 1 Year')
      if hashes['1 Year'] == 'Yes'
        log('[1 Year] is - ' + hashes['1 Year'] + ' , [1 Year] is checked.')
        promo_subscription_1_Year.set(true)
      elsif hashes['1 Year'] == 'No'
        log('[1 Year] is - ' + hashes['1 Year'] + ' , [1 Year] is unchecked.')
        promo_subscription_1_Year.set(false)
      else
        log('[1 Year] is by default.')
      end

      log('set good for product(s)/subscription(s) - 2 Year')
      if hashes['2 Year'] == 'Yes'
        log('[2 Year] is - ' + hashes['2 Year'] + ' , [2 Year] is checked.')
        promo_subscription_2_Year.set(true)
      elsif hashes['2 Year'] == 'No'
        log('[2 Year] is - ' + hashes['2 Year'] + ' , [2 Year] is unchecked.')
        promo_subscription_2_Year.set(false)
      else
        log('[2 Year] is by default.')
      end

      log('set through')
      unless hashes['through'].nil?
        log('[through] is - ' + hashes['through'])
        promo_expire_date.type_text(hashes['through'])
      end

      log('set good for domain(s) - COM')
      if hashes['COM'] == 'Yes'
        log('[COM] is - ' + hashes['COM'] + ' , [COM] is checked.')
        promo_valid_domains_COM.set(true)
      elsif hashes['COM'] == 'No'
        log('LogQA: [COM] is - ' + hashes['COM'] + ' , [COM] is unchecked.')
        promo_valid_domains_COM.set(false)
      else
        log('LogQA: [COM] is by default.')
      end

      log('LogQA: set good for domain(s) - UK')
      if hashes['UK'] == 'Yes'
        log('[UK] is - ' + hashes['UK'] + ' , [UK] is checked.')
        promo_valid_domains_UK.set(true)
      elsif hashes['UK'] == 'No'
        log('[UK] is - ' + hashes['UK'] + ' , [UK] is unchecked.')
        promo_valid_domains_UK.set(false)
      else
        log('[UK] is by default.')
      end

      log('set good for domain(s) - IE')
      if hashes['IE'] == 'Yes'
        log('[IE] is - ' + hashes['IE'] + ' , [IE] is checked.')
        promo_valid_domains_IE.set(true)
      elsif hashes['IE'] == 'No'
        log('[IE] is - ' + hashes['IE'] + ' , [IE] is unchecked.')
        promo_valid_domains_IE.set(false)
      else
        log('[IE] is by default.')
      end

      log('set good for domain(s) - FR')
      if hashes['FR'] == 'Yes'
        log('[FR] is - ' + hashes['FR'] + ' , [FR] is checked.')
        promo_valid_domains_FR.set(true)
      elsif hashes['FR'] == 'No'
        log('[FR] is - ' + hashes['FR'] + ' , [FR] is unchecked.')
        promo_valid_domains_FR.set(false)
      else
        log('[FR] is by default.')
      end

      log('set good for domain(s) - DE')
      if hashes['DE'] == 'Yes'
        log('[DE] is - ' + hashes['DE'] + ' , [DE] is checked.')
        promo_valid_domains_DE.set(true)
      elsif hashes['DE'] == 'No'
        log('[DE] is - ' + hashes['DE'] + ' , [DE] is unchecked.')
        promo_valid_domains_DE.set(false)
      else
        log('[DE] is by default.')
      end

      log('set code useage limit')
      unless hashes['code usage limit'].nil?
        log('[Code usage limit] is ' + hashes['code usage limit'])
        promo_times.type_text(hashes['code usage limit'])
      end

      log('set valid no renewal')
      if hashes['valid on renewal'] == 'Yes'
        log('[Valid on renewal] is - ' + hashes['valid on renewal'] + ' , [valid on renewal] is true.')
        promo_valid_on_renewal_true.click
      elsif hashes['valid on renewal'] == 'No'
        log('[Valid on renewal] is - ' + hashes['valid on renewal'] + ' , [valid on renewal] is false.')
        promo_valid_on_renewal_false.click
      else
        log('[Valid on renewal] is by default.')
      end

      log('click save changes')
      promo_save_changes.click

    end

    #======================================================
    # public: Get Message once promotion creaion is successful
    # return: success message
    #======================================================
    def get_creation_success_message
      log('returned text is - " + success_msg.text()')
      return success_msg.text()
    end

  end
end