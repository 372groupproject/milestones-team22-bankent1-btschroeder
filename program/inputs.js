/*
inputs.js
/bean

manages the fields for inputs
based on the equation type selected
*/

const eqform = document.querySelector('#eq')
const type = document.querySelector('#type')
const expr = document.querySelector('#expr')

eqform.onsubmit = () => {
    console.log(parse(expr.value))
    return false
}


reset() //initial state

//reset input fields to match with selected equation
function reset() {
    expr.value = ""
}

//add an input field
function add() {

}

//parses expression string of type
function parse (expression, type, sym) {
    return expression 
    .split(/\s*\+\s*/)                      //split on '+' surrounded by space
    .map((term) => term.split(/\s*x|X\s*/)) //split on variable symbol surrounded by space
    .map(termobj(type))
    .reduce(polynomial.liketerms, [])
    .sort(polynomial.ascending)
}

function termobj(type) {
    return (term) => {
        return {
            co: parseFloat(term[0]),
            exp:    term.length <= 1 ? 0 :
                    term[1] == "" ?    1 :
                    parseInt(term[1].slice(1)) //lose the '^' symbol
        }
    }
}

//expr := [term,...]
//term := {co: #, exp: #}
const polynomial = {
    liketerms: (expr, term) => { //combines term into expr using like-terms
        //see if expr has like term
        let liketerm = expr.find(liketerm => liketerm.exp == term.exp)
        if (liketerm) liketerm.co += term.co
        else expr.push(term)
        return expr
    },

    ascending: (term1, term2) => { //orders terms in ascending degree
        return term1.exp - term2.exp
    } 
}
