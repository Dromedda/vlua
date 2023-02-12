-- VLUA 
-- Made By Erik Dromedda Gustafsson

local operations = {}
operations["!="] = "~="
operations["fn"] = "function"
operations["import"]   = "require"

local search_patterns = {}
search_patterns["!="] = "!="
search_patterns["fn"] = "fn"
search_patterns["import"] = "import"

function parse(_path, _target)
	if (_path == ".") then 
		error("Directory compilation is not implemented yet")
	else 
		local output = generate_output(_path, _target)
		print("Output:")
		for k, v in pairs(output) do 
			print(v)
		end

		print("Use: lua ".. _target.. " ")
		print("to run the program")
	end
end

function generate_output(_file, _target)
	local ret = parse_file(_file)
	local file =	io.open(_target, "w")
	local string_output = ""
	for _, v in pairs(ret) do 
		string_output = string_output.. v.. ";"
	end
	file:write(string_output)
	file:close()
	return ret	
end

function parse_file(_file_path)	
	local lines_from_file = lines_from(_file_path)
	local output = {}
	local ret = {}
	for _,line in pairs(lines_from_file) do 
		local tokens = get_tokens(line)
		for _, token in pairs(tokens) do
			table.insert(output, token)
		end
		table.insert(output, line)
	end
	local output_index = 1
	for i = 1, #output, 1 do
		if (output[output_index] ~= lines_from_file[i]) then 
			table.insert(ret, output[output_index])
			output_index = output_index + 1
		else 
			table.insert(ret, lines_from_file[i])
		end
		output_index = output_index + 1
	end
	return ret
end

function get_tokens(_line)
	local result = {}
	for k, v in pairs(search_patterns) do 
		local new_line = string.gsub(_line, v, operations[k])
		if (new_line ~= _line) then
			table.insert(result, new_line)
		end
	end
	return result
end

function file_exists(_file)
  local f = io.open(_file, "rb")
  if f then f:close() end
  return f ~= nil
end

function lines_from(_file)
  if not file_exists(_file) then return {} end
  lines = {}
  for line in io.lines(_file) do 
    lines[#lines + 1] = line
  end
  return lines
end

parse(arg[1], arg[2])