# Scripts
Any other commands are considered to be a script

Create a script file named `v.scripts`. The scripts file follows a similar format as mentioned below

```sh
compiler=tsc
filename=index.ts

run=$compiler $filename --watch true
```

`vinit run` executes `tsc $index.ts --watch true`