package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealOutput = output Real "'output Real' as connector";
    end Interfaces;
  end Blocks;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Random  "Library of functions for generating random numbers" 
      extends Modelica.Icons.Package;

      package Generators  "Library of functions generating uniform random numbers in the range 0 < random <= 1.0 (with exposed state vectors)" 
        extends Modelica.Icons.Package;

        package Xorshift64star  "Random number generator xorshift64*" 
          constant Integer nState = 2 "The dimension of the internal state vector";
          extends Modelica.Icons.Package;

          function initialState  "Returns an initial state for the xorshift64* algorithm" 
            extends Modelica.Icons.Function;
            input Integer localSeed "The local seed to be used for generating initial states";
            input Integer globalSeed "The global seed to be combined with the local seed";
            output Integer[nState] state "The generated initial states";
          protected
            Real r "Random number not used outside the function";
            constant Integer p = 10 "The number of iterations to use";
          algorithm
            if localSeed == 0 and globalSeed == 0 then
              state := {126247697, globalSeed};
            else
              state := {localSeed, globalSeed};
            end if;
            for i in 1:p loop
              (r, state) := random(state);
            end for;
          end initialState;

          function random  "Returns a uniform random number with the xorshift64* algorithm" 
            extends Modelica.Icons.Function;
            input Integer[nState] stateIn "The internal states for the random number generator";
            output Real result "A random number with a uniform distribution on the interval (0,1]";
            output Integer[nState] stateOut "The new internal states of the random number generator";
            external "C" ModelicaRandom_xorshift64star(stateIn, stateOut, result) annotation(Library = "ModelicaExternalC");
          end random;
        end Xorshift64star;

        package Xorshift128plus  "Random number generator xorshift128+" 
          constant Integer nState = 4 "The dimension of the internal state vector";
          extends Modelica.Icons.Package;

          function initialState  "Returns an initial state for the xorshift128+ algorithm" 
            extends Modelica.Icons.Function;
            input Integer localSeed "The local seed to be used for generating initial states";
            input Integer globalSeed "The global seed to be combined with the local seed";
            output Integer[nState] state "The generated initial states";
          algorithm
            state := Utilities.initialStateWithXorshift64star(localSeed, globalSeed, size(state, 1));
            annotation(Inline = true); 
          end initialState;

          function random  "Returns a uniform random number with the xorshift128+ algorithm" 
            extends Modelica.Icons.Function;
            input Integer[nState] stateIn "The internal states for the random number generator";
            output Real result "A random number with a uniform distribution on the interval (0,1]";
            output Integer[nState] stateOut "The new internal states of the random number generator";
            external "C" ModelicaRandom_xorshift128plus(stateIn, stateOut, result) annotation(Library = "ModelicaExternalC");
          end random;
        end Xorshift128plus;
      end Generators;

      package Utilities  "Library of utility functions for the Random package (usually of no interest for the user)" 
        extends Modelica.Icons.UtilitiesPackage;

        function initialStateWithXorshift64star  "Return an initial state vector for a random number generator (based on xorshift64star algorithm)" 
          extends Modelica.Icons.Function;
          input Integer localSeed "The local seed to be used for generating initial states";
          input Integer globalSeed "The global seed to be combined with the local seed";
          input Integer nState(min = 1) "The dimension of the state vector (>= 1)";
          output Integer[nState] state "The generated initial states";
        protected
          Real r "Random number only used inside function";
          Integer[2] aux "Intermediate container of state integers";
          Integer nStateEven "Highest even number <= nState";
        algorithm
          aux := .Modelica.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed);
          if nState >= 2 then
            state[1:2] := aux;
          else
            state[1] := aux[1];
          end if;
          nStateEven := 2 * div(nState, 2);
          for i in 3:2:nStateEven loop
            (r, aux) := .Modelica.Math.Random.Generators.Xorshift64star.random(state[i - 2:i - 1]);
            state[i:i + 1] := aux;
          end for;
          if nState >= 3 and nState <> nStateEven then
            (r, aux) := .Modelica.Math.Random.Generators.Xorshift64star.random(state[nState - 2:nState - 1]);
            state[nState] := aux[1];
          else
          end if;
        end initialStateWithXorshift64star;
      end Utilities;
    end Random;
  end Math;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package ExamplesPackage  "Icon for packages containing runnable examples" 
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial model Example  "Icon for runnable examples" end Example;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package UtilitiesPackage  "Icon for utility packages" 
      extends Modelica.Icons.Package;
    end UtilitiesPackage;

    partial function Function  "Icon for functions" end Function;
  end Icons;
  annotation(version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z"); 
end Modelica;

package PNlib  
  model PC  "Continuous Place" 
    Real t "marking";
    parameter Integer nIn = 0 "number of input transitions";
    parameter Integer nOut = 0 "number of output transitions";
    parameter Real startMarks = 0 "start marks";
    parameter Real minMarks = 0 "minimum capacity";
    parameter Real maxMarks = Constants.inf "maximum capacity";
    Boolean reStart = false "restart condition";
    parameter Real reStartMarks = 0 "number of marks at restart";
    parameter Integer N = settings.N "N+1=amount of levels";
    parameter Integer enablingType = 1 "resolution type of actual conflict (type-1-conflict)";
    parameter Real[nIn] enablingProbIn = fill(1 / nIn, nIn) "enabling probabilities of input transitions";
    parameter Real[nOut] enablingProbOut = fill(1 / nOut, nOut) "enabling probabilities of output transitions";
    Real levelCon "conversion of tokens to level concentration according to M and N of the settings box";
    Integer showPlaceName = settings.showPlaceName "only for place animation and display (Do not change!)";
    Integer showCapacity = settings.showCapacity "only for place animation and display (Do not change!)";
    Integer animateMarking = settings.animateMarking "only for place animation and display (Do not change!)";
    Real[3] color "only for place animation and display (Do not change!)";
    parameter Boolean showTokenFlow = settings.showTokenFlow;
    Blocks.tokenFlowCon tokenFlow(nIn = nIn, nOut = nOut, conFiringSumIn = firingSumIn.conFiringSum, conFiringSumOut = firingSumOut.conFiringSum, fireIn = fireIn, fireOut = fireOut, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, instSpeedIn = instSpeedIn, instSpeedOut = instSpeedOut) if showTokenFlow;
    parameter Integer localSeedIn = Functions.Random.counter() "Local seed to initialize random number generator for input conflicts";
    parameter Integer localSeedOut = Functions.Random.counter() "Local seed to initialize random number generator for output conflicts";
  protected
    outer PNlib.Settings settings "global settings for animation and display";
    Real disMarkChange "discrete mark change";
    Real conMarkChange "continuous mark change";
    Real[nIn] arcWeightIn "weights of input arcs";
    Real[nOut] arcWeightOut "weights of output arcs";
    Real[nIn] instSpeedIn "instantaneous speed of input transitions";
    Real[nOut] instSpeedOut "instantaneous speed of output transitions";
    Real[nIn] maxSpeedIn "maximum speed of input transitions";
    Real[nOut] maxSpeedOut "maximum speed of output transitions";
    Real[nIn] prelimSpeedIn "preliminary speed of input transitions";
    Real[nOut] prelimSpeedOut "preliminary speed of output transitions";
    Real tokenscale "only for place animation and display";
    Real t_(start = startMarks, fixed = true) "marking";
    Boolean disMarksInOut(start = false, fixed = true) "discrete marks change";
    Boolean[nIn] preFireIn "pre-value of fireIn";
    Boolean[nOut] preFireOut "pre-value of fireOut";
    Boolean[nIn] fireIn(each start = false, each fixed = true) "Does any input transition fire?";
    Boolean[nOut] fireOut(each start = false, each fixed = true) "Does any output transition fire?";
    Boolean[nIn] disTransitionIn "Are the input transitions discrete?";
    Boolean[nOut] disTransitionOut "Are the output transitions discrete?";
    Boolean[nIn] activeIn "Are the input transitions active?";
    Boolean[nOut] activeOut "Are the output transitions active?";
    Boolean[nIn] enabledByInPlaces "Are the input transitions enabled by all their input places?";
    Blocks.enablingInCon enableIn(active = activeIn, delayPassed = delayPassedIn.anytrue, nIn = nIn, arcWeight = arcWeightIn, t = t_, maxMarks = maxMarks, TAein = enabledByInPlaces, enablingType = enablingType, enablingProb = enablingProbIn, disTransition = disTransitionIn, localSeed = localSeedIn, globalSeed = settings.globalSeed);
    Blocks.enablingOutCon enableOut(delayPassed = delayPassedOut.anytrue, nOut = nOut, arcWeight = arcWeightOut, t = t_, minMarks = minMarks, TAout = activeOut, enablingType = enablingType, enablingProb = enablingProbOut, disTransition = disTransitionOut, localSeed = localSeedOut, globalSeed = settings.globalSeed);
    Blocks.anyTrue delayPassedOut(vec = activeOut and disTransitionOut);
    Blocks.anyTrue delayPassedIn(vec = activeIn and disTransitionIn);
    Blocks.anyTrue disMarksOut(vec = fireOut and disTransitionOut);
    Blocks.anyTrue disMarksIn(vec = fireIn and disTransitionIn);
    Blocks.anyTrue feeding(vec = preFireIn and not disTransitionIn);
    Blocks.anyTrue emptying(vec = preFireOut and not disTransitionOut);
    Blocks.firingSumCon firingSumIn(fire = preFireIn, arcWeight = arcWeightIn, instSpeed = instSpeedIn, disTransition = disTransitionIn);
    Blocks.firingSumCon firingSumOut(fire = preFireOut, arcWeight = arcWeightOut, instSpeed = instSpeedOut, disTransition = disTransitionOut);
    Real[nIn] decFactorIn "decreasing factors for input transitions";
    Real[nOut] decFactorOut "decreasing factors for output transitions";
  public
    Interfaces.PlaceIn[nIn] inTransition(each t = t_, each tint = 1, each maxTokens = maxMarks, each maxTokensint = 1, enable = enableIn.TEin_, each emptied = emptying.anytrue, decreasingFactor = decFactorIn, each disPlace = false, each speedSum = firingSumOut.conFiringSum, fire = fireIn, disTransition = disTransitionIn, active = activeIn, arcWeight = arcWeightIn, instSpeed = instSpeedIn, maxSpeed = maxSpeedIn, prelimSpeed = prelimSpeedIn, enabledByInPlaces = enabledByInPlaces) if nIn > 0 "connector for input transitions";
    Interfaces.PlaceOut[nOut] outTransition(each t = t_, each tint = 1, each minTokens = minMarks, each minTokensint = 1, enable = enableOut.TEout_, each fed = feeding.anytrue, decreasingFactor = decFactorOut, each disPlace = false, each arcType = 1, each speedSum = firingSumIn.conFiringSum, each tokenInOut = pre(disMarksInOut), fire = fireOut, disTransition = disTransitionOut, active = activeOut, arcWeight = arcWeightOut, instSpeed = instSpeedOut, maxSpeed = maxSpeedOut, prelimSpeed = prelimSpeedOut, each testValue = -1, each testValueint = -1, each normalArc = 2) if nOut > 0 "connector for output transitions";
    Modelica.Blocks.Interfaces.RealOutput pc_t = t "connector for Simulink connection";
  equation
    (decFactorIn, decFactorOut) = Functions.decreasingFactor(nIn = nIn, nOut = nOut, t = t_, minMarks = minMarks, maxMarks = maxMarks, speedIn = firingSumIn.conFiringSum, speedOut = firingSumOut.conFiringSum, maxSpeedIn = maxSpeedIn, maxSpeedOut = maxSpeedOut, prelimSpeedIn = prelimSpeedIn, prelimSpeedOut = prelimSpeedOut, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, firingIn = fireIn and not disTransitionIn, firingOut = fireOut and not disTransitionOut);
    conMarkChange = firingSumIn.conFiringSum - firingSumOut.conFiringSum;
    der(t_) = conMarkChange;
    disMarkChange = firingSumIn.disFiringSum - firingSumOut.disFiringSum;
    disMarksInOut = disMarksOut.anytrue or disMarksIn.anytrue;
    when {disMarksInOut, reStart} then
      reinit(t_, if reStart then reStartMarks else t_ + disMarkChange);
    end when;
    levelCon = t * settings.M / N;
    for i in 1:nOut loop
      preFireOut[i] = if disTransitionOut[i] then fireOut[i] else pre(fireOut[i]);
    end for;
    for i in 1:nIn loop
      preFireIn[i] = if disTransitionIn[i] then fireIn[i] else pre(fireIn[i]);
    end for;
    t = noEvent(if t_ < minMarks then minMarks elseif t_ > maxMarks then maxMarks else t_);
    tokenscale = t * settings.scale;
    color = if settings.animatePlace == 1 then if tokenscale < 100 then {255, 255 - 2.55 * tokenscale, 255 - 2.55 * tokenscale} else {255, 0, 0} else {255, 255, 255};
    assert(Functions.OddsAndEnds.isEqual(sum(enablingProbIn), 1.0, 1e-6) or nIn == 0 or enablingType == 1, "The sum of input enabling probabilities has to be equal to 1");
    assert(Functions.OddsAndEnds.isEqual(sum(enablingProbOut), 1.0, 1e-6) or nOut == 0 or enablingType == 1, "The sum of output enabling probabilities has to be equal to 1");
    assert(startMarks >= minMarks and startMarks <= maxMarks, "minMarks<=startMarks<=maxMarks");
  end PC;

  model TC  "Continuous Transition" 
    parameter Integer nIn = 0 "number of input places";
    parameter Integer nOut = 0 "number of output places";
    Real maximumSpeed = 1 "maximum speed";
    Real[nIn] arcWeightIn = fill(1, nIn) "arc weights of input places";
    Real[nOut] arcWeightOut = fill(1, nOut) "arc weights of output places";
    Boolean firingCon = true "additional firing condition";
    Boolean fire "Does the transition fire?";
    Real instantaneousSpeed "instantaneous speed";
    Real actualSpeed = if fire then instantaneousSpeed else 0.0;
    Integer showTransitionName = settings.showTransitionName "only for transition animation and display (Do not change!)";
    Integer animateSpeed = settings.animateSpeed "only for transition animation and display (Do not change!)";
    Real[3] color "only for transition animation and display (Do not change!)";
  protected
    outer PNlib.Settings settings "global settings for animation and display";
    Real prelimSpeed "preliminary speed";
    Real[nIn] tIn "tokens of input places";
    Real[nOut] tOut "tokens of output places";
    Real[nIn] minTokens "minimum tokens of input places";
    Real[nOut] maxTokens "maximum tokens of output places";
    Real[nIn] speedSumIn "Input speeds of continuous input places";
    Real[nOut] speedSumOut "Output speeds of continuous output places";
    Real[nIn] decreasingFactorIn "decreasing factors of input places";
    Real[nOut] decreasingFactorOut "decreasing factors of output places";
    Real[nIn] testValue "test values of test or inhibitor arcs";
    Integer[nIn] arcType "type of input arcs 1=normal, 2=test arc, 3=inhibitor arc, 4=read arc";
    Integer[nIn] arcWeightIntIn "Integer arc weights of discrete input places (for generating events!)";
    Integer[nOut] arcWeightIntOut "Integer arc weights of discrete output places (for generating events!)";
    Integer[nIn] minTokensInt "Integer minimum tokens of input places (for generating events!)";
    Integer[nOut] maxTokensInt "Integer maximum tokens of output places (for generating events!)";
    Integer[nIn] tIntIn "integer tokens of input places (for generating events!)";
    Integer[nOut] tIntOut "integer tokens of output places (for generating events!)";
    Integer[nIn] testValueInt "Integer test values of input arcs (for generating events!)";
    Integer[nIn] normalArc "1=no, 2=yes, i.e. double arc: test and normal arc or inhibitor and normal arc";
    Boolean[nIn] fed "Are the input places fed by their input transitions?";
    Boolean[nOut] emptied "Are the output places emptied by their output transitions?";
    Boolean[nIn] disPlaceIn "Are the input places discrete?";
    Boolean[nOut] disPlaceOut "Are the output places discrete?";
    Boolean[nIn] enableIn "Is the transition enabled by all its discrete input transitions?";
    Blocks.activationCon activation(testValue = testValue, testValueInt = testValueInt, normalArc = normalArc, nIn = nIn, nOut = nOut, tIn = tIn, tOut = tOut, tIntIn = tIntIn, tIntOut = tIntOut, arcType = arcType, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, arcWeightIntIn = arcWeightIntIn, arcWeightIntOut = arcWeightIntOut, minTokens = minTokens, maxTokens = maxTokens, minTokensInt = minTokensInt, maxTokensInt = maxTokensInt, firingCon = firingCon, fed = fed, emptied = emptied, disPlaceIn = disPlaceIn, disPlaceOut = disPlaceOut);
    Boolean fire_ = Functions.OddsAndEnds.allTrue(Functions.OddsAndEnds.boolOr(enableIn, not disPlaceIn));
  public
    Interfaces.TransitionIn[nIn] inPlaces(each active = activation.active, each fire = fire, arcWeight = arcWeightIn, arcWeightint = arcWeightIntIn, each disTransition = false, each instSpeed = instantaneousSpeed, each prelimSpeed = prelimSpeed, each maxSpeed = maximumSpeed, t = tIn, tint = tIntIn, arcType = arcType, minTokens = minTokens, minTokensint = minTokensInt, fed = fed, disPlace = disPlaceIn, enable = enableIn, speedSum = speedSumIn, decreasingFactor = decreasingFactorIn, testValue = testValue, testValueint = testValueInt, normalArc = normalArc) if nIn > 0 "connector for input places";
    Interfaces.TransitionOut[nOut] outPlaces(each active = activation.active, each fire = fire, each enabledByInPlaces = true, arcWeight = arcWeightOut, arcWeightint = arcWeightIntOut, each disTransition = false, each instSpeed = instantaneousSpeed, each prelimSpeed = prelimSpeed, each maxSpeed = maximumSpeed, t = tOut, tint = tIntOut, maxTokens = maxTokens, maxTokensint = maxTokensInt, emptied = emptied, disPlace = disPlaceOut, speedSum = speedSumOut, decreasingFactor = decreasingFactorOut) if nOut > 0 "connector for output places";
  equation
    prelimSpeed = Functions.preliminarySpeed(nIn = nIn, nOut = nOut, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, speedSumIn = speedSumIn, speedSumOut = speedSumOut, maximumSpeed = maximumSpeed, weaklyInputActiveVec = activation.weaklyInputActiveVec, weaklyOutputActiveVec = activation.weaklyOutputActiveVec);
    fire = fire_ and activation.active and not maximumSpeed <= 0;
    instantaneousSpeed = min(min(min(decreasingFactorIn), min(decreasingFactorOut)) * maximumSpeed, prelimSpeed);
    color = if fire and settings.animateTransition == 1 then {255, 255, 0} else {255, 255, 255};
    for i in 1:nIn loop
      if disPlaceIn[i] then
        arcWeightIntIn[i] = integer(arcWeightIn[i]);
      else
        arcWeightIntIn[i] = 1;
      end if;
      assert(disPlaceIn[i] and arcWeightIn[i] - arcWeightIntIn[i] <= 0.0 or not disPlaceIn[i], "Input arcs connected to discrete places must have integer weights.");
      assert(arcWeightIn[i] >= 0, "Input arc weights must be positive.");
    end for;
    for i in 1:nOut loop
      if disPlaceOut[i] then
        arcWeightIntOut[i] = integer(arcWeightOut[i]);
      else
        arcWeightIntOut[i] = 1;
      end if;
      assert(disPlaceOut[i] and arcWeightOut[i] - arcWeightIntOut[i] <= 0.0 or not disPlaceOut[i], "Output arcs connected to discrete places must have integer weights.");
      assert(arcWeightOut[i] >= 0, "Output arc weights must be positive.");
    end for;
  end TC;

  model Settings  "Global Settings for Animation and Display" 
    parameter Integer showPlaceName = 1 "show names of places";
    parameter Integer showTransitionName = 1 "show names of transitions";
    parameter Integer showDelay = 1 "show delays of discrete transitions";
    parameter Integer showCapacity = 2 "show capacities of places";
    parameter Integer animateMarking = 1 "animation of markings";
    parameter Integer animatePlace = 1 "animation of places";
    parameter Real scale = 1 "scale factor for place animation 0-100";
    parameter Integer animateTransition = 1 "animation of transitions";
    parameter Real timeFire = 0.3 "time of transition animation";
    parameter Integer animatePutFireTime = 1 "animation of putative fire time of stochastic transitions";
    parameter Integer animateHazardFunc = 1 "animation of hazard functions of stochastic transitions";
    parameter Integer animateSpeed = 1 "animation speed of continuous transitions";
    parameter Integer animateWeightTIarc = 1 "show weights of test and inhibitor arcs";
    parameter Integer animateTIarc = 1 "animation of test and inhibition arcs";
    parameter Integer N = 10 "N+1=amount of levels";
    parameter Real M = 1 "maximum concentration";
    parameter Boolean showTokenFlow = false;
    parameter Integer globalSeed = 30020 "global seed to initialize random number generator";
    annotation(defaultComponentPrefixes = "inner", missingInnerMessage = "The settings object is missing"); 
  end Settings;

  package Interfaces  "contains the connectors for the Petri net component models" 
    connector PlaceIn  "part of place model to connect places to input transitions" 
      input Boolean active "Are the input transitions active?" annotation(HideResult = true);
      input Boolean fire "Do the input transitions fire?" annotation(HideResult = true);
      input Real arcWeight "Arc weights of input transitions" annotation(HideResult = true);
      input Integer arcWeightint "Integer arc weights of input transitions" annotation(HideResult = true);
      input Boolean enabledByInPlaces "Are the input transitions enabled by all theier input places?" annotation(HideResult = true);
      input Boolean disTransition "Types of input transitions (discrete/stochastic or continuous)" annotation(HideResult = true);
      input Real instSpeed "Instantaneous speeds of continuous input transitions" annotation(HideResult = true);
      input Real prelimSpeed "Preliminary speeds of continuous input transitions" annotation(HideResult = true);
      input Real maxSpeed "Maximum speeds of continuous input transitions" annotation(HideResult = true);
      output Real t "Marking of the place" annotation(HideResult = true);
      output Integer tint "Integer marking of the place" annotation(HideResult = true);
      output Real maxTokens "Maximum capacity of the place" annotation(HideResult = true);
      output Integer maxTokensint "Integer maximum capacity of the place" annotation(HideResult = true);
      output Boolean enable "Which of the input transitions are enabled by the place?" annotation(HideResult = true);
      output Real decreasingFactor "Factor for decreasing the speed of continuous input transitions" annotation(HideResult = true);
      output Boolean disPlace "Type of the place (discrete or continuous)" annotation(HideResult = true);
      output Boolean emptied "Is the continuous place emptied by output transitions?" annotation(HideResult = true);
      output Real speedSum "Output speed of a continuous place" annotation(HideResult = true);
    end PlaceIn;

    connector PlaceOut  "part of place model to connect places to output transitions" 
      input Boolean active "Are the output transitions active?" annotation(HideResult = true);
      input Boolean fire "Do the output transitions fire?" annotation(HideResult = true);
      input Real arcWeight "Arc weights of output transitions" annotation(HideResult = true);
      input Integer arcWeightint "Integer arc weights of output transitions" annotation(HideResult = true);
      input Boolean disTransition "Are the output transitions discrete?" annotation(HideResult = true);
      input Real instSpeed "Instantaneous speeds of continuous output transitions" annotation(HideResult = true);
      input Real prelimSpeed "Preliminary speeds of continuous output transitions" annotation(HideResult = true);
      input Real maxSpeed "Maximum speeds of continuous output transitions" annotation(HideResult = true);
      output Real t "Marking of the place" annotation(HideResult = true);
      output Integer tint "Integer marking of the place" annotation(HideResult = true);
      output Real minTokens "Minimum capacity of the place" annotation(HideResult = true);
      output Integer minTokensint "Integer minimum capacity of the place" annotation(HideResult = true);
      output Boolean enable "Which of the output transitions are enabled by the place?" annotation(HideResult = true);
      output Real decreasingFactor "Factor for decreasing the speed of continuous input transitions" annotation(HideResult = true);
      output Boolean disPlace "Type of the place (discrete or continuous)" annotation(HideResult = true);
      output Integer arcType "Type of output arcs (normal, test, inhibition, or read)" annotation(HideResult = true);
      output Boolean fed "Is the continuous place fed by input transitions?" annotation(HideResult = true);
      output Real speedSum "Input speed of a continuous place" annotation(HideResult = true);
      output Boolean tokenInOut "Does the place have a discrete token change?" annotation(HideResult = true);
      output Real testValue "Test value of a test or inhibitor arc" annotation(HideResult = true);
      output Integer testValueint "Integer test value of a test or inhibitor arc" annotation(HideResult = true);
      output Integer normalArc "Double arc: test and normal arc or inhibitor and normal arc" annotation(HideResult = true);
    end PlaceOut;

    connector TransitionIn  "part of transition model to connect transitions to input places" 
      input Real t "Markings of input places" annotation(HideResult = true);
      input Integer tint "Integer Markings of input places" annotation(HideResult = true);
      input Real minTokens "Minimum capacites of input places" annotation(HideResult = true);
      input Integer minTokensint "Integer minimum capacites of input places" annotation(HideResult = true);
      input Boolean enable "Is the transition enabled by input places?" annotation(HideResult = true);
      input Real decreasingFactor "Factor of continuous input places for decreasing the speed" annotation(HideResult = true);
      input Boolean disPlace "Types of input places (discrete or continuous)" annotation(HideResult = true);
      input Integer arcType "Types of input arcs (normal, test, inhibition, or read)" annotation(HideResult = true);
      input Boolean fed "Are the continuous input places fed?" annotation(HideResult = true);
      input Real speedSum "Input speeds of continuous input places" annotation(HideResult = true);
      input Boolean tokenInOut "Do the input places have a discrete token change?" annotation(HideResult = true);
      input Real testValue "Test value of a test or inhibitor arc" annotation(HideResult = true);
      input Integer testValueint "Integer test value of a test or inhibitor arc" annotation(HideResult = true);
      input Integer normalArc "Double arc: test and normal arc or inhibitor and normal arc" annotation(HideResult = true);
      output Boolean active "Is the transition active?" annotation(HideResult = true);
      output Boolean fire "Does the transition fire?" annotation(HideResult = true);
      output Real arcWeight "Input arc weights of the transition" annotation(HideResult = true);
      output Integer arcWeightint "Integer input arc weights of the transition" annotation(HideResult = true);
      output Boolean disTransition "Type of the transition(discrete/stochastic or continuous)" annotation(HideResult = true);
      output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult = true);
      output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult = true);
      output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult = true);
    end TransitionIn;

    connector TransitionOut  "part of transition model to connect transitions to output places" 
      input Real t "Markings of output places" annotation(HideResult = true);
      input Integer tint "Integer markings of output places" annotation(HideResult = true);
      input Real maxTokens "Maximum capacities of output places" annotation(HideResult = true);
      input Integer maxTokensint "Integer maximum capacities of output places" annotation(HideResult = true);
      input Boolean enable "Is the transition enabled by output places?" annotation(HideResult = true);
      input Real decreasingFactor "Factor of continuous output places for decreasing the speed" annotation(HideResult = true);
      input Boolean disPlace "Types of output places (discrete or continuous)" annotation(HideResult = true);
      input Boolean emptied "Are the continuous output places emptied?" annotation(HideResult = true);
      input Real speedSum "Output speeds of continuous output places" annotation(HideResult = true);
      output Boolean active "Is the transition active?" annotation(HideResult = true);
      output Boolean fire "Does the transition fire?" annotation(HideResult = true);
      output Real arcWeight "Output arc weights of the transition" annotation(HideResult = true);
      output Integer arcWeightint "Integer output arc weights of the transition" annotation(HideResult = true);
      output Boolean enabledByInPlaces "Is the transition enabled by all input places?" annotation(HideResult = true);
      output Boolean disTransition "Type of the transition (discrete/stochastic or continuous)" annotation(HideResult = true);
      output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult = true);
      output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult = true);
      output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult = true);
    end TransitionOut;
  end Interfaces;

  package Blocks  "contains blocks with specific procedures that are used in the Petri net component models" 
    block activationCon  "activation process of continuous transitions" 
      parameter input Integer nIn "number of input places";
      parameter input Integer nOut "number of output places";
      input Real[:] tIn "marking of input places";
      input Real[:] tOut "marking of output places";
      input Integer[:] tIntIn "marking of input places";
      input Integer[:] tIntOut "marking of output places";
      input Integer[:] arcType "arc type of input places";
      input Real[:] arcWeightIn "arc weights of input places";
      input Real[:] arcWeightOut "arc weights of output places";
      input Integer[:] arcWeightIntIn "arc weights of input places";
      input Integer[:] arcWeightIntOut "arc weights of output places";
      input Real[:] minTokens "minimum capacities of input places";
      input Real[:] maxTokens "maximum capacities of output places";
      input Integer[:] minTokensInt "minimum capacities of input places";
      input Integer[:] maxTokensInt "maximum capacities of output places";
      input Boolean firingCon "firing condition";
      input Boolean[:] fed "input places are fed?";
      input Boolean[:] emptied "output places are emptied?";
      input Boolean[:] disPlaceIn "types of input places";
      input Boolean[:] disPlaceOut "types of output places";
      input Real[:] testValue "test values of test and inhibitor arcs";
      input Integer[:] testValueInt "integer test values of test and inhibitor arcs";
      input Integer[:] normalArc "normal or double arc?";
      output Boolean active "activation of transition";
      output Boolean[nIn] weaklyInputActiveVec "places that causes weakly input activation";
      output Boolean[nOut] weaklyOutputActiveVec "places that causes weakly output activation";
    algorithm
      active := true;
      weaklyInputActiveVec := fill(false, nIn);
      weaklyOutputActiveVec := fill(false, nOut);
      for i in 1:nIn loop
        if disPlaceIn[i] then
          if arcType[i] == 1 and tIntIn[i] - arcWeightIntIn[i] < minTokensInt[i] then
            active := false;
          elseif arcType[i] == 2 and tIntIn[i] < testValueInt[i] then
            active := false;
          elseif arcType[i] == 3 and tIntIn[i] >= testValueInt[i] then
            active := false;
          else
          end if;
        else
          if arcType[i] == 1 or normalArc[i] == 2 then
            if arcWeightIn[i] <= 0.0 then
            elseif tIn[i] <= minTokens[i] and not fed[i] then
              active := false;
            elseif tIn[i] <= minTokens[i] and fed[i] then
              weaklyInputActiveVec[i] := true;
            else
            end if;
          else
          end if;
          if arcType[i] == 2 then
            if tIn[i] <= testValue[i] then
              active := false;
            else
            end if;
            if tIn[i] > testValue[i] and fed[i] and normalArc[i] == 2 then
              weaklyInputActiveVec[i] := true;
            else
            end if;
          elseif arcType[i] == 3 and tIn[i] >= testValue[i] then
            active := false;
          else
          end if;
        end if;
      end for;
      for i in 1:nOut loop
        if disPlaceOut[i] then
          if tIntOut[i] + arcWeightIntOut[i] > maxTokensInt[i] then
            active := false;
          else
          end if;
        else
          if tOut[i] >= maxTokens[i] then
            if emptied[i] then
              weaklyOutputActiveVec[i] := true;
            else
              active := false;
            end if;
          else
          end if;
        end if;
      end for;
      active := active and firingCon;
      for i in 1:nOut loop
        weaklyOutputActiveVec[i] := weaklyOutputActiveVec[i] and firingCon;
      end for;
      for i in 1:nIn loop
        weaklyInputActiveVec[i] := weaklyInputActiveVec[i] and firingCon;
      end for;
    end activationCon;

    block anyTrue  "Is any entry of a Boolean vector true?" 
      input Boolean[:] vec;
      output Boolean anytrue;
      output Integer numtrue;
    algorithm
      anytrue := false;
      numtrue := 0;
      for i in 1:size(vec, 1) loop
        anytrue := anytrue or vec[i];
        if vec[i] then
          numtrue := numtrue + 1;
        else
        end if;
      end for;
    end anyTrue;

    block enablingInCon  "enabling process of input transitions (continuous places)" 
      parameter input Integer nIn "number of input transitions";
      input Real[nIn] arcWeight "arc weights of input transitions";
      input Real t "current marking";
      input Real maxMarks "maximum capacity";
      input Boolean[nIn] TAein "active input transitions which are already enabled by their input places";
      input Integer enablingType "resolution of actual conflicts";
      input Real[nIn] enablingProb "enabling probabilites of input transitions";
      input Boolean[nIn] disTransition "discrete transition?";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean[nIn] active "Are the input transitions active?";
      parameter input Integer localSeed "Local seed to initialize random number generator";
      parameter input Integer globalSeed "Global seed to initialize random number generator";
      output Boolean[nIn] TEin_ "enabled input transitions";
    protected
      discrete Integer[4] state128 "state of random number generator";
      Boolean[nIn] TEin "enabled input transitions";
      Boolean[nIn] disTAin(each start = false, each fixed = true) "discret active input transitions";
      Integer[nIn] remTAin(each start = 0, each fixed = true) "remaining active input transitions";
      discrete Real[nIn] cumEnablingProb(each start = 0, each fixed = true) "cumulated, scaled enabling probabilities";
      discrete Real arcWeightSum "arc weight sum";
      Integer nremTAin "number of remaining active input transitions";
      Integer nTAin "number ofactive input transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      discrete Real randNum "uniform distributed random number";
      discrete Real sumEnablingProbTAin "sum of the enabling probabilities of the active input transitions";
      Boolean endWhile;
    initial algorithm
      state128 := Modelica.Math.Random.Generators.Xorshift128plus.initialState(localSeed, globalSeed);
      (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(state128);
    algorithm
      TEin := fill(false, nIn);
      when delayPassed then
        if nIn > 0 then
          disTAin := Functions.OddsAndEnds.boolAnd(TAein, disTransition);
          arcWeightSum := Functions.OddsAndEnds.conditionalSum(arcWeight, disTAin);
          if t + arcWeightSum - maxMarks <= Constants.almost_eps or Functions.OddsAndEnds.isEqual(arcWeightSum, 0.0) then
            TEin := TAein;
          else
            TEin := Functions.OddsAndEnds.boolAnd(TAein, not disTransition);
            if enablingType == 1 then
              arcWeightSum := 0;
              for i in 1:nIn loop
                if disTAin[i] and (t + arcWeightSum + arcWeight[i] <= maxMarks or Functions.OddsAndEnds.isEqual(arcWeight[i], 0.0)) then
                  TEin[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                else
                end if;
              end for;
            else
              arcWeightSum := 0;
              remTAin := zeros(nIn);
              nremTAin := 0;
              for i in 1:nIn loop
                if disTAin[i] then
                  nremTAin := nremTAin + 1;
                  remTAin[nremTAin] := i;
                else
                end if;
              end for;
              nTAin := nremTAin;
              sumEnablingProbTAin := sum(enablingProb[remTAin[1:nremTAin]]);
              cumEnablingProb := zeros(nIn);
              cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
              for j in 2:nremTAin loop
                cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
              end for;
              for i in 1:nTAin loop
                (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(pre(state128)) "uniform distributed random number";
                endWhile := false;
                k := 1;
                while k <= nremTAin and not endWhile loop
                  if randNum <= cumEnablingProb[k] then
                    posTE := remTAin[k];
                    endWhile := true;
                  else
                    k := k + 1;
                  end if;
                end while;
                if t + arcWeightSum + arcWeight[posTE] - maxMarks <= Constants.almost_eps or Functions.OddsAndEnds.isEqual(arcWeight[i], 0.0) then
                  arcWeightSum := arcWeightSum + arcWeight[posTE];
                  TEin[posTE] := true;
                else
                end if;
                nremTAin := nremTAin - 1;
                if nremTAin > 0 then
                  remTAin := Functions.OddsAndEnds.deleteElementInt(remTAin, k);
                  cumEnablingProb := zeros(nIn);
                  sumEnablingProbTAin := sum(enablingProb[remTAin[1:nremTAin]]);
                  if sumEnablingProbTAin > 0 then
                    cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
                    for j in 2:nremTAin loop
                      cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
                    end for;
                  else
                    cumEnablingProb[1:nremTAin] := fill(1 / nremTAin, nremTAin);
                  end if;
                else
                end if;
              end for;
            end if;
          end if;
        else
          disTAin := fill(false, nIn);
          remTAin := fill(0, nIn);
          cumEnablingProb := fill(0.0, nIn);
          arcWeightSum := 0.0;
          nremTAin := 0;
          nTAin := 0;
          k := 0;
          posTE := 0;
          randNum := 0.0;
          state128 := pre(state128);
          sumEnablingProbTAin := 0.0;
          endWhile := false;
        end if;
      end when;
      for i in 1:nIn loop
        TEin_[i] := TEin[i] and active[i];
      end for;
    end enablingInCon;

    block enablingOutCon  "enabling process of output transitions (continuous places)" 
      parameter input Integer nOut "number of output transitions";
      input Real[:] arcWeight "arc weights of output transitions";
      input Real t "current marks";
      input Real minMarks "minimum capacity";
      input Boolean[:] TAout "active output transitions with passed delay";
      input Integer enablingType "resolution of actual conflicts";
      input Real[:] enablingProb "enabling probabilites of output transitions";
      input Boolean[:] disTransition "discrete transition?";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      parameter input Integer localSeed "Local seed to initialize random number generator";
      parameter input Integer globalSeed "Global seed to initialize random number generator";
      output Boolean[nOut] TEout_ "enabled output transitions";
    protected
      discrete Integer[4] state128 "state of random number generator";
      Boolean[nOut] TEout "enabled output transitions";
      Boolean[nOut] disTAout(each start = false, each fixed = true) "discret active output transitions";
      Integer[nOut] remTAout(each start = 0, each fixed = true) "remaining active output transitions";
      discrete Real[nOut] cumEnablingProb(each start = 0, each fixed = true) "cumulated, scaled enabling probabilities";
      discrete Real arcWeightSum "arc weight sum";
      Integer nremTAout "number of remaining active output transitions";
      Integer nTAout "number of active output transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      discrete Real randNum "uniform distributed random number";
      discrete Real sumEnablingProbTAout "sum of the enabling probabilities of the active output transitions";
      Boolean endWhile;
    initial algorithm
      state128 := Modelica.Math.Random.Generators.Xorshift128plus.initialState(localSeed, globalSeed);
      (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(state128);
    algorithm
      TEout := fill(false, nOut);
      when delayPassed then
        if nOut > 0 then
          disTAout := Functions.OddsAndEnds.boolAnd(TAout, disTransition);
          arcWeightSum := Functions.OddsAndEnds.conditionalSum(arcWeight, disTAout);
          if t - arcWeightSum - minMarks >= (-Constants.almost_eps) or Functions.OddsAndEnds.isEqual(arcWeightSum, 0.0) then
            TEout := TAout;
          else
            TEout := Functions.OddsAndEnds.boolAnd(TAout, not disTransition);
            if enablingType == 1 then
              arcWeightSum := 0;
              for i in 1:nOut loop
                if disTAout[i] and (t - (arcWeightSum + arcWeight[i]) >= minMarks or Functions.OddsAndEnds.isEqual(arcWeight[i], 0.0)) then
                  TEout[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                else
                end if;
              end for;
            else
              arcWeightSum := 0;
              remTAout := zeros(nOut);
              nremTAout := 0;
              for i in 1:nOut loop
                if disTAout[i] then
                  nremTAout := nremTAout + 1;
                  remTAout[nremTAout] := i;
                else
                end if;
              end for;
              nTAout := nremTAout;
              sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
              cumEnablingProb := zeros(nOut);
              cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
              for j in 2:nremTAout loop
                cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
              end for;
              for i in 1:nTAout loop
                (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(pre(state128)) "uniform distributed random number";
                endWhile := false;
                k := 1;
                while k <= nremTAout and not endWhile loop
                  if randNum <= cumEnablingProb[k] then
                    posTE := remTAout[k];
                    endWhile := true;
                  else
                    k := k + 1;
                  end if;
                end while;
                if t - (arcWeightSum + arcWeight[posTE]) - minMarks >= (-Constants.almost_eps) or Functions.OddsAndEnds.isEqual(arcWeight[i], 0.0) then
                  arcWeightSum := arcWeightSum + arcWeight[posTE];
                  TEout[posTE] := true;
                else
                end if;
                nremTAout := nremTAout - 1;
                if nremTAout > 0 then
                  remTAout := Functions.OddsAndEnds.deleteElementInt(remTAout, k);
                  cumEnablingProb := zeros(nOut);
                  sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
                  if sumEnablingProbTAout > 0 then
                    cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
                    for j in 2:nremTAout loop
                      cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
                    end for;
                  else
                    cumEnablingProb[1:nremTAout] := fill(1 / nremTAout, nremTAout);
                  end if;
                else
                end if;
              end for;
            end if;
          end if;
        else
          disTAout := fill(false, nOut);
          remTAout := fill(0, nOut);
          cumEnablingProb := fill(0.0, nOut);
          arcWeightSum := 0.0;
          nremTAout := 0;
          nTAout := 0;
          k := 0;
          posTE := 0;
          randNum := 0.0;
          state128 := pre(state128);
          sumEnablingProbTAout := 0.0;
          endWhile := false;
        end if;
      end when;
      for i in 1:nOut loop
        TEout_[i] := TEout[i] and TAout[i];
      end for;
    end enablingOutCon;

    block firingSumCon  "calculates the firing sum of continuous places" 
      input Boolean[:] fire "firability of transitions";
      input Real[:] arcWeight "arc weights";
      input Real[:] instSpeed "istantaneous speed of transitions";
      input Boolean[:] disTransition "types of transitions";
      output Real conFiringSum "continuous firing sum";
      output Real disFiringSum "discrete firing sum";
    protected
      Real[size(fire, 1)] vec1;
      Real[size(fire, 1)] vec2;
    equation
      for i in 1:size(fire, 1) loop
        if fire[i] and not disTransition[i] then
          vec1[i] = arcWeight[i] * instSpeed[i];
        else
          vec1[i] = 0;
        end if;
        if fire[i] and disTransition[i] then
          vec2[i] = arcWeight[i];
        else
          vec2[i] = 0;
        end if;
      end for;
      conFiringSum = sum(vec1);
      disFiringSum = sum(vec2);
    end firingSumCon;

    block tokenFlowCon  "Calculates the token flow for a continuous place." 
      parameter input Integer nIn "number of input transitions";
      parameter input Integer nOut "number of output transitions";
      input Real conFiringSumIn;
      input Real conFiringSumOut;
      input Boolean[nIn] fireIn;
      input Boolean[nOut] fireOut;
      input Real[nIn] arcWeightIn;
      input Real[nOut] arcWeightOut;
      input Real[nIn] instSpeedIn;
      input Real[nOut] instSpeedOut;
      output Real inflowSum;
      output Real[nIn] inflow;
      output Real outflowSum;
      output Real[nOut] outflow;
    equation
      der(inflowSum) = conFiringSumIn;
      for i in 1:nIn loop
        der(inflow[i]) = if pre(fireIn[i]) then arcWeightIn[i] * instSpeedIn[i] else 0.0;
      end for;
      der(outflowSum) = conFiringSumOut;
      for i in 1:nOut loop
        der(outflow[i]) = if pre(fireOut[i]) then arcWeightOut[i] * instSpeedOut[i] else 0.0;
      end for;
    end tokenFlowCon;
  end Blocks;

  package Functions  "contains functions with specific algorithmic procedures which are used in the Petri net component models" 
    package Random  "random functions" 
      impure function counter  "Impure function which counts its calls." 
        output Integer value;
        external "C" value = _counter() annotation(Include = "int _counter()
                                                       {
                                                         static int counter=0;
                                                         return ++counter;
                                                       }");
      end counter;
    end Random;

    package OddsAndEnds  "help functions" 
      function allTrue  "Are all entries of a boolean vector true?" 
        input Boolean[:] vec;
        output Boolean alltrue;
      algorithm
        alltrue := true;
        for i in 1:size(vec, 1) loop
          alltrue := alltrue and vec[i];
        end for;
      end allTrue;

      function boolAnd  "hack for Dymola 2017" 
        input Boolean[:] a;
        input Boolean[:] b;
        output Boolean[size(a, 1)] result;
      algorithm
        for i in 1:size(a, 1) loop
          result[i] := a[i] and b[i];
        end for;
        annotation(Inline = true); 
      end boolAnd;

      function boolOr  "hack for Dymola 2017" 
        input Boolean[:] a;
        input Boolean[:] b;
        output Boolean[size(a, 1)] result;
      algorithm
        for i in 1:size(a, 1) loop
          result[i] := a[i] or b[i];
        end for;
        annotation(Inline = true); 
      end boolOr;

      function conditionalSum  "calculates the conditional sum of real vector entries" 
        input Real[:] vec;
        input Boolean[:] con;
        output Real conSum;
      algorithm
        conSum := 0;
        for i in 1:size(vec, 1) loop
          if con[i] then
            conSum := conSum + vec[i];
          else
          end if;
        end for;
      end conditionalSum;

      function deleteElementInt  "deletes an element of an integer vector" 
        input Integer[:] vecin;
        input Integer idx;
        output Integer[size(vecin, 1)] vecout;
      protected
        parameter Integer nVec = size(vecin, 1);
      algorithm
        assert(idx >= 1 and idx <= nVec, "PNlib.Functions.OddsAndEnds.deleteElementInt: index out of range");
        if nVec == idx then
          vecout[1:idx - 1] := vecin[1:idx - 1];
          vecout[nVec] := 0;
        elseif idx == 1 then
          vecout[idx:nVec - 1] := vecin[idx + 1:nVec];
          vecout[nVec] := 0;
        else
          vecout[1:idx - 1] := vecin[1:idx - 1];
          vecout[idx:nVec - 1] := vecin[idx + 1:nVec];
          vecout[nVec] := 0;
        end if;
      end deleteElementInt;

      function isEqual  "Determine if two Real scalars are numerically identical" 
        extends Modelica.Icons.Function;
        input Real s1 "First scalar";
        input Real s2 "Second scalar";
        input Real eps(min = 0) = 1e-8 "The two scalars are identical if abs(s1-s2) <= eps";
        output Boolean result "= true, if scalars are identical";
      algorithm
        result := abs(s1 - s2) <= eps;
        annotation(Inline = true); 
      end isEqual;

      function numTrue  
        input Boolean[:] vec;
        output Integer numTrue;
      algorithm
        numTrue := 0;
        for i in 1:size(vec, 1) loop
          if vec[i] then
            numTrue := numTrue + 1;
          else
          end if;
        end for;
      end numTrue;
    end OddsAndEnds;

    function decreasingFactor  "calculation of decreasing factors" 
      parameter input Integer nIn "number of input transitions";
      parameter input Integer nOut "number of output transitions";
      input Real t "marking";
      input Real minMarks "minimum capacity";
      input Real maxMarks "maximum capacity";
      input Real speedIn "input speed";
      input Real speedOut "output speed";
      input Real[:] maxSpeedIn "maximum speeds of input transitions";
      input Real[:] maxSpeedOut "maximum speeds of output transitions";
      input Real[:] prelimSpeedIn "preliminary speeds of input transitions";
      input Real[:] prelimSpeedOut "preliminary speeds of output transitions";
      input Real[:] arcWeightIn "arc weights of input transitions";
      input Real[:] arcWeightOut "arc weights of output transitions";
      input Boolean[:] firingIn "firability of input transitions";
      input Boolean[:] firingOut "firability of output transitions";
      output Real[nIn] decFactorIn "decreasing factors for input transitions";
      output Real[nOut] decFactorOut "decreasing factors for output transitions";
    protected
      Real maxSpeedSumIn;
      Real maxSpeedSumOut;
      Real prelimSpeedSumIn;
      Real prelimSpeedSumOut;
      Real prelimDecFactorIn;
      Real prelimDecFactorOut;
      Real modSpeedIn;
      Real modSpeedOut;
      Real minMarksMod;
      Integer numFireOut;
      Integer numFireIn;
      Boolean stop;
      Real[nIn] prelimSpeedIn_;
      Real[nOut] prelimSpeedOut_;
    algorithm
      decFactorIn := fill(-1, nIn);
      decFactorOut := fill(-1, nOut);
      modSpeedIn := speedIn;
      modSpeedOut := speedOut;
      numFireOut := Functions.OddsAndEnds.numTrue(firingOut);
      numFireIn := Functions.OddsAndEnds.numTrue(firingIn);
      stop := false;
      maxSpeedSumIn := 0;
      maxSpeedSumOut := 0;
      prelimSpeedSumIn := 0;
      prelimSpeedSumOut := 0;
      prelimDecFactorIn := 0;
      prelimDecFactorOut := 0;
      minMarksMod := minMarks;
      for i in 1:nIn loop
        prelimSpeedIn_[i] := max(prelimSpeedIn[i], 0.0);
      end for;
      for i in 1:nOut loop
        prelimSpeedOut_[i] := max(prelimSpeedOut[i], 0.0);
      end for;
      if numFireOut > 0 and numFireIn > 1 then
        prelimSpeedSumIn := Functions.OddsAndEnds.conditionalSum(arcWeightIn .* prelimSpeedIn_, firingIn);
        maxSpeedSumIn := Functions.OddsAndEnds.conditionalSum(arcWeightIn .* maxSpeedIn, firingIn);
        if maxSpeedSumIn > 0 then
          if not t < maxMarks and speedOut < prelimSpeedSumIn then
            prelimDecFactorIn := speedOut / maxSpeedSumIn;
            while not stop loop
              stop := true;
              for i in 1:nIn loop
                if firingIn[i] and prelimDecFactorIn * maxSpeedIn[i] > prelimSpeedIn_[i] and decFactorIn[i] < 0 and prelimDecFactorIn < 1 then
                  decFactorIn[i] := prelimSpeedIn_[i] / maxSpeedIn[i];
                  modSpeedOut := modSpeedOut - arcWeightIn[i] * prelimSpeedIn_[i];
                  maxSpeedSumIn := maxSpeedSumIn - arcWeightIn[i] * maxSpeedIn[i];
                  stop := false;
                else
                end if;
              end for;
              if maxSpeedSumIn > 0 then
                prelimDecFactorIn := modSpeedOut / maxSpeedSumIn;
              else
                prelimDecFactorIn := 1;
              end if;
            end while;
            for i in 1:nIn loop
              if decFactorIn[i] < 0 then
                decFactorIn[i] := prelimDecFactorIn;
              else
              end if;
            end for;
          else
            decFactorIn := fill(1, nIn);
          end if;
        else
          decFactorIn := fill(1, nIn);
        end if;
      else
        decFactorIn := fill(1, nIn);
      end if;
      stop := false;
      if numFireOut > 1 and numFireIn > 0 then
        prelimSpeedSumOut := Functions.OddsAndEnds.conditionalSum(arcWeightOut .* prelimSpeedOut_, firingOut);
        maxSpeedSumOut := Functions.OddsAndEnds.conditionalSum(arcWeightOut .* maxSpeedOut, firingOut);
        if maxSpeedSumOut > 0 then
          if not t > minMarks and speedIn < prelimSpeedSumOut then
            prelimDecFactorOut := speedIn / maxSpeedSumOut;
            while not stop loop
              stop := true;
              for i in 1:nOut loop
                if firingOut[i] and prelimDecFactorOut * maxSpeedOut[i] > prelimSpeedOut_[i] and decFactorOut[i] < 0 and prelimDecFactorOut < 1 then
                  decFactorOut[i] := prelimSpeedOut_[i] / maxSpeedOut[i];
                  modSpeedIn := modSpeedIn - arcWeightOut[i] * prelimSpeedOut_[i];
                  maxSpeedSumOut := maxSpeedSumOut - arcWeightOut[i] * maxSpeedOut[i];
                  stop := false;
                else
                end if;
              end for;
              if maxSpeedSumOut > 0 then
                prelimDecFactorOut := modSpeedIn / maxSpeedSumOut;
              else
                prelimDecFactorIn := 1;
              end if;
            end while;
            for i in 1:nOut loop
              if decFactorOut[i] < 0 then
                decFactorOut[i] := prelimDecFactorOut;
              else
              end if;
            end for;
          else
            decFactorOut := fill(1, nOut);
          end if;
        else
          decFactorOut := fill(1, nOut);
        end if;
      else
        decFactorOut := fill(1, nOut);
      end if;
    end decreasingFactor;

    function preliminarySpeed  "calculates the preliminary speed of a continuous transition" 
      parameter input Integer nIn "number of input places";
      parameter input Integer nOut "number of output places";
      input Real[:] arcWeightIn "input arc weights";
      input Real[:] arcWeightOut "output arc weights";
      input Real[:] speedSumIn "input speed";
      input Real[:] speedSumOut "output speed";
      input Real maximumSpeed "maximum speed";
      input Boolean[:] weaklyInputActiveVec "places that causes weakly input activation";
      input Boolean[:] weaklyOutputActiveVec "places that causes weakly output activation";
      output Real prelimSpeed "preliminary speed";
    protected
      Real speedSum;
      Real arcWeight;
    algorithm
      prelimSpeed := max(maximumSpeed, 0.0);
      for i in 1:nIn loop
        speedSum := max(speedSumIn[i], 0.0);
        arcWeight := max(arcWeightIn[i], 0.0);
        if weaklyInputActiveVec[i] and speedSum < prelimSpeed * arcWeight then
          prelimSpeed := speedSum / arcWeight;
        else
        end if;
      end for;
      for i in 1:nOut loop
        speedSum := max(speedSumOut[i], 0.0);
        arcWeight := max(arcWeightOut[i], 0.0);
        if weaklyOutputActiveVec[i] and speedSum < prelimSpeed * arcWeight then
          prelimSpeed := speedSum / arcWeight;
        else
        end if;
      end for;
    end preliminarySpeed;
  end Functions;

  package Constants  "contains constants which are used in the Petri net component models" 
    constant Real inf = 3.40282e+038 "Biggest Real number such that inf and -inf are representable on the machine";
    constant Real almost_eps = 1.e-9;
  end Constants;

  package Examples  
    extends Modelica.Icons.ExamplesPackage;

    package ConTest  
      extends Modelica.Icons.ExamplesPackage;

      model PCtoTC  
        extends Modelica.Icons.Example;
        inner PNlib.Settings settings;
        PNlib.PC P1(nOut = 1, startMarks = 1);
        PNlib.TC T1(nIn = 1);
      equation
        connect(P1.outTransition[1], T1.inPlaces[1]);
        annotation(experiment(StartTime = 0.0, StopTime = 20.0)); 
      end PCtoTC;
    end ConTest;
  end Examples;
  annotation(version = "1.4"); 
end PNlib;

model PCtoTC_total
  extends PNlib.Examples.ConTest.PCtoTC;
 annotation(experiment(StartTime = 0.0, StopTime = 20.0));
end PCtoTC_total;
