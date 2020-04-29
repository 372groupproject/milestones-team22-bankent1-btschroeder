/*
grapher.js
/bean

creates a graph we can plot paths on using
beginPath, moveTo, lineTo, closePath, stroke
on an HTML canvas
*/

const point = (x,y) => {
    return {x:parseFloat(x), y:parseFloat(y)}
}

const from = point
const to = point

const canvas = document.querySelector("#graph")
const ctx = canvas.getContext('2d');

const width = canvas.width
const height = canvas.height

//default graph window
const win = {
    xmin: -4,
    xmax: 4, 
    ymin: -3,
    ymax: 3, 
}

let ixscale = width / 2 / (win.xmax-win.xmin)
let iyscale = height / 2 / (win.ymax-win.ymin)

//define default origin point o
const o = {
    x: width/2,
    y: height/2
}

document.querySelectorAll('#controls > input').forEach(node => node.value = win[node.id])

const controls = document.querySelector('#controls')
controls.oninput = (changed) => {
    win[changed.target.id] = parseFloat(changed.target.value)
    ixscale = width / 2 / (win.xmax-win.xmin)
    iyscale = height / 2 / (win.ymax-win.ymin)

    //origin point
    o.x = width/2 - (win.xmax + win.xmin)*ixscale
    o.y = height/2 + (win.ymax + win.ymin)*iyscale

    eqform.requestSubmit()
}

drawaxes()

function clearplot() {
    ctx.clearRect(0, 0, width, height)
    drawaxes()
}

function drawaxes() {
    ctx.linewidth = 2
    ctx.setLineDash([5,15])
    drawline (from (-width, 0), to (width, 0), 2)
    drawline (from (0, -height), to (0, height), 2)
}

//draw a line on the graph given points relative to the origin
function drawline(from, to) {
    ctx.beginPath()
    ctx.moveTo(o.x + from.x, o.y - from.y)
    ctx.lineTo(o.x + to.x, o.y - to.y)
    ctx.closePath()
    ctx.stroke()
}

//graph the plot of given function f
//default bounds are window bounds
function plot(f, nterms, step=0.1) {
    ctx.linewidth = 1
    ctx.setLineDash([]) //solid line

    for (let x = win.xmin*ixscale; x <= win.xmax*ixscale-step; x += step) {
        drawline(from(x*ixscale, f(nterms, x)*iyscale), to((x+step)*ixscale, f(nterms, x+step)*iyscale))
    }
}