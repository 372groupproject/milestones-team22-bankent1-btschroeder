/*
inputs.js
/bean

manages the fields for inputs
based on the equation type selected
*/

const eqform = document.querySelector('#eq')
const type = document.querySelector('#type')
const expr = document.querySelector('#expr')
const format = document.querySelector('#format')

const mem = new WebAssembly.Memory({initial:1})
const nprint = (n) => console.log(n);
const funcs = {}

let functype = (name) => {
    switch(name) {
        case "poly": return polynomial
        case "exp": return exponential
        case "sin": return sinusoidal
    }
}

type.onchange = (changed) => {
    console.log(changed.target.value)

    //reset input
    reset();
    
    //change format hint
    format.innerHTML = functype(changed.target.value).format
}

eqform.onsubmit = () => {
    if (!expr.value) { //ignore empty
        clearplot()
        return false
    }

    let terms = parse(expr.value, functype(type.value))
    console.log(terms)
    
    let coarr = new Float64Array(mem.buffer)

    coarr.fill(0, 0, Math.max(2, terms.length)) //reset to zeroes
    
    Object.assign(coarr, terms) //assign coeffs

    //graph function
    clearplot()
    plot(funcs[type.value], terms.length)
    
    return false
}


reset() //initial state

//reset input fields to match with selected equation
function reset() {
    expr.value = ""
}

//parses expression string of type
function parse (expression, functype, sym) {
    return expression 
    .replace(/\s*\+\s*\-\s*/g, '-')  //replace "  +    -  #" with "-#"
    .replace(/\s*\-\s*/g, '+-')      //replace "  -   #" with "+-#"
    .split(/\s*\+\s*/)              //split on '+' surrounded by 0 or more space
    .map(functype.termstrs)         //split on term strings
    .map(functype.terms)            
    .reduce(polynomial.liketerms, [])   //get expr representing coeffs by assoc. degree
}


//str := "#[x|X[^#]]"
//termstr := ["#", "^#"]
//term := {co: #, exp: #]
//expr := [#co, ...] where # is coeff for term of degree index
const polynomial = {
    termstrs: (str) => { //termstr
        return str.split(/\s*x|X\s*/)
    },

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
    },

    format: "Format: [T_1 [&lt;+|-&gt; T_2 [...]]] where each T_i is of the form A[x[^n]] for a floating point A and positive integer n."
}

//str := "#[e^x]"
//termstr := ["#", undef | "x|X"]
//term := {co: #, exp: 0 | 1}
//expr := [#A, #B] where expr is Ae^x + B
const exponential = {
    termstrs: (str) => { //termstr
        return str.split(/\s*e\s*\^\s*/)
    },

    terms: (termstr) => { //term
        return {
            co:     termstr[0] == "" ?  1:
                    termstr[0] == "-"? -1:
                    parseFloat(termstr[0] || 1),
            exp:    termstr[1] == undefined ? 1 : 0
        }
    },

    format: "Format: [T_1 [&lt;+|-&gt; T_2 [...]]] where each T_i is of the form A[e^x] for a floating point A."
}

const sinusoidal = {
    termstrs: (str) => { //termstr
        return str.split(/\s*sin\s*\s*/)
    },

    terms: (termstr) => { //term
        return {
            co:     termstr[0] == "" ?  1:
                    termstr[0] == "-"? -1:
                    parseFloat(termstr[0] || 1),
            exp:    termstr[1] == undefined ? 1 : 0
        }
    },

    format: "Format: [T_1 [&lt;+|-&gt; T_2 [...]]] where each T_i is of the form A[sinX] for a floating point A."
}
