@ECHO OFF
cls
tsc index.ts --outDir ./dist
node dist/index.js init --lol=5
