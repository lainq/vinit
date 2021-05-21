function clone_from_url($url) {
    git clone $url vinit
}

$v_installed = Read-Host "Do you have v installed (y/n)"
if ($v_installed -ne 'y') {
    Write-Host "Go and install v"
    Start-Process "https://github.com/vlang/v/releases/latest"
    exit
} 

$repo_url = "https://github.com/pranavbaburaj/vinit.git"
clone_from_url($repo_url)

cd vinit
cd vinit
v vinit.v -o ../../vinit.exe
