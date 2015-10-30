def format_input(packages_to_install)
	packages_to_install.map { |package| package.split(": ") }
end

def find_dependencies(packages_to_install)
	dependencies = {}

	format_input(packages_to_install).each do | package |
		dependencies[package[0]] = package[1]
	end
	dependencies
end

def independent_packages(packages_to_install)
	format_input(packages_to_install).select { |package| package.length == 1 }.flatten
end

def valid_package_set?(packages_to_install, installation_order)
	packages_to_install.count == installation_order.count 
end

def order_packages(packages_to_install)
	installation_order = []
	dependency_index = find_dependencies(packages_to_install)

	installation_order.concat(independent_packages(packages_to_install))

	installation_order.each do | package |
		if dependent_package = dependency_index.key(package)
			installation_order << dependent_package
		end
	end
	
	if valid_package_set?(packages_to_install, installation_order)
		installation_order
	else
		raise Exception.new("Package set contains cycle")
	end
end

def installation_order_to_s(packages_to_install)
	order_packages(packages_to_install).join(", ")
end

# invalid = ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: ','Ice: Leetmeme']
# valid = ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: Leetmeme','Ice: ']

# # p order_packages(invalid)
# p order_packages(valid)


