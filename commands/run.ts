import { readdirSync, statSync } from "fs";
import { join } from "path";
import { cwd } from "process";

export class VMake {
    private readonly filename:string = 'v.toml'
    private readonly scripts?:string;

    constructor(scripts?:string){
        this.scripts = scripts;
        this.make()
    }

    private make():void {
        console.log(this.find(this.filename, cwd()))
    }

    private find(filename:string, directory:string):boolean {
        const files = readdirSync(directory)
        return files.filter((file:string):boolean => {
            return statSync(join(directory, file)).isFile() && file == this.filename
        }).length != 0
    }
}