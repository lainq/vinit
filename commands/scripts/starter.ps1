<#
This is where you can run custom powershell
scripts. You can replace the commands below 
with your own commands

The below given snippets and taken from learnxinyminutes
#>


<#
Foreach loops iterate over arrays
prints:
    dog is a mammal
    cat is a mammal
    mouse is a mammal
#>
foreach ($animal in ("dog", "cat", "mouse")) {
  # You can use -f to interpolate formatted strings
  "{0} is a mammal" -f $animal
}

<#
For loops iterate over arrays and you can specify indices
prints:
 0 a
 1 b
 2 c
 3 d
 4 e
 5 f
 6 g
 7 h
#>
$letters = ('a','b','c','d','e','f','g','h')
for($i=0; $i -le $letters.Count-1; $i++){
  Write-Host $i, $letters[$i]
}

<#
While loops go until a condition is no longer met.
prints:
  0
  1
  2
  3
#>
$x = 0
while ($x -lt 4) {
  Write-Output $x
  $x += 1  # Shorthand for x = x + 1
}