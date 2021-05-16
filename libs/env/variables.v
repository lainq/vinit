module env

struct EnvironmentVariable {
	variable_name string
	variable_value string
}

fn create_env_variables(data []string) ?[]EnvironmentVariable {
	mut environment_variables := []EnvironmentVariable{}
	for index:= 0 ; index<data.len; index++ {
		current := data[index]
		assignment_counts := current.count('=')
		if (assignment_counts > 1) || (assignment_counts < 1) {
			return error('Expected 1 assignment but got $assignment_counts')
		}
		statement := current.split('=')
		if statement.len != 2 {
			return error('Unexpected statement length, Expected 2 got ${statement.len}')
		}

		environment_variables << EnvironmentVariable{
			variable_name : statement[0],
			variable_value : statement[1]
		}
	}
	return environment_variables
}