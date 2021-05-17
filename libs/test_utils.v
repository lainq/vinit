import generate { Files }
import os { join_path , getwd }

fn main() {
	data := Files{
		path : join_path(getwd(), 'test')
		files : ['teststtstts']
		directories : [
			'testing1',
			'testign2'
		],
	}
	data.create() or {
		panic(err)
		return 
	}
}