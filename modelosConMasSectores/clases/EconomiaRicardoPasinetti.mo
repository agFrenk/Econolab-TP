model EconomiaRicardoPasinetti
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

  // Variables macro
  // ===== Salario y beneficios =====
  Real w "Salario real (w = K/N)";
  Real P "Beneficios nominales (en $)";
  Real P_real "Beneficios reales (en unidades del bien 1)";

  // Componentes
  SectorBienSalario    s1(A=A, a=a1, alpha=alpha1);
  SectorBienLujo     s2(a=a2);
  SectorBienCapital s3(A=A3, a=a3);

  // Conectores
  //MercadoBienes  mercadoB1;

equation
  // === Capital va al sector 1
  s1.K = K;

  // === Conectar sector1 con sector2
  // === S2 lee la renta de S1 mediante este conector, y con esto determina su output
  //connect(s1.bienes, mercadoB1);
  //connect(s2.bienAgro, mercadoB1);
  s2.p1 = s1.p;
  s2.R1 = s1.R;

  // === Población total
  N = s1.N + s2.N + s3.N;

  // === Salario real
  w = K / N;

  // === Beneficios nominales
  //P = mercadoB1.precio * s1.Y
  //  + s2.p * s2.Y
  //  - mercadoB1.precio * mercadoB1.excedente
  //  - mercadoB1.precio * K;

  // === Beneficios nominales
  P = s1.p * s1.Y
    + s2.p * s2.Y
    - s1.p * s1.R
    - s1.p * K;


  //P_real = P / mercadoB1.precio;
  P_real = P / s1.p;

  // === Sector 3 requiere P_real
  s3.P_real = beta * P_real;

  // === Dinámica del capital
  der(K) = s3.Y - delta*K;

  // === Dinámica poblacional
  der(N) = gamma * (w - wS);

annotation(experiment(StartTime=0, StopTime=100));
end EconomiaRicardoPasinetti;
