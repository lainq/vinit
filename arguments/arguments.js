const { Command } = require('commander');

// the new command
const program = new Command();

program
  .option('-i, --install <package>', 'output extra debugging')
  .option('-u, --uninstall <package>', 'small pizza size')
  .option('-n, --new <name>', 'Name of the project');


function evokeCommandArgument(arguments){
    program.parse(arguments);
    return program.opts();
}

module.exports = {evokeCommandArgument} 