import arguments { ArgumentParser }

fn main() {
	mut argument_parser := ArgumentParser{}
	command, params := argument_parser.parse() or {
		println(err)
		return
	}
	println(params)
}