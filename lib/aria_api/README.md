# AriaApi [![Build Status](https://secure.travis-ci.org/jpemberthy/aria_api.png)](http://travis-ci.org/jpemberthy/aria_api)

Ruby wrap for the aria billing and subscriptions API.

## Installation

    gem install aria_api

For Rails Apps. Just add this to Gemfile.

    gem "aria_api"

## Configuration

First you'll need to define your credentials:

    AriaApi::Configuration.auth_key = "the-key"
    AriaApi::Configuration.client_no = "the-client"
    AriaApi::Configuration.url = "https://secure.future.stage.ariasystems.net/api/ws/api_ws_class_dispatcher.php"

In Rails. You could define specific configuration for each environment.

There's also a parameter to define the version of the Aria API you want to use. Default is 5.15

    AriaApi::Configuration.api_version = "5.16"


## Usage

AriaApi supports most of the API features defined in [https://developer.ariasystems.net/apidocs/web/app.php/api_docs](https://developer.ariasystems.net/apidocs/web/app.php/api_docs).

Just call the service name as an AriaApi method, the options are the same as the specified in the API docs.

    AriaApi.get_country_from_ip(ip_address: "207.97.227.239")
    # { "country_code" => "US", "country_name" => "United States", "error_code" => 0, "error_msg" => "OK" }

Note you don't need to pass credentials since they're already defined in the configuration module.

## Demo Application

[Code](https://github.com/jpemberthy/aria_api_demo)

[Live App](http://aria-api-demo.herokuapp.com/)
