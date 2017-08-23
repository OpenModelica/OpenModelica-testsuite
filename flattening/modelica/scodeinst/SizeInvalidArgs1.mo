// name: SizeInvalidArgs1
// keywords: size
// status: incorrect
// cflags: -d=newInst
//
// Tests the builtin size operator.
//

model SizeInvalidArgs1
  Real x[3];
  Integer y = size(x, 1, 2);
end SizeInvalidArgs1;

// Result:
// Error processing file: SizeInvalidArgs1.mo
// [flattening/modelica/scodeinst/SizeInvalidArgs1.mo:11:3-11:28:writable] Error: No matching function found for size in component 
// candidates are :
//   size(array) => Integer[:]
//   size(array, Integer) => Integer
//
// # Error encountered! Exiting...
// # Please check the error message and the flags.
//
// Execution failed!
// endResult
