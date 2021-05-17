import generate { extensions }
import os { getwd, join_path }

fn main() {
	// data := Files{
	// 	path : join_path(getwd(), 'test')
	// 	files : ['teststtstts']
	// 	directories : [
	// 		'testing1',
	// 		'testign2'
	// 	],
	// }
	// data.create() or {
	// 	panic(err)
	// 	return
	// }
	// create_all(
	// 	['test'],
	// 	false
	// ) or {
	// 	panic(err)
	// }
	d := extensions(join_path(getwd())) or { panic(err) }
	println(d)
}
