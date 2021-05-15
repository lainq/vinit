import {validURL, version} from '../commands/init';

console.log(
  validURL(
    'https://stackoverflow.com/questions/30970068/js-regex-url-validation'
  )
);
console.log(version('2.0'));
