<p align="center">
  <img src="https://i.imgur.com/xs4pUIG.png" aly="logo">
  <h3 align="center">Vinit</h3>

  <p align="center">
    Vinit is a command line tool to generate v projects and run scripts
    <br />
<!--     <a href="https://python-polyglot.netlify.app/">📖 Documentation</a> -->
    ·
    <a href="https://github.com/pranavbaburaj/vinit/issues">Report a Bug</a>
    ·
    <a href="https://github.com/pranavbaburaj/vinit/pulls">Request Feature</a>
  </p>
  <br>
  <p align="center">
    <img src="https://img.shields.io/discord/808537055177080892.svg">
    <img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=103">
    <img src="https://img.shields.io/github/last-commit/pranavbaburaj/vinit">
    <a href="https://twitter.com/intent/tweet?text=Vinit,%20a%20command%20line%20tool%20to%20generate%20v%20projects%20and%20run%20scripts&url=https://github.com/pranavbaburaj/vinit&via=baburaj_pranav&hashtags=developers,polyglot,language"><img src="https://img.shields.io/twitter/url/http/shields.io.svg?style=social"></a>
    <img src="https://tokei.rs/b1/github/pranavbaburaj/vinit">
  </p>

  <br />
</p>


## Setup
How to setup vinit on your local system
- Windows
  Windows users can download the vinit executablew from the releases or build the vinit source
  with the `windows-build.ps1` powershell script.
- Linux
  Linux users can use the `linux-build.sh` file in the releases. 

##  How to use it?
```sh
ts-node index.ts <command> <params> 
```

### Commands :

- ***init*** Create a new project
- ***get*** Clone a repository into `vmodules`
		-  `--url` The git repository url
		- `--name` The name of the project

		ts-node index.ts get --url=<url> --name=<name>

- ***run*** To run scripts
To run script, your directory should have a `v.toml` file in which the scripts are written.

The toml file has two main parts.
		 1) `variables`: Where all the variables are declared
		 2) `scripts` : Where all the scripts are defined
An example `v.toml` file
```sh
[variables]
compiler = 'ts-node'
filename = 'E:\vlol\tests\prompt.ts'

[scripts]
run = '$compiler $filename'
```

To run the script
```sh
ts-node index.ts run --script-<script-name>
```
