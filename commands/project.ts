import {existsSync, mkdir, readdirSync, Stats, statSync, writeFile} from 'fs';
import {join} from 'path';
import {cwd} from 'process';
import simpleGit, {SimpleGitOptions} from 'simple-git';
import {VSetupException} from '../exception';
import {InitResults} from './init';

export interface Files {
  files: Map<string, string>;
  directories: Array<string>;
}

export class Project {
  private files: Files;
  private data: InitResults;

  constructor(files: Files, data: InitResults) {
    this.files = files;
    this.data = data;

    this.create();
  }

  private create = (): void => {
    const path: string = this.createValidProjectDirectory(
      this.data.params.get('name')
    );
    this.validateDirectory(path);

    this.files.files.set('v.mod', this.data.mod);
    this.files.directories.forEach((dirName: string) => {
      mkdir(join(path, dirName), (err: NodeJS.ErrnoException | null) => {
        if (err) {
          const error = new VSetupException({
            message: err?.message || '',
          }).throwException(true);
        }
      });
    });

    Array.from(this.files.files.keys()).forEach((fileName: string) => {
      this.createFile(
        join(path, fileName),
        this.files.files.get(fileName)?.trim() || '\n'
      );
    });

    const options: Partial<SimpleGitOptions> = {
      baseDir: path,
      binary: 'git',
      maxConcurrentProcesses: 6,
    };
    const git = simpleGit(options);
    try {
      git.init();
    } catch (exception: any) {
      // ignore the exception
    }
  };

  private createFile(filename: string, content: string): void {
    writeFile(filename, content, (err: NodeJS.ErrnoException | null) => {
      if (err) {
        const error = new VSetupException({
          message: err?.message || '',
        }).throwException(true);
      }
    });
  }

  private validateDirectory(path: string): any {
    const exists = Project.exists(path);
    if (exists) {
      if (readdirSync(path).length != 0) {
        const error = new VSetupException({
          message: `${path} is not empty`,
          suggestion: 'Try another project name',
        }).throwException(true);
      }
    } else {
      mkdir(path, (err: NodeJS.ErrnoException | null) => {
        if (err) {
          const error = new VSetupException({
            message: err?.message || '',
          }).throwException(true);
        }
      });
    }
    return path;
  }

  public static exists(path: string, file: boolean = false): boolean {
    try {
      const exists: boolean = existsSync(path);
      const stat: Stats = statSync(path);
      if (file) {
        return stat.isFile();
      }
      return stat.isDirectory();
    } catch (exception: any) {
      return false;
    }
  }

  private createValidProjectDirectory(name: string | undefined): string {
    if (!name) {
      return cwd();
    }
    if (name.trim() == '.') {
      return cwd();
    }
    return join(cwd(), name.trim());
  }
}
