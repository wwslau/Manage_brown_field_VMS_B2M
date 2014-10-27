require 'csv'

def capture_managed_vm
  my_managed = 'csa_vm_details.txt'
  $managed_vm_array = Array.new
  # Load my_managed_vm into an array
  puts ("***********************")
  managed_vm = CSV.read(my_managed)
  managed_vm.shift
  managed_vm.shift
  managed_vm.each do |line|
  	vm_name = line[0]
  	vm_name = vm_name.strip
  	#puts(vm_name)	
  	$managed_vm_array.push(vm_name)
  end
  puts ("Managed_vm = " + $managed_vm_array.length.to_s)
end

capture_managed_vm

my_vm_details = 'my_vm.csv'
my_env_file = 'new_vm_details.csv'
vm_array = []

vm_detail = CSV.read(my_vm_details)
vm_detail.shift

my_file_hander = File.open(my_env_file, 'w')

# need to write header to my_env_file to make it a complete csv
my_file_hander.puts('vc,owner,managed_by_csa,env_name,server_group_name,vm_id,uuid,name,overall_status,ip_address,mac_address,datacenter,cluster_compute_resource,resource_pool')
vm_num = 1
vm_detail.each do |line|
	item_count=0
	vc = line[item_count]

	item_count+=1
	owner = line[item_count]

	item_count+=1
	managed_by_csa  = line[item_count]

	item_count+=1
	env_name = line[item_count]

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
	cluster_compute_resource = line[item_count]

	item_count+=1
	resource_pool = line[item_count]

	# check if vmname exists in my_vm_details
	# if y, mark 'Y'
	exist_mark = 'N'
	if $managed_vm_array.include?(name)
		puts (vm_num)
		vm_num += 1
		puts (vm_num.to_s + ' ' + name + '=Y')
		exist_mark = 'Y'
	end

#	if !(ip_address.to_s == 'n/a') 
#		my_file_hander.puts('<Server ip_address="'+ip_address.to_s+'" mac_address="'+mac_address.to_s + '" uuid="' + uuid.to_s + '" />')
#	end

	my_file_hander.write(vc.to_s + ',')
	my_file_hander.write(owner.to_s + ',')
	my_file_hander.write(exist_mark.to_s + ',')
	my_file_hander.write(env_name.to_s + ',')
	my_file_hander.write(server_group_name.to_s + ',')
	my_file_hander.write(vm_id.to_s + ',')
	my_file_hander.write(uuid.to_s + ',')
	my_file_hander.write(name.to_s + ',')
	my_file_hander.write(overall_status.to_s + ',')
	my_file_hander.write(ip_address.to_s + ',')
	my_file_hander.write(mac_address.to_s + ',')
	my_file_hander.write(datacenter.to_s + ',')
	my_file_hander.write(cluster_compute_resource.to_s + ',')
	my_file_hander.puts(resource_pool.to_s)
end

my_file_hander.close
puts ("***********************")
