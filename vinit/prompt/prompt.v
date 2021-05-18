module prompt

import os

// The PromptOptions struct that
// contains the options for the propmt
pub struct PromptOptions {
	// The prompt message passed in with
	// os.input
	message string [required]

	// The message suffix
	// Output format : [message] [suffix]
	suffix string = '[?]'
}

pub struct Choices {
	// The chouces provided with the choice
	// functions for the user to choose
	choices []string [required]
}

// Create a prompt and grap the input which
// is returned from the function
pub fn prompt(options PromptOptions) string {
	user_input := os.input('$options.message $options.suffix ')
	return user_input
}

// Throws the input message along with
// the options into the stdin
// Checks if the user inputs the correct index
// else, repeat the function
pub fn choices(options PromptOptions, choice Choices, repeat bool) string {
	println('$options.message $options.suffix ')
	mut valid_user_inputs := []string{}
	for choice_index := 0; choice_index < choice.choices.len; choice_index++ {
		current_choice := choice.choices[choice_index]
		println('${choice_index + 1}) $current_choice')
		valid_user_inputs << (choice_index + 1).str()
	}
	user_input := os.input('')

	if user_input !in valid_user_inputs {
		if repeat {
			choices(options, choice, repeat)
		} else {
			println('Invalid input')
			return user_input
		}
	}

	// Return the value at the user_input index in the
	// choices
	return choice.choices[user_input.int() - 1]
}
