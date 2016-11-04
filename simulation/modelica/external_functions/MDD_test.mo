within ;
model MDD_test

Modelica_DeviceDrivers.Blocks.Communication.SerialPortReceive serialReceive(
  Serial_Port="COM3",
  baud=Modelica_DeviceDrivers.Utilities.Types.SerialBaudRate.B9600,
  parity=0,
  startTime=0.1,
  userBufferSize=2,
    sampleTime=2,
    enableExternalTrigger=false)
    annotation (Placement(transformation(extent={{-82,16},{-62,36}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.UnpackUnsignedInteger unpackInt(bitOffset=
       0, width=16)
    annotation (Placement(transformation(extent={{-62,-14},{-42,6}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-30,-14},{-10,6}})));
equation

  connect(serialReceive.pkgOut,unpackInt. pkgIn) annotation (Line(
      points={{-61.2,26},{-52,26},{-52,6.8}}));
  connect(unpackInt.y,integerToReal. u) annotation (Line(
      points={{-41,-4},{-32,-4}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{100,100}}), graphics),
    experiment(
      StopTime=15,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-200,-100},{100,100}})),
    uses(Modelica(version="3.2.1")));
end MDD_test;
