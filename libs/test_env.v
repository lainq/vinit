import env
import os

fn main() {
	env.loadenv('.env') or {
		print(err)
		return
	}
	println(os.getenv('lol'))
}
