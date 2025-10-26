# Econolab-TP
# Modelo Ricardiano según Pasinetti (1960)

## Supuestos
- Dos bienes: 
  - Bien-salario (1): maíz  
  - Bien-lujo (2): oro  
- Un solo factor de producción: **trabajo**  
- Capital = salarios adelantados  
- Período de producción = 1 año  
- El oro actúa como **patrón invariable de valor**  
- Todos los beneficios se reinvierten (no hay consumo improductivo de capitalistas)

---

## 1. Producción

**Variables:**
- $ X_1$: cantidad física de maíz producida (bien-salario)  
- $ X_2 $: cantidad física de oro producida (bien-lujo)  
- $ N_1 $: trabajadores empleados en agricultura  
- $ N_2 $: trabajadores empleados en la producción de oro  
- $ N $: trabajadores totales en la economía
- $ f(\cdot) $: **función de producción agrícola**, que describe la relación entre el número de trabajadores empleados y la cantidad de maíz obtenida.  
  - Refleja el uso de **tierra de calidad decreciente**: a medida que se emplean más trabajadores, se incorporan tierras menos fértiles y el producto marginal del trabajo cae.
- $a$ : productividad del trabajo en ese sector, es decir, cuántas unidades de oro produce un trabajador por año.

**Ecuaciones:**

$$
X_1 = f(N_1)
$$

$$
f'(N_1) > 0, \quad f''(N_1) < 0
$$

$$
X_2 = a N_2, \quad a > 0
$$

$$
N = N_1 + N_2
$$

Interpretación:  
- La producción de maíz sigue una función de producción con **rendimientos decrecientes** (por uso de tierra).  
- La producción de oro tiene **productividad constante**.  
- La población total se reparte entre ambos sectores.

---

## 2. Salarios y capital

**Variables:**
- $ W $: masa salarial total (en unidades físicas de maíz)  
- $ x $: salario real por trabajador (en unidades de maíz)  
- $ K $: capital total, equivalente a los salarios adelantados

**Ecuaciones:**

$$
W = N x
$$

$$
K = W
$$

Interpretación:  
Todo el capital se destina al pago de salarios (capital circulante).  
No hay capital fijo ni depreciación.

---

## 3. Renta de la tierra

**Variable:**
- $ R $: renta total (en unidades de maíz)

**Ecuación:**

$$
R = f(N_1) - N_1 f'(N_1)
$$

Interpretación:  
La renta es el **excedente del producto agrícola** sobre el valor del producto marginal (de la tierra menos fértil).  
Proviene de los **rendimientos decrecientes** de la producción agrícola.

---

## 4. Beneficios

**Variables:**
- $ \pi_1 $: beneficio del sector agrícola  
- $ \pi $: beneficio total del sistema (en unidades de oro)  
- $ p_1, p_2 $: precios del maíz y del oro, medidos en oro

**Ecuaciones:**

Beneficio del sector 1:
$$
\pi_1 = X_1 - R - N_1 x
$$

Beneficio total:
$$
\pi = p_1 X_1 + p_2 X_2 - p_1 R - p_1 W
$$

Interpretación:  
Los beneficios son el **remanente del producto total** después de pagar salarios y rentas.

---

## 5. Ecuaciones de valor (teoría del trabajo)

**Variables:**
- $ p_1, p_2 $: precios relativos expresados en oro  
- $ N_1, N_2 $: cantidad de trabajo empleada  
- $ X_1, X_2 $: productos físicos

**Ecuaciones:**

$$
p_1 (X_1 - R) = N_1
$$

$$
p_2 X_2 = N_2
$$

De donde se obtiene:

$$
p_1 = \frac{1}{f'(N_1)}, \quad p_2 = \frac{1}{a}
$$

Interpretación:  
El **valor** del producto (en oro) equivale al trabajo incorporado.  
El precio del maíz depende de la **productividad marginal del trabajo agrícola**, mientras que el oro es el patrón constante.

---

## 6. Condición de gasto (Ley de Say)

**Ecuación:**

$$
p_2 X_2 = p_1 R
$$

Interpretación:  
Toda la renta de los terratenientes se gasta en bienes de lujo (oro).  
No hay ahorro improductivo: se cumple la **Ley de Say** (todo ingreso se gasta).

---

## 7. Datos exógenos (condiciones naturales)

**Variables exógenas:**
- $ \bar{x} $: salario real “natural” (nivel de subsistencia o reproducción estable de la población)  
- $ \bar{K} $: capital disponible al inicio del período

**Ecuaciones:**

$$
x = \bar{x} > 0
$$

$$
K = \bar{K} > 0
$$

Interpretación:  
Estas dos variables se toman como datos dados del sistema.  
El salario natural asegura una población constante y el capital inicial permite determinar el nivel de producción.

---

## 8. Tasa de ganancia y salario monetario

**Variables:**
- $ r $: tasa de ganancia (en unidades físicas de maíz o proporción del capital)  
- $ w $: salario monetario (en unidades de oro)

**Ecuaciones:** (QUEDA DISCUTIR SI LA GANANCIA ES EN ORO O EN MAIZ)

Formula Sebas:
$$
r = \frac{\pi}{p_1 K}
$$


Formula agus:
$$
r = f'(N_1) - x
$$

$$
w = p_1 x
$$

Interpretación:  
La tasa de ganancia es el **excedente de productividad del trabajo agrícola** sobre el salario real.  
El salario monetario depende del precio del maíz y del salario real.

---

## 9. Condición de equilibrio natural

**Ecuación:**

$$
f'(0) > x > f'(\infty)
$$

Interpretación:  
El producto marginal inicial debe ser mayor que el salario natural, pero este último debe ser mayor que el producto marginal en el límite (cuando la tierra se satura).  
Garantiza que exista un punto intermedio de equilibrio.

---

## 10. Dinámica (crecimiento y población)

**Variables:**
- $ N(t) $: población en el tiempo  
- $ K(t) $: capital en el tiempo  
- $ \pi $: beneficios totales  
- $ F(\cdot) $: función de ajuste demográfico  
- $ \Phi(\cdot) $: función de acumulación de capital

**Ecuaciones:**

Ecuación poblacional:
$$
\frac{dN}{dt} = F(x - \bar{x}), \quad F'(x - \bar{x}) > 0
$$

Acumulación de capital:
$$
\frac{dK}{dt} = \Phi\left(\frac{\pi}{K}\right), \quad \Phi' > 0
$$

Interpretación:  
- Si los salarios reales superan el nivel natural, la población crece.  
- Si hay beneficios, el capital se acumula.  
- Ambos mecanismos impulsan la **dinámica del crecimiento**.

## Conexión entre \(r_1, r_2\) y la asignación sectorial

### 🔹 Versión discreta

\[
\begin{aligned}
r_{1,t+1} &= \frac{f'(N_{1,t+1}) - x_{t+1}}{x_{t+1}} \\
r_{2,t+1} &= \frac{a - x_{t+1}}{x_{t+1}}
\end{aligned}
\]

La igualación de rentabilidades guía la movilidad del capital:

\[
r_{1,t+1} = r_{2,t+1} \;\Longrightarrow\; f'(N_{1,t+1}) = a
\]

De esta condición se obtiene \(N_{1,t+1}\) y, por identidad:

\[
N_{2,t+1} = N_{t+1} - N_{1,t+1}.
\]

💬 **Interpretación:**  
Si \(r_{1,t} > r_{2,t}\), el trigo es más rentable → los capitalistas trasladan trabajo hacia el sector 1 → \(N_{1,t+1}\) aumenta.  
Si \(r_{1,t} < r_{2,t}\), el oro es más rentable → se traslada trabajo al sector 2 → \(N_{1,t+1}\) disminuye.  
En equilibrio, las tasas se igualan y ya no hay incentivos a mover capital.

---

### 🔹 Versión continua

\[
\begin{aligned}
r_1(t) &= \frac{f'(N_1(t)) - x(t)}{x(t)} \\
r_2(t) &= \frac{a - x(t)}{x(t)}
\end{aligned}
\]

La movilidad intersectorial se describe con un flujo de reasignación:

\[
\frac{dN_1}{dt} = \lambda \,[\,r_1(t) - r_2(t)\,], \qquad
\frac{dN_2}{dt} = -\lambda \,[\,r_1(t) - r_2(t)\,],
\]

con \(\lambda > 0\) midiendo la velocidad de ajuste del capital.

En equilibrio dinámico:

\[
r_1(t) = r_2(t) \;\Longrightarrow\; f'(N_1(t)) = a.
\]

💬 **Interpretación:**  
Los capitalistas mueven trabajo entre sectores proporcionalmente a la diferencia de ganancias.  
El ajuste continúa hasta que las rentabilidades se igualan, fijando una distribución estable \(N_1^*\) y \(N_2^*\).


---

## 11. Estado estacionario

**Condiciones:**

$$
f'(N_1^*) = \bar{x}
$$

$$
r = 0, \quad \frac{dK}{dt} = 0, \quad \frac{dN}{dt} = 0
$$

Interpretación:  
El sistema alcanza el **estado estacionario** cuando la productividad marginal del trabajo iguala el salario natural.  
En ese punto:
- La tasa de ganancia es nula.  
- No hay más acumulación de capital.  
- La población se estabiliza.  
Es el equilibrio de largo plazo del modelo ricardiano.

---
