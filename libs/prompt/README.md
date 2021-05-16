# Prompt

```
import prompt


fn main() {
	data := prompt.PromptOptions{
		message: 'lol'
	}
	c := prompt.Choices{
		choices: ['lol1', 'lol2']
	}

    // for choices
	println(prompt.choices(data, c, true))
    // for promptes
	println(prompt.prompt(data))
}

```