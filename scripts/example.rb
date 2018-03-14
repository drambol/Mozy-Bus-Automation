#!/usr/bin/env ruby

require '../lib/aria_api/lib/aria_api'

=begin
Access details (PROD ARIA)
* Client Number
    * 5226000
* Authorization Key
    * cUHbNPsfuqq7vDfn9AVR4HfvD9wmrSvG
* URL
    * https://secure.ariasystems.net/api/ws/api_ws_class_dispatcher.php

Access details (QA ARIA)
* Client Number
    * 4775000
* Authorization Key
    * pm4QJD8TmXTrbKGmbRUVskCb7BmffQKN
* URL
    * https://secure.future.stage.ariasystems.net/api/ws/api_ws_class_dispatcher.php
=end

AriaApi::Configuration.auth_key = 'pm4QJD8TmXTrbKGmbRUVskCb7BmffQKN'
AriaApi::Configuration.client_no = '4775000'
AriaApi::Configuration.url = 'https://secure.future.stage.ariasystems.net/api/ws/api_ws_class_dispatcher.php'

print AriaApi.get_country_from_ip(ip_address: "207.97.227.239")
#expected results
#{"country_code"=>"US", "country_name"=>"United States", "error_code"=>0, "error_msg"=>"OK"}
