import prompt

// fn test_u() {
// 	utility.helloworld()
// 	assert 1 == 1
// }

fn main() {
	data := prompt.PromptOptions {
		message : 'lol'
	}
	c := prompt.Choices {
		choices : ['lol1' 'lol2'],
	}
	println(prompt.choices(data, c, true))
	println(__file__)
}