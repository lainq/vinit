## Env 

Create a `.env` file
```sh
# This is an example comment
lol=EXAMPLE_DATA        
```

```v
import env
import os

fn main() {
    // Load the environment variables
    env.loadenv('.env') or {
		panic(err)
		return
	}

    // Access environment variables
	println(os.getenv('lol'))
}
```