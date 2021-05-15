import { existsSync, readdirSync, Stats, statSync } from "fs";
import { join } from "path";
import { cwd } from "process";
import { VSetupException } from "../exception";
import { InitResults } from "./init"

export interface Files {
    files : Map<string, string>,
    directories : Array<string>
}

export class Project {
    private files:Files
    private data:InitResults

    constructor(files:Files, data:InitResults) {
        this.files = files;
        this.data = data;

        this.create()
    }

    private create = ():void => {
        const path:string = this.createValidProjectDirectory(this.data.params.get('name'))
        console.log(path)
    }

    private validateDirectory(path:string):boolean {
        const exists = Project.exists(path)
        if(exists){
            if(readdirSync(path).length != 0){
                const error = new VSetupException({
                    message : `${path} is not empty`,
                    suggestion : "Try another project name"
                }).throwException(true)
            }
        }
        console.log("Ready")
    }

    public static exists(path:string, file:boolean=false):boolean {
        try {
            const exists:boolean = existsSync(path)
            const stat:Stats = statSync(path)
            if(file){
                return stat.isFile()
            }
            return stat.isDirectory()
        } catch(exception:any) {
            return false;
        }
    }

    private createValidProjectDirectory(name:string | undefined):string {
        if(!name){
            return cwd()
        }
        if(name.trim() == '.'){
            return cwd()
        }
        return join(cwd(), name.trim())
    }
}