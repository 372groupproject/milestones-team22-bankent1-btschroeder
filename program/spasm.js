const filepaths = ['funcs.wasm']

filepaths.forEach(filepath => 
    fetch(filepath).then(response =>
        response.arrayBuffer()
    ).then(buffer =>
        WebAssembly.instantiate(buffer, {grapher : {mem: mem, nprint: nprint}})
    ).then(({module, instance}) => 
        Object.assign(funcs, instance.exports)
    )
  )