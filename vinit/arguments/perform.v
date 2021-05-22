module arguments

import commands { 
	DependencyFiles, 
	execute_v_script, 
	get, 
	initialize_v_project, 
	install
 }
import os { getwd }

pub fn execute_command(command CurrentCharacterType, parameters map[string]string) {
	if (command as string) == "arguments.CurrentCharacterType('init')" {
		initialize_v_project()
	} else if (command as string) == "arguments.CurrentCharacterType('get')" {
		get()
	} else if (command as string) == "arguments.CurrentCharacterType('install')" {
		install(mut DependencyFiles{
			dirname: getwd()
			filename: 'vinit.get'
		})
	} else {
		execute_v_script(command as string)
	}
}
