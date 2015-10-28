def format_input(array)
	array.map { |package| package.split(": ") }
end

def no_dependency_packages(formatted_array)
	formatted_array.select { |package| package.length == 1 }.flatten
end


