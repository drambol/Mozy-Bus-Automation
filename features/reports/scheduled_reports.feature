Feature: Scheduled Reports

  Background:
    Given I log in bus admin console as administrator


  # fixed data: Linux GA Test
  @TC.124061 @bus @tasks_p2 @reports
  Scenario: 124061: Linux Outdated Clients of scheduled reports
    And I navigate to bus admin console login page
    And I log in bus admin console with user name mozybus+catherine+0401@gmail.com and password default password
    And I build a new report:
      | type             | name                      |
      | Outdated Clients | outdated clients TC124061 |
    Then Report created successful message should be Created Outdated Clients Report.
    And I clear downloads folder outdated-clients*.csv file
    And I download outdated clients TC124061 scheduled report
    Then Scheduled Outdated Clients report csv file details should be:
      | Column A      | Column B             | Column C             | Column D                      | Column E        | Column F                | Column G               | Column H                | Column I                   |
      | Partner       | User Group           | Username             | Machine Alias                 | Client Platform | Current Client Name     | Current Client Version | Recommended Client Name | Recommended Client Version |
      | Linux GA Test | (default user group) | chris.qa6.1@mozy.com | ubuntu10-x86.bif.mozycorp.com | linux           | linux deb-64 1.0.5.4698 | 1.0.5.4698             | Linux 1.2.0.5055        | 1.2.0.5055                 |
      | Linux GA Test | (default user group) | chris.qa6.2@mozy.com | ubuntu1204                    | linux           | linux deb-64 1.0.5.4698 | 1.0.5.4698             | Linux 1.2.0.5055        | 1.2.0.5055                 |
      | Linux GA Test | (default user group) | linux.qa6.1@mozy.com | cas01                         | linux           | linux deb-64 1.0.6.4505 | 1.0.6.4505             | Linux 1.2.0.5055        | 1.2.0.5055                 |
    And I delete outdated clients TC124061 scheduled report
    And I clear downloads folder outdated-clients*.csv file

#  VMBU is End Of Life
#  @TC.124095 @bus @tasks_p2 @reports @qa12 @env_dependent
#  Scenario: 124095: VMBU Reporting: Machine over Quota
#    When I act as partner by:
#      | name          |
#      | ClientQA-VMBU |
#    And I build a new report:
#      | type               | name                        | frequency |
#      | Machine Over Quota | machine over quota TC124095 | Daily     |
#    Then Report created successful message should be Created Machine Over Quota Report.
#    And I clear downloads folder machine-over-quota*.csv file
#    And I download machine over quota TC124095 scheduled report
#    Then Scheduled Machine Over Quota report csv file details should be:
#      | Column A      | Column B             | Column C                    | Column D           | Column E        | Column F        |
#      | Partner       | User Group           | Machine Name                | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
#      | ClientQA-VMBU | (default user group) | qa2-loki.mozyclientqa.local | Limited: 100       | 124.83          | 124%            |
#    And I delete machine over quota TC124095 scheduled report
#    And I clear downloads folder machine-over-quota*.csv file

  @TC.21163 @bus @tasks_p2 @reports
  Scenario: 21163:[Scheduled Reports] Verify Billing Summary Report
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I build a new report:
      | type            | name                         | frequency |
      | Billing Summary | billing summary test TC21163 | Daily     |
    Then Billing summary report should be created
    And I clear downloads folder billing-summary*.csv file
    And I download billing summary test TC21163 scheduled report
    Then Scheduled Billing Summary report csv file details should be:
      | Column A                                | Column B             | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
      | Partner                                 | User Group           | Billing Code | Total GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Server Keys Purchased | Server GB Purchased | Effective price per Desktop license | Effective price per Server license | Effective price per GB |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) |              | Shared             | 7                     | N/A                 | 0                      | N/A                  |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       |              | Assigned: 30       | 2                     | N/A                 | 4                      | N/A                  |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       |              | Assigned: 10       | 2                     | N/A                 | 0                      | N/A                  |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          |              | Limited: 50        | 4                     | N/A                 | 0                      | N/A                  |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-None             |              | N/A                | 0                     | N/A                 | 0                      | N/A                  |                                    |                                     | $0.51                  |
    And I delete billing summary test TC21163 scheduled report
    And I clear downloads folder billing-summary*.csv file

  @TC.21199 @bus @tasks_p2 @reports
  Scenario: 21199:[Scheduled Reports] Verify Billing Details Report
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I build a new report:
      | type           | name                        | frequency |
      | Billing Detail | billing detail test TC21199 | Daily     |
    Then Billing detail report should be created
    And I wait for 15 seconds
    And I clear downloads folder billing-detail*.csv file
    And I download billing detail test TC21199 scheduled report
    Then Scheduled Billing Detail report csv file details should be:
      | Column A                                | Column B              | Column C     | Column D           | Column E            | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K             | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
      | Partner                                 | User Group            | Billing Code | Total GB Purchased | Desktop GB Purchased | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Server GB Purchased | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Effective price per Desktop license | Effective price per Server license | Effective price per GB |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group)  |              | Shared             | N/A                 | N/A                         | 45                     | 7                     | 2                     | 5                                      | N/A                  | N/A                          | 0                      | 0                      | 0                      | 0                                       |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1        |              | Assigned: 30       | N/A                 | N/A                         | 0                     | 2                     | 0                     | 2                                      | N/A                  | N/A                          | 24                       | 4                      | 2                      | 2                                       |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2        |              | Assigned: 10       | N/A                 | N/A                         | 7                      | 2                     | 2                     | 0                                      | N/A                  | N/A                          | 0                       | 0                      | 0                      | 0                                       |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited           |              | Limited: 50        | N/A                 | N/A                         | 9                      | 4                     | 3                     | 1                                      | N/A                  | N/A                          | 0                       | 0                      | 0                      | 0                                       |                                    |                                     | $0.51                  |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-None              |              | N/A                | N/A                 | N/A                         | 0                      | 0                     | 0                     | 0                                      | N/A                  | N/A                          | 0                       | 0                      | 0                      | 0                                       |                                    |                                     | $0.51                  |
    And I delete billing detail test TC21199 scheduled report
    And I clear downloads folder billing-detail*.csv file
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I build a new report:
      | type           | name                                 | frequency |
      | Billing Detail | billing detail test itemized TC21199 | Daily     |
    Then Billing detail report should be created
    And I clear downloads folder billing-detail*.csv file
    And I wait for 15 seconds
    And I download billing detail test itemized TC21199 scheduled report
    Then Scheduled Billing Detail report csv file details should be:
      | Column A                                 | Column B              | Column C     | Column D           | Column E            | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K             | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
      | Partner                                  | User Group            | Billing Code | Total GB Purchased | Desktop GB Purchased | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Server GB Purchased | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Effective price per Desktop license | Effective price per Server license | Effective price per GB |
      | [DO NOT CHANGE][Itemized] Reporting Test | (default user group)  |              | N/A                | Shared              | N/A                         | 0                      | 2                   | 0                     | 0                                      | Shared               | N/A                          | 0                       | 192                      | 0                      | 2                                       |                                    |                                     | $0.36                  |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned          |              | N/A                | Assigned: 100        | N/A                         | 98                     | 4                     | 2                     | 2                                      | Assigned: 50        | N/A                          | 42                      | 4                      | 2                      | 2                                       |                                    |                                     | $0.36                  |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited           |              | N/A                | Limited: 80         | N/A                         | 51                     | 4                     | 2                     | 0                                      | Limited: 50          | N/A                          | 37                      | 4                      | 2                      | 0                                       |                                    |                                     | $0.36                  |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-None              |              | N/A                | N/A                 | N/A                         | 0                      | 0                     | 0                     | 0                                      | N/A                  | N/A                          | 0                       | 0                      | 0                      | 0                                       |                                    |                                     | $0.36                  |
    And I delete billing detail test itemized TC21199 scheduled report
    And I clear downloads folder billing-detail*.csv file

  @TC.21200 @bus @tasks_p2 @reports
  Scenario: 21200:[Scheduled Reports] Verify Machine Status Report
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I build a new report:
      | type           | name                          | frequency |
      | Machine Status | machine status bundle TC21200 | Daily     |
    Then Report created successful message should be Created Machine Status Report.
    And I clear downloads folder machine-status*.csv file
    And I wait for 30 seconds
    And I download machine status bundle TC21200 scheduled report
    Then Scheduled Machine Status report csv file details should be:
      | Column A                        | Column B        | Column C     | Column D               | Column E           | Column F        | Column G               |
      | Username                        | Machine Alias   | License Type | Keystring (LicenseKey) | Quota Assigned(GB) | Quota Used (GB) | Last Successful Backup |
      | qa1+bundled+report+90@decho.com | Report Test 001 | Desktop      | WTZ2G447BRWFWRREFZW5   | Limited: 40        | 36.00           |                        |
      | qa1+bundled+report+90@decho.com | Report Test 009 | Desktop      | VSZQCE824QABFWT7ASRT   | Limited: 20        | 5.00            |                        |
      | qa1+bundled+report+80@decho.com | Report Test 003 | Server       | SDFR7BV99C5SFQ4XT74C   | Limited: 15        | 12.00           |                        |
      | qa1+bundled+report+80@decho.com | Report Test 002 | Server       | 463VEQ4ZT753D2QA9CB4   | Limited: 15        | 12.00           |                        |
      | qa1+bundled+report+70@decho.com | Report Test 004 | Desktop      | B9ATEQQWXV8VXS7FEVWT   | Shared             | 6.00            |                        |
      | qa1+bundled+report+70@decho.com | Report Test 005 | Desktop      | VF9V7CSDDG2T36T4DSF8   | Limited: 4         | 1.00            |                        |
      | qa1+bundled+report+60@decho.com | Report Test 007 | Desktop      | T4WDF6RGWW4776GVADQS   | Limited: 10        | 1.00            |                        |
      | qa1+bundled+report+60@decho.com | Report Test 006 | Desktop      | TZ3X7DWDERX7RQ766ZAD   | Limited: 10        | 7.00            |                        |
      | qa1+bundled+report+60@decho.com | Report Test 008 | Desktop      | 55G9X2WWZ6VBBW9AQ6R5   | Limited: 10        | 1.00            |                        |
       And I delete machine status bundle TC21200 scheduled report
    And I clear downloads folder machine-status*.csv file
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I build a new report:
      | type           | name                            | frequency |
      | Machine Status | machine status itemized TC21200 | Daily     |
    Then Report created successful message should be Created Machine Status Report.
    And I clear downloads folder machine-status*.csv file
    And I wait for 30 seconds
    And I download machine status itemized TC21200 scheduled report
    Then Scheduled Machine Status report csv file details should be:
      | Column A                         | Column B        | Column C     | Column D               | Column E           | Column F        | Column G               |
      | Username                         | Machine Alias   | License Type | Keystring (LicenseKey) | Quota Assigned(GB) | Quota Used (GB) | Last Successful Backup |
      | qa1+itemized+report+80@decho.com | Report Test 003 | Server       | 3EG8F3GG4VDWC8GGEDRW   | Shared             | 35.00           |                        |
      | qa1+itemized+report+80@decho.com | Report Test 004 | Server       | 26WG34W8AZ2TG9VVBB3F   | Limited: 10        | 7.00            |                        |
      | qa1+itemized+report+90@decho.com | Report Test 001 | Desktop      | 83SF4DZCVG72WDBQ8B8S   | Limited: 40        | 48.00           |                        |
      | qa1+itemized+report+90@decho.com | Report Test 002 | Desktop      | 5EEXTV3AS45EW6G5WRE2   | Shared             | 45.00           |                        |
      | qa1+itemized+report+60@decho.com | Report Test 006 | Desktop      | D8A48F93E2BWADT2FCB8   | Shared             | 2.00            |                        |
      | qa1+itemized+report+60@decho.com | Report Test 005 | Desktop      | G7BVSQ5E44VGDR6QQBS7   | Shared             | 48.00           |                        |
      | qa1+itemized+report+70@decho.com | Report Test 007 | Server       | 2GT3SV5Q4Q5839393E5Q   | Shared             | 32.00           |                        |
      | qa1+itemized+report+70@decho.com | Report Test 008 | Server       | 2AATSASC7Z8SQ8G2TQ7A   | Shared             | 5.00            |                        |
    And I delete machine status itemized TC21200 scheduled report
    When I stop masquerading
    When I act as partner by:
      | name                    |
      | [MozyPro] Delete Device |
    And I build a new report:
      | type           | name                                 | frequency |
      | Machine Status | machine status delete device TC21200 | Daily     |
    Then Report created successful message should be Created Machine Status Report.
    And I clear downloads folder machine-status*.csv file
    And I wait for 30 seconds
    And I download machine status delete device TC21200 scheduled report
    Then Scheduled Machine Status report csv file details should be:
      | Column A              | Column B         | Column C     | Column D               | Column E           | Column F        | Column G               |
      | Username              | Machine Alias    | License Type | Keystring (LicenseKey) | Quota Assigned(GB) | Quota Used (GB) | Last Successful Backup |
      | test004+1108@mozy.com | Itemized Test 02 | Server       | 69QDDS43F29BAFF7ZV4B   | Shared             | 0.00            |                        |
      | test01+1519@mozy.com  | Itemized Test 02 | Desktop      | B6ZDWVF89SDZ4R6EEW92   | Limited: 20        | 15.00           |                        |
    And I delete machine status delete device TC21200 scheduled report
    And I clear downloads folder machine-status*.csv file
    When I stop masquerading
    When I act as partner by:
      | name                                 |
      | Alura Business Solutions[Donot edit] |
    And I build a new report:
      | type           | name                            | frequency |
      | Machine Status | machine status reseller TC21200 | Daily     |
    Then Report created successful message should be Created Machine Status Report.
    And I clear downloads folder machine-status*.csv file
    And I wait for 30 seconds
    And I download machine status reseller TC21200 scheduled report
    Then Scheduled report Machine Status csv file details should include
      | Column A                                  | Column B      | Column C     | Column D               | Column E           | Column F        | Column G               |
      | Username                                  | Machine Alias | License Type | Keystring (LicenseKey) | Quota Assigned(GB) | Quota Used (GB) | Last Successful Backup |
      | redacted-7041859@notarealdomain.mozy.com  | HTPD-SBS11    | Server       | A7QTETS8SVZC642BESDZ   | 40.00              | 2.82            | 2012-04-26 15:37:30    |
      | redacted-17917942@notarealdomain.mozy.com | HCTT-SBS11    | Server       | GGQRQ8FVBR54B6R6DCA7   | 25.00              | 18.76           | 2012-04-26 17:28:55   |
    And I delete machine status reseller TC21200 scheduled report
    And I clear downloads folder machine-status*.csv file

  @TC.21201 @bus @tasks_p2 @reports
  Scenario: 21201:[Scheduled Reports] Verify Resources Added Report
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I build a new report:
      | type            | name                           |
      | Resources Added | resources added bundle TC21201 |
    Then Report created successful message should be Created Resources Added Report.
    And I clear downloads folder resources-added*.csv file
    And I wait for 20 seconds
    And I download resources added bundle TC21201 scheduled report
    Then Scheduled Resources Added report csv file details should be:
      | Column A           | Column B                                | Column C             | Column D     | Column E  | Column F | Column G       | Column H | Column I |
      | Date Applied       | Partner                                 | User Group           | Billing Code | User      | Machine  | Licenses Count | GB Count | Cost     |
      | <%=@current_date%> | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Bundled] Reporting Test | NEW-None             |              |           |          |                | 0.00     |          |
    And I delete resources added bundle TC21201 scheduled report
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I build a new report:
      | type            | name                             |
      | Resources Added | resources added itemized TC21201 |
    Then Report created successful message should be Created Resources Added Report.
    And I clear downloads folder resources-added*.csv file
    And I wait for 20 seconds
    And I download resources added itemized TC21201 scheduled report
    Then Scheduled Resources Added report csv file details should be:
      | Column A           | Column B                                 | Column C             | Column D     | Column E  | Column F | Column G       | Column H | Column I |
      | Date Applied       | Partner                                  | User Group           | Billing Code | User      | Machine  | Licenses Count | GB Count | Cost     |
      | <%=@current_date%> | [DO NOT CHANGE][Itemized] Reporting Test | (default user group) |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned         |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited          |              |           |          |                | 0.00     |          |
      | <%=@current_date%> | [DO NOT CHANGE][Itemized] Reporting Test | NEW-None             |              |           |          |                | 0.00     |          |
    And I delete resources added itemized TC21201 scheduled report
    When I stop masquerading
    When I act as partner by:
      | name                    |
      | [MozyPro] Delete Device |
    And I build a new report:
      | type            | name                                  |
      | Resources Added | resources added delete device TC21201 |
    Then Report created successful message should be Created Resources Added Report.
    And I clear downloads folder resources-added*.csv file
    And I wait for 20 seconds
    And I download resources added delete device TC21201 scheduled report
    Then Scheduled Resources Added report csv file details should be:
      | Column A           | Column B                | Column C             | Column D     | Column E  | Column F | Column G       | Column H | Column I |
      | Date Applied       | Partner                 | User Group           | Billing Code | User      | Machine  | Licenses Count | GB Count | Cost     |
      | <%=@current_date%> | [MozyPro] Delete Device | (default user group) |              |           |          |                | 0.00     |          |
    And I delete resources added delete device TC21201 scheduled report
    And I clear downloads folder resources-added*.csv file
    When I stop masquerading
    When I act as partner by:
      | name                                         |
      | [DO NOT CHANGE][Bundled] Resource Added Test |
    And I build a new report:
      | type            | name                              |
      | Resources Added | resources added overdraft TC21201 |
    Then Report created successful message should be Created Resources Added Report.
    And I clear downloads folder resources-added*.csv file
    And I wait for 20 seconds
    And I download resources added overdraft TC21201 scheduled report
    Then Scheduled Resources Added report csv file details should be:
      | Column A           | Column B                                     | Column C             | Column D     | Column E  | Column F | Column G       | Column H | Column I |
      | Date Applied       | Partner                                      | User Group           | Billing Code | User      | Machine  | Licenses Count | GB Count | Cost     |
      | 05/08/2013         | [DO NOT CHANGE][Bundled] Resource Added Test |                      |              |           |          |                | 5        |          |
      | 05/15/2013         | [DO NOT CHANGE][Bundled] Resource Added Test |                      |              |           |          |                | 5        |          |
      | <%=@current_date%> | [DO NOT CHANGE][Bundled] Resource Added Test | (default user group) |              |           |          |                | 0.00     |          |
    And I delete resources added overdraft TC21201 scheduled report
    And I clear downloads folder resources-added*.csv file

  @TC.21202 @bus @tasks_p2 @reports
  Scenario: 21202:[Scheduled Reports] Verify Machine Over Quota Report
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    # 1%
    And I build a new report:
      | type               | name                        | threshold |
      | Machine Over Quota | machine over quota bundle 1 | 1         |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I clear downloads folder machine-over-quota*.csv file
    And I wait for 20 seconds
    And I download machine over quota bundle 1 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                | Column B             | Column C        | Column D           | Column E        | Column F        |
      | Partner                                 | User Group           | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 001 | Limited: 40        | 36.00           | 90%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 009 | Limited: 20        | 5.00            | 50%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Sync            | Limited: 5         | 4.00            | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 002 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 003 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       | Report Test 004 | Shared             | 6.00            | 66%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       | Report Test 005 | Limited: 4         | 1.00            | 25%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 006 | Limited: 10        | 7.00            | 70%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 007 | Limited: 10        | 1.00            | 14%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 008 | Limited: 10        | 1.00            | 14%             |
    And I delete machine over quota bundle 1 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 10%
    When I build a new report:
      | type               | name                         | threshold |
      | Machine Over Quota | machine over quota bundle 10 | 10        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota bundle 10 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                | Column B             | Column C        | Column D           | Column E        | Column F        |
      | Partner                                 | User Group           | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 001 | Limited: 40        | 36.00           | 90%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 009 | Limited: 20        | 5.00            | 50%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Sync            | Limited: 5         | 4.00            | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 002 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 003 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       | Report Test 004 | Shared             | 6.00            | 66%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       | Report Test 005 | Limited: 4         | 1.00            | 25%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 006 | Limited: 10        | 7.00            | 70%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 007 | Limited: 10        | 1.00            | 14%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 008 | Limited: 10        | 1.00            | 14%             |
    And I delete machine over quota bundle 10 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 60 %
    When I build a new report:
      | type               | name                         | threshold |
      | Machine Over Quota | machine over quota bundle 60 | 60        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota bundle 60 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                | Column B             | Column C        | Column D           | Column E        | Column F        |
      | Partner                                 | User Group           | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 001 | Limited: 40        | 36.00           | 90%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Sync            | Limited: 5         | 4.00            | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 002 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 003 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-2       | Report Test 004 | Shared             | 6.00            | 66%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Limited          | Report Test 006 | Limited: 10        | 7.00            | 70%             |
    And I delete machine over quota bundle 60 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 70 %
    When I build a new report:
      | type               | name                         | threshold |
      | Machine Over Quota | machine over quota bundle 70 | 70        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota bundle 70 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                | Column B             | Column C        | Column D           | Column E        | Column F        |
      | Partner                                 | User Group           | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 001 | Limited: 40        | 36.00           | 90%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Sync            | Limited: 5         | 4.00            | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 002 | Limited: 15        | 12.00           | 80%             |
      | [DO NOT CHANGE][Bundled] Reporting Test | NEW-Assigned-1       | Report Test 003 | Limited: 15        | 12.00           | 80%             |
    And I delete machine over quota bundle 70 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 80 %
    When I build a new report:
      | type               | name                         | threshold |
      | Machine Over Quota | machine over quota bundle 80 | 80        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota bundle 80 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                | Column B             | Column C        | Column D           | Column E        | Column F        |
      | Partner                                 | User Group           | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Bundled] Reporting Test | (default user group) | Report Test 001 | Limited: 40        | 36.00           | 90%             |
    And I delete machine over quota bundle 80 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 90 %
    When I build a new report:
      | type               | name                         | threshold |
      | Machine Over Quota | machine over quota bundle 90 | 90        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota bundle 90 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A | Column B   | Column C     | Column D           | Column E        | Column F        |
      | Partner  | User Group | Machine Name | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
    And I delete machine over quota bundle 90 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 100 %
    When I build a new report:
      | type               | name                          | threshold |
      | Machine Over Quota | machine over quota bundle 100 | 100       |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota bundle 100 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A | Column B   | Column C     | Column D           | Column E        | Column F        |
      | Partner  | User Group | Machine Name | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
    And I delete machine over quota bundle 100 scheduled report
    And I clear downloads folder machine-over-quota*.csv file
    # for itemized partner
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I build a new report:
      | type               | name                          | threshold |
      | Machine Over Quota | machine over quota itemized 1 | 1         |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I clear downloads folder machine-over-quota*.csv file
    And I wait for 20 seconds
    And I download machine over quota itemized 1 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 002 | Shared             | 45.00           | 95%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 003 | Shared             | 35.00           | 81%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 004 | Limited: 10        | 7.00            | 70%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Sync            | Shared             | 5.00            | 71%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 005 | Shared             | 48.00           | 62%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 006 | Shared             | 2.00            | 6%              |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 007 | Shared             | 32.00           | 71%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 008 | Shared             | 5.00            | 27%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Sync            | Shared             | 1.00            | 3%              |
    And I delete machine over quota itemized 1 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 10%
    When I build a new report:
      | type               | name                           | threshold |
      | Machine Over Quota | machine over quota itemized 10 | 10        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota itemized 10 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 002 | Shared             | 45.00           | 95%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 003 | Shared             | 35.00           | 81%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 004 | Limited: 10        | 7.00            | 70%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Sync            | Shared             | 5.00            | 71%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 005 | Shared             | 48.00           | 62%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 007 | Shared             | 32.00           | 71%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 008 | Shared             | 5.00            | 27%             |
    And I delete machine over quota itemized 10 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 60 %
    When I build a new report:
      | type               | name                           | threshold |
      | Machine Over Quota | machine over quota itemized 60 | 60        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota itemized 60 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 002 | Shared             | 45.00           | 95%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 003 | Shared             | 35.00           | 81%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 004 | Limited: 10        | 7.00            | 70%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Sync            | Shared             | 5.00            | 71%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 005 | Shared             | 48.00           | 62%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 007 | Shared             | 32.00           | 71%             |
    And I delete machine over quota itemized 60 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 70 %
    When I build a new report:
      | type               | name                           | threshold |
      | Machine Over Quota | machine over quota itemized 70 | 70        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota itemized 70 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 002 | Shared             | 45.00           | 95%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 003 | Shared             | 35.00           | 81%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Sync            | Shared             | 5.00            | 71%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Limited  | Report Test 007 | Shared             | 32.00           | 71%             |
    And I delete machine over quota itemized 70 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
     # 80 %
    When I build a new report:
      | type               | name                           | threshold |
      | Machine Over Quota | machine over quota itemized 80 | 80        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota itemized 80 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 002 | Shared             | 45.00           | 95%             |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 003 | Shared             | 35.00           | 81%             |
    And I delete machine over quota itemized 80 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 90 %
    When I build a new report:
      | type               | name                           | threshold |
      | Machine Over Quota | machine over quota itemized 90 | 90        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota itemized 90 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 002 | Shared             | 45.00           | 95%             |
    And I delete machine over quota itemized 90 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    # 100 %
    When I build a new report:
      | type               | name                            | threshold |
      | Machine Over Quota | machine over quota itemized 100 | 100       |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota itemized 100 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                                 | Column B     | Column C        | Column D           | Column E        | Column F        |
      | Partner                                  | User Group   | Machine Name    | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | [DO NOT CHANGE][Itemized] Reporting Test | NEW-Assigned | Report Test 001 | Limited: 40        | 48.00           | 120%            |
    And I delete machine over quota itemized 100 scheduled report
    And I clear downloads folder machine-over-quota*.csv file
    When I stop masquerading
    When I act as partner by:
      | name                                 |
      | Alura Business Solutions[Donot edit] |
    And I build a new report:
      | type               | name                           | threshold |
      | Machine Over Quota | machine over quota reseller 90 | 90        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota reseller 90 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A                             | Column B                         | Column C     | Column D           | Column E        | Column F        |
      | Partner                              | User Group                       | Machine Name | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
      | Alura Business Solutions[Donot edit] | 234cb4bf09161846906a021e6a20cc20 | PDSERVER     | 20.00              | 19.00           | 95%             |
      | Alura Business Solutions[Donot edit] | 37904c654228caa7462ffc83a415e09e | IRIDIUM      | 55.00              | 50.53           | 91%             |
      | Alura Business Solutions[Donot edit] | 727ecd288d7afd2f2984737f226d47a2 | ZEUS         | 200.00             | 184.45          | 92%             |
      | Alura Business Solutions[Donot edit] | 9755c4207b687613df43053089606f11 | DANPACI-PC   | 2.00               | 1.86            | 92%             |
      | Alura Business Solutions[Donot edit] | 9755c4207b687613df43053089606f11 | ZEUS         | 155.00             | 147.97          | 95%             |
      | Alura Business Solutions[Donot edit] | c155725dd1a4be316e188cda07a8eeb4 | EBS1         | 90.00              | 85.55           | 95%             |
      | Alura Business Solutions[Donot edit] | e52ee513335ac8a0e57366e7cd2e985a | MAINSRVR     | 100.00             | 91.01           | 91%             |
      | Alura Business Solutions[Donot edit] | feaa5e024383cbb92fe6fe6d855d2542 | CMSBS08      | 12.00              | 10.93           | 91%             |
    And I delete machine over quota reseller 90 scheduled report
    And I close add report section
    And I clear downloads folder machine-over-quota*.csv file
    And I build a new report:
      | type               | name                            | threshold  |
      | Machine Over Quota | machine over quota reseller 100 | 100        |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 20 seconds
    And I download machine over quota reseller 100 scheduled report
    Then Scheduled Machine Over Quota report csv file details should be:
      | Column A | Column B   | Column C     | Column D           | Column E        | Column F        |
      | Partner  | User Group | Machine Name | Quota Assigned(GB) | Quota Used (GB) | % of Quota used |
    And I delete machine over quota reseller 100 scheduled report
    And I clear downloads folder machine-over-quota*.csv file

  @TC.123394 @bus @tasks_p2 @reports
  Scenario: 123394:[Scheduled Reports] Verify Machine Watchlist Report
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | server add-on |
      | 12     | 1     | 100 GB       | 2             |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    And I build a new report:
      | type              | name                       |
      | Machine Watchlist | machine watchlist TC123394 |
    Then Report created successful message should be Created Machine Watchlist Report.
    And I clear downloads folder machine-watchlist*.csv file
    And I download machine watchlist TC123394 scheduled report
    Then Scheduled report Machine Watchlist csv file header should be:
      | Column A | Column B   | Column C | Column D      | Column E    | Column F     | Column G      | Column H   | Column I           |
      | Partner  | User Group | Username | Machine Alias | Last Backup | Last Failure | Error Message | Error Code | Backup In Progress |
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
    And I clear downloads folder machine-watchlist*.csv file

  #################################################################################################


 #  Create/ edit / delete / Deactivate Reports

 #################################################################################################
  @TC.7329 @bus @tasks_p2 @reports
  Scenario: 7329 Create reports with single subscriber
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    And I build a new report:
      | type            | name                   |
      | Billing Summary | billing summary tc7329 |
    Then Billing summary report should be created
    And I wait for 60 seconds
    And I search emails by keywords:
      | to               | content                                       |
      | @new_admin_email | Your billing summary tc7329 - Billing Summary |
    Then I should see 1 email(s)
    And I build a new report:
      | type           | name                  | recipients             |
      | Billing Detail | billing detail tc7329 | <%=create_user_email%> |
    Then Billing detail report should be created
    And I wait for 60 seconds
    And I search emails by keywords:
      | to                        | content                                     |
      | <%=@recipients_array[0]%> | Your billing detail tc7329 - Billing Detail |
    Then I should see 1 email(s)
    And I build a new report:
      | type              | name                     |
      | Machine Watchlist | machine watchlist tc7329 |
    Then Report created successful message should be Created Machine Watchlist Report.
    And I wait for 60 seconds
    And I search emails by keywords:
      | to               | content                                           |
      | @new_admin_email | Your machine watchlist tc7329 - Machine Watchlist |
    Then I should see 1 email(s)
    And I build a new report:
      | type           | name                  | recipients             |
      | Machine Status | machine status tc7329 | <%=create_user_email%> |
    Then Report created successful message should be Created Machine Status Report.
    And I wait for 60 seconds
    And I search emails by keywords:
      | to                        | content                                     |
      | <%=@recipients_array[0]%> | Your machine status tc7329 - Machine Status |
    Then I should see 1 email(s)
    And I build a new report:
      | type               | name                      | recipients             |
      | Machine Over Quota | machine over quota tc7329 | <%=create_user_email%> |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 60 seconds
    And I search emails by keywords:
      | to                        | content                                             |
      | <%=@recipients_array[0]%> | Your machine over quota tc7329 - Machine Over Quota |
    Then I should see 1 email(s)
    # legacy bug 144781 for Resources Added report when partner has no machine.
    And I build a new report:
      | type            | name                   |
      | Resources Added | resources added tc7329 |
    Then Report created successful message should be Created Resources Added Report.
    And I wait for 60 seconds
    And I search emails by keywords:
      | to               | content                                       |
      | @new_admin_email | Your resources added tc7329 - Resources Added |
    Then I should see 1 email(s)
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.7330 @bus @tasks_p2 @reports
  Scenario: 7330 Create reports with multiple subscriber
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    And I build a new report:
      | type            | name                   | multiple recipients                            |
      | Billing Summary | billing summary tc7330 | <%=create_user_email%>; <%=create_user_email%> |
    Then Billing summary report should be created
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                       |
      | <%=@recipients_array[0]%> | Your billing summary tc7330 - Billing Summary |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                       |
      | <%=@recipients_array[1]%> | Your billing summary tc7330 - Billing Summary |
    Then I should see 1 email(s)
    And I build a new report:
      | type           | name                  | multiple recipients                            |
      | Billing Detail | billing detail tc7330 | <%=create_user_email%>; <%=create_user_email%> |
    Then Billing detail report should be created
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                     |
      | <%=@recipients_array[0]%> | Your billing detail tc7330 - Billing Detail |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                     |
      | <%=@recipients_array[1]%> | Your billing detail tc7330 - Billing Detail |
    Then I should see 1 email(s)
    And I build a new report:
      | type              | name                     | multiple recipients                            |
      | Machine Watchlist | machine watchlist tc7330 | <%=create_user_email%>; <%=create_user_email%> |
    Then Report created successful message should be Created Machine Watchlist Report.
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                           |
      | <%=@recipients_array[0]%> | Your machine watchlist tc7330 - Machine Watchlist |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                           |
      | <%=@recipients_array[1]%> | Your machine watchlist tc7330 - Machine Watchlist |
    Then I should see 1 email(s)
    And I build a new report:
      | type           | name                  | multiple recipients                            |
      | Machine Status | machine status tc7330 | <%=create_user_email%>; <%=create_user_email%> |
    Then Report created successful message should be Created Machine Status Report.
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                     |
      | <%=@recipients_array[0]%> | Your machine status tc7330 - Machine Status |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                     |
      | <%=@recipients_array[1]%> | Your machine status tc7330 - Machine Status |
    Then I should see 1 email(s)
    And I build a new report:
      | type               | name                      | multiple recipients                            |
      | Machine Over Quota | machine over quota tc7330 | <%=create_user_email%>; <%=create_user_email%> |
    Then Report created successful message should be Created Machine Over Quota Report.
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                             |
      | <%=@recipients_array[0]%> | Your machine over quota tc7330 - Machine Over Quota |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                             |
      | <%=@recipients_array[1]%> | Your machine over quota tc7330 - Machine Over Quota |
    Then I should see 1 email(s)
    # legacy bug 144781 for Resources Added report when partner has no machine.
    And I build a new report:
      | type            | name                   | multiple recipients                            |
      | Resources Added | resources added tc7330 | <%=create_user_email%>; <%=create_user_email%> |
    Then Report created successful message should be Created Resources Added Report.
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                       |
      | <%=@recipients_array[0]%> | Your resources added tc7330 - Resources Added |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                       |
      | <%=@recipients_array[1]%> | Your resources added tc7330 - Resources Added |
    Then I should see 1 email(s)
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.7345 @bus @tasks_p2 @reports
  Scenario: 7345 Edit report - add recipients
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I build a new report:
      | type            | name                     | frequency |
      | Billing Summary | billing summary test7345 | Daily     |
    Then Billing summary report should be created
    And I close add report section
    When I add more recipients to report billing summary test7345
      | more recipients                                |
      | <%=create_user_email%>; <%=create_user_email%> |
    Then Report updated successful message should be Updated Billing Summary Report.
    And I run report billing summary test7345
    And I wait for 50 seconds
    And I search emails by keywords:
      | to                        | content                                         | after |
      | <%=@recipients_array[0]%> | Your billing summary test7345 - Billing Summary | today |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                         | after |
      | <%=@recipients_array[1]%> | Your billing summary test7345 - Billing Summary | today |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                        | content                                         | after |
      | <%=@recipients_array[2]%> | Your billing summary test7345 - Billing Summary | today |
    Then I should see 2 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.7352 @bus @tasks_p2 @reports
  Scenario: 7352 Deactive a report
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I get partner id by admin email from database
    When I act as newly created partner account
    And I build a new report:
      | type            | name                     | frequency |
      | Billing Summary | billing summary test7352 | Daily     |
    Then Billing summary report should be created
    And billing summary test7352 scheduled report Next Run value should be tomorrow
    And I close add report section
    And I wait for 30 seconds
    And I search emails by keywords:
      | to               | content                                         | after |
      | @new_admin_email | Your billing summary test7352 - Billing Summary | today |
    Then I should see 1 email(s)
    And I run report billing summary test7352
    When I inactive billing summary test7352 scheduled report
    Then billing summary test7352 scheduled report Next Run value should be Inactive
    And billing summary test7352 scheduled report History value should be 2 reports
    # wait for 1 day and 1 min
    #And I wait for 86460 seconds
    #And I search emails by keywords:
    #  | to               | content                                         | after |
    #  | @new_admin_email | Your billing summary test7352 - Billing Summary | today |
    #Then I should see 0 email(s)
    #And I navigate to bus admin console login page
    Then no report is scheduled for this partner
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.7356 @bus @tasks_p2 @reports @24hours
  Scenario: 7356 Delete a report
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I get partner id by admin email from database
    When I act as newly created partner account
    And I build a new report:
      | type            | name                     | frequency |
      | Billing Summary | billing summary test7356 | Daily     |
    Then Billing summary report should be created
    And I delete billing summary test7356 scheduled report
    Then I should see No results found in scheduled reports list
    # wait for 1 day and 1 min
    #And I wait for 86460 seconds
    #And I search emails by keywords:
    #  | to               | content                                         | after |
    #  | @new_admin_email | Your billing summary test7352 - Billing Summary | today |
    #Then I should see 0 email(s)
    #And I navigate to bus admin console login page
    And no report is scheduled for this partner
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
