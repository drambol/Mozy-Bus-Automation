module Aria
  # This class provides actions for form of payment section
  class FormOfPaymentSection < SiteHelper::Section

    def credit_card_info_hash
      cc_dl = find(:xpath, '//dl')
      Hash[*cc_dl.dt_dd_elements_text.flatten]
    end

  end

end