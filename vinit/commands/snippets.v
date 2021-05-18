module commands

pub const (
	compiler = 'v'
	filename = 'main.v'
	toml     = "
[variables]
compiler = '$compiler'
filename = '$filename'

[scripts]
run = '$compiler $filename'
	"
	script   = '
echo "Hello World"
	'
)
