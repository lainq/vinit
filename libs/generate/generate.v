module generate

import os {
	create,
	getwd,
	is_dir,
	is_dir_empty,
	is_file,
	join_path,
	ls,
	mkdir,
}

// Get a map of extensions and the number of files with the specific
// extensions in a specified directory
pub fn extensions(path string) ?map[string]int {
	mut file_extensions := map[string]int{}
	data := ls(path) or { return err }

	// Loop through the files and ignore
	// if the file is a directory
	for index := 0; index < data.len; index++ {
		current := join_path(path, data[index])
		if is_dir(current) {
			continue
		}
		ext := data[index].split('.')

		// Check if the current extension exists in the map
		// of extensions. If it doesn't exists. Create it and
		// set it to 0
		current_ext := ext[ext.len - 1]
		if current_ext !in file_extensions {
			file_extensions[current_ext] = 0
		}
		file_extensions[current_ext] += 1
	}

	return file_extensions
}

// Create all the directories in an array in the current
// working directory(getwd())
pub fn create_all(directories []string, log bool) ?int {
	for index := 0; index < directories.len; index++ {
		current_create_dir := directories[index]
		create := mkdir(join_path(getwd(), current_create_dir)) or { return 1 }
		if create {
			println('[SUCCESS] Created $current_create_dir')
		} else {
			println('[ERROR] Cannot create $current_create_dir')
		}
	}
	return directories.len
}

// Convert a string into an array of bytes
fn create_byte_array(data string) []byte {
	mut return_value := []byte{}
	for index := 0; index < data.len; index++ {
		return_value << data[index]
	}
	return return_value
}

fn generate_project_files(files []string, path string) ?int {
	for index := 0; index < files.len; index++ {
		create_filename := join_path(path, files[index])
		if !is_file(create_filename) {
			create(create_filename) or { return err }
		}
	}
	return 0
}

fn generate_project_directories(dirs []string, path string) ?int {
	for index := 0; index < dirs.len; index++ {
		current_create_dir := join_path(path, dirs[index])
		if is_dir(current_create_dir) {
			return error('Cannot create $current_create_dir as it already exists')
		} else {
			mkdir(current_create_dir) or { return err }
		}
	}
	return 0
}

pub struct Files {
	// The path in which we should create
	// the project
	path string = getwd()
	// The files to create in the directory
	files []string [required]

	// The subdirectories to create in the directory
	directories []string [required]

	// Whether to create the project even if the project
	// folder is not empty
	append bool
}

pub fn (files Files) create() ?int {
	if is_dir(files.path) {
		if !is_dir_empty(files.path) {
			if !files.append {
				return error('Cannot create the project in $files.path')
			}
		}
	} else {
		mkdir(files.path) or { panic(err) }
	}
	generate_project_directories(files.directories, files.path) or { return err }

	generate_project_files(files.files, files.path) or { return err }
	return 0
}
