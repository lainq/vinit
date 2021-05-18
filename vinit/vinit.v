import arguments { ArgumentParser, execute_command }

fn main() {
	mut argument_parser := ArgumentParser{}
	command, params := argument_parser.parse() or {
		println(err)
		return
	}
	execute_command(command, params)
}
