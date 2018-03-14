# encoding: utf-8

module Billing

  def get_currency(country)
    case country
      when CONFIGS['bus']['mozy_root_partner']['mozypro_uk']
        return '£'
      when CONFIGS['bus']['mozy_root_partner']['mozypro']
        return '$'
      else
        return '€'
    end
  end

  def get_vat_rate(country)
    (BILLING_ENV['VAT_RATE'].has_key? country)? BILLING_ENV['VAT_RATE'][country].to_f/100 : 0
  end

  def get_price(partner_type, parent_partner, period, quota, plan_type)
    if parent_partner == CONFIGS['bus']['mozy_root_partner']['mozypro'] || parent_partner == CONFIGS['bus']['mozy_root_partner']['mozypro_uk']
      return BILLING_ENV[partner_type][parent_partner][period][quota][plan_type]
    else
      return BILLING_ENV[partner_type]['MozyPro EU'][period][quota][plan_type]
    end
  end

  def get_discounts(coupon_code)
    (BILLING_ENV['COUPON_CODE'].has_key? coupon_code)? BILLING_ENV['COUPON_CODE'][coupon_code] : 0
  end

  def format_price(currency,price)
    currency+format("%0.2f", price).reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def get_mozypro_signup_order(partner)

    currency = get_currency(partner.partner_info.parent)

    vat_rate = get_vat_rate(partner.company_info.country)
    discount_rate = get_discounts(partner.partner_info.coupon_code)

    base_price = (!partner.has_initial_purchase)? 0.00 : get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.base_plan, "base plan").to_f
    server_price = (!partner.has_server_plan) ? 0.00 : get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.base_plan, "server plan").to_f
    add_on_each_price = (partner.storage_add_on == 0) ? 0.00 : get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.base_plan, "add on").to_f
    add_on_unit = get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.base_plan, "add on quota")
    add_on_all_price = (partner.storage_add_on == 0) ? 0: add_on_each_price * partner.storage_add_on.to_f

    pre_all_sub_total = (base_price + server_price + add_on_all_price).round(2)
    discounts = (base_price * discount_rate).round(2)+(server_price * discount_rate).round(2)+(add_on_all_price * discount_rate).round(2)
    pre_tax_sub_total =  pre_all_sub_total - discounts

    tax = (partner.company_info.vat_num == "" || partner.company_info.vat_num == "IE9691104A" ) ?
        (base_price * vat_rate * (1-discount_rate)).round(2)+(server_price * vat_rate * (1-discount_rate)).round(2)+(add_on_all_price * vat_rate * (1-discount_rate)).round(2) : 0

    total = pre_tax_sub_total + tax

    base_price   = format("%0.2f", base_price)
    server_price = format("%0.2f", server_price)
    add_on_each_price = format("%0.2f", add_on_each_price)
    add_on_all_price = format("%0.2f", add_on_all_price)
    discounts = format("%0.2f", discounts)
    pre_tax_sub_total = format("%0.2f", pre_tax_sub_total)
    tax = format("%0.2f", tax)
    total = format("%0.2f", total)
    pre_all_sub_total = format("%0.2f", pre_all_sub_total)

    partner.billing_info.billing[:base_plan_price] = base_price
    partner.billing_info.billing[:server_plan_price] = server_price
    partner.billing_info.billing[:add_on_unit] = add_on_unit
    partner.billing_info.billing[:add_on_each_price] = add_on_each_price
    partner.billing_info.billing[:add_on_quantity] =  partner.storage_add_on
    partner.billing_info.billing[:add_on_total_price] = add_on_all_price
    partner.billing_info.billing[:discounts] = discounts
    partner.billing_info.billing[:pre_all_subtotal] = pre_all_sub_total
    partner.billing_info.billing[:pre_tax_subtotal] = pre_tax_sub_total
    partner.billing_info.billing[:taxes] = tax
    partner.billing_info.billing[:total] = total
    partner.billing_info.billing[:zero] = format_price(currency,0)
    partner.billing_info.billing[:currency] = currency
    partner.billing_info.billing[:total_str] = format_price(currency,total)


  end

  def get_reseller_signup_order(partner)

    currency = get_currency(partner.partner_info.parent)

    vat_rate = get_vat_rate(partner.company_info.country)
    discount_rate = get_discounts(partner.partner_info.coupon_code)

    base_each_price = (!partner.has_initial_purchase)? 0.00 : get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.reseller_type, "base plan").to_f
    server_price = (!partner.has_server_plan) ? 0.00 : get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.reseller_type, "server plan").to_f
    add_on_each_price = get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.reseller_type, "add on").to_f
    add_on_unit = get_price(partner.partner_info.type, partner.partner_info.parent, partner.subscription_period, partner.reseller_type, "add on quota")

    add_on_all_price = ( partner.reseller_add_on_quota == 0) ? 0: add_on_each_price *  partner.reseller_add_on_quota.to_f
    base_price = base_each_price * partner.reseller_quota.to_f
    pre_all_sub_total = (base_price + server_price + add_on_all_price).round(2)
    discounts = (base_price * discount_rate).round(2)+(server_price * discount_rate).round(2)+(add_on_all_price * discount_rate).round(2)
    pre_tax_sub_total =  pre_all_sub_total - discounts
    tax = (partner.company_info.vat_num == "" || partner.company_info.vat_num == "IE9691104A" ) ?
        (base_price * vat_rate * (1-discount_rate)).round(2)+(server_price * vat_rate * (1-discount_rate)).round(2)+(add_on_all_price * vat_rate * (1-discount_rate)).round(2) : 0
    total = pre_tax_sub_total + tax


    base_each_price = format("%0.2f", base_each_price)
    base_price   = format("%0.2f", base_price)
    server_price = format("%0.2f", server_price)
    add_on_each_price = format("%0.2f", add_on_each_price)
    add_on_all_price = format("%0.2f", add_on_all_price)
    discounts = format("%0.2f", discounts)
    pre_tax_sub_total = format("%0.2f", pre_tax_sub_total)
    tax = format("%0.2f", tax)
    total = format("%0.2f", total)
    pre_all_sub_total = format("%0.2f", pre_all_sub_total)

    partner.billing_info.billing[:base_each_price] = base_each_price
    partner.billing_info.billing[:base_plan_price] = base_price
    partner.billing_info.billing[:server_plan_price] = server_price
    partner.billing_info.billing[:add_on_unit] = add_on_unit
    partner.billing_info.billing[:add_on_each_price] = add_on_each_price
    partner.billing_info.billing[:add_on_quantity] =  partner.reseller_add_on_quota
    partner.billing_info.billing[:add_on_total_price] = add_on_all_price
    partner.billing_info.billing[:discounts] = discounts
    partner.billing_info.billing[:pre_all_subtotal] = pre_all_sub_total
    partner.billing_info.billing[:pre_tax_subtotal] = pre_tax_sub_total
    partner.billing_info.billing[:taxes] = tax
    partner.billing_info.billing[:total] = total
    partner.billing_info.billing[:zero] = format_price(currency,0)
    partner.billing_info.billing[:currency] = currency
    partner.billing_info.billing[:total_str] = format_price(currency,total)


  end

  def get_bus_mozypro_order_summery(partner)
    currency =  partner.billing_info.billing[:currency]
    base_price_str   = format_price(currency,partner.billing_info.billing[:base_plan_price])
    server_price_str = format_price(currency,partner.billing_info.billing[:server_plan_price])
    add_on_each_price_str = format_price(currency,partner.billing_info.billing[:add_on_each_price])
    add_on_total_str = format_price(currency,partner.billing_info.billing[:add_on_total_price])
    discounts_str = '-'+format_price(currency,partner.billing_info.billing[:discounts])
    pre_tax_sub_total_str = format_price(currency,partner.billing_info.billing[:pre_tax_subtotal])
    tax_str = format_price(currency,partner.billing_info.billing[:taxes])
    total_str = format_price(currency,partner.billing_info.billing[:total])

    order_summary = Array.new

    if partner.has_initial_purchase
      order_summary.push(
          {'Description' => partner.base_plan,
           'Quantity'    => '1',
           'Price Each'  => base_price_str,
           'Total Price' => base_price_str})
    end

    if partner.has_server_plan
      order_summary.push(
          {'Description' => 'Server Plan',
           'Quantity'    => '1',
           'Price Each'  => server_price_str,
           'Total Price' => server_price_str})
    end

    if partner.storage_add_on.to_i > 0
      order_summary.push(
          {'Description' => partner.billing_info.billing[:add_on_unit],
           'Quantity'    => partner.storage_add_on,
           'Price Each'  => add_on_each_price_str,
           'Total Price' => add_on_total_str})
    end

    if partner.billing_info.billing[:discounts].to_i != 0
      order_summary.push(
          {'Description' => 'Discounts Applied',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => discounts_str})
    end

    if partner.has_initial_purchase
      order_summary.push(
          {'Description' => 'Pre-tax Subtotal',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => pre_tax_sub_total_str})
    end

    if partner.has_initial_purchase && partner.billing_info.billing[:taxes].to_i != 0
      order_summary.push(
          {'Description' => 'Taxes',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => tax_str})
    end

    if partner.has_initial_purchase
      order_summary.push(
          {'Description' => 'Total Charges',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => total_str})
    end

    return order_summary
  end

  def get_bus_reseller_order_summery(partner)
    currency =  partner.billing_info.billing[:currency]
    base_each_price_str = format_price(currency,partner.billing_info.billing[:base_each_price])
    base_price_str   = format_price(currency,partner.billing_info.billing[:base_plan_price])
    server_price_str = format_price(currency,partner.billing_info.billing[:server_plan_price])
    add_on_each_price_str = format_price(currency,partner.billing_info.billing[:add_on_each_price])
    add_on_total_str = format_price(currency,partner.billing_info.billing[:add_on_total_price])
    discounts_str = '-'+format_price(currency,partner.billing_info.billing[:discounts])
    pre_tax_sub_total_str = format_price(currency,partner.billing_info.billing[:pre_tax_subtotal])
    tax_str = format_price(currency,partner.billing_info.billing[:taxes])
    total_str = format_price(currency,partner.billing_info.billing[:total])
    pre_all_sub_total_str = format_price(currency,partner.billing_info.billing[:pre_all_subtotal])

    order_summary = Array.new

    if partner.has_initial_purchase
      description = 'GB - ' + partner.reseller_type + ' Reseller'
      order_summary.push(
          {'Description' => description,
           'Quantity'    => partner.reseller_quota,
           'Price Each'  => base_each_price_str,
           'Total Price' => base_price_str})
    end

    if partner.has_server_plan
      order_summary.push(
          {'Description' => 'Server Plan',
           'Quantity'    => '1',
           'Price Each'  => server_price_str,
           'Total Price' => server_price_str})
    end

    if  partner.reseller_add_on_quota.to_i > 0
      order_summary.push(
          {'Description' => partner.billing_info.billing[:add_on_unit],
           'Quantity'    =>  partner.reseller_add_on_quota,
           'Price Each'  => add_on_each_price_str,
           'Total Price' => add_on_total_str})
    end

    if partner.billing_info.billing[:discounts].to_i != 0
      order_summary.push(
          {'Description' => 'Discounts Applied',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => discounts_str})
    end

    if partner.has_initial_purchase
      order_summary.push(
          {'Description' => 'Pre-tax Subtotal',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => pre_tax_sub_total_str})
    end

    if partner.has_initial_purchase && partner.billing_info.billing[:taxes].to_i != 0
      order_summary.push(
          {'Description' => 'Taxes',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => tax_str})
    end

    if partner.has_initial_purchase
      order_summary.push(
          {'Description' => 'Total Charges',
           'Quantity'    => '',
           'Price Each'  => '',
           'Total Price' => total_str})
    end

    return order_summary
  end

end
