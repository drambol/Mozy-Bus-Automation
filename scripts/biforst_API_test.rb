require File.expand_path('../../lib/bifrost_helper/bifrost_helper', __FILE__)
require 'json'

include BifrostHelper

#partner_to_delete = Subpartner.new('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb')
#puts partner_to_delete.get(3542147)
#puts partner_to_delete.delete(3542147)


#======create partner======
#partner_to_add = Subpartner.new('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb') # bifrost service api-key
#body = Hash.new
#body['name'] = 'Partner Created by Bifrost api'
#body['partner_id'] = 31391 # MozyOEM
#body['username'] = "mozyautotest+bifrost#{Time.now.to_i}@emc.com"
##body['full_name'] = 'Thomas Yu'
#body['pro_plan_id'] = 1 # monthly invoiced of MozyOEM
##body['root_role_id'] = 542 # OEM Partner Admin
#puts partner_to_add.add(body)

#======create user group======
#ug = UserGroup.new('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb')
#body = Hash.new
#body['partner_id'] = 426319
#body['name'] = 'user_group1'
#puts ug.add('MozyPro', body)


#======create user======
#user_to_add = User.new('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb')
#body = Hash.new
#body['user_group_id'] = 977918
#body['username'] = 'hellworld_1101@emc.com'
#body['password'] = 'QAP@SSW0rd'
#body['name'] = 'test'
#body['type'] = 'Desktop'
#body['machines_count'] = 2
#puts user_to_add.add(body)


#machine = BifrostHelper::Machine.new('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb')
machine = BifrostHelper::Machine.new('iTmUDsoeHzd8KuQxOz5Y9vtIBUcmeRTIxuCTUcEZzm2jmGAOIYDws2dDxg2fuhZb')
body = Hash.new
body['user_id'] = 27368055  #user under (default user group)
body['type'] = 'desktop'
body['name'] = 'machine001'
#body['external_id'] = 'bilibili'
puts machine.add(body)