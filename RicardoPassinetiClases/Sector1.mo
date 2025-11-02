model Sector1
  parameter Real A  = 2   "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral (0<a1<1)";

  Real N1 "Empleo en sector 1 (definido por la macro)";
  Real Y1 "Output bien 1";
  Real R  "Renta del sector 1";
  Real p1 "Precio bien 1";
  Real MPL "Producto marginal del trabajo";

equation
  Y1  = A * N1^a1;
  MPL = a1 * A * N1^(a1 - 1);
  p1  = 1 / MPL;
  R   = Y1 * (1 - a1);
  
  annotation(__Dymola_keepModel=true);

end Sector1;
