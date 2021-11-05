add_llvm_library( LLVMObfuscation MODULE BUILDTREE_ONLY
  CryptoUtils.cpp
  Utils.cpp
  SplitBasicBlocks.cpp
  Substitution.cpp
  Flattening.cpp
  BogusControlFlow.cpp
  Foo.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )
