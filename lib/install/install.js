// http for downloading files
// from the internet
const http = require('https')

const files = require('fs')

const { basename, join } = require('path')

// the main install function which
// installs the package
/**
 * 
 * @param {string} package 
 * @param {string} folder
 * 
 * @returns {void} 
 */

const install = function(package, folder){
    // the base filename
    // @example
    // https://raw.githubusercontent.com/pranavbaburaj/poop/main/project/prompt.js
    // will get converted to prompt.js
    const filename = basename(package)

    // the final path
    // example = lib/mod/file.js
    // created by joining the folder 
    // name with the base
    // filename
    const path = join(folder, filename)

    const file = files.createWriteStream(path)

    // check if a folder exists 
    // and if not created one
    if(!files.existsSync(folder)){
        files.mkdir(folder, function(err){
            if(err){throw err}
        })
    }

    // create a blank file
    // for writing the raw file(response)
    files.writeFile(path, ' ', function(err){
        if(err){
            throw err
        }
    })

    // requesting for the file
    // writing the raw file to the 
    // specified path
    const request = http.get(package, function(response) {
        response.pipe(file);
    });
}

module.exports = install