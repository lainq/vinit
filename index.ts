import {red} from 'chalk'

class ArgumentParse {
    private arguments:Array<string>;
    private readonly values:any;

    constructor(args:Array<string>){
        this.arguments = args.slice(2, args.length);
        this.values = {
            command : this.getInformation(0),
            name : this.getInformation(1)
        }
        console.log(this.values)
    }

    private getInformation(index) {
        if(this.arguments.length > 1){
            return this.arguments[index]
        } else {
            this.evokeError("Insufficient arguments")
        }
    }


    private evokeError(errorStatement){
        console.log(red(errorStatement.toString()))
    }
}

const argument = process.argv

const parser = new ArgumentParse(argument)
