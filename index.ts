import {evokeCommandArgument} from "./argument.js"
import {Project} from "./project/project"

// the argument parser results
const args:any = evokeCommandArgument(process.argv)

const projectNameExists = (args:any) => {
    return Object.keys(args).includes("new")
}

// check for project name
if(projectNameExists(args)){
    const project = new Project(args.new)
    project.initializeProject()
}

