/*
inputs.js
/bean

manages the fields for inputs
based on the equation type selected
*/

const eqform = document.querySelector('#eq')
const type = document.querySelector('#type')
const expr = document.querySelector('#expr')

const mem = new WebAssembly.Memory({initial:1})
const nprint = (n) => console.log(n);
const funcs = {}

eqform.onsubmit = () => {
    let terms = parse(expr.value, type.value)
    console.log(terms)
    
    let coarr = new Float64Array(mem.buffer)

    coarr.fill(0, 0, terms.length) //reset to zeroes
    
    Object.assign(coarr, terms) //assign coeffs

    //graph function

    plot(funcs.poly, terms.length)
    
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
    .replace(/\s*\+\s*\-\s*/, '-')  //replace "  +    -  #" with "-#"
    .replace(/\s*\-\s*/, '+-')      //replace "  -   #" with "+-#"
    .split(/\s*\+\s*/)                      //split on '+' surrounded by 0 or more space
    .map((term) => term.split(/\s*x|X\s*/)) //split on variable symbol surrounded by 0 or more space (or function sin(x))
    .map(polynomial.terms)              //
    .reduce(polynomial.liketerms, [])   //get polynomial expr in ascending order
}


//termstr := ["#", "^#"]
//term := {co: #, exp: #]
//expr := [#co, ...] where # is coeff for term of degree index
const polynomial = {
    terms: (termstr) => { //term
        return {
            co:     termstr[0] == "" ?  1:
                    termstr[0] == "-"? -1:
                    parseFloat(termstr[0] || 1),
            exp:    termstr[1] == undefined ? 0 :
                    termstr[1] == "" ?        1  :
                    parseInt(termstr[1].slice(1)) //lose the '^' symbol
        }
    },

    liketerms: (expr, term) => { //combines term into expr using like-terms
        //see if expr has like term
        let liketerm = expr[term.exp]
        if (liketerm) expr[term.exp] += term.co
        else expr[term.exp] = term.co
        return expr
    }
}
