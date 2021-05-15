import {readFileSync} from 'fs';
import {join} from 'path';

export function gitignore(): string {
  return readFileSync(join(__dirname, 'gitignore.txt')).toString();
}
