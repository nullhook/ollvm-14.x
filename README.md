# ollvm-14.x

This project takes a fork of the original [ollvm](https://github.com/obfuscator-llvm/obfuscator/wiki) and ports it to the latest version of llvm (14.x)

# how to run
Currently, this works individually using the opt tool and still uses the legacy pass manager.

Building this would generate a dynamic library of name LLVMObfuscation{.so|dylib} extension and just load it via opt tool.

`opt -enable-new-pm=0 -load lib/LLVMObfuscation.dylib -flattening test.bc -o /dev/null` 

TODO:

- [ ] Add passes to PassManagerBuilder.cpp
- [ ] Port to the new pass manager

