module arguments

import commands { initialize_v_project, execute_v_script }

pub fn execute_command(command CurrentCharacterType, parameters map[string]string) {
	if (command as string) == "arguments.CurrentCharacterType('init')" {
		initialize_v_project()
	} else {
		execute_v_script(command as string, parameters)
	}

}
