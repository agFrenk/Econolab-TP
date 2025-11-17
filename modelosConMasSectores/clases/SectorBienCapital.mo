model SectorBienCapital
  parameter Real A = 1.0 "Productividad sector 3";
  parameter Real a = 0.6 "Elasticidad laboral";

  MercadoBienes  bienCapital;

  Real N;
  Real Y;
  Real P_real "Beneficios reales del sistema (input externo, es la cantidad que sera invertida por los otros sectores)";
  Real p "precio del bien producido";
equation
  // Producción requerida iguala la inversión deseada
  Y = max(0, P_real);

  // Empleo necesario
  N = (Y / A)^(1/a);

  // Precio del bien de capital (inverso del MPL)
  p = 1 / (a * A * N^(a - 1));

end SectorBienCapital;
