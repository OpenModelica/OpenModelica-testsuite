// name: FuncSimpleOverload
// keywords: overload
// status: correct
// cflags: -d=newInst
//
// Tests simple overloading.
//
model FuncSimpleOverload
  function F
    input Integer f1;
    output Integer f2;
  end F;  

  function G
    input Integer g1;
    input Integer g2;
    output Integer g3;
  end G;
  
  function OV = $overload(F,G);
  
  Integer x = OV(1);
  Integer y = OV(1,2);
end FuncSimpleOverload;

// Result:
// function F
//   input Integer f1;
//   output Integer f2;
// end F;
//
// function G
//   input Integer g1;
//   input Integer g2;
//   output Integer g3;
// end G;
//
// class FuncSimpleOverload
//   Integer x = F(1);
//   Integer y = G(1, 2);
// end FuncSimpleOverload;
// endResult
