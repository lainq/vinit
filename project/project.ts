import { dir } from 'console'
import {readdirSync} from 'fs'

// check if the project name does not
// exists
/**
 * @param {string} projectName
 * @returns {boolean}
 */
function isValidProjectName(projectName:string):boolean{
    var directories:Array<string> = new Array()
    readdirSync(process.cwd()).forEach(function(file) {
        directories.push(file) // add to array
    })
    directories = directories.filter(function(element) {
        return element == projectName
    })
    // return if arr is empty
    return directories.length == 0
}

export class Project {
    private projectName:string;

    constructor(name:string){
        // the project name 
        this.projectName = name
    }

    public initializeProject(){
       const isValid = isValidProjectName(this.projectName)
       console.log(`${this.projectName} is ${isValid}`)
    }
}