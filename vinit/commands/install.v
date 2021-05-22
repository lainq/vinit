module commands

import os { join_path, is_file }
import exception { VinitException }

pub struct DependencyFiles {
	dirname string [required]
	filename string [required]

	mut:
	path string
	content Dependencies
}

pub fn install(mut dependencies DependencyFiles) {
	dependencies.path = join_path(dependencies.dirname, dependencies.filename)
	if !is_file(dependencies.path) {
		VinitException{
			exception_message : 'Cannot find ${dependencies.path}',
			fatal : true
		}.raise()
	}

	dependencies.content = dependency_file_parser(ModulesDependency{
		v_module_filename : dependencies.dirname,
		vinit_dependency_filename : dependencies.path
	}) or {
		VinitException{
			exception_message : err.msg,
			fatal : true
		}.raise()
		return 
	}

	for package_name, clone_url in dependencies.content.dependencies {
		CloneRepository{
			name : package_name,
			url : clone_url
		}.install()
	}
}