import inquirer from "inquirer";
import { VSetupException } from "../exception";

function stringArray(data:Array<string>):string {
  let returnValue:string = '[';
  for(let index=0; index<data.length; index++){
    const current:string = data[index]
    returnValue += `'${current}'`
    if(index != data.length-1){
      returnValue += ', '
    }
  }
  return returnValue + ']'
}

export function validURL(str:string) {
  var pattern = /(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g
  return str.match(pattern)
}

export function version(current:string):string {
  if(current.length == 0){
    return '1.0.0'
  }
  const data = current.split('.')
  if(data.length > 3){
    const error = new VSetupException({
      message : `Invalid version - ${current}`
    }).throwException(true)
  }

  data.forEach((versionElement:string) => {
    if(!Number.isInteger(parseInt(versionElement))) {
      const errpr = new VSetupException({
        message : `Found ${versionElement} in version string`
      }).throwException(true)
    }
  })
  return current
}

export function initialize() {
  const queries = [
    'name',
    'author',
    'version',
    'repo_url',
    'vcs',
    'tags',
    'description',
    'license',
  ];
  let prompts:Array<any> = []
  for(let index=0; index<queries.length; index++){
    const current:string = queries[index];
    prompts.push({
      type : 'input',
      message : current,
      name : current
    })
  }

  inquirer.prompt(prompts).then((answers) => {
    let params:Map<string, string> = new Map<string, string>();
    Object.keys(answers).forEach((key:string) => {
      if(key == 'version'){
        params.set(key, version(answers[key]))
      } else if(key == 'repo_url') {
        // const url:Array<string> | null = validURL(key)
        // if(!url) {
        //   const exception = new VSetupException({
        //     message : 'Invalid repo url'
        //   }).throwException(true)
        // }
        params.set(key, answers[key])
      }else if(key == 'tags') {
        params.set(key, stringArray(answers[key].split(' ').map((element:string) => {
          return element.trim()
        })))
      } else if(key == 'name') {
        if(answers[key].length == 0){
          const error = new VSetupException({
            message : 'Name cannot be empty'
          }).throwException(true)
        }

        params.set(key, answers[key])
      } else {
        params.set(key, answers[key])
      }
    })
    const mod:string = `
    Module {
        name: '${
          params.get('name') || ''
        }'
        author: '${params.get('author')}'
        version: '${params.get('version')}'
        repo_url: '${params.get('repo_url')}'
        vcs: '${params.get('vcs')}'
        tags: ${params.get('tags')}
        description: '${params.get('description')}'
        license: '${params.get('license')}'
    }
    `.trim()
    console.log(mod)
  }).catch((exception:any) => {
    const error = new VSetupException({
      message : exception.message || exception.info
    }).throwException(true)
  })
}
