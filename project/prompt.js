const inquirer = require('inquirer')

function createPrompt(data, func) {
    inquirer.prompt(data).then(function(response){
        func(response)
    })
}

module.exports = {createPrompt}