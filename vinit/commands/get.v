module commands

import os { vmodules_dir, is_dir, mkdir, execute, join_path }
import exception { VinitException }

struct CloneRepository {
	url string
	name string
}

fn (repo CloneRepository) install() {
	execute('git clone ${repo.url} ${join_path(vmodules_dir(), repo.name)}')
}

fn check_if_module_exists(module_name string) bool {
	if !is_dir(vmodules_dir()) {
		mkdir(vmodules_dir()) or {
			panic(err)
			return false
		}
		return false
	}
	return is_dir(join_path(vmodules_dir(), module_name))	
}

pub fn get() int {
	parameters := prompt_user(['url', 'name'], '[?]')
	name, url := parameters['name'], parameters['url']
	if check_if_module_exists(name) {
		println('[INSTALLED] $name seams to be already installed')
	} else {
		CloneRepository{
			url : url,
			name : name
		}.install()
	}
	return 0
}