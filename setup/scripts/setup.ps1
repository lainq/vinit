<#
This is the setup file for v setup on windows
This program clones a number of files and folders 
#>

<#
V Modules directory where all the vlang modules
are stored
#>
$vlang_module_path = "$HOME\.vmodules\"
$vlang_module_path_exists = Test-Path $vlang_module_path

if ($vlang_module_path_exists -eq $False) {
    [System.io.directory]::createDirectory($vlang_module_path)
}

function vlang_setup ($git_clone_repo_url ) {
    git clone $git_clone_repo_url
    cd vsetup/libs
    $libs = Get-ChildItem -dir
    foreach ($library in $libs) {
        $name  = $library.name
        $library_path = "$vlang_module_path$name\"
        if (Test-Path $library_path ){
            echo "$name already installed"
            continue
        } else {
            Copy-Item -Path $name -Destination $library_path -PassThru
        }
        echo $library_path
    }
    cd ../..
}

$vlang_installed = Read-Host 'Do you have v installed (y/n)'
if ($vlang_installed -ne 'y') {
    $zipfile = "$pwd\v"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Ssl3
    [Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"
    Invoke-WebRequest -Uri "https://github.com/vlang/v/releases/download/weekly.2021.20/v_windows.zip" -OutFile $zipfile
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "$pwd\vlang")
}

vlang_setup('https://github.com/pranavbaburaj/vsetup.git')
