module commands

import generate { Files }
import prompt { prompt, PromptOptions }

fn prompt_user(questions []string, suffix string) map[string]string {
	mut solutions := map[string]string{}
	for index := 0; index < questions.len; index++ {
		current_prompt_message := questions[index]
		data := prompt(PromptOptions{
			message : current_prompt_message,
			suffix : suffix
		})
		solutions[current_prompt_message] = data
	}
	return solutions
}

pub fn initialize_v_project() int {
	mut project_settings := prompt_user(
		[
			'name',
			'version',
			'description',
			'repo_url',
			'author',
			'tags',
			'vcs',
			'license'
		], '[?]'
	)
	for key, value in project_settings {
		if key == 'name' {
			project_settings[key] = generate_project_directory(value)
		} else if key == 'version' {
			project_settings[key] = check_version_string(value)
		} else if key == 'tags' {
			project_settings[key] = generate_tag_string(value)
		}
	}
	println(project_settings)
	return 0
}