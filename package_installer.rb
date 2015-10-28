def format_input(array)
	array.map {|package| package.split(": ")}
end