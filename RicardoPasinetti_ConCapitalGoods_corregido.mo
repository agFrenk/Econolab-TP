model RicardoPasinetti_ConCapitalGoods_corregido
  // Revisar
  // 1. Unidades de precios
  // 2. Y3 = I ?
  // 3. Revisar valores de parametros
  // ===== Parámetros sector 1 (agro) =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral respecto al trabajo (exponente N1)";
  parameter Real alpha1 = 0.2 "Elasticidad del capital en el agro (exponente K)";
  // ===== Parámetros sector 2 (oro) =====
  parameter Real a2 = 0.5 "Coef. laboral sector 2 (N2 = Y2 / a2)";
  // ===== Parámetros sector 3 (bienes de capital) =====
  parameter Real A3 = 1 "Productividad sector 3 (bienes de capital)";
  parameter Real a3 = 0.5 "Elasticidad laboral sector 3";
  parameter Real delta = 0.3 "Tasa de depreciación del capital";
  parameter Real alpha3 = 0.78;
  // ===== Dinámica poblacional =====
  parameter Real gamma = 5 "Velocidad de ajuste poblacional";
  parameter Real wS = 0.5 "Salario natural/subsistencia";
  Real W;
  Real W_p;
  Real w;
  // ===== Estados =====
  Real K(start = 1);
  Real N(start = 20) "Población/empleo total";
  // ===== Empleo por sector =====
  Real N1(start = 1) "Empleo sector 1 (agro)";
  Real N2(start = 1) "Empleo sector 2 (oro)";
  parameter Real N3 = 5 "Empleo sector 3 (bienes de capital)";
  // ===== Outputs =====
  Real Y1 "Output sector 1 (alimentos/agro)";
  Real Y1_p "Output sector 1 (alimentos/agro) en dinero";
  Real Y2 "Output sector 2 (oro)";
  Real Y2_p "Output sector 2 (oro)";
  Real Y3(start = 6) "Output sector 3 (bienes de capital)";
  Real Y3_p "Output sector 3 (bienes de capital)";
  // ===== Producto marginal y precios =====
  Real MPL "Producto marginal del trabajo (sector 1)";
  Real MPL3 "Producto marginal del trabajo (sector 3)";
  Real R "Renta (del sector 1)";
  Real P_real;
  Real P;
  Real p1 "Precio bien 1 (numéraire)";
  Real p2 "Precio bien 2 (oro)";
  Real p3 "Precio bien 3 (capital)";
  // ==== Maquinaria ========================
  Real M1(start = 1);
  Real M3(start = 1);
  Real M;
  Real I1;
  Real I3;
  Real I;
equation
// ===== Sector 1: agro con capital =====
// Tecnología Cobb-Douglas en K y N1
  Y1 = A*M1^alpha1*N1^a1;
  Y1_p = Y1*p1;
  MPL = a1*A*N1^(a1 - 1)*M1^alpha1;
  p1 = 1/MPL;
// Renta (parte del producto que va a terratenientes)
  R = Y1*(1 - a1);

// ===== Sector 2: oro (financiado con la renta) =====
  p2 = 1/a2;
// Toda la renta se gasta en oro: p2*Y2 = p1*R
  Y2 = (p1/p2)*R;
  Y2_p = Y2 * p2;
  N2 = Y2/a2;
  
// ===== Reparto de trabajo total =====
  N = N1 + N2 + N3;
// Si querés forzar N1 como residuo, podés usar:
// N1 = N - N2 - N3;

// ===== Inversion  =====
  I1 = (alpha1/(alpha1 + alpha3))*I;
  I3 = (alpha3/(alpha1 + alpha3))*I;
  I = Y3;
  
// ===== Sector 3: bienes de capital =====
  Y3 = (p1/p3)*A3*(M3^alpha3)*(N3^a3);
  Y3_p = Y3 *p3;
  MPL3 = a3*A3*(N3^(a3 - 1))* M3^alpha3;
  p3 = 1/MPL3;
  der(M1) = I1 - delta*M1;
  der(M3) = I3 - delta*M3;
  M = M1 + M3;
// ===== Acumulación de capital =====
// Stock de capital aumenta con Y3 y disminuye con depreciación
// produccion de los 3 sectores, menos la renta, menos todos los salarios(W)
// a preguntar con martin. va p3*Y3?
  P = Y1_p + Y2_p + Y3_p - p1*R - W_p;
  P_real = P/p1;
  der(K) = P_real;
// ===== Dinámica poblacional =====
  W = (K - I);
  W_p = W * p1;
  w = W/N;
  der(N) = gamma*(w - wS);
  annotation(
    experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 0.2));
end RicardoPasinetti_ConCapitalGoods_corregido;
