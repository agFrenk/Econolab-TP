model RicardoPasinetti_ConCapitalGoods
  // ===== Parámetros sector 1 (agro) =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral respecto al trabajo (exponente N1)";
  parameter Real alpha1 = 0.3 "Elasticidad del capital en el agro (exponente K)";

  // ===== Parámetros sector 2 (oro) =====
  parameter Real a2 = 0.5 "Coef. laboral sector 2 (N2 = Y2 / a2)";

  // ===== Parámetros sector 3 (bienes de capital) =====
  parameter Real A3 = 2.5 "Productividad sector 3 (bienes de capital)";
  parameter Real a3 = 0.6 "Elasticidad laboral sector 3";
  parameter Real beta = 1 "Sensibilidad de la inversión a beneficios reales";
  parameter Real delta = 0.4 "Tasa de depreciación del capital";

  // ===== Dinámica poblacional =====
  parameter Real gamma = 5 "Velocidad de ajuste poblacional";
  parameter Real wS = 0.1 "Salario natural/subsistencia";

  // ===== Condiciones iniciales =====
  parameter Real K0 = 1;
  parameter Real N0 = 2;

  // ===== Estados =====
  Real K(start = K0) "Stock de capital";
  Real N(start = N0) "Población/empleo total";

  // ===== Empleo por sector =====
  Real N1(start = 1) "Empleo sector 1 (agro)";
  Real N2(start = 0.5) "Empleo sector 2 (oro)";
  Real N3(start = 0.5) "Empleo sector 3 (bienes de capital)";

  // ===== Outputs =====
  Real Y1 "Output sector 1 (alimentos/agro)";
  Real Y2 "Output sector 2 (oro)";
  Real Y3 "Output sector 3 (bienes de capital)";

  // ===== Producto marginal y precios =====
  Real MPL "Producto marginal del trabajo (sector 1)";
  Real MPL3 "Producto marginal del trabajo (sector 3)";
  Real R "Renta (del sector 1)";
  Real p1 "Precio bien 1 (numéraire)";
  Real p2 "Precio bien 2 (oro)";
  Real p3 "Precio bien 3 (capital)";

  // ===== Salario y beneficios =====
  Real w "Salario real (w = K/N)";
  Real P "Beneficios nominales (en $)";
  Real P_real "Beneficios reales (en unidades del bien 1)";
equation
  // ===== Sector 1: agro con capital =====
  // Tecnología Cobb-Douglas en K y N1
  Y1  = A * K^alpha1 * N1^a1;
  MPL = a1 * A * K^alpha1 * N1^(a1 - 1);
  p1  = 1 / MPL;

  // Renta (parte del producto que va a terratenientes)
  R   = Y1 * (1 - a1); // podés refinar esta definición si cambiás la interpretación de a1

  // ===== Sector 2: oro (financiado con la renta) =====
  p2 = 1 / a2;
  // Toda la renta se gasta en oro: p2*Y2 = p1*R
  Y2 = (p1 / p2) * R;
  N2 = Y2 / a2;

  // ===== Reparto de trabajo total =====
  N = N1 + N2 + N3;
  // Si querés forzar N1 como residuo, podés usar:
  // N1 = N - N2 - N3;

  // ===== Salario real =====
  w = K / N;

  // ===== Beneficios (solo sectores 1 y 2, el sector 3 es pura inversión) =====
  P      = p1*Y1 + p2*Y2 - p1*R - p1*K;
  P_real = P / p1;

  // ===== Sector 3: bienes de capital =====
  // La inversión agregada en términos reales es beta * P_real.
  // La producción física de bienes de capital Y3 debe igualarla.
  Y3 = max(0, beta * P_real); 
  N3 = (Y3 / A3)^(1 / a3); 
  MPL3 = a3 * A3 * N3^(a3 - 1); 
  p3 = 1 / MPL3;
  
  // ===== Acumulación de capital =====
  // Stock de capital aumenta con Y3 y disminuye con depreciación
  der(K) = Y3 - delta * K;

  // ===== Dinámica poblacional =====
  der(N) = gamma * (w - wS);

  annotation(
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
end RicardoPasinetti_ConCapitalGoods;
