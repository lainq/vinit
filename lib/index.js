const Install = require('./install/install.js')

// the module index
var moduleRegistry = {}

// the main import class
// used to import libraries

class Import {
	constructor(moduleUrl, moduleFolder){
		this.moduleUrl = moduleUrl 
		this.moduleFolder = moduleFolder

		// add the main module to the
		// local module registry where we
		// look
		// for packages when the call import
		this.addModule()
		this.installPackage()
	}

	/**
	 * @returns {any}
	 */
	addModule(){
		// check if the url is already present 
		// in the module registry and if it exists
		// pass of else add it to the
		// module registry
		if(!Object.keys(moduleRegistry).includes(this.moduleUrl)){
			moduleRegistry[this.moduleUrl] = this.moduleFolder
		}

		return moduleRegistry
	}

	installPackage(){
		Install(this.moduleUrl, this.moduleFolder)
	}
}

module.exports = Import