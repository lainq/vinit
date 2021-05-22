module arguments

import commands { execute_v_script, initialize_v_project, get, install, DependencyFiles }
import os { getwd }

pub fn execute_command(command CurrentCharacterType, parameters map[string]string) {
	if (command as string) == "arguments.CurrentCharacterType('init')" {
		initialize_v_project()
	} else if (command as string) == "arguments.CurrentCharacterType('get')" {
		get()
	} else if (command as string) == "arguments.CurrentCharacterType('install')" {
		install(mut DependencyFiles{
			dirname : getwd(),
			filename : 'vinit.get'
		})
	} else{
		execute_v_script(command as string)
	} 
}
