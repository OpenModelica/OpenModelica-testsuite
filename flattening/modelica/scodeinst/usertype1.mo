// name: usertype1.mo
// keywords:
// status: correct
// cflags: -d=scodeInst
//

type MyReal = Real;

model M
  MyReal x;
end M;
// Result:
// class M
//   Real x;
// end M;
// endResult
