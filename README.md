
# Vinit
A tool for v :wink:

## Setup
You will have to manually clone the repository to install vinit.
```sh
# Clone the repository
git clone https://github.com/pranavbaburaj/vinit.git
```

```sh
# Node dependencies
npm -v
node -v
npm install
npm install typescript ts-node -g
```

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
