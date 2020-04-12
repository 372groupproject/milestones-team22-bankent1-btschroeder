You need wat2wasm installed for it to compile. It comes with wabt (webassembly binary toolkit), found here:
https://github.com/WebAssembly/wabt

Run with 'make run' then navigate to localhost:8000 in your browser. You may need to refresh your browser after navigating to the page.

Choose the function you would like to run from the drop down menu. Once the function is chosen, type in some arguments into the top text box and hit enter to run the function.

Try to compile p3_compile_err.wat.bad with wat2wasm, you should get a compile time error.