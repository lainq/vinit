import {mkdir, readdirSync} from 'fs'
import * as path from 'path'

// local imports
import {ErrorInformation} from "../error/error"

// prompt
import {createPrompt} from "./prompt.js"

// project generator
import {Generator} from "./generate"

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

/**
 * 
 * @param {string} projectPath
 * @returns {void}
 */
export function createDirectory(projectPath:string):void{
    mkdir(projectPath, function(err: NodeJS.ErrnoException){
        if(err){
         var error:ErrorInformation = new ErrorInformation("Unable to create project")
         error.evokeError()
        }
    })
}

export class Project {
    private projectName:string;

    constructor(name:string){
        // the project name 
        this.projectName = name.toString()
    }

    public initializeProject(){
       const isValid:boolean = isValidProjectName(this.projectName)
       const projectPath:string = path.join(process.cwd(), this.projectName)

       if(isValid){
           // if a folder or file
           // with the name does not exists

           // create the prompt

           const information:any = createPrompt(
            [
                {
                    name : "type",
                    type : "list",
                    choices: ["frontend", "node js"]
                },
                {
                    name : "description",
                    type : "input"
                },
                {
                    name : "author",
                    type : "input"
                },
                {
                    name : `Are you sure you want to create project ${this.projectName}`,
                    type : "confirm"
                }
            ], function(data, projectName) {
                console.clear()
                const projectGenerator = new Generator(data, projectName).init()
            }, this.projectName
           )
           

       } else {
           var error:ErrorInformation = new ErrorInformation("Project name not valid")
           error.evokeError()
       }
    }
}