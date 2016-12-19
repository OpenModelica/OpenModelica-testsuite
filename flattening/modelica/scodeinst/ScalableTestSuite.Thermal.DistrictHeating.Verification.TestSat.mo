package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), Polygon(points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(graphics = {Line(points = {{0, 80}, {-8, 80}}, color = {95, 95, 95}), Line(points = {{0, -80}, {-8, -80}}, color = {95, 95, 95}), Line(points = {{0, -90}, {0, 84}}, color = {95, 95, 95}), Text(extent = {{5, 104}, {25, 84}}, lineColor = {95, 95, 95}, textString = "y"), Polygon(points = {{0, 98}, {-6, 82}, {6, 82}, {0, 98}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
      <p>
      Icon for a mathematical function, consisting of an y-axis in the middle.
      It is expected, that an x-axis is added and a plot of the function.
      </p>
      </html>")); end AxisCenter;
    end Icons;

    function tanh  "Hyperbolic tangent" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = tanh(u) annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-47.8, -78.7}, {-35.8, -75.7}, {-27.7, -70.6}, {-22.1, -64.2}, {-17.3, -55.9}, {-12.5, -44.3}, {-7.64, -29.2}, {-1.21, -4.82}, {6.83, 26.3}, {11.7, 42}, {16.5, 54.2}, {21.3, 63.1}, {26.9, 69.9}, {34.2, 75}, {45.4, 78.4}, {72, 79.9}, {80, 80}}), Text(extent = {{-88, 72}, {-16, 24}}, lineColor = {192, 192, 192}, textString = "tanh")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {84, 0}}, color = {95, 95, 95}), Polygon(points = {{96, 0}, {80, 6}, {80, -6}, {96, 0}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80.5}, {-47.8, -79.2}, {-35.8, -76.2}, {-27.7, -71.1}, {-22.1, -64.7}, {-17.3, -56.4}, {-12.5, -44.8}, {-7.64, -29.7}, {-1.21, -5.32}, {6.83, 25.8}, {11.7, 41.5}, {16.5, 53.7}, {21.3, 62.6}, {26.9, 69.4}, {34.2, 74.5}, {45.4, 77.9}, {72, 79.4}, {80, 79.5}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-29, 72}, {-9, 88}}, textString = "1", lineColor = {0, 0, 255}), Text(extent = {{3, -72}, {23, -88}}, textString = "-1", lineColor = {0, 0, 255}), Text(extent = {{82, -2}, {102, -22}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {88, 80}}, color = {175, 175, 175})}), Documentation(info = "<html>
    <p>
    This function returns y = tanh(u), with -&infin; &lt; u &lt; &infin;:
    </p>

    <p>
    <img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
    </p>
    </html>"));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-47.8, -78.7}, {-35.8, -75.7}, {-27.7, -70.6}, {-22.1, -64.2}, {-17.3, -55.9}, {-12.5, -44.3}, {-7.64, -29.2}, {-1.21, -4.82}, {6.83, 26.3}, {11.7, 42}, {16.5, 54.2}, {21.3, 63.1}, {26.9, 69.9}, {34.2, 75}, {45.4, 78.4}, {72, 79.9}, {80, 80}}), Text(extent = {{-88, 72}, {-16, 24}}, lineColor = {192, 192, 192}, textString = "tanh")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {84, 0}}, color = {95, 95, 95}), Polygon(points = {{96, 0}, {80, 6}, {80, -6}, {96, 0}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80.5}, {-47.8, -79.2}, {-35.8, -76.2}, {-27.7, -71.1}, {-22.1, -64.7}, {-17.3, -56.4}, {-12.5, -44.8}, {-7.64, -29.7}, {-1.21, -5.32}, {6.83, 25.8}, {11.7, 41.5}, {16.5, 53.7}, {21.3, 62.6}, {26.9, 69.4}, {34.2, 74.5}, {45.4, 77.9}, {72, 79.4}, {80, 79.5}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-29, 72}, {-9, 88}}, textString = "1", lineColor = {0, 0, 255}), Text(extent = {{3, -72}, {23, -88}}, textString = "-1", lineColor = {0, 0, 255}), Text(extent = {{82, -2}, {102, -22}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {88, 80}}, color = {175, 175, 175})}), Documentation(info = "<html>
    <p>
    This function returns y = tanh(u), with -&infin; &lt; u &lt; &infin;:
    </p>

    <p>
    <img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
    </p>
    </html>")); 
    end tanh;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, {-55.1, 66.4}, {-49.4, 74.6}, {-43.8, 79.1}, {-38.2, 79.8}, {-32.6, 76.6}, {-26.9, 69.7}, {-21.3, 59.4}, {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, -50.2}, {23.7, -64.2}, {29.3, -73.1}, {35, -78.4}, {40.6, -80}, {46.2, -77.6}, {51.9, -71.5}, {57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}, color = {0, 0, 0}, smooth = Smooth.Bezier)}), Documentation(info = "<html>
  <p>
  This package contains <b>basic mathematical functions</b> (such as sin(..)),
  as well as functions operating on
  <a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
  <a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
  <a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
  <a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
  </p>

  <dl>
  <dt><b>Main Authors:</b></dt>
  <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
      Marcus Baur<br>
      Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
      Institut f&uuml;r Robotik und Mechatronik<br>
      Postfach 1116<br>
      D-82230 Wessling<br>
      Germany<br>
      email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
  </dl>

  <p>
  Copyright &copy; 1998-2016, Modelica Association and DLR.
  </p>
  <p>
  <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
  </p>
  </html>", revisions = "<html>
  <ul>
  <li><i>October 21, 2002</i>
         by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
         and Christian Schweiger:<br>
         Function tempInterpol2 added.</li>
  <li><i>Oct. 24, 1999</i>
         by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
         Icons for icon and diagram level introduced.</li>
  <li><i>June 30, 1999</i>
         by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
         Realized.</li>
  </ul>

  </html>")); 
  end Math;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0)}), Documentation(info = "<html>
    <p>Standard package icon.</p>
    </html>")); end Package;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})})); 
    end IconsPackage;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})}), Documentation(info = "<html>
  <p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>

  <h4>Main Authors:</h4>

  <dl>
  <dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
      <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
      <dd>Oberpfaffenhofen</dd>
      <dd>Postfach 1116</dd>
      <dd>D-82230 Wessling</dd>
      <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
  <dt>Christian Kral</dt>

      <dd>  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  </dd>
      <dd>1060 Vienna, Austria</dd>
      <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
  <dt>Johan Andreasson</dt>
      <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
      <dd>Ideon Science Park</dd>
      <dd>22370 Lund, Sweden</dd>
      <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
  </dl>

  <p>Copyright &copy; 1998-2016, Modelica Association, DLR, AIT, and Modelon AB. </p>
  <p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
  </html>")); 
  end Icons;
  annotation(preferredView = "info", version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z", revisionId = "$Id::                                       $", uses(Complex(version = "3.2.2"), ModelicaServices(version = "3.2.2")), conversion(noneFromVersion = "3.2.1", noneFromVersion = "3.2", noneFromVersion = "3.1", noneFromVersion = "3.0.1", noneFromVersion = "3.0", from(version = "2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(origin = {-6.9888, 20.048}, fillColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-93.0112, 10.3188}, {-93.0112, 10.3188}, {-73.011, 24.6}, {-63.011, 31.221}, {-51.219, 36.777}, {-39.842, 38.629}, {-31.376, 36.248}, {-25.819, 29.369}, {-24.232, 22.49}, {-23.703, 17.463}, {-15.501, 25.135}, {-6.24, 32.015}, {3.02, 36.777}, {15.191, 39.423}, {27.097, 37.306}, {32.653, 29.633}, {35.035, 20.108}, {43.501, 28.046}, {54.085, 35.19}, {65.991, 39.952}, {77.897, 39.688}, {87.422, 33.338}, {91.126, 21.696}, {90.068, 9.525}, {86.099, -1.058}, {79.749, -10.054}, {71.283, -21.431}, {62.816, -33.337}, {60.964, -32.808}, {70.489, -16.14}, {77.368, -2.381}, {81.072, 10.054}, {79.749, 19.05}, {72.605, 24.342}, {61.758, 23.019}, {49.587, 14.817}, {39.003, 4.763}, {29.214, -6.085}, {21.012, -16.669}, {13.339, -26.458}, {5.401, -36.777}, {-1.213, -46.037}, {-6.24, -53.446}, {-8.092, -52.387}, {-0.684, -40.746}, {5.401, -30.692}, {12.81, -17.198}, {19.424, -3.969}, {23.658, 7.938}, {22.335, 18.785}, {16.514, 23.283}, {8.047, 23.019}, {-1.478, 19.05}, {-11.267, 11.113}, {-19.734, 2.381}, {-29.259, -8.202}, {-38.519, -19.579}, {-48.044, -31.221}, {-56.511, -43.392}, {-64.449, -55.298}, {-72.386, -66.939}, {-77.678, -74.612}, {-79.53, -74.083}, {-71.857, -61.383}, {-62.861, -46.037}, {-52.278, -28.046}, {-44.869, -15.346}, {-38.784, -2.117}, {-35.344, 8.731}, {-36.403, 19.844}, {-42.488, 23.813}, {-52.013, 22.49}, {-60.744, 16.933}, {-68.947, 10.054}, {-76.884, 2.646}, {-93.0112, -12.1707}, {-93.0112, -12.1707}}, smooth = Smooth.Bezier), Ellipse(origin = {40.8208, -37.7602}, fillColor = {161, 0, 4}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-17.8562, -17.8563}, {17.8563, 17.8562}})}), Documentation(info = "<html>
<p>
Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
  provides an overview of the Modelica Standard Library
  inside the <a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
<li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
 summarizes the changes of new versions of this package.</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
  lists the contributors of the Modelica Standard Library.</li>
<li> The <b>Examples</b> packages in the various libraries, demonstrate
  how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li><b>1600</b> models and blocks, and</li>
<li><b>1350</b> functions</li>
</ul>
<p>
that are directly usable (= number of public, non-partial classes). It is fully compliant
to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
and it has been tested with Modelica tools from different vendors.
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2016, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.&nbsp;Haumer, ITI, C.&nbsp;Kral, Modelon,
TU Hamburg-Harburg, Politecnico di Milano, XRG Simulation.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>
<b>Modelica&reg;</b> is a registered trademark of the Modelica Association.
</p>
</html>")); 
end Modelica;

package ScalableTestSuite  "A library of scalable Modelica test models" 
  package Thermal  "Models from the thermal domain" 
    package DistrictHeating  "Simplified models of district heating systems - only continuous time equations" 
      package Models  
        function sat  "Smooth saturation of input x between xmin and xmax" 
          input Real x;
          input Real xmin;
          input Real xmax;
          output Real y;
        algorithm
          y := Modelica.Math.tanh(2 * (x - xmin) / (xmax - xmin) - 1) * (xmax - xmin) / 2 + (xmax + xmin) / 2;
        end sat;
      end Models;

      package Verification  
        model TestSat  "Test of the Models.sat function" 
          Real x = (-20) + time * 40;
          Real y;
        equation
          y = Models.sat(x, -3, 6);
          annotation(experiment(StopTime = 1, Interval = 2e-5)); 
        end TestSat;
      end Verification;
    end DistrictHeating;
  end Thermal;
  annotation(version = "1.8.2", uses(Modelica(version = "3.2.2")), Documentation(info = "<html>
<p>This library contains a collection of Modelica models whose size can be scaled by means of integer parameter(s). This is useful to test the ability of Modelica tools to compile and simulate models of  increasing size efficiently.</p>
<p>The library contains examples with a physical motivation, which are also verified against known analytical solutions wherever possible, as well as elementary models to stress some specific features of the Modelica tools.</p>
<p>In some cases, when feasible, two mathematically equivalent models are provided, one built by raw equations and the other one built using the Modelica Standard Library. This makes it possible to evaluate how efficiently the Modelica tool can handle the overhead of a modular description both in terms of compilation time, which might be higher due to additional processing, and of simulation time, which should be the same.</p>
<p>This work was originally inspired by discussion at the <a href=\"http://www.eoolt.org/2014/index.php\">2014 EOOLT Workshop in Berlin</a>. Version 1.0.0 is the outcome of Kaan Sezginer&apos;s<a href=\"modelica://ScalableTestSuite/Resources/Docs/2015_04_SEZGINER_Thesis.pdf\"> master&apos;s thesis</a> work at Politecnico di Milano, under the supervision of prof. Francesco Casella. It is expected that the library grows and becomes a reference for the community.</p>
<p>The master branch of the library is hosted on <a href=\"https://github.com/casella/ScalableTestSuite\">GitHub</a>. Please contact , please contact<a href=\"mailto:francesco.casella@polimi.it\"> Francesco Casella</a> or directly submit a pull request
if you want to contribute to the library.
<p>Main Authors</p>
<ul>
<li>Kaan Sezginer</li>
<li>Francesco Casella</li>
</ul>
<p>Copyright  &copy; 2015-2016 Politecnico di Milano</p>
<p>All rights reserved.</p>

<p>Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:</p>
<ol>
<li>Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.</li>
<li>Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.</li>
<li>Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.</li>
</ol>
<p>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &quot;AS IS&quot;
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, 50}, {50, -100}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, 0}, {0, -100}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, -40}, {-40, -100}}, lineColor = {0, 0, 0}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, -70}, {-68, -100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)})); 
end ScalableTestSuite;

model TestSat_total  "Test of the Models.sat function"
  extends ScalableTestSuite.Thermal.DistrictHeating.Verification.TestSat;
 annotation(experiment(StopTime = 1, Interval = 2e-5));
end TestSat_total;
