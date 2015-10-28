def format_input(array)
	array.map { |package| package.split(": ") }
end

def no_dependency_packages(formatted_array)
	formatted_array.select { |package| package.length == 1 }.flatten
end

def dependency_hash(input_array)
	dependencies = {}
	format_input(input_array).each do | package |
		dependencies[package[0]] = package[1]
	end
	dependencies
end

def order_packages(input_array)
	package_order = []
	packages_to_install = format_input(input_array)

	package_order.concat(no_dependency_packages(packages_to_install))
	# packages_to_install.delete_if {|package| package.length == 1}

	package_order.each do | package |
		
	end
	package_order
end

def installation_order(input_array)
	order_packages(input_array).join(", ")
end

# ["Fraudstream: Leetmeme", "Cyberportal: Ice", "Leetmeme: Cyberportal", "CamelCaser: KittenService", "Ice: ", "KittenService: "]

# Ice
# KittenService
