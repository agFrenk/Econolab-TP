model Economia
  // ===== Parámetros =====
  parameter Real A = 2 "Productividad sector 1";
  parameter Real a1 = 0.7 "Elasticidad laboral sector 1 (0<a1<1)";
  parameter Real a2 = 0.5 "Coef. laboral sector 2 (N2 = Y2 / a2)";
  parameter Real gamma = 5 "Velocidad de ajuste poblacional";
  parameter Real beta = 1 "Sensibilidad inversión a beneficios reales";
  parameter Real wS = 0.5 "Salario natural/subsistencia";
  
  // ===== Condiciones iniciales =====
  parameter Real K0 = 1;
  parameter Real N0 = 2;

  // ===== Estados =====
  Real K(start = K0) "Capital";
  Real N(start = N0) "Población/empleo total";

  // ===== Salario y beneficios =====
  Real w "Salario real (w = K/N)";
  Real P "Beneficios nominales (en oro)";
  Real P_real "Beneficios reales (en unidades del bien 1)";
  
  
  // ---- Componentes ----
  Sector1 s1(A=A, a1=a1);
  Sector2 s2(a2=a2);

equation
  // Conexión entre sectores
  s2.R  = s1.R;
  s2.p1 = s1.p1;

  // Reparto de empleo
  s1.N1 = N - s2.N2;

  // Cuentas agregadas
  w = K / N;
  P = s1.p1*s1.Y1 + s2.p2*s2.Y2 - s1.p1*s1.R - s1.p1*K;
  P_real = P / s1.p1;

  // Dinámicas
  der(K) = beta  * P_real;
  der(N) = gamma * (w - wS);

  annotation(
    experiment(StartTime=0, StopTime=100, Tolerance=1e-6, Interval=0.2));
end Economia;
