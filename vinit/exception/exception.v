module exception

pub struct VinitException {
	// The exception message
	exception_message string
	// The suggestion to solve the error
	// or line numbers if the error is
	// related to files
	exception_suggestion string
	// Whether if the error is fatal or not.
	// inorder to exist the program after
	// throwing the error
	fatal bool
}

pub fn (vinit_exception VinitException) raise() {
	println('[ERROR]:$vinit_exception.exception_message')
	if vinit_exception.exception_suggestion.len > 0 {
		println('$vinit_exception.exception_suggestion')
	}
	if vinit_exception.fatal {
		exit(1)
	}
}
