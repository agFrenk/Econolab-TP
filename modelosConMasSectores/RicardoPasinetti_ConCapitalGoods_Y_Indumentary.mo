model RicardoPasinetti_ConCapitalGoods_Y_Indumentary
  // ===== Parámetros sector 1 (agro) =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral respecto al trabajo (exponente N1)";
  parameter Real alpha1 = 0.4 "Elasticidad del capital en el agro (exponente K)";

  // ===== Parámetros sector 2 (oro) =====
  parameter Real a2 = 0.5 "Coef. laboral sector 2 (N2 = Y2 / a2)";

  // ===== Parámetros sector 3 (bienes de capital) =====
  parameter Real A3 = 1.6 "Productividad sector 3 (bienes de capital)";
  parameter Real a3 = 0.6 "Elasticidad laboral sector 3";
  parameter Real beta = 1.8 "Sensibilidad de la inversión a beneficios reales";
  parameter Real delta = 0.35 "Tasa de depreciación del capital";
  parameter Real PR = 0.7 "Porcentaje de reinversión de beneficios";

  // ===== Parámetros sector 4 (indumentaria) =====
  parameter Real A4 = 1.5 "Productividad sector 4 (indumentaria)";
  parameter Real a4 = 0.4 "Elasticidad laboral sector 4 (más intensivo en trabajo)";
  parameter Real alpha4 = 0.4 "Elasticidad del capital en indumentaria";
  parameter Real lambdaC = 0.2 "Fracción del ingreso salarial gastada en indumentaria";

  // ===== Dinámica poblacional =====
  parameter Real gamma = 5 "Velocidad de ajuste poblacional";
  parameter Real wS = 0.7 "Salario natural/subsistencia";

  // ===== Condiciones iniciales =====
  parameter Real K0 = 1;
  parameter Real N0 = 2;

  // ===== Estados =====
  Real K(start = K0) "Stock de capital agregado";
  Real N(start = N0) "Población/empleo total";

  // ===== Empleo por sector =====
  Real N1(start = 1) "Empleo sector 1 (agro)";
  Real N2(start = 0.5) "Empleo sector 2 (oro)";
  Real N3(start = 0.5) "Empleo sector 3 (bienes de capital)";
  Real N4(start = 0.2) "Empleo sector 4 (indumentaria)";

  // ===== Outputs =====
  Real Y1 "Output sector 1 (alimentos/agro)";
  Real Y2 "Output sector 2 (oro)";
  Real Y3 "Output sector 3 (bienes de capital)";
  Real Y4 "Output sector 4 (indumentaria)";

  // ===== Producto marginal y precios =====
  Real MPL "Producto marginal del trabajo (sector 1)";
  Real MPL3 "Producto marginal del trabajo (sector 3)";
  Real MPL4 "Producto marginal del trabajo (sector 4)";
  Real R "Renta (del sector 1)";
  Real p1 "Precio bien 1 (numéraire, alimentos)";
  Real p2 "Precio bien 2 (oro)";
  Real p3 "Precio bien 3 (capital)";
  Real p4 "Precio bien 4 (indumentaria)";

  // ===== Salario y beneficios =====
  Real w "Salario real (w = K/N)";
  Real P "Beneficios nominales (en $ del bien 1)";
  Real P_real "Beneficios reales (en unidades del bien 1)";
equation
  // ===== Sector 1: agro con capital =====
  // Tecnología Cobb-Douglas en K y N1
  Y1  = A * K^alpha1 * N1^a1;
  MPL = a1 * A * K^alpha1 * N1^(a1 - 1);
  p1  = 1 / MPL;

  // Renta (parte del producto que va a terratenientes)
  R   = Y1 * (1 - a1);

  // ===== Sector 2: oro (financiado con la renta) =====
  p2 = 1 / a2;
  // Toda la renta se gasta en oro: p2*Y2 = p1*R
  Y2 = (p1 / p2) * R;
  N2 = Y2 / a2;

  // ===== Sector 4: indumentaria (bien de salario, intensivo en trabajo) =====
  // Tecnología Cobb-Douglas en K y N4 (con poco capital: alpha4 < alpha1)
  Y4   = A4 * K^alpha4 * N4^a4;
  MPL4 = a4 * A4 * K^alpha4 * N4^(a4 - 1);
  p4   = 1 / MPL4;

  // Demanda de indumentaria:
  // Los trabajadores gastan una fracción lambdaC de su ingreso en ropa.
  // Ingreso salarial en términos del bien 1: w * N = K (porque w = K/N).
  // Valor gastado en ropa: lambdaC * K.
  // Condición de equilibrio de mercado:
  // p4 * Y4 = lambdaC * K
  // Usando la tecnología, esto implica N4 = a4 * lambdaC * K (derivado analíticamente).
  N4 = a4 * lambdaC * K;

  // ===== Reparto de trabajo total =====
  // El trabajo total se reparte entre los cuatro sectores
  N = N1 + N2 + N3 + N4;

  // ===== Salario real =====
  w = K / N;

  // ===== Beneficios (sectores que generan excedente monetario) =====
  // Incluímos la producción de alimentos y de indumentaria,
  // menos renta y menos "cargo" sobre el capital K.
  P      = (Y1 + Y4 - R - K) * PR;
  P_real = P / p1;

  // ===== Sector 3: bienes de capital =====
  // La inversión agregada en términos reales es beta * P_real.
  // La producción física de bienes de capital Y3 la iguala (si es positiva).
  Y3   = max(0, beta * P_real);
  N3   = (if Y3 > 0 then (Y3 / A3)^(1 / a3) else 0);
  MPL3 = (if N3 > 0 then a3 * A3 * N3^(a3 - 1) else A3) "Evita potencias raras en N3=0";
  p3   = 1 / MPL3;

  // ===== Acumulación de capital =====
  // Stock de capital aumenta con Y3 y disminuye con depreciación
  der(K) = Y3 - delta*K;

  // ===== Dinámica poblacional =====
  der(N) = gamma * (w - wS);

  annotation(
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.2));
end RicardoPasinetti_ConCapitalGoods_Y_Indumentary;
