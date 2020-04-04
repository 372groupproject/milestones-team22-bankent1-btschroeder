/*
spasm.js
/bean

spasm.js is a way to play with webassembly

it provides a command line (for input) and
a command output area for function returns

you can load multiple .wat files at a time
(from the server, perhaps later locally..)

each file has functions you can try out to
show off cool stuff we did coding wasmtext

Notes for later:
- the JS constructor WebAssembly.Memory throws a RangeError if memory cannot be allocated.
- Also throws a RangeError if cannot grow memory more as well!
*/


//load these guys from the server
const filepaths = ["./p2_if.wasm", "./p2_br_table.wasm"]

//funcs list of wasm functions we can call
let funcs = []

class Terminal {
  constructor(linebuf) {
    this.mem = new WebAssembly.Memory({initial:1})
    this.linebuf = linebuf
  }

  nprint (arg) {
    this.linebuf.value += arg
  }

  sprint (offset, length) {
    let bytes = new Uint8Array(mem.buffer, offset, length);
    let string = new TextDecoder('utf8').decode(bytes);
    this.linebuf.value += string;
  }
}

filepaths.map(filepath => 
  fetch(filepath).then(response =>
      response.arrayBuffer()
  ).then(buffer =>
      WebAssembly.instantiate(buffer, {terminal : new Terminal(output)})
  ).then(({module, instance}) => 
      Object.keys(instance.exports)
      .filter(key => typeof(instance[key]) == "function")
      .map(key => instance[key])
  )
)