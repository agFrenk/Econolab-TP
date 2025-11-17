model SectorBienLujo
  // Sector Oro, produccion depende solo de la renta del sector agro (demanda terrateniente)
  // Ejemplifica como la renta de ese sector genera demanda y produccion en otro sector de la economi
  parameter Real a = 0.5 "Coeficiente laboral";
  
  //MercadoBienes  bienAgro; // recibe precio y renta del agro
  Real p1;
  Real R1;
  Real p; //precio del bien producido
  Real N;
  Real Y;

equation
  // Precio oro es fijo
  p = 1 / a;
  // Producción, aumenta con la renta del agro (demanda terrateniente)
  //Y = (bienAgro.precio / p) * bienAgro.excedente;
  Y = (p1 / p) * R1;
  
  N = Y / a;

end SectorBienLujo;
