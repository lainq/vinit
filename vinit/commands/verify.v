module commands

import os { getwd, join_path }

fn generate_project_directory(name string) string {
	if (name == '.') || (name.len == 0) {
		return getwd()
	} else {
		return join_path(getwd(), name)
	}
}

fn check_version_string(version string) string {
	default_version := '1.0.0'
	statement := version.split('.')
	if statement.len != 3 {
		return default_version
	} else {
		return version
	}
}

fn generate_tag_string(tags string) string {
	tag_array := tags.split(',').map(fn (character string) string {
		return character.trim(' ')
	})
	return "[ ${tag_array.join(', ')} ]"
}