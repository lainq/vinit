module commands

import os { getwd, join_path, user_os }

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
	return '[ ${tag_array.join(', ')} ]'
}

fn filename() string {
	if user_os() == 'windows' {
		return 'script.ps1'
	} else {
		return 'script.sh'
	}
}

fn create_module(project_settings map[string]string) string {
	return '
Module {
	name : ${project_settings['name']},
	version : ${project_settings['version']},
	description : ${project_settings['description']},
	repo_url : ${project_settings['repo_url']},
	author : ${project_settings['author']},
	tags : ${project_settings['tags']},
	vcs : ${project_settings['vcs']},
	license : ${project_settings['license']}
}
	'
}
