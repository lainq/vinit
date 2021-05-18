module commands

import generate { Files }
import prompt { PromptOptions, prompt }
import exception { VinitException }
import os { hostname, join_path, write_file }

fn write_files(files map[string]string, path string) {
	for key, value in files {
		write_file(join_path(path, key), value) or { panic(err) }
	}
}

fn prompt_user(questions []string, suffix string) map[string]string {
	mut solutions := map[string]string{}
	for index := 0; index < questions.len; index++ {
		current_prompt_message := questions[index]
		data := prompt(PromptOptions{
			message: current_prompt_message
			suffix: suffix
		})
		solutions[current_prompt_message] = data
	}
	return solutions
}

pub fn initialize_v_project() int {
	mut project_settings := prompt_user([
		'name',
		'version',
		'description',
		'repo_url',
		'author',
		'tags',
		'vcs',
		'license',
	], '[?]')
	for key, value in project_settings {
		if key == 'name' {
			project_settings[key] = generate_project_directory(value)
		} else if key == 'version' {
			project_settings[key] = check_version_string(value)
		} else if key == 'tags' {
			project_settings[key] = generate_tag_string(value)
		}
	}
	files := Files{
		path: project_settings['name']
		files: ['README.md', 'v.toml', 'v.mod', '.env']
		directories: ['scripts', 'json', 'docs', 'src', join_path('src', 'tests')]
	}
	files.create() or {
		error := VinitException{
			exception_message: err.msg
			fatal: true
		}
		error.raise()
		return 1
	}

	write_files(map{
		'v.toml':                                              toml
		'.env':                                                'HOSTNAME=$hostname()'
		join_path('docs', 'README.md'):            '# Documentation'
		join_path('scripts', filename()): script
		'v.mod':                                               create_module(project_settings)
	}, project_settings['name'])
	return 0
}
