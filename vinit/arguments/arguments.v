module arguments

import os { args }

type CurrentCharacterType = int | string

pub struct ArgumentParser {
mut:
	arguments []string = args[1..]
}

struct ParserPosition {
mut:
	position int
	data     []string
}

fn (position ParserPosition) current_character() CurrentCharacterType {
	if position.position == position.data.len {
		return 0
	} else {
		return position.data[position.position]
	}
}

pub fn (mut parser ArgumentParser) parse() ?(string, map[string]string) {
	mut position := ParserPosition{
		position: 0
		data: parser.arguments
	}
	mut character := position.current_character()
	mut command := ''
	mut params := map[string]string{}

	if parser.arguments.len == 0 {
		println('Read the documentation - https://github.com/pranavbaburaj/vinit/tree/main/docs')
		exit(1)
	}

	for index := 0; index < parser.arguments.len; index++ {
		position.position = index
		character = position.current_character()
		if character == CurrentCharacterType(0) {
			break
		}
		if position.position == 0 {
			command = character.str()
			continue
		}

		mut statement := character.str().split('=')
		if statement.len < 2 {
			return error('Expected an assignment in ${parser.arguments[position.position]}')
		}

		parameter_key := statement[0]
		parameter_value := statement[1..].join('=')
		params[parameter_key] = parameter_value
	}
	return command, params
}
