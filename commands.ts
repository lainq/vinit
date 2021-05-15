import {initialize} from './commands/init';
import {VMake} from './commands/run';

export const commands: Map<string, Array<string>> = new Map<
  string,
  Array<string>
>([
  ['init', []],
  ['run', ['script']],
]);

/**
 * @param command The command to execute
 * @param params The params passed in
 */
export const performCommand = (
  command: string,
  params: Map<string, string>,
  cli: Array<string>
) => {
  if (command == 'init') {
    initialize();
  } else if (command == 'run') {
    const run = new VMake(params.get('script'));
  }
};
