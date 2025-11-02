model Sector2
  parameter Real a2 = 0.5 "Coeficiente laboral (N2 = Y2/a2)";

  Real R  "Renta proveniente del sector 1";
  Real p1 "Precio del bien 1";
  Real Y2 "Output bien 2 (oro)";
  Real N2 "Empleo sector 2";
  Real p2 "Precio bien 2";

equation
  p2 = 1 / a2;
  Y2 = (p1 / p2) * R;
  N2 = Y2 / a2;
  
  
  
  annotation(__Dymola_keepModel=true);

end Sector2;
