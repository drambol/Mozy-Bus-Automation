Feature: Product download

  Background:
    Given I have login freyja as ent user

  @TC.121707 @freyja @freyja_smoke  @ent  @ent_product_download @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user view product download through Freyja
  When I select options menu
  And I select Product Downloads
  And I click backup download
  And I click View website
#  When I select options menu
#  And I logout
