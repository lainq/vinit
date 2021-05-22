read -p 'Do you have v installed ' v_installed;

if [ $v_installed != 'y' ]
then
    echo "Install v first"
    exit
else
    git clone https://github.com/pranavbaburaj/vinit.git vinit
    cd vinit/vinit
    v vinit.v -o ../../vinit
fi
