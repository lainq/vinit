module arguments

import commands { initialize_v_project }

pub fn execute_command(command CurrentCharacterType, parameters map[string]string) {
		if (command as string) == "arguments.CurrentCharacterType('init')" {
			initialize_v_project()
		}
}