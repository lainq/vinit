import {red} from 'chalk'

/**
 * ErrorInformation
 * @param {string} errorStatement
 * 
 * @returns {void}
 */
export class ErrorInformation {
    private readonly errorStatement:string;

    constructor(private readonly error:string){
        this.errorStatement = error
    }

    static create(error:string):ErrorInformation{
        return new ErrorInformation(error)
    }

    public evokeError():void{
        console.log(red(this.errorStatement))
    }
}