# Generate

Generate files and directories

## Create a project

```v
import generate
import os

fn main() {
    files := generate.Files{
        files : ['filename1.txt', os.join_path('folder1', 'filename2.txt')], // The files to create [required]
        directories : ['folder1', 'folder2', 'docs'] // The directories to create [required]
        path : os.join_path(os.getwd(), 'project-directory') // The path to create the project [optional] [default=os.getwd]
        append : false // Whether to create files even if the project
        // folder is not empty [optional] [default=false]
    }
    files.create() or {
        panic(err)
        return
    }
}
```

## Create directories

```v
import generate

fn main() {
    // Creates folders in the current directory
    generate.create_all(['folder1', 'folder2'], true) or { return }
}
```

## Get all the file extensions

```v
import generate

fn main() {
    data := generate.extensions(join_path(getwd())) or {
		panic(err)
	}
}
```
