import { readdirSync, readFileSync, statSync } from "fs";
import { join } from "path";
import { cwd } from "process";
import { parse } from "toml";
import { VSetupException } from "../exception";

interface VMakeObject {
    variables : any;
    scripts : any;
}

export class VMake {
    private readonly filename:string = 'v.toml'
    private readonly script?:string;
    private variables:Map<string, any> = new Map<string, any>();
    private scripts:Map<string, string> = new Map<string, string>();

    constructor(scripts?:string){
        this.script = scripts;
        this.make()
    }

    private createVariables(object:VMakeObject):void | null {
        if(!object.variables){
            return null
        }
        Object.keys(object.variables).forEach((key:string) => {
            this.variables.set(key, object.variables[key])
        })
    }

    private createScripts(object:VMakeObject):void | null {
        if(!object.scripts){
            return null;
        }

        Object.keys(object.scripts).forEach((scriptName:string) => {
            let data:Array<string> = object.scripts[scriptName].trim().split(' ')
            for(let idx=0; idx<data.length; idx++){
                if(data[idx].startsWith('$')){
                    const value = this.variables.get(data[idx].slice(1))
                    if(value){
                        data[idx] = String(value)
                    } 
                }
            }
            this.scripts.set(scriptName, data.join(' '))
        })
        console.log(this.scripts)
    }

    private make():void {
        if(!this.find(this.filename, cwd())){
            const error = new VSetupException({
                message : 'Cannot find v.toml',
                suggestion : "Try creating a v.toml file with all the scripts"
            }).throwException(true)
        }
        try {
            const json:VMakeObject = parse(readFileSync(join(cwd(), this.filename)).toString()) as VMakeObject
            this.createVariables(json)
            this.createScripts(json)
        } catch(exception:any) {
            const error = new VSetupException({
                message : exception.message 
            }).throwException(true)
        }
    }

    private find(filename:string, directory:string):boolean {
        const files = readdirSync(directory)
        return files.filter((file:string):boolean => {
            return statSync(join(directory, file)).isFile() && file == this.filename
        }).length != 0
    }
}