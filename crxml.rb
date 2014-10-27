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
  puts ("Managed_vm = " + managed_vm_array.length.to_s)
end

class Vm_details
  def initialize(line)
    	item_count=0
    	@vc = line[item_count]

    	item_count+=1
    	@owner = line[item_count]

    	item_count+=1
    	@managed_by_csa  = line[item_count]

    	item_count+=1
    	@env_name = line[item_count]

    	item_count+=1
    	@server_group_name = line[item_count]

    	item_count+=1
    	@vm_id = line[item_count]

    	item_count+=1
    	@uuid = line[item_count]

    	item_count+=1
    	@name = line[item_count]

    	item_count+=1
    	@overall_status = line[item_count]

    	item_count+=1
    	@ip_address = line[item_count]

    	item_count+=1
    	@mac_address = line[item_count]

    	item_count+=1
    	@datacenter = line[item_count]

    	item_count+=1
    	@cluster_compute_resource = line[item_count]

    	item_count+=1
    	@resource_pool = line[item_count]
  end
  
  attr_reader :ip_address, :vc, :owner
  
  def to_s
  		return ('<Server ip_address="'+@ip_address.to_s+'" mac_address="'+@mac_address.to_s + '" uuid="' + @uuid.to_s + '" />')    
  end
end

my_vm_details = 'new_vm_details.csv'

puts ("User name=")
my_user_name = gets.chomp

puts ("VC=")
my_vc = gets.chomp

puts (my_user_name)
puts (my_vc)

my_env_file = my_user_name.to_s + '_env_file_' + my_vc.to_s + '.csv'
vm_array = []

vm_detail = CSV.read(my_vm_details)
vm_detail.shift

my_file_hander = File.open(my_env_file, 'w')

my_file_hander.puts('<Env name="Wilson-app">')
my_file_hander.puts('<ServerGroup name="Wilson-app-group" providerType="VMWARE_VCENTER">')

vm_num = 1
vm_detail.each do |line|
  my_vm = Vm_details.new(line)

	if !(my_vm.ip_address.to_s == 'n/a') && my_vm.vc==my_vc && my_vm.owner==my_user_name
		my_file_hander.puts(my_vm.to_s)
	end
end

my_file_hander.puts('</ServerGroup>')
my_file_hander.puts('</Env>')

my_file_hander.close
puts ("***********************")
