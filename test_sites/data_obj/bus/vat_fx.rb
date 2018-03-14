module Bus
  module DataObj
    # This class contains attributes for VAT rates and FX rates
    class VATFXRate
      attr_accessor :vat_country, :vat_rate, :vat_effective_date, :fx_from_currency, :fx_to_currency, :fx_rate, :fx_effective_date
    end
  end
end