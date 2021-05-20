module commands

import os { args, getwd, is_file, join_path, read_file }
import exception { VinitException }

struct InvalidCommandException {
	message    string
	suggestion string
	fatal      bool
}

fn (params InvalidCommandException) throw_exception() {
	error := VinitException{
		exception_message: params.message
		exception_suggestion: params.suggestion
		fatal: params.fatal
	}
	error.raise()
}

fn replace_statement_variables(mut variables map[string]string) map[string]string {
	for key, value in variables {
		mut value_array := value.split(' ')
		for index := 0; index < value_array.len; index++ {
			if value_array[index].starts_with('$') {
				variable_name := value_array[index][1..]
				if variable_name in variables {
					value_array[index] = variables[variable_name]
				}
			}
		}
		variables[key] = value_array.join(' ')
	}
	return variables
}

struct ScriptFileParser {
	data []string
mut:
	scripts map[string]string = map{}
}

fn map_filter(data map[string]string, value string) string {
	for key, element in data {
		if element == value {
			return key
		}
	}
	return ''
}

fn (mut parser ScriptFileParser) parse(filename string) map[string]string {
	mut line_count := 0
	for line in parser.data {
		if line.len == 0 || line.starts_with('#') {
			continue
		}
		statements := line.split('=')
		name := statements[0].trim(' ')
		value := statements[1..].join('=').trim(' ')
		if name.len == 0 {
			InvalidCommandException{
				message : 'Variables names cannot be of length less than 1.',
				suggestion : 'line number ${line_count + 1} in $filename',
				fatal : true
			}.throw_exception()
		}
		if name in parser.scripts {
			InvalidCommandException{
				message : 'Found duplicate variable name - $name',
				suggestion : 'line number ${line_count + 1} in $filename',
				fatal : true
			}.throw_exception()
		}

		duplicate_variables := map_filter(parser.scripts, value)
		if duplicate_variables.len != 0 {
			println('[WARNING] Found duplicate for variable $${duplicate_variables} : $name')
		}

		parser.scripts[name] = value
		line_count += 1
	}
	return parser.scripts
}

struct ScriptsFile {
	filename string
	root     string
mut:
	exists bool
}


fn find_script_file(script_file ScriptsFile) bool {
	filepath := join_path(script_file.root, script_file.filename)
	return is_file(filepath)
}

pub fn execute_v_script(script string, variables map[string]string) {
	mut file := ScriptsFile{
		filename: 'v.scripts'
		root: getwd()
	}
	file.exists = find_script_file(file)
	if !file.exists {
		InvalidCommandException{
			message: '${args[1..][0]} is not a command'
			fatal: true
		}.throw_exception()
	} else {
		file_content := read_file(join_path(file.root, file.filename)) or {
			panic(err)
			return
		}

		mut parser := ScriptFileParser{
			data : file_content.split_into_lines()
		}
	    mut scripts := parser.parse(file.filename)
		data := replace_statement_variables(mut scripts)
		println(data)
	}
}
