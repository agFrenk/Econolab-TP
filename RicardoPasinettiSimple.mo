model RicardoPasinetti_SimpleAligned
  // ===== Parámetros (caso base del script en R) =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral sector 1 (0<a1<1)";
  parameter Real a2 = 0.5 "Coef. laboral sector 2 (N2 = Y2 / a2)";
  parameter Real gamma = 5 "Velocidad de ajuste poblacional";
  parameter Real beta = 1 "Sensibilidad inversión a beneficios reales";
  parameter Real wS = 0.5 "Salario natural/subsistencia";
  // ===== Condiciones iniciales (como en R) =====
  parameter Real K0 = 1;
  parameter Real N0 = 2;
  // ===== Estados =====
  Real K(start = K0) "Capital";
  Real N(start = N0) "Población/empleo total";
  // ===== Variables de sector y precios =====
  Real N1(start = 1) "Empleo sector 1 (pista de inicio)";
  Real N2(start = 1) "Empleo sector 2 (pista de inicio)";
  Real Y1 "Output sector 1";
  Real Y2 "Output sector 2";
  Real MPL "Producto marginal del trabajo (sector 1)";
  Real R "Renta (del sector 1)";
  Real p1 "Precio bien 1";
  Real p2 "Precio bien 2";
  // ===== Salario y beneficios =====
  Real w "Salario real (w = K/N)";
  Real P "Beneficios nominales (en $)";
  Real P_real "Beneficios reales (en unidades del bien 1)";
equation
// (3) Producción sector 1: Y1 = A * N1^a1
  Y1 = A*N1^a1;
// (5) Producto marginal: MPL = a1 * A * N1^(a1 - 1)
  MPL = a1*A*N1^(a1 - 1);
// (8) Precio 1: p1 = 1 / MPL
  p1 = 1/MPL;
// (6) Renta: R = Y1 * (1 - a1)
  R = Y1*(1 - a1);
// (11) Precio 2: p2 = 1 / a2 (constante)
  p2 = 1/a2;
// (9) Producción sector 2 desde la renta: Y2 = (p1/p2) * R
  Y2 = (p1/p2)*R;
// (10) Empleo sector 2 y (4) empleo sector 1 (partición algebraica)
  N2 = Y2/a2;
  N1 = N - N2;
// (3') Salario real y masa salarial (en $): p1*N*w = p1*K
  w = K/N;
// (13) Beneficios nominales (en $)
  P = p1*Y1 + p2*Y2 - p1*R - p1*K;
// Beneficios reales (unidades del bien 1)
  P_real = P/p1;
// (14) Acumulación de capital (continuo; análogo a K_t = K_{t-1} + beta*P_{t-1}/p1_{t-1})
  der(K) = beta*P_real;
// (8) Dinámica poblacional (continuo)
  der(N) = gamma*(w - wS);
  annotation(
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
end RicardoPasinetti_SimpleAligned;
