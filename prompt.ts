import {stdout, stdin} from 'process';
import {createInterface, Interface} from 'readline';

const readlineInterface: Interface = createInterface({
  input: stdin,
  output: stdout,
});

export interface PromptParameters {
  query: string;
  color: Function;
  suffix: string;
  callback?: Function;
}

export class Prompt {
  private config: PromptParameters;
  public answers: Array<string> = [];

  constructor(config: PromptParameters) {
    this.config = config;
    this.createPrompt();
  }

  private createPrompt = () => {
    readlineInterface.question(
      this.config.color(`${this.config.query} ${this.config.suffix} `),
      (solution) => {
        if (this.config.callback) {
          this.answers.push(solution);
          this.config.callback(solution.toString(), this);
        }
        readlineInterface.close();
      }
    );
  };
}
