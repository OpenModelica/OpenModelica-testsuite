encapsulated package Lexer "Implements the DFA of OMCC"
import Types;
import LexerCode;
import LexTable;
import OMCCTypes;
import System;
import List;
import Util;

import arrayGet = MetaModelica.Dangerous.arrayGetNoBoundsChecking;
import stringGet = MetaModelica.Dangerous.stringGetNoBoundsChecking;
import MetaModelica.Dangerous.listReverseInPlace;

uniontype LexerTable
  record LEXER_TABLE
    array<Integer> accept;
    array<Integer> ec;
    array<Integer> meta;
    array<Integer> base;
    array<Integer> def;
    array<Integer> nxt;
    array<Integer> chk;
    array<Integer> acclist;
  end LEXER_TABLE;
end LexerTable;

constant Boolean debug = false;

function scan "Scan starts the lexical analysis, load the tables and consume the program to output the tokens"
  input String fileName "input source code file";
  output list<OMCCTypes.Token> tokens "return list of tokens";
protected
  String contents;
algorithm
  contents := loadSourceCode(fileName);
  tokens := lex(fileName,contents);
end scan;

function scanString "Scan starts the lexical analysis, load the tables and consume the program to output the tokens"
  input String fileSource "input source code file";
  output list<OMCCTypes.Token> tokens "return list of tokens";
algorithm
  tokens := lex("<StringSource>",fileSource);
end scanString;

function loadSourceCode
  input String fileName "input source code file";
  output String contents;
algorithm
  System.realtimeTick(2);
  contents := System.readFile(fileName);
  print("loadSourceCode finished in: " + realString(System.realtimeTock(2)*1000) + "ms\n");
end loadSourceCode;

function lex "Scan starts the lexical analysis, load the tables and consume the program to output the tokens"
  input String fileName "input source code file";
  input String contents;
  output list<OMCCTypes.Token> tokens "return list of tokens";
protected
  Integer startSt,numStates,i,r,cTok,cTok2,currSt,pos,sPos,ePos,linenr,contentLen,numBacktrack,buffer,lineNrStart;
  list<Integer> cProg,cProg2;
  list<String> chars;
  array<Integer> mm_accept,mm_ec,mm_meta,mm_base,mm_def,mm_nxt,mm_chk,mm_acclist,states;
  LexerTable lexTables;
  String s1,s2;
algorithm
  // load arrays

  mm_accept := listArray(LexTable.yy_accept);
  mm_ec := listArray(LexTable.yy_ec);
  mm_meta := listArray(LexTable.yy_meta);
  mm_base := listArray(LexTable.yy_base);
  mm_def := listArray(LexTable.yy_def);
  mm_nxt := listArray(LexTable.yy_nxt);
  mm_chk := listArray(LexTable.yy_chk);
  mm_acclist := listArray(LexTable.yy_acclist);
  lexTables := LEXER_TABLE(mm_accept,mm_ec,mm_meta,mm_base,mm_def,mm_nxt,mm_chk,mm_acclist);

  // Initialize the Env Variables
  startSt := 1;
  currSt := 1;
  pos := 1;
  sPos := 0;
  ePos := 0;
  linenr := 1;
  lineNrStart := 1;
  buffer := 0;
  // TODO: All
  states := arrayCreate(128,1);
  numStates := 1;

  if (debug==true) then
     print("\nLexer analyzer LexerCode..." + fileName + "\n");
     //printAny("\nLexer analyzer LexerCode..." + fileName + "\n");
  end if;

  tokens := {};
  if (debug) then
    print("\n TOTAL Chars:");
    print(intString(stringLength(contents)));
  end if;
  contentLen := stringLength(contents);
  i := 1;
  while i <= contentLen loop
     cTok := stringGet(contents,i);
     (tokens,numBacktrack,startSt,currSt,pos,sPos,ePos,linenr,lineNrStart,buffer,states,numStates) := consume(cTok,lexTables,tokens,contents,startSt,currSt,pos,sPos,ePos,linenr,lineNrStart,buffer,states,numStates,fileName);
     i := i - numBacktrack + 1;
  end while;
  tokens := listReverseInPlace(tokens);
end lex;

function consume
  input Integer cp;
  input LexerTable lexTables;
  input list<OMCCTypes.Token> tokens;
  input String fileContents;
  input Integer startSt;
  input Integer currSt,pos,sPos,ePos,linenr,inLineNrStart;
  input Integer inBuffer;
  input array<Integer> inStates;
  input Integer inNumStates;
  input String fileName;
  output list<OMCCTypes.Token> resToken;
  output Integer bkBuffer = 0;
  output Integer mm_startSt;
  output Integer mm_currSt,mm_pos,mm_sPos,mm_ePos,mm_linenr,lineNrStart;
  output Integer buffer;
  output array<Integer> states;
  output Integer numStates;
protected
  OMCCTypes.Token tok;
  Integer act,buffer2;
  array<Integer> mm_accept,mm_ec,mm_meta,mm_base,mm_def,mm_nxt,mm_chk,mm_acclist;
  Integer c,mm_finish,baseCond;
algorithm
  LEXER_TABLE(accept=mm_accept,ec=mm_ec,meta=mm_meta,base=mm_base,
    def=mm_def,nxt=mm_nxt,chk=mm_chk,acclist=mm_acclist) := lexTables;

  mm_startSt := startSt;
  mm_currSt := currSt;
  mm_pos := pos;
  mm_sPos := sPos;
  mm_ePos := ePos;
  mm_linenr := linenr;
  lineNrStart := inLineNrStart;
  buffer := inBuffer;
  states := inStates;
  numStates := inNumStates;

  mm_finish := LexTable.yy_finish;
  baseCond := arrayGet(mm_base,mm_currSt);
  if (debug==true) then
    print("\nPROGRAM:{" + intString(cp) + "} ");
    print("\nBUFFER:{" + intString(buffer) + "} ");
    print("base:" + intString(baseCond) + " st:" + intString(mm_currSt)+" ");
  end if;

  buffer := buffer+1;
  mm_pos := mm_pos+1;

  if (cp==10) then
    mm_linenr := mm_linenr+1;
    mm_sPos := 0;
  else
    mm_sPos := mm_sPos+1;
  end if;
  if (debug==true) then
    print("\n[Reading:'"  + intStringChar(cp) +"' at p:" + intString(mm_pos-1) + " line:"+ intString(mm_linenr) + " rPos:" + intString(mm_sPos) +"]");
  end if;
  c := arrayGet(mm_ec,cp);

  if (debug==true) then
    print(" evalState Before[c" + intString(c) + ",s"+ intString(mm_currSt)+"]");
  end if;
  (mm_currSt,c) := evalState(lexTables,mm_currSt,c);
  if (debug==true) then
    print(" After[c" + intString(c) + ",s"+ intString(mm_currSt)+"]");
  end if;
  if (mm_currSt>0) then
    mm_currSt := arrayGet(mm_base,mm_currSt);
    // print("BASE:"+ intString(mm_currSt)+"]");
    mm_currSt := arrayGet(mm_nxt,mm_currSt + c);
    // print("NEXT:"+ intString(mm_currSt)+"]");
  else
    mm_currSt := arrayGet(mm_nxt,c);
  end if;
  numStates := numStates+1; // TODO: BAD BAD BAD. At least arrayUpdate should be a safe operation... We need to grow the number of states on demand though.
  arrayUpdate(states,numStates,mm_currSt);
  // printAny(states);
  //  print("[c" + intString(c) + ",s"+ intString(mm_currSt)+"]");
  //  print("[B:" + intString(arrayGet(mm_base,mm_currSt))+"]");

  baseCond := arrayGet(mm_base,mm_currSt);
  if (baseCond==mm_finish) then
    if (debug==true) then
      print("\n[RESTORE=" + intString(arrayGet(mm_accept,mm_currSt)) + "]");
    end if;

    (act, mm_currSt, mm_pos, mm_sPos, mm_linenr, buffer, bkBuffer, states, numStates) := findRule(lexTables, fileContents, mm_currSt, mm_pos, mm_sPos, mm_ePos, mm_linenr, buffer, bkBuffer, states, numStates);

    (tok,mm_startSt,buffer2) := LexerCode.action(act,mm_startSt,mm_currSt,mm_pos,mm_sPos,mm_ePos,mm_linenr,lineNrStart,buffer,debug,fileName,fileContents);
    mm_currSt := mm_startSt;
    arrayUpdate(states,1,mm_startSt);
    numStates := 1;

    /* Either a token was output (get new positions for next token). Or a whitespace was emitted. */
    if buffer <> buffer2 then
      mm_ePos := mm_sPos;
      lineNrStart := linenr;
    end if;
    buffer := buffer2;

/*
  _ := match otok
local
OMCCTypes.Token tok;
case SOME(tok) equation print("Output token: " + OMCCTypes.printToken(tok) + "\n"); then ();
else ();
end match;
*/
    resToken := match tok
      case OMCCTypes.TOKEN(id=-1) then tokens;
      else tok::tokens;
    end match;
    if(debug) then
      print("\n CountTokens:" + intString(listLength(resToken)));
    end if;
  else
     bkBuffer := 0; // consume the character
     resToken := tokens;
  end if;

end consume;



function findRule
  input LexerTable lexTables;
  input String fileContents;
  input Integer currSt;
  input Integer pos;
  input Integer sPos;
  input Integer mm_ePos;
  input Integer linenr;
  input Integer inBuffer;
  input Integer inBkBuffer;
  input array<Integer> inStates;
  input Integer inNumStates;
  output Integer action;
  output Integer mm_currSt;
  output Integer mm_pos;
  output Integer mm_sPos;
  output Integer mm_linenr;
  output Integer buffer;
  output Integer bkBuffer;
  output array<Integer> states;
  output Integer numStates;
protected
  array<Integer> mm_accept,mm_ec,mm_meta,mm_base,mm_def,mm_nxt,mm_chk,mm_acclist;
  Integer lp,lp1,stCmp;
  Boolean st;
algorithm
  LEXER_TABLE(accept=mm_accept,ec=mm_ec,meta=mm_meta,base=mm_base,
    def=mm_def,nxt=mm_nxt,chk=mm_chk,acclist=mm_acclist) := lexTables;
  mm_currSt := currSt;
  mm_pos := pos;
  mm_sPos := sPos;
  mm_linenr := linenr;
  buffer := inBuffer;
  bkBuffer := inBkBuffer;
  states := inStates;
  numStates := inNumStates;

  stCmp := arrayGet(states,numStates);
  lp := arrayGet(mm_accept,stCmp);
  lp1 := arrayGet(mm_accept,stCmp+1);

  st := intGt(lp,0) and intLt(lp,lp1);
  (action, mm_currSt, mm_pos, mm_sPos, mm_linenr, buffer, bkBuffer, states, numStates) := match(numStates,st)
    local
      Integer act,cp;
      list<Integer> restBuff;
    case (_,true)
      equation
        lp = arrayGet(mm_accept,stCmp);
        act = arrayGet(mm_acclist,lp);
      then (act, mm_currSt, mm_pos, mm_sPos, mm_linenr, buffer, bkBuffer, states, numStates);
    case (_,false)
      equation
        cp = stringGet(fileContents,mm_pos-1);
        buffer = buffer-1;
        bkBuffer = bkBuffer+1;
        mm_pos = mm_pos - 1;
        mm_sPos = mm_sPos -1;
        if (cp==10) then
          mm_sPos = mm_ePos;
          mm_linenr = mm_linenr-1;
        end if;
        mm_currSt = arrayGet(states,numStates);
        numStates = numStates - 1;
        (act, mm_currSt, mm_pos, mm_sPos, mm_linenr, buffer, bkBuffer, states, numStates) = findRule(lexTables, fileContents, mm_currSt, mm_pos, mm_sPos, mm_ePos, mm_linenr, buffer, bkBuffer, states, numStates);
      then (act, mm_currSt, mm_pos, mm_sPos, mm_linenr, buffer, bkBuffer, states, numStates);

  end match;
end findRule;

function evalState
  input LexerTable lexTables;
  input Integer cState;
  input Integer c;
  output Integer new_state;
  output Integer new_c;
  protected
  Integer cState1 =cState;
  Integer c1 =c;
  array<Integer> mm_accept,mm_ec,mm_meta,mm_base,mm_def,mm_nxt,mm_chk,mm_acclist;
  Integer val,val2,chk;
algorithm
  LEXER_TABLE(accept=mm_accept,ec=mm_ec,meta=mm_meta,base=mm_base,
    def=mm_def,nxt=mm_nxt,chk=mm_chk,acclist=mm_acclist) := lexTables;
  chk := arrayGet(mm_base,cState1);
  chk := chk + c1;
  val := arrayGet(mm_chk,chk);
  val2 := arrayGet(mm_base,cState1) + c1;
  //   print("{val2=" + intString(val2) + "}\n");
  (new_state,new_c) := match (cState1==val)
    local
      Integer s,c2;
    case (true)
       then (cState1,c1);
    case (false)
      equation
        cState1 = arrayGet(mm_def,cState1);
        //print("[newS:" + intString(cState)+"]");
        //c2 = c;
        if ( cState1 >= LexTable.yy_limit ) then
          c1 = arrayGet(mm_meta,c1);
          //     print("META[c:" + intString(c)+"]");
        end if;
          if (cState1>0) then
            (cState1,c1) = evalState(lexTables,cState1,c1);
          end if;
          then (cState1,c1);
  end match;

end evalState;

function getInfo
  input Integer len;
  input Integer sPos;
  input Integer ePos;
  input Integer lineNrStart;
  input Integer mm_linenr;
  input String programName;
  output OMCCTypes.Info info;
protected
  Integer mm_sPos;
  Integer c;
algorithm
/*  for i in  (List.isEmpty(buff1)==false) loop
      c::buff1 := buff1;
      if (c==10) then
          mm_linenr := mm_linenr - 1;
          mm_sPos := 0;
      else
          mm_sPos := mm_sPos - 1;
      end if;
  end while; */
  info := OMCCTypes.INFO(programName,false,lineNrStart,ePos+1,mm_linenr /* flineNr */, sPos+1 /* frPos+1 */,Absyn.dummyTimeStamp);
  /*if (true) then
     print("\nTOKEN file:" +programName + " p(" + intString(mm_sPos) + ":" + intString(mm_linenr) + ")-(" + intString(frPos) + ":" + intString(flineNr) + ")");
  end if; */
end getInfo;

function printBuffer2
  input list<Integer> inList;
  input String cBuff;
  output String outList;
  protected
  list<Integer> inList1= inList;
  String cBuff1 =cBuff;
algorithm
  (outList) := match(inList,cBuff)
    local
      Integer c;
      String new,tout;
      list<Integer> rest;
    case ({},_)
    then (cBuff1);
      else
      equation
        c::rest = inList1;
        new = cBuff1 + intStringChar(c);
        (tout) = printBuffer2(rest,new);
      then (tout);
  end match;
end printBuffer2;

function printBuffer
  input list<Integer> inList;
  output String outList;
  protected
  list<Integer> inList1= inList;
  Integer c;
algorithm
  outList := "";
  while (List.isEmpty(inList1)==false) loop
     c::inList1 := inList1;
     outList := outList + intStringChar(c);
  end while;
end printBuffer;

function printStack
    input list<Integer> inList;
    input String cBuff;
    output String outList;
    protected
    list<Integer> inList1 =inList;
    String cBuff1 =cBuff;
   algorithm
    (outList) := match(inList,cBuff)
      local
        Integer c;
        String new,tout;
        list<Integer> rest;
      case ({},_)
        then (cBuff1);
      else
        equation
           c::rest = inList1;
           new = cBuff1 + "|" + intString(c);
           (tout) = printStack(rest,new);
        then (tout);
     end match;
  end printStack;



end Lexer;
