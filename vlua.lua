-- VLUA 
-- By Erik "Dromedda" Gustafsson

local operations = {}
operations["!="] = "~="
operations["fn"] = "function"
operations["import"]   = "require"
operations["let"] = "local"

local search_patterns = {}
search_patterns["!="] = "!="
search_patterns["fn"] = "fn"
search_patterns["import"] = "import"
search_patterns["let"] = "let"

function parse(_path, _target)
	if (_path == ".") then 
		error("Directory compilation is not implemented yet")
	else 
		print("Path: ".. _path, "Target: ".. _target)
		generate_output(_path, _target)
		print("Use: lua ".. _target)
		print("To run the program")
	end
end

function generate_output(_file, _target)
	print("Reading Source File: ".. _file)
	local ret = parse_file(_file)
	print("Writing to file... ".. _target)
	local file =	io.open(_target, "w")
	local string_output = ""
	for _, v in pairs(ret) do 
		-- NOTE: This is the hex for LF, i.e. it doesnt work on windows(?) because windows use CR-LF
		string_output = string_output.. v.. string.format("%-5s", "\x0A")
	end
	file:write(string_output)
	file:close()
	print("Success!")
	return ret	
end

function parse_file(_file_path)	
	local lines_from_file = lines_from(_file_path)
	local modified_return = {}
	local ret = {}
	for _,line in pairs(lines_from_file) do 
		local tokens = tokenize(line)
		for _, token in pairs(tokens) do
			table.insert(modified_return, token)
		end
		table.insert(modified_return, line)
	end
	local modified_return_index = 1
	for i = 1, #modified_return, 1 do
		if (modified_return[modified_return_index] ~= lines_from_file[i]) then 
			table.insert(ret, modified_return[modified_return_index])
			modified_return_index = modified_return_index + 1
		else 
			table.insert(ret, lines_from_file[i])
		end
		modified_return_index = modified_return_index + 1
	end
	return ret
end

function tokenize(_line)
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