// the final answer
let score = 0

// the text input
const text = document.querySelector('.ans')


function changeInputTextValue(textbox, newValue){
    if(newValue == null){
        alert("An error occured")
    } else {
        textbox.value = newValue
    }
}

function getIInputTextBoxText(textBox){
    return textBox.value
}

function calculateEquation(equation){
    if(equation == null){
            return null
    } else {
        return eval(equation.toString().replace(" ", ""))
    }
}


// the buttons
const buttons = document.getElementsByTagName('button')

for (let index = 0; index < buttons.length; index++){
    const btn = buttons[index]
    btn.addEventListener('click', function(event) {
        if(btn.innerHTML == "c"){
            text.value = ""
        } else if (btn.innerHTML == "=") {
            text.value =  eval(text.value)
        }else {
            text.value += btn.innerHTML
        }
    })
}
