# encoding: utf-8
module Phoenix
  # This class provides actions for phoenix registration page
  class DomSelection < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}/registration")

    # Private elements
    #
    # Select dom page
    #
    element(:country_select, id: "person_country")
    element(:country_selected, xpath: "//select[@id='person_country']/option[@selected='selected']")
    #
    # Various elements
    #
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    element(:mozypro_radio_btn, id: "product_mozypro")
    element(:mozyhome_radio_btn, id: "product_mozyhome")
    #
    # Public : verify dom elements
    #
    # required: element, element_hash
    #
    # Example
    #
    #   select_country('dom')
    #
    # Returns nothing
    def verify_dom_elements
      add_existence_checker(:country_select, id: "person_country")
      add_existence_checker(:continue_btn, css: "input.img-button")
    end

    #
    # Public : select dom
    #
    # required: person_country - country for user/partner, controls dom
    #
    # Example
    #
    # select_country('dom')
    #
    # Returns nothing
    def select_country(partner)
      country_select.select(partner.company_info.country)
      continue_btn.click
      # sleep 2 # take a sec and then check the url - ensures we are @ correct dom location
      wait_until { !first(:xpath, "//input[contains(@id,'username')]").nil? }
      verify_domain(partner)
    end

    def localize_country(partner)
      case partner.company_info.country
        when 'Germany'
          country_select.select('Deutschland')
        else
          country_select.select(partner.company_info.country)
      end
    end

    # redmine: 103781,82333
    # per the a combination of comments in redmine tickets above and entries from countries yaml file
    # yaml file first, then corrections based on redmine tickets.
    # purpose is to ensure prospective user/partners correct linguistic treatment according to nationality selection
    def verify_domain(partner)
      case partner.company_info.country
        # german - lang specific
        when 'Switzerland', 'Schweiz', 'Austria', 'Österrreich', 'Germany', 'Deutschland', 'Liechtenstein'
          url.eql?(/https?:\/\/secure.mozy.de\/registration\/[\S]+location\/[\S]+/)
          if partner.partner_info.type == 'MozyPro'
            partner.partner_info.parent = 'MozyPro Germany'
          elsif partner.partner_info.type == 'MozyHome'
            partner.partner_info.parent = 'MozyHome Germany'
          end
        # french - lang specific
        when 'France', 'Suisse', 'Canada', 'Burkina Faso', 'Niger', 'Senegal', 'Mali', 'Rwanda', 'Belgique', 'Ivory Coast',
            'Haiti', 'Burundi', 'Bénin', 'Togo', 'Congo', 'Gabon', 'Comoros', 'Equatorial Guinea', 'Djibouti', 'Luxembourg',
            'Seychelles', 'Monaco', 'Guadeloupe', 'Reunion', 'New Caledonia', 'Wallis and Futuna', 'French Polynesia', 'Belgium',
            'French Southern Territories', 'French Guiana', 'Martinique', 'Saint Pierre and Miquelon', 'Guinée',
            'Côte d’Ivoire''Gabun', 'Mayotte'
            url.eql?(/https?:\/\/secure.mozy.fr\/registration\/[\S]+location\/[\S]+/)
          if partner.partner_info.type == 'MozyPro'
            partner.partner_info.parent = 'MozyPro France'
          elsif partner.partner_info.type == 'MozyHome'
            partner.partner_info.parent = 'MozyHome France'
          end
        # ireland - mainstream EU
        when 'Andorra', 'Albania', 'Netherlands Antilles', 'Bosnia and Herzegovina', 'Bulgaria', 'Cyprus', 'Slovakia',
            'Estonia', 'Spain', 'Europe', 'Finland', 'Greece', 'Croatia', 'Greenland', 'Faroe Island', 'Latvia',
            'Ireland', 'Iceland', 'Italy', 'Lithuania', 'Montenegro', 'Czech Republic', 'Malta', 'Romania',
            'Netherlands', 'Poland', 'Portugal', 'Slovenia', 'San Marino', 'Holy See', 'Denmark', 'Hungary', 'Sweden'
          url.eql?(/https?:\/\/secure.mozy.ie\/registration\/[\S]+location\/[\S]+/)
          if partner.partner_info.type == 'MozyPro'
            partner.partner_info.parent = 'MozyPro Ireland'
          elsif partner.partner_info.type == 'MozyHome'
            partner.partner_info.parent = 'MozyHome Ireland'
          end
        # united kingdom
        when 'United Kingdom', 'Falkland Islands (Malvinas)', 'Gibraltar', 'South Georgia and the South Sandwich Islands', 'Isle of Man',
            'British Indian Ocean Territory', 'Falkland Islands', 'Jersey',  'Pitcairn', 'Saint Helena', 'Virgin Islands, British'
          url.eql?(/https?:\/\/secure.mozy.co.uk\/registration\/[\S]+location\/[\S]+/)
          if partner.partner_info.type == 'MozyPro'
            partner.partner_info.parent = 'MozyPro UK'
          elsif partner.partner_info.type == 'MozyHome'
            partner.partner_info.parent = 'MozyHome UK'
          end
        else
        # us dom - encompasses all those not mentioned here
          url.eql?(/https?:\/\/secure.mozy.com\/registration\/[\S]+location\/[\S]+/)
          if partner.partner_info.type == 'MozyPro'
            partner.partner_info.parent = 'MozyPro'
          elsif partner.partner_info.type == 'MozyHome'
            partner.partner_info.parent = 'MozyHome'
          end
      end
    end

    def register_partner(type)
      continue_btn.click
      wait_until { !first(:xpath, "//input[contains(@id,'username')]").nil? }
      case type
        when 'MozyPro'
          mozypro_radio_btn.click
        when 'MozyHome'
          mozyhome_radio_btn.click
      end
    end

    def get_selected_country
      country_selected.text
    end

  end
end
