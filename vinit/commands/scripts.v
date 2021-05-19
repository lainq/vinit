module commands

import os { args, getwd, is_file, join_path, read_file }
import exception { VinitException }

struct ScriptFileParser {
	data []string
}

fn (parser ScriptFileParser) parse() {
	for line in parser.data {
		println(line)
	}
}

struct ScriptsFile {
	filename string
	root     string
mut:
	exists bool
}

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

		println(file_content)
	}
}
