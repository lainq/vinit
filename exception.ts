import { red, yellow } from "chalk";

export interface VSetExceptionParams {
  message: string;
  suggestion?: string;
  file?: string;
  line?: number;
}

export class VSetupException {
  private readonly message: string;
  private readonly suggestion: string | undefined;

  /**
   * @constructor
   *
   * @param {VSetExceptionParams} params The pappermintparameters contaning, messages, suggestion
   * line and files
   */
  constructor(params: VSetExceptionParams) {
    this.message = params.message;
    this.suggestion = params.suggestion;
  }

  /**
   * @public
   *
   * Throw the exception
   *
   * @param {boolean} fatal Whether to exit from the program after the
   * error or not
   */
  public throwException(fatal: boolean) {
    console.log(red(this.message));
    if (this.suggestion) {
      console.log(yellow(this.suggestion));
    }

    if (fatal) {
      process.exit();
    }
  }
}