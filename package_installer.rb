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

def order_packages(input_array)
	installation_order = []
	dependencies = dependency_hash(input_array)

	installation_order.concat(no_dependency_packages(format_input(input_array)))

	installation_order.each do | package |
		if dependency = dependencies.key(package)
			installation_order << dependency
		end
	end
	installation_order
end

def installation_order_to_s(input_array)
	order_packages(input_array).join(", ")
end