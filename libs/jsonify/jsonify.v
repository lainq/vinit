module jsonify

import os

pub struct JsonStore {
	filename string
	extension string
}

fn (store JsonStore) create_file()  {
	filename := '${store.filename}.${store.extension}'
	os.write_file(filename, '[]') or {
		panic(err)
		return
	}
}

pub fn initialize(store JsonStore) {
	store.create_file()
}