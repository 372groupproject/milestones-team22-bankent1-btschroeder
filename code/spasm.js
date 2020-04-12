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
const filepaths = ["./p2_if.wasm", "./p2_br_table.wasm", "./p2_loop.wasm", "./p3_i32.wasm", "./p3_i64.wasm"]

//wasm functions we can call
let funcs = {}

class Terminal {
  constructor() {
    this.mem = new WebAssembly.Memory({initial:1})
    let m = this.mem
    this.sprint = (offset, length) => {
      let bytes = new Uint8Array(m.buffer, offset, length);
      let string = new TextDecoder('utf8').decode(bytes);
      line += string;
    }
  }

  nprint (arg) {
    line += arg
  }

}

filepaths.forEach(filepath => 
  fetch(filepath).then(response =>
      response.arrayBuffer()
  ).then(buffer =>
      WebAssembly.instantiate(buffer, {terminal : new Terminal()})
  ).then(({module, instance}) => 
      Object.assign(funcs, instance.exports)
  )
)
