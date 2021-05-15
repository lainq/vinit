import {argv} from 'process';
import { commands, performCommand } from './commands';
import { VSetupException } from './exception';

export class VSetupArgs {
  private readonly arguments: Array<string>;
  private readonly length: number;
  private command: string;

  private position: number = 0;

  /**
   * @constructor
   * @param {Array<string> | undefined} args The list of command arguments
   */
  constructor(args?: Array<string>) {
    this.arguments = args == undefined ? argv.slice(2) : args;
    this.length = this.arguments.length;

    if (this.length > 0) {
      this.command = this.arguments[0];
      this.arguments = this.arguments.slice(1);
      this.length = this.arguments.length;

      this.parseCommandArguments();
    } else {
      process.exit();
    }
  }

  /**
   * @public
   *
   * parse all the command arguments and
   * gather all the params by parsing through
   * the flags and values
   */
  public parseCommandArguments = (): void | null => {
    let cli = [];
    let cliEnabled = false;
    let current: string | null = this.currentArgument();
    let commandParams: Map<string, string> = new Map<string, string>();
    while (current != null) {
      if (cliEnabled) {
        cli.push(current);

        this.position += 1;
        current = this.currentArgument();

        continue;
      }
      if (!current.startsWith('--')) {
        const exception = new VSetupException({
          message: `Invalid flag - ${current} ❎`,
          suggestion: 'User -- in the beginning of the option',
        }).throwException(true);
      }

      if (this.command == 'run' && current == '--args') {
        cliEnabled = true;

        this.position += 1;
        current = this.currentArgument();

        continue;
      }

      const commandArguments = current.split('=');
      if (commandArguments.length != 2) {
        const exception = new VSetupException({
          message: 'Expected assignment 😦',
          suggestion: 'Try assigning values : --<flag>=<value>',
        }).throwException(true);
      }

      commandArguments[0] = commandArguments[0].slice(2);
      commandParams.set(commandArguments[0], commandArguments[1]);
      this.position += 1;
      current = this.currentArgument();
    }

    this.validateParameters(this.command, commandParams, cli);
  };

  /**
   * @private
   *
   * Validate all the parameters and run the command
   * with the parameters :slight_smile:
   *
   * @param command The command
   * @param params The params
   * @returns
   */
  private validateParameters = (
    command: string,
    params: Map<string, string>,
    cli: Array<string>
  ): void | null => {
    if (!Array.from(commands.keys()).includes(command)) {
      const exception = new VSetupException({
        message: `Invalid command - ${command}`,
      }).throwException(true);

      return null;
    }

    const flags = commands.get(command);
    if (flags) {
      const paramKeys = Array.from(params.keys());
      for (let paramIndex = 0; paramIndex < paramKeys.length; paramIndex++) {
        if (!flags.includes(paramKeys[paramIndex])) {
          const exception = new VSetupException({
            message: `Invalid flag ${paramKeys[paramIndex]} for ${command}`,
            suggestion: `Valid flags - ${flags.join(', ')}`,
          }).throwException(true);
          return null;
        }
      }

      performCommand(command, params, cli);
    } else {
      process.exit();
    }
  };

  /**
   * @private
   *
   * Get the current character or return null
   * if reached the end of the array
   *
   * @returns {string | null} Current character or null
   */
  private currentArgument = (): string | null => {
    if (this.length == this.position) {
      return null;
    } else {
      return this.arguments[this.position];
    }
  };
}