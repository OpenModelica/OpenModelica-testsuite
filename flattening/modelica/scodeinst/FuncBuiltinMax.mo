// name: FuncBuiltinMax
// keywords: max
// status: correct
// cflags: -d=newInst
//
// Tests the builtin max operator.
//

model FuncBuiltinMax
  type E = enumeration(one, two, three);

  Real r1 = max(4.0, 2.0);
  Real r2 = max({3.0, 1.0, 2.0});
  Real r3 = max(r1, r2);

  Integer i1 = max(5, 6);
  Integer i2 = max({4, 2, 1});
  Integer i3 = max(i2, i1);

  Boolean b1 = max(true, false);
  Boolean b2 = max({false, true});
  Boolean b3 = max(b1, b2);

  E e1 = max(E.one, E.three);
  E e2 = max({E.one, E.two, E.three});
  E e3 = max(e1, e2);
end FuncBuiltinMax;

// Result:
// Error processing file: FuncBuiltinMax.mo
// [flattening/modelica/scodeinst/FuncBuiltinMax.mo:12:3-12:26:writable] Error: No matching function found for max(4, 2) in component <REMOVE ME>
// candidates are :
//   max()
//
// # Error encountered! Exiting...
// # Please check the error message and the flags.
//
// Execution failed!
// endResult
