// USE THIS FILE AS THE LAUNCH POINT
// const filepath = "./m1.wasm"
 
var memory = new WebAssembly.Memory({initial:1});
// js functions to be imported in wasm
var importObject = {
  console: {
    log: function(arg) {
      console.log(arg);
    },
    logstr: function(offset, length) {
        var bytes = new Uint8Array(memory.buffer, offset, length);
        var string = new TextDecoder('utf8').decode(bytes);
        console.log(string);
    }
  },
  js: {
      mem: memory
  }
};

fetch('m1.wasm').then(response =>
    response.arrayBuffer()
).then(buffer =>
    WebAssembly.instantiate(buffer, importObject)
).then(({module, instance}) =>
    instance.exports.hello()
);
