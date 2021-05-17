module generate

import os { ls, getwd, is_dir, is_dir_empty, join_path, mkdir, open, is_file, create }

pub fn extensions(path string) ?map[string]int {
	mut file_extensions := map[string]int{}
	data := ls(path) or {
		return err
	}
	for index := 0; index <data.len; index++ {
		current := join_path(path, data[index])
		if is_dir(current){
			continue
		}
	    ext := data[index].split('.')
		current_ext := ext[ext.len-1]
		if current_ext !in file_extensions {
			file_extensions[current_ext] = 0
		} 
		file_extensions[current_ext] += 1
	}

	return file_extensions
}

pub fn create_all(directories []string, log bool) ?int {
	for index := 0; index < directories.len; index++ {
		current_create_dir := directories[index]
		create := mkdir(join_path(getwd(), current_create_dir)) or {
			return 1
		}
		if create {
			println('[SUCCESS] Created $current_create_dir')
		} else {
			println('[ERROR] Cannot create $current_create_dir')
		}
	}
	return directories.len
} 

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
			create(create_filename) or {
				return err
			}
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
			mkdir(current_create_dir) or {
				return err
			}
		}
	}
	return 0
}

pub struct Files {
	path string = getwd()
	files []string [required]
	directories []string [required]
	append bool
}

pub fn (files Files) create() ?int {
	if is_dir(files.path) {
		if !is_dir_empty(files.path) {
			if !files.append {
				return error('Cannot create the project in ${files.path}')
			}
		}
	} else {
		mkdir(files.path) or {
			panic(err)
		}
	}
	generate_project_directories(files.directories, files.path) or {
		return err
	}

	generate_project_files(files.files, files.path) or  {
		return err
	}
	return 0
}