model SectorBienSalario
  // Sector agro - bien salario - productividad marginal del trabajo decreciente
  // ===== Parámetros sector 1 (agro) =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a = 0.7 "Elasticidad laboral respecto al trabajo (exponente N1)";
  parameter Real alpha = 0.3 "Elasticidad del capital en el agro (exponente K)";

  // Conector mercado, el sector agro escribe el precio del bien producido y la renta acumulada
  //MercadoBienes  bienes;
  
  Real Y "Output sector 1 (alimentos/agro)";
  Real MPL "Producto marginal del trabajo (sector 1)";
  Real R "Renta (del sector 1)";
  Real p "Precio bien 1";
  
  // === Variables dadas por la macro
  Real N(start = 1) "Empleo del sector";
  Real K "Stock de capital disponible, input viene de la macro";

equation

  Y  = A * K^alpha * N^a;
  MPL = a * A * K^alpha * N^(a - 1);

  // Variables que se escriben al conector
  //bienes.precio    = 1 / MPL;  
  //bienes.excedente = Y * (1 - a);
  p    = 1 / MPL;  
  R = Y * (1 - a);
end SectorBienSalario;
