module env

import os { is_file, read_file, setenv }

fn load(variables []EnvironmentVariable) {
	for index := 0; index < variables.len; index++ {
		current := variables[index]
		setenv(current.variable_name, current.variable_value, true)
	}
}

pub fn loadenv(filename string) ?int {
	if is_file(filename){
		file_content := read_file(filename) or {
			panic('Error reading $filename')
			return 0
		}
		data := create_env_variables(tokenise(file_content)) or {
			panic(err)
			return 0
		}
		load(data)
		return 0
	} else {
		return error('$filename is not a file')
	}
}