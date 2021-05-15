import inquirer from "inquirer";
import { VSetupException } from "../exception";

function version(current:string):string {
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
  return current.length == 0 ? '1.0.0' : current
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
      } else {
        params.set(key, answers[key])
      }
    })
    console.log(params)
  }).catch((exception:any) => {
    const error = new VSetupException({
      message : exception.message || exception.info
    }).throwException(true)
  })
}
