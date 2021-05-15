import { cyan } from "chalk";
import { Prompt } from "../prompt";

const prompt = new Prompt({
    query : "LOL",
    color : cyan,
    suffix : '[?]',
    callback : (data:string) => {
        console.log(data)
    }
})