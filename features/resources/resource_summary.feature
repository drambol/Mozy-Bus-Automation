Feature: Resource Summary

  As an Mozy administrator
  I want to see my account level available storage and devices
  So that I can quickly a purchasing decision

  Background:
    Given I log in bus admin console as administrator

  @TC.20783 @bus @2.5 @manage_storage @display_account_storage @device_summary @need_test_account @env_dependent @regression @core_function_remove
  Scenario: 20783 [Itemized]Available and Used, Used/Total has correct values when 0<used<total
    When I act as partner by:
      | email                                     |
      | test_resource_summary_enterprise@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used  |
      | 30 GB        | 200 GB        | 0           | 100 GB       | 270 GB    | 30 GB |
    And Itemized device summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used |
      | 1            | 8             | 0           | 200          | 207       | 1    |

  @TC.20787 @bus @2.5 @manage_storage @display_account_storage @device_summary @need_test_account @env_dependent @regression @core_function_remove
  Scenario: 20787 [Itemized]Total=Available+Used and Total_Used=sum(storage type) when 0<used<total
    When I act as partner by:
      | email                                     |
      | test_resource_summary_enterprise@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then The following equation about storage for Itemized partner is right
      | Available | + | Used | == | Desktop Total | + |Server Total |
    And The following equation about storage for Itemized partner is right
      | Desktop Used | + | Server Used | == | Used |
    And The following equation about device for Itemized partner is right
      | Available | + | Used | == | Desktop Total | + |Server Total |
    And The following equation about device for Itemized partner is right
      | Desktop Used | + | Server Used | == | Used |

  @TC.20798 @bus @2.5 @manage_storage @display_account_storage @device_summary @need_test_account @env_dependent @regression @core_function
  Scenario: 20798 [Itemized with subpartner]The subpartner info shows
    When I act as partner by:
      | email                                                |
      | test_resource_summary_enterprise_subpartner@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used  | All Subpartner | Desktop Subpartner | Server Subpartner |
      | 0            | 170 GB        | 10 GB       | 80 GB        | 240 GB    | 10 GB | 50 GB          | 30 GB              | 20 GB             |
    And Itemized device summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used | All Subpartner | Desktop Subpartner | Server Subpartner |
      | 0            | 5             | 1           | 198          | 202       | 1    | 5              | 3                  | 2                 |


  @TC.20803 @bus @2.5 @manage_storage @display_account_storage @device_summary @need_test_account @env_dependent @regression @core_function
  Scenario: 20803 [Bundled]Available and Used, Used/Total has correct values when 0<used<total
    When I act as partner by:
      | email                                             |
      | test_resource_summary_bundled@auto.com 	          |
    And I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used  |
      | 70 GB     | 30 GB |

  @TC.20805 @bus @2.5 @manage_storage @display_account_storage @device_summary @need_test_account @env_dependent @regression @core_function
  Scenario: 20805 [Bundled with subpartner]The subpartner Storage shows in the partner's summary view
    When I act as partner by:
      | email                                        |
      | resource_summary_bundled_subpartner@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used  | All Subpartner |
      | 70 GB     |  0    | 30 GB          |

#  @TC.20797 @firefox_debug
#  Scenario: 20797 [Itemized]Click 'More' link will show all the Storage type when Storage type is more than 3
#    When I act as partner by:
#      | email                               |
#      | resource_summary_test_more@auto.com |
#    And I navigate to Resource Summary section from bus admin console page
#    Then Itemized storage summary should be:
#      | Test2 Used | Test2 Total | Test1 Used | Test1 Total | Server Used | Server Total | Available | Used  |
#      | 0          | 200 GB      | 0          | 200 GB      | 0           | 200 GB       | 850 GB    | 0     |
#    And Itemized device summary should be:
#      | Test2 Used | Test2 Total | Test1 Used | Test1 Total | Server Used | Server Total | Available | Used  |
#      | 0          | 0           | 0          | 0           | 0           | 0            | 10        | 0     |
#    When I click the more link for storage
#    And I click the more link for device
#    Then Itemized storage summary should be:
#      | Test2 Used | Test2 Total | Test1 Used | Test1 Total | Server Used | Server Total | Desktop Used | Desktop Total | Available | Used  |
#      | 0          | 200 GB      | 0          | 200 GB      | 0           | 200 GB       | 0            | 250 GB        | 850 GB    | 0     |
#    And Itemized device summary should be:
#      | Test2 Used | Test2 Total | Test1 Used | Test1 Total | Server Used | Server Total | Desktop Used | Desktop Total | Available | Used  |
#      | 0          | 0           | 0          | 0           | 0           | 0            | 0            | 10            | 10        | 0     |
#    When I click the hide link for storage
#    And I click the hide link for device
#    Then Itemized storage summary should be:
#      | Test2 Used | Test2 Total | Test1 Used | Test1 Total | Server Used | Server Total | Available | Used  |
#      | 0          | 200 GB      | 0          | 200 GB      | 0           | 200 GB       | 850 GB    | 0     |
#    And Itemized device summary should be:
#      | Test2 Used | Test2 Total | Test1 Used | Test1 Total | Server Used | Server Total | Available | Used  |
#      | 0          | 0           | 0          | 0           | 0           | 0            | 10        | 0     |
