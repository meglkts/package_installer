def format_input(input_array)
	input_array.map { |package| package.split(": ") }
end

def dependency_hash(input_array)
	dependencies = {}

	format_input(input_array).each do | package |
		dependencies[package[0]] = package[1]
	end
	dependencies
end

def no_dependency_packages(formatted_array)
	formatted_array.select { |package| package.length == 1 }.flatten
end

def valid_input?(input_array, installation_order)
	input_array.count == installation_order.count 
end

def order_packages(input_array)
	installation_order = []
	dependencies = dependency_hash(input_array)

	installation_order.concat(no_dependency_packages(format_input(input_array)))

	installation_order.each do | package |
		if dependency = dependencies.key(package)
			installation_order << dependency
		end
	end
	
	if valid_input?(input_array, installation_order)
		installation_order
	else
		raise Exception.new("Package set contains cycle")
	end
end

def installation_order_to_s(input_array)
	order_packages(input_array).join(", ")
end

# invalid = ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: ','Ice: Leetmeme']
# valid = ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: Leetmeme','Ice: ']

# # p order_packages(invalid)
# p order_packages(valid)


