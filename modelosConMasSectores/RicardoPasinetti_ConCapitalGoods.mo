model RicardoPasinetti_ConCapitalGoods
  // ===== Parámetros sector 1 (agro) =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral respecto al trabajo (exponente N1)";
  parameter Real alpha1 = 0.7 "Elasticidad del capital en el agro (exponente K)";
  parameter Real w1 = 0.2;
  
  // ===== Parámetros sector 2 (oro) =====
  parameter Real a2 = 0.5 "Coef. laboral sector 2 (N2 = Y2 / a2)";
  parameter Real alpha2 = 0.4;
  parameter Real w2 = 0.2;
  
  // ===== Parámetros sector 3 (bienes de capital) =====
  parameter Real A3 = 2.5 "Productividad sector 3 (bienes de capital)";
  parameter Real a3 = 0.6 "Elasticidad laboral sector 3";
  parameter Real beta = 1 "Sensibilidad de la inversión a beneficios reales";
  parameter Real delta = 0.4 "Tasa de depreciación del capital";
  parameter Real alpha3 = 0.9;
  parameter Real w3 = 0.2;

  // ===== Dinámica poblacional =====
  parameter Real gamma = 5 "Velocidad de ajuste poblacional";
  parameter Real wS = 0.1 "Salario natural/subsistencia";

  // ===== Condiciones iniciales =====
  parameter Real K0 = 1;
  parameter Real N0 = 2;

  // ===== Estados =====
  Real K1(start = K0) "Stock de capital";
  Real K2(start = K0) "Stock de capital";
  Real K3(start = K0) "Stock de capital";
  Real K;
  
  Real N "Población/empleo total";

  // ===== Empleo por sector =====
  Real N1(start = 1) "Empleo sector 1 (agro)";
  Real N2(start = 0.5) "Empleo sector 2 (oro)";
  Real N3(start = 0.5) "Empleo sector 3 (bienes de capital)";

  // ===== Outputs =====
  Real Y1 "Output sector 1 (alimentos/agro)";
  Real Y2 "Output sector 2 (oro)";
  Real Y3 "Output sector 3 (bienes de capital)";
  Real Y3_1;
  Real Y3_2;
  Real Y3_3;

  // ===== Producto marginal y precios =====
  Real MPL "Producto marginal del trabajo (sector 1)";
  Real MPL3 "Producto marginal del trabajo (sector 3)";
  Real R "Renta (del sector 1)";
  Real p1 "Precio bien 1 (numéraire)";
  Real p2 "Precio bien 2 (oro)";
  Real p3 "Precio bien 3 (capital)";

  Real I1;
  Real I2;
  Real I3;
  Real I;
  
  Real w;
equation
  // ===== Sector 1: agro con capital =====
  // Tecnología Cobb-Douglas en K y N1
  Y1  = A * K1^alpha1 * N1^a1;
  MPL = a1 * A * K1^alpha1 * N1^(a1 - 1);
  p1  = 1 / MPL;

  // Renta (parte del producto que va a terratenientes)
  R   = Y1 * (1 - a1); // podés refinar esta definición si cambiás la interpretación de a1

  // ===== Sector 2: oro (financiado con la renta) =====
  p2 = 1 / a2;
  // Toda la renta se gasta en oro: p2*Y2 = p1*R
  Y2 = (p1 / p2) * R * K2^alpha2;
  N2 = Y2 / a2;

  // ===== Reparto de trabajo total =====
  N = N1 + N2 + N3;
  // Si querés forzar N1 como residuo, podés usar:
  // N1 = N - N2 - N3;

  // ===== Inversion  =====
  I1 = Y1 - R - N1*w1;
  I2 = Y2 - N2*w2;
  I3 = Y3 - N3*w3;
  
  I = I1 + I2 + I3;

  // ===== Sector 3: bienes de capital =====
  // La inversión agregada en términos reales es beta * P_real.
  // La producción física de bienes de capital Y3 debe igualarla.
  Y3_1 = max(0, beta * I1 * K3 ^ alpha3 * N3^a3 * (p1 / p3));
  Y3_2 = max(0, beta * I2 * K3 ^ alpha3 * N3^a3 * (p1 / p3));
  Y3_3 = max(0, beta * I3 * K3 ^ alpha3 * N3^a3 * (p1 / p3)); 
  Y3 = Y3_1 + Y3_2 + Y3_3;
  
  N3 = (Y3 / A3)^(1 / a3); 
  MPL3 = a3 * A3 * N3^(a3 - 1); 
  p3 = 1 / MPL3;
  
  // ===== Acumulación de capital =====
  // Stock de capital aumenta con Y3 y disminuye con depreciación
  der(K1) = Y3_1 - delta * K1;
  der(K2) = Y3_2 - delta * K2;
  der(K3) = Y3_3 - delta * K3;

  K = K1 + K2 + K3;

  // ===== Dinámica poblacional =====
  w = w1 + w2 + w3;
  der(N) = gamma * (w - wS);

  annotation(
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
end RicardoPasinetti_ConCapitalGoods;
