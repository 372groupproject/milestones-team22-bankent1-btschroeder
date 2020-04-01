// USE THIS FILE AS THE LAUNCH POINT
const filepath = "./p2_if.wasm"
 
var memory = new WebAssembly.Memory({initial:1});
// js functions to be imported in wasm
var importObject = {
  console: {
    nprint: function(arg) {
      line += arg;
    },
    sprint: function(offset, length) {
        var bytes = new Uint8Array(memory.buffer, offset, length);
        var string = new TextDecoder('utf8').decode(bytes);
        line += string;
    }
  },
  js: {
      mem: memory
  }
};

fetch(filepath).then(response =>
    response.arrayBuffer()
).then(buffer =>
    WebAssembly.instantiate(buffer, importObject)
).then(({module, instance}) => {
    funcs = instance.exports;
  }  
);
