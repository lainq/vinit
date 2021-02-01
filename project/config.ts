import {writeFile} from "fs"
import {join} from 'path'
import { ErrorInformation } from "../error/error"

import {createDirectory} from './project'
export namespace Configuration {

    // the data
    export interface ConfigFormat {
        config : any;
    }

    export class Config{
        private readonly data:ConfigFormat
        private readonly name:string

        constructor(data:ConfigFormat, name:string){
            this.data = data
            this.name = name
        }

        public createConfiguration():void {
            delete this.data.config['Are you sure you want to create project shit']
            const path:string = join(process.cwd(), this.name)

            createDirectory(path)

            const configPath:string = join(path, `${this.name}.json`)
            this.writeConfigJSON(this.getJSON(path), configPath)
        }

        private getJSON(path:string):any{
            return {
                name : this.name,
                path : path,
                packages : [],
                info : this.data.config
            }
        }

        private writeConfigJSON(jsonData:any, path:string):void {
            writeFile(path, JSON.stringify(jsonData), function(err: NodeJS.ErrnoException){
                if(err) {
                 const error = new ErrorInformation("Unable to create config file")
                 error.evokeError()  
                }
            })
        }
    }
}