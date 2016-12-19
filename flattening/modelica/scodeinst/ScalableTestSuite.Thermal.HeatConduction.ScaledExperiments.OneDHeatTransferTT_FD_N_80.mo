package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package ExamplesPackage  "Icon for packages containing runnable examples" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {8.0, 14.0}, lineColor = {78, 138, 73}, fillColor = {78, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-58.0, 46.0}, {42.0, -14.0}, {-58.0, -74.0}, {-58.0, 46.0}})}), Documentation(info = "<html>
    <p>This icon indicates a package that contains executable examples.</p>
    </html>")); 
    end ExamplesPackage;

    partial package Package  "Icon for standard packages"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0)}), Documentation(info = "<html>
    <p>Standard package icon.</p>
    </html>")); end Package;
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

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992" 
    extends Modelica.Icons.Package;
    type Length = Real(final quantity = "Length", final unit = "m");
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
    type Temperature = ThermodynamicTemperature;
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)");
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-66, 78}, {-66, -40}}, color = {64, 64, 64}), Ellipse(extent = {{12, 36}, {68, -38}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-74, 78}, {-66, -40}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Polygon(points = {{-66, -4}, {-66, 6}, {-16, 56}, {-16, 46}, {-66, -4}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Polygon(points = {{-46, 16}, {-40, 22}, {-2, -40}, {-10, -40}, {-46, 16}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Ellipse(extent = {{22, 26}, {58, -28}}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{68, 2}, {68, -46}, {64, -60}, {58, -68}, {48, -72}, {18, -72}, {18, -64}, {46, -64}, {54, -60}, {58, -54}, {60, -46}, {60, -26}, {64, -20}, {68, -6}, {68, 2}}, lineColor = {64, 64, 64}, smooth = Smooth.Bezier, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
  <p>This package provides predefined types, such as <i>Mass</i>,
  <i>Angle</i>, <i>Time</i>, based on the international standard
  on units, e.g.,
  </p>

  <pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                       <b>final</b> unit     = \"rad\",
                       displayUnit    = \"deg\");
  </pre>

  <p>
  Some of the types are derived SI units that are utilized in package Modelica
  (such as ComplexCurrent, which is a complex number where both the real and imaginary
  part have the SI unit Ampere).
  </p>

  <p>
  Furthermore, conversion functions from non SI-units to SI-units and vice versa
  are provided in subpackage
  <a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
  </p>

  <p>
  For an introduction how units are used in the Modelica standard library
  with package SIunits, have a look at:
  <a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
  </p>

  <p>
  Copyright &copy; 1998-2016, Modelica Association and DLR.
  </p>
  <p>
  <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
  </p>
  </html>", revisions = "<html>
  <ul>
  <li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
  <li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
  <li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
  <li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
  <li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
  <li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
  <li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
  <li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
  <li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
  <li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
  <li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br/>Some chapters realized.</li>
  </ul>
  </html>")); 
  end SIunits;
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
    package HeatConduction  "Models of 1-D heat conduction in solids" 
      package Models  
        model OneDHeatTransferTT_FD  "Both ends are exposed to a fixed temperature, implemented by FD method" 
          parameter .Modelica.SIunits.Length L "length";
          parameter Integer N = 2 "number of nodes";
          parameter .Modelica.SIunits.Temperature T0 "Initial temperature";
          parameter .Modelica.SIunits.Temperature T1 "Initial temperature at first node";
          parameter .Modelica.SIunits.Temperature TN "Initial temperature at the last node";
          parameter .Modelica.SIunits.SpecificHeatCapacity cp "Material Heat Capacity";
          parameter .Modelica.SIunits.ThermalConductivity lambda "Material thermal conductivity";
          parameter .Modelica.SIunits.Density rho "Material Density";
          final parameter Modelica.SIunits.Length dx = L / (N - 1) "Element length";
          .Modelica.SIunits.Temperature[N] T "temperature of the nodes";
        initial equation
          for i in 2:N - 1 loop
            T[i] = T0;
          end for;
        equation
          T[1] = T1;
          T[N] = TN;
          for i in 2:N - 1 loop
            der(T[i]) = lambda * ((T[i - 1] - T[i]) / dx + ((-T[i]) + T[i + 1]) / dx) / cp / rho / dx;
          end for;
          annotation(Documentation(info = "<html><p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/uniformrod.png\"/></p>A uniform rod has the length L, density ρ, specific heat capacity cp and thermal conductivity λ which are all assumed to be constant. Moreover, the sides of the rod are assumed to be insulated. In HeatConductionTT, both ends are exposed to a fixed temperature. We considered a small portion of the rod which has a width of dx from a distance x, and by considering the conservation of energy the equations are defined. According to the conservation of energy, difference between the heat in from left boundary and heat out from the right boundary has to be equal to the heat change at the portion at Δx in time Δt.</p><p>The discretized equations are described in the following form:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/HeatConductionEq.png\"/><p>where i = 2,..,N−1 and they correspond to the temperature nodes along the rod excluding the temperature variables at the ends. In HeatConductionTT, T1 and TN have constant temperature values.</p><p>The parameters for HeatConductionTT_FD are:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
            <tr>
              <th>Parameters</th>
              <th>Comment</th>
            </tr>
                        <tr>
              <td valign=\"top\">L</td>
              <td valign=\"top\">Length of the rod</td>
            </tr>
                        <tr>
              <td valign=\"top\">N</td>
              <td valign=\"top\">number of nodes</td>
            </tr>
           <tr>
              <td valign=\"top\">T0</td>
              <td valign=\"top\">Initial temperature</td>
            </tr>
            <tr>
              <td valign=\"top\">T1</td>
              <td valign=\"top\">temperature at the first node</td>
            </tr>
                        <tr>
              <td valign=\"top\">TN</td>
              <td valign=\"top\">temperature at the last node</td>
            </tr>
            <tr>
              <td valign=\"top\">cp</td>
              <td valign=\"top\">material specific heat capacity</td>
            </tr>
                        <tr>
              <td valign=\"top\">lambda</td>
              <td valign=\"top\">material thermal conductivity</td>
            </tr>
                        <tr>
              <td valign=\"top\">rho</td>
              <td valign=\"top\">material density</td>
            </tr>
                        <tr>
              <td valign=\"top\">dx</td>
              <td valign=\"top\">element length</td>
            </tr>
        </table>
        </html>")); 
        end OneDHeatTransferTT_FD;
      end Models;

      package ScaledExperiments  
        extends Modelica.Icons.ExamplesPackage;

        model OneDHeatTransferTT_FD_N_10  
          extends Models.OneDHeatTransferTT_FD(L = 0.2, N = 10, T0 = 273.15, T1 = 330, TN = 300, cp = 910, lambda = 237, rho = 2712);
          annotation(experiment(StopTime = 350, Tolerance = 1e-6)); 
        end OneDHeatTransferTT_FD_N_10;

        model OneDHeatTransferTT_FD_N_80  
          extends OneDHeatTransferTT_FD_N_10(N = 80);
          annotation(experiment(StopTime = 350, Tolerance = 1e-6)); 
        end OneDHeatTransferTT_FD_N_80;
        annotation(Documentation(info = "<html><p>In this package there are 32 tests for different N values; 8 for the OneDHeatTransferTT_FD, 8 for the OneDHeatTransferTT_Modelica, 8 for the OneDHeatTransferTI_FD and 8 for the OneDHeatTransferTI_Modelica.</p><p> The tests for the models are performed according to the N values as shown in the table below:</p><table border=\"1\">
          <tr>
            <th>N</th>
          </tr>
                      <tr>
            <td valign=\"top\">10</td>
          </tr>
         <tr>
            <td valign=\"top\">20</td>
          </tr>
          <tr>
            <td valign=\"top\">40</td>
          </tr>
          <tr>
            <td valign=\"top\">80</td>
          </tr>
                      <tr>
            <td valign=\"top\">160</td>
          </tr>
                      <tr>
            <td valign=\"top\">320</td>
          </tr>
                      <tr>
            <td valign=\"top\">640</td>
          </tr>
                      <tr>
            <td valign=\"top\">1280</td>
          </tr>
      </table><p>Parameter values for OneDHeatTransferTT models:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
          <tr>
            <th>Parameters</th>
            <th>Comment</th>
          </tr>
                      <tr>
            <td valign=\"top\">L</td>
            <td valign=\"top\">0.2</td>
          </tr>
                      <tr>
            <td valign=\"top\">N</td>
            <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
          </tr>
         <tr>
            <td valign=\"top\">T0</td>
            <td valign=\"top\">273.15</td>
          </tr>
          <tr>
            <td valign=\"top\">T1</td>
            <td valign=\"top\">330</td>
          </tr>
          <tr>
            <td valign=\"top\">TN</td>
            <td valign=\"top\">330</td>
          </tr>
                      <tr>
            <td valign=\"top\">cp</td>
            <td valign=\"top\">910</td>
          </tr>
                      <tr>
            <td valign=\"top\">lambda</td>
            <td valign=\"top\">237</td>
          </tr>
                      <tr>
            <td valign=\"top\">rho</td>
            <td valign=\"top\">2712</td>
          </tr>
      </table><p>Parameter values for OneDHeatTransferTI models:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
          <tr>
            <th>Parameters</th>
            <th>Comment</th>
          </tr>
                      <tr>
            <td valign=\"top\">L</td>
            <td valign=\"top\">0.2</td>
          </tr>
                      <tr>
            <td valign=\"top\">N</td>
            <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
          </tr>
         <tr>
            <td valign=\"top\">T0</td>
            <td valign=\"top\">273.15</td>
          </tr>
          <tr>
            <td valign=\"top\">TN</td>
            <td valign=\"top\">330</td>
          </tr>
                      <tr>
            <td valign=\"top\">cp</td>
            <td valign=\"top\">910</td>
          </tr>
                      <tr>
            <td valign=\"top\">lambda</td>
            <td valign=\"top\">237</td>
          </tr>
                      <tr>
            <td valign=\"top\">rho</td>
            <td valign=\"top\">2712</td>
          </tr>
      </table></html>")); 
      end ScaledExperiments;
    end HeatConduction;
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

model OneDHeatTransferTT_FD_N_80_total
  extends ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_FD_N_80;
 annotation(experiment(StopTime = 350, Tolerance = 1e-6));
end OneDHeatTransferTT_FD_N_80_total;
