import {red} from 'chalk'


// the config file
import {Configuration} from "./config"

export class Generator {
    private data:any
    private name:string;

    constructor(data:any, project:string){
        this.data = data
        this.name = project
    }

    public init(){
        if(this.data[`Are you sure you want to create project shit`]){
            const configData:Configuration.ConfigFormat = {
                config : this.data
            }
            const config = new Configuration.Config(configData, this.name)
            config.createConfiguration()
        } else {
            console.log(red("process aborted"))
        }
    }
}