/*
grapher.js
/bean

creates a graph we can plot paths on using
beginPath, moveTo, lineTo, closePath, stroke
on an HTML canvas
*/

const canvas = document.querySelector("#graph")
const ctx = canvas.getContext('2d');

const width = canvas.width
const height = canvas.height

//define default origin point o
const o = {
    x: width/2,
    y: height/2
}

//define default window
let xmin = -width/2
let xmax = width/2
let ymin = -height/2
let ymax = height/2

//define default scale
let xscale = 10
let yscale = 10

drawaxes()

function clearplot() {
    ctx.clearRect(0, 0, width, height)
    drawaxes()
}

function drawaxes() {
    ctx.linewidth = 2
    ctx.setLineDash([5,15])
    drawline({x: 0, y: ymin}, {x: 0, y: ymax}, 2)
    drawline({x: xmin, y: 0}, {x: xmax, y: 0}, 2)
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
function plot(f, step=1) {
    ctx.linewidth = 1
    ctx.setLineDash([]) //solid line

    for (let x = xmin; x <= (xmax-step)/xscale; x += step) {
        drawline(from(x*xscale, f(x)*yscale), to((x+step)*xscale, f(x+step)*yscale))
    }
}

const point = (x,y) => {
    return {x:x, y:y}
}

const from = point
const to = point