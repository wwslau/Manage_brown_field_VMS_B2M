require 'csv'

vm_array = []
#vm_detail = CSV.read('MoffettLab_vCenter_wilson.csv')
vm_detail = CSV.read('a.csv')
vm_detail.shift

my_env_file = 'wilson_env.xml'
my_file_hander = File.open(my_env_file, 'w')

my_file_hander.puts('<Env name="Wilson-app">')
my_file_hander.puts('<ServerGroup name="Wilson-app-group" providerType="VMWARE_VCENTER">')
vm_detail.each do |line|
	item_count=0
	vc = line[item_count]

	item_count+=1
	owner = line[item_count]

	item_count+=1
	managed_bycsa  = line[item_count]

	item_count+=1
	server_group_name = line[item_count]

	item_count+=1
	vm_id = line[item_count]

	item_count+=1
	uuid = line[item_count]

	item_count+=1
	name = line[item_count]

	item_count+=1
	overall_status = line[item_count]

	item_count+=1
	ip_address = line[item_count]

	item_count+=1
	mac_address = line[item_count]

	item_count+=1
	datacenter = line[item_count]

	item_count+=1
	cluster_computer_resource = line[item_count]

	item_count+=1
	resource_pool = line[item_count]

	if !(ip_address.to_s == 'n/a') 
		my_file_hander.puts('<Server ip_address="'+ip_address.to_s+'" mac_address="'+mac_address.to_s + '" uuid="' + uuid.to_s + '" />')
	end
end
my_file_hander.puts('</ServerGroup>')
my_file_hander.puts('</Env>')

my_file_hander.close
