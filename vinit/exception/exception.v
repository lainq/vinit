module exception

pub struct VinitException {
	exception_message    string
	exception_suggestion string
	fatal                bool
}

pub fn (vinit_exception VinitException) raise() {
	println('[ERROR]:$vinit_exception.exception_message')
	if vinit_exception.exception_suggestion.len > 0 {
		println('[TRY]:$vinit_exception.exception_suggestion')
	}
	if vinit_exception.fatal {
		exit(1)
	}
}
