import {writeFile} from "fs"

export namespace Configuration {

    // the data
    export interface ConfigFormat {
        config : any;
    }

    export class Config{
        private readonly data:ConfigFormat

        constructor(data:ConfigFormat){
            this.data = data
        }

        public createConfiguration():void {
            delete this.data.config['Are you sure you want to create project shit']
            writeFile(path)
        }
    }
}