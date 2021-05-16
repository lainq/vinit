module prompt

import os

pub struct PromptOptions {
	message string [required]
	suffix string = '[?]'
	repeat bool
}

pub struct Choices {
	choices []string [required]
}

pub fn prompt(options PromptOptions) string {
	user_input := os.input('${options.message} ${options.suffix} ')
	return user_input
}

pub fn choices(options PromptOptions, choice Choices, repeat bool) string {
	println('${options.message} ${options.suffix} ')
	mut valid_user_inputs := []string{}
	for choice_index := 0; choice_index < choice.choices.len; choice_index++ {
		current_choice := choice.choices[choice_index]
		println('${choice_index+1}) $current_choice')
		valid_user_inputs << (choice_index + 1).str()
	}
	user_input := os.input('')

	if user_input !in valid_user_inputs{
		if repeat {
			choices(options, choice, repeat)
		} else {
			println("Invalid input")
			return user_input
		}
	}
	return choice.choices[(user_input).int() - 1]
}