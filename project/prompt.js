const inquirer = require('inquirer')

function createPrompt(data, func, projectName) {
    inquirer.prompt(data).then(function(response){
        func(response, projectName)
    })
}

module.exports = {createPrompt}