module Aria
  # This class provides actions for taxpayer page section
  class TaxpayerSection < SiteHelper::Section

    # Private elements
    #
    element(:taxpayer_id_dd, xpath: "//form/fieldset/dl/dd[1]")
    element(:tax_exempt_status_dd, xpath: "//form/fieldset/dl/dd[2]")
    element(:edit_tax_exempt_btn, css: "input[value='Edit Fields']")
    element(:save_tax_exempt_btn, css: "input[value='Save Changes']")

    element(:federal_tax_exempt_cb, css: "input[name='inFederalTaxExempt']")
    element(:state_tax_exempt_cb, css: "input[name='inStateProvTaxExempt']")

    # Public: Account VAT number
    #
    # Example
    #   taxpayer_section.vat_number
    #   # => "BE0883236072"
    #
    # Returns taxpayer VAT number text
    def vat_number
      taxpayer_id_dd.text
    end

    # Public: Account tax exempt status
    #
    # Example
    #   taxpayer_section.tax_exempt_status
    #   # => "Account is exempt from both federal/national and state/province taxation."
    #
    # Returns account tax exempt status
    def tax_exempt_status
      tax_exempt_status_dd.text
    end

    # Public: Change federal exempt taxes status to true/false
    #
    # Example
    #   taxpayer_section.set_federal_exempt_taxes(true)
    #
    # Returns nothing
    def set_federal_exempt_taxes(status)
      edit_tax_exempt_btn.click
      federal_tax_exempt_cb.uncheck unless status
      save_tax_exempt_btn.click
    end

    # Public: Change state exempt taxes status to true/false
    #
    # Example
    #   taxpayer_section.set_state_exempt_taxes(true)
    #
    # Returns nothing
    def set_state_exempt_taxes(status)
      edit_tax_exempt_btn.click
      state_tax_exempt_cb.uncheck unless status
      save_tax_exempt_btn.click
    end
  end
end

