import numpy as np
import matplotlib.pyplot as plt



# Set number of periods
Q = 600

# Set number of scenarios (including baseline)
S = 5

# Set period in which shock/shift will occur
s = 15

# Create (S x Q)-matrices that will contain the simulated data
Y1 = np.ones((S, Q))
Y2 = np.ones((S, Q))
R = np.ones((S, Q))
P = np.ones((S, Q))
P1 = np.ones((S, Q))
P2 = np.ones((S, Q))
N = np.ones((S, Q))
N1 = np.ones((S, Q))
N2 = np.ones((S, Q))
w = np.ones((S, Q))
wn = np.ones((S, Q))
K = np.ones((S, Q))
MPL = np.ones((S, Q))
r = np.ones((S, Q))
p1 = np.ones((S, Q))
p2 = np.ones((S, Q))
N_eq = np.zeros(S)
K_eq = np.zeros(S)
test = np.ones((S, Q))

# Set baseline parameter values
gamma = 5
beta = 1
A = np.full((S, Q), 2.0)
a1 = np.full((S, Q), 0.7)
a2 = np.full((S, Q), 0.5)
wS = np.full((S, Q), 0.5)

# Set parameter values for different scenarios
A[1, s:] = 3     # scenario 2: productivity boost I
a1[2, s:] = 0.75 # scenario 3: productivity boost II
a2[3, s:] = 0.55 # scenario 4: productivity boost III
wS[4, s:] = 0.6  # scenario 5: higher subsistence wage

# Initialize variables
N1[:, 0] = 1
N2[:, 0] = 1
N[:, 0] = N1[:, 0] + N2[:, 0]
K[:, 0] = 1
w[:, 0] = wS[:, 0]
Y1[:, 0] = A[:, 0] * N1[:, 0] ** (a1[:, 0])
MPL[:, 0] = a1[:, 0] * A[:, 0] * (N1[:, 0] ** (a1[:, 0] - 1))

# Simulate the model by looping over Q time periods for S different scenarios
for i in range(S):
    for t in range(1, Q):
        for iterations in range(1000):
            # Model equations
            Y1[i, t] = A[i, t] * (N1[i, t] ** a1[i, t])
            N1[i, t] = N[i, t] - N2[i, t]
            MPL[i, t] = a1[i, t] * A[i, t] * (N1[i, t] ** (a1[i, t] - 1))
            R[i, t] = Y1[i, t] * (1 - a1[i, t])
            P1[i, t] = Y1[i, t] - R[i, t] - N1[i, t] * w[i, t]
            p1[i, t] = 1 / MPL[i, t]
            Y2[i, t] = (p1[i, t] / p2[i, t]) * R[i, t]
            w[i, t] = K[i, t] / N[i, t]
            N2[i, t] = Y2[i, t] / a2[i, t]
            p2[i, t] = 1 / a2[i, t]
            P2[i, t] = Y2[i, t] - (p1[i, t] / p2[i, t]) * N2[i, t] * w[i, t]
            P[i, t] = p1[i, t] * Y1[i, t] + p2[i, t] * Y2[i, t] - p1[i, t] * R[i, t] - p1[i, t] * K[i, t]
            K[i, t] = K[i, t - 1] + beta * (P[i, t - 1] / p1[i, t - 1])
            N[i, t] = N[i, t - 1] + gamma * (w[i, t - 1] - wS[i, t - 1])


# Plots (here for employ# Set start and end periods for plots
Tmax = 100
Tmin = 6

# Baseline
# Employment and capital accumulation
fig, ax1 = plt.subplots()
ax1.plot(N[0, 2:(Tmax+1)], linestyle='solid', label='N', linewidth=0.8, color="black")

ax1.set_xlabel('Time')
ax1.set_ylabel('N', rotation=0)
ax2 = ax1.twinx()
ax2.plot(K[0, 2:Tmax], linestyle='dashed', label='K', linewidth=0.8, color="black")
ax2.set_ylabel('K', rotation=0)
lines, labels = ax1.get_legend_handles_labels() #collect legend in one box
lines2, labels2 = ax2.get_legend_handles_labels()
ax2.legend(lines + lines2, labels + labels2, loc=5)
plt.title("Figure 1: Employment and capital accumulation")
plt.show()
