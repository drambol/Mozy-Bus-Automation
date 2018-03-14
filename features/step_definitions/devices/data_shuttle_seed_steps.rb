When /^I set the data shuttle seed status:$/ do |seed_status_table|
attributes = seed_status_table.hashes.first

status = attributes["status"] || "seeding"
seed_complete = attributes["seed complete"] || "false"
total_files = attributes["total files"] || 0
total_bytes = attributes["total bytes"] || 0
total_files_seeded = attributes["total files seeded"] || 0
total_bytes_seeded = attributes["total bytes seeded"] || 0
username = attributes["username"] || @clients.last.username
attributes["password"].replace ERB.new(attributes["password"]).result(binding) unless attributes["password"].nil?
password = attributes["password"] || @clients.last.password
machine_hash = attributes["machine_hash"] || @clients.last.machine_hash

set_seed_status_client(@seed_id, status,seed_complete,total_files,total_bytes,total_files_seeded,total_bytes_seeded, @admin_id, username, password, machine_hash)
end
