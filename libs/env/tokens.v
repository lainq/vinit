module env

struct Position {
	mut:
	position int
}

fn (mut position Position) increment() int {
	position.position += 1
	return position.position
}

fn (mut position Position) decrement() int {
	position.position += -1
	return position.position
}

fn (position Position) current_character(data []string) string {
	if position.position == data.len {
		return '\n'
	} else {
		return data[position.position]
	}
}

fn tokenise(content string) []string {
	mut position := Position{}
	contents := content.split_into_lines()

	mut variables := []string{}

	mut character := position.current_character(contents)
	for index := 0; index < contents.len; index++ {
		if !character.starts_with('#') {
			variables << character
		}
		position.position = index+1
		character = position.current_character(contents)
	}
	return variables
}