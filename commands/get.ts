import { yellow } from "chalk"
import { existsSync, mkdir, statSync } from "fs"
import { homedir } from "os"
import { join } from "path"
import { VSetupException } from "../exception"
import { exec } from 'shelljs'

export interface Package {
    name: string
    url : string
}

export class VGetPackage {
    private url?:string
    private name?:string
    
    constructor(params:Map<string, string>) {
        this.url = params.get('url')
        this.name = params.get('name')

        if([this.url, this.name].includes(undefined)){
            const exception = new VSetupException({
                message : "url and name are required fields"
            }).throwException(true)
        } else {
            const path:string | null = this.createInstallDirectory(this.name)
            if(path){
                exec(`git clone ${this.url} ${path}`)
            } else {
                console.log(yellow(`${this.name} already exists`))
            }
        }
    }

    private createInstallDirectory(name?:string):string | null {
        if(!name){
            return null
        }
        const path:string = join(homedir(), '.vmodules')
        this.exists(path, true)
        const projectPath:string = join(path, name)
        if(this.exists(projectPath, false)){
            return null
        }
        return projectPath
    }

    private exists(path:string, create:boolean=false):boolean{
        try {
            let exists = existsSync(path)
            if(exists){
                exists = exists && statSync(path).isDirectory()
            }
            if(!create){
                return exists
            }
            if(!exists){
                mkdir(path, (err:NodeJS.ErrnoException | null) => {
                    if(err){
                        const exception = new VSetupException({
                            message : err.message
                        }).throwException(true)
                    }
                })
            }
            return exists
        } catch(exception:any) {
            return false
        }
    }
}