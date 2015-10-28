def format_input(array)
	array.map { |package| package.split(": ") }
end

def no_dependency_packages(formatted_array)
	formatted_array.select { |package| package.length == 1 }.flatten
end

def order_packages(input_array)
	package_order = []
	packages_to_install = format_input(input_array)

	package_order.concat(no_dependency_packages(packages_to_install))
	packages_to_install.delete_if {|package| package.length == 1}

	packages_to_install.each do | package |
		if package_order.include?(package[1])
			package_order << package[0] unless package_order.include?(package[0])
		else
			package_order.push(package[1], package[0])
		end
	end
	package_order
end

def installation_order(input_array)
	order_packages(input_array).join(", ")
end
