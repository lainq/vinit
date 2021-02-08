import { evokeCommandArgument } from "./arguments/arguments.js"

// get the argument parser results
const argumentParser = evokeCommandArgument(
    process.argv
)

console.log(argumentParser)