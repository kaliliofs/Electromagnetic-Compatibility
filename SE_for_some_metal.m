%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Cindy S Cheung
% Last Updated: November 10, 2008
% Function: Matlab Source Code that Calculates and Plots Absorption Loss,
% Reflection Loss, Re-Reflection Correction Factor, and
% Shielding Effectiveness for a Superalloy, Aluminum, and
% Mumetal Shielding 0.00035 inches thick and located 1 meter
% from EM source
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear Output Windows
clear all;
clc;
% Frequency Range
Freq=3e18:30e18:300e18; %Frequencies used for Plots
%Freq = [1e1 5e1 1e2 5e2 1e3 5e3 1e4 5e4 1e5 5e5 1e6 5e6 1e7 5e7 1e8 5e8 1e9];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Absorption Loss for all Fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K1 = 131.4; %Constant = 131.4 if l is meters; 3.34 if l is inches
l = 0.05; %Thickness in inches
% Superalloy Parameters ((TEFLON))
SA_ur = 1.256* 10e-6; %Permability
SA_gr = 10e-25; %Conductivity
% Aluminum Parameters
Al_ur = 1; %Permability
Al_gr = 0.53; %Conductivity
% Mumetal Parameters
Mu_ur = 2e4; %Permability
Mu_gr = 0.0289; %Conductivity
% Absorption Loss Equations
A_SA = K1 * l * sqrt(Freq * SA_ur * SA_gr);
A_Al = K1 * l * sqrt(Freq * Al_ur * Al_gr);
A_Mu = K1 * l * sqrt(Freq * Mu_ur * Mu_gr);
% Plot Absorption Loss
figure (1);
loglog(Freq, A_SA, Freq, A_Al, Freq, A_Mu);
grid on;
title('Absorption Loss');
xlabel('Freqency (Hz)');
ylabel('Absorption Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflection Loss
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C1 = 2.1; %Coefficient for Magnetic = 0.0117 if r is meters
% = 0.462 if r is inches
C2 = 5.35; %Coefficient for Magnetic = 5.35 if r is meters
% = 0.136 if r is inches
C3 = 322;
r = 1; %Distance from EM Source to Shield in meters
% Reflection Loss for Magnetic Field
Rm_SA = 20 * log10((C1 ./ (r .* sqrt((Freq .* SA_gr) ./ SA_ur))) +...
(C2 .* (r .* sqrt((Freq .* SA_gr) ./ SA_ur))) + 0.354);
Rm_Al = 20 * log10((C1 ./ (r .* sqrt((Freq .* Al_gr) ./ Al_ur))) +...
(C2 .* (r .* sqrt((Freq .* Al_gr) ./ Al_ur))) + 0.354);
Rm_Mu = 20 * log10((C1 ./ (r .* sqrt((Freq .* Mu_gr) ./ Mu_ur))) +...
(C2 .* (r .* sqrt((Freq .* Mu_gr) ./ Mu_ur))) + 0.354);
% Plot Reflection Loss for Magnetic Field
figure(2);
semilogx(Freq, Rm_SA, Freq, Rm_Al, Freq, Rm_Mu);
grid on;
title('Reflection Loss For Magnetic Field');
xlabel('Freqency (Hz)');
ylabel('Reflection Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
% Reflection Loss For Electric Field
Re_SA = C3 - (10 * log10((SA_ur * Freq.^3 * r.^2) / SA_gr));
Re_Al = C3 - (10 * log10((Al_ur * Freq.^3 * r.^2) / Al_gr));
Re_Mu = C3 - (10 * log10((Mu_ur * Freq.^3 * r.^2) / Mu_gr));
% Plot Reflection Loss For Electric Field
figure (3);
semilogx(Freq, Re_SA, Freq, Re_Al, Freq, Re_Mu);
grid on;
title('Reflection Loss For Electric Field');
xlabel('Freqency (Hz)');
ylabel('Reflection Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
% Reflection Loss For Plane Wave
Rp_SA = 168 - 20 * log10(sqrt((Freq * SA_ur) / SA_gr));
Rp_Al = 168 - 20 * log10(sqrt((Freq * Al_ur) / Al_gr));
Rp_Mu = 168 - 20 * log10(sqrt((Freq * Mu_ur) / Mu_gr));
% Plot Reflection Loss For Plane Wave
figure(4);
semilogx(Freq, Rp_SA, Freq, Rp_Al, Freq, Rp_Mu);
grid on;
title('Reflection Loss For Plane Wave');
xlabel('Freqency (Hz)');
ylabel('Reflection Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Total Loss For Magnetic Field
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TotalM_SA = A_SA + Rm_SA;
TotalM_Al = A_Al + Rm_Al;
TotalM_Mu = A_Mu + Rm_Mu;
% Plot Total Loss For Magnetic Field
figure (5);
loglog(Freq, TotalM_SA, Freq, TotalM_Al, Freq, TotalM_Mu);
grid on;
title('Total Loss For Magnetic Field');
xlabel('Freqency (Hz)');
ylabel('Total Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Total Loss For Electric Field
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TotalE_SA = A_SA + Re_SA;
TotalE_Al = A_Al + Re_Al;
TotalE_Mu = A_Mu + Re_Mu;
% Plot Total Loss For Electric Field
figure (6);
loglog(Freq, TotalE_SA, Freq, TotalE_Al, Freq, TotalE_Mu);
grid on;
title('Total Loss For Electric Field');
xlabel('Freqency (Hz)');
ylabel('Total Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Total Loss For Plane Wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TotalP_SA = A_SA + Rp_SA;
TotalP_Al = A_Al + Rp_Al;
TotalP_Mu = A_Mu + Rp_Mu;
% Plot Total Loss for Plane Wave
figure(7);
loglog(Freq, TotalP_SA, Freq, TotalP_Al, Freq, TotalP_Mu);
grid on;
title('Total Loss For Plane Wave');
xlabel('Freqency (Hz)');
ylabel('Total Loss (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Re-Reflection Correction Factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter m for r in meters for Magnetic Field
mM_SA = (4.7e-2 ./ r) .* sqrt(SA_ur ./ (Freq .* SA_gr));
mM_Al = (4.7e-2 ./ r) .* sqrt(Al_ur ./ (Freq .* Al_gr));
mM_Mu = (4.7e-2 ./ r) .* sqrt(Mu_ur ./ (Freq .* Mu_gr));
% Reflection Coefficient for Magnetic Field
GammaM_SA = 4 .* (((1 - (mM_SA.^2)).^2 - (2 .* (mM_SA.^2)) +...
(i * (2 .* sqrt(2)) .* mM_SA .* (1 - (mM_SA.^2)))) ./...
(((1 + (sqrt(2) .* mM_SA)).^2 + 1).^2));
GammaM_Al = 4 .* (((1 - (mM_Al.^2)).^2 - (2 .* (mM_Al.^2)) +...
(i * (2 .* sqrt(2)) .* mM_Al .* (1 - (mM_Al.^2)))) ./...
(((1 + (sqrt(2) .* mM_Al)).^2 + 1).^2));
GammaM_Mu = 4 .* (((1 - (mM_Mu.^2)).^2 - (2 .* (mM_Mu.^2)) +...
(i * (2 .* sqrt(2)) .* mM_Mu .* (1 - (mM_Mu.^2)))) ./...
(((1 + (sqrt(2) .* mM_Mu)).^2 + 1).^2));
%Re-Reflection Correction Factor for Magnetic Field
CM_SA = 20 .* log(1 - (GammaM_SA .* (10.^(-A_SA ./ 10)) .*...
(cos(0.23 .* A_SA) - (i .* sin(0.23 .* A_SA)))));
CM_Al = 20 .* log(1 - (GammaM_Al .* (10.^(-A_Al ./ 10)) .*...
(cos(0.23 .* A_Al) - (i .* sin(0.23 .* A_Al)))));
CM_Mu = 20 .* log(1 - (GammaM_Mu .* (10.^(-A_Mu ./ 10)) .*...
(cos(0.23 .* A_Mu) - (i .* sin(0.23 .* A_Mu)))));
% Magnitude of Correction Factor for Magnetic Field
magCM_SA = abs(CM_SA);
magCM_Al = abs(CM_Al);
magCM_Mu = abs(CM_Mu);
%Plot Correction Factor for Magnetic Field
figure (8);
semilogx(Freq, magCM_SA, Freq, magCM_Al, Freq, magCM_Mu);
grid on;
title('Re-Reflection Correction Factor, C, for Magnetic Field');
xlabel('Freqency (Hz)');
ylabel('Re-Reflection Correction Factor, C (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%--------------------------------------------------------------------------
%Parameter m for r in meters for Electric Field
mE_SA = 0.205e-16 * r * sqrt((SA_ur * Freq.^3) / SA_gr);
mE_Al = 0.205e-16 * r * sqrt((Al_ur * Freq.^3) / Al_gr);
mE_Mu = 0.205e-16 * r * sqrt((Mu_ur * Freq.^3) / Mu_gr);
%Reflection Coefficient for Electric Field
GammaE_SA = 4 .* (((1 - (mE_SA.^2)).^2 - (2 .* (mE_SA.^2)) -...
(i * (2 .* sqrt(2)) .* mE_SA .* (1 - (mE_SA.^2)))) ./...
(((1 - (sqrt(2) .* mE_SA)).^2 + 1).^2));
GammaE_Al = 4 .* (((1 - (mE_Al.^2)).^2 - (2 .* (mE_Al.^2)) -...
(i * (2 .* sqrt(2)) .* mE_Al .* (1 - (mE_Al.^2)))) ./...
(((1 - (sqrt(2) .* mE_Al)).^2 + 1).^2));
GammaE_Mu = 4 .* (((1 - (mE_Mu.^2)).^2 - (2 .* (mE_Mu.^2)) -...
(i * (2 .* sqrt(2)) .* mE_Mu .* (1 - (mE_Mu.^2)))) ./...
(((1 - (sqrt(2) .* mE_Mu)).^2 + 1).^2));
%Re-Reflection Correction Factor for Electric Field
CE_SA = 20 .* log(1 - (GammaE_SA .* (10.^(-A_SA ./ 10)) .*...
(cos(0.23 .* A_SA) - (i .* sin(0.23 .* A_SA)))));
CE_Al = 20 .* log(1 - (GammaE_Al .* (10.^(-A_Al ./ 10)) .*...
    (cos(0.23 .* A_Al) - (i .* sin(0.23 .* A_Al)))));
CE_Mu = 20 .* log(1 - (GammaE_Mu .* (10.^(-A_Mu ./ 10)) .*...
(cos(0.23 .* A_Mu) - (i .* sin(0.23 .* A_Mu)))));
% Magnitude of Correction Factor for Electric Field
magCE_SA = abs(CE_SA);
magCE_Al = abs(CE_Al);
magCE_Mu = abs(CE_Mu);
%Plot Correction Factor for Electric Field
figure(9);
semilogx(Freq, magCE_SA, Freq, magCE_Al, Freq, magCE_Mu);
grid on;
title('Re-Reflection Correction Factor, C, for Electric Field');
xlabel('Freqency (Hz)');
ylabel('Re-Reflection Correction Factor, C (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%--------------------------------------------------------------------------
%Parameter m for r in meters for Plane Wave
mP_SA = 9.77e-10 .* sqrt((Freq .* SA_ur) / SA_gr);
mP_Al = 9.77e-10 .* sqrt((Freq .* Al_ur) / Al_gr);
mP_Mu = 9.77e-10 .* sqrt((Freq .* Mu_ur) / Mu_gr);
%Reflection Coefficient for Plane Wave
GammaP_SA = 4 .* (((1 - (mP_SA.^2)).^2 - (2 .* (mP_SA.^2)) -...
(i * (2 .* sqrt(2)) .* mP_SA .* (1 - (mP_SA.^2)))) ./...
(((1 + (sqrt(2) .* mP_SA)).^2 + 1).^2));
GammaP_Al = 4 .* (((1 - (mP_Al.^2)).^2 - (2 .* (mP_Al.^2)) -...
(i * (2 .* sqrt(2)) .* mP_Al .* (1 - (mP_Al.^2)))) ./...
(((1 + (sqrt(2) .* mP_Al)).^2 + 1).^2));
GammaP_Mu = 4 .* (((1 - (mP_Mu.^2)).^2 - (2 .* (mP_Mu.^2)) -...
(i * (2 .* sqrt(2)) .* mP_Mu .* (1 - (mP_Mu.^2)))) ./...
(((1 + (sqrt(2) .* mP_Mu)).^2 + 1).^2));
%Re-Reflection Correction Factor for Plane Wave
CP_SA = 20 .* log(1 - (GammaP_SA .* (10.^(-A_SA ./ 10)).*...
(cos(0.23 .* A_SA) - (i .* sin(0.23 .* A_SA)))));
CP_Al = 20 .* log(1 - (GammaP_Al .* (10.^(-A_Al ./ 10)).*...
(cos(0.23 .* A_Al) - (i .* sin(0.23 .* A_Al)))));
CP_Mu = 20 .* log(1 - (GammaP_Mu .* (10.^(-A_Mu ./ 10)).*...
(cos(0.23 .* A_Mu) - (i .* sin(0.23 .* A_Mu)))));
% Magnitude of Correction Factor for Plane Wave
magCP_SA = abs(CP_SA);
magCP_Al = abs(CP_Al);
magCP_Mu = abs(CP_Mu);
%Plot Correction Factor for Plane Wave
figure (10);
semilogx(Freq, magCP_SA, Freq, magCP_Al, Freq, magCP_Mu);
grid on;
title('Re-Reflection Correction Factor, C, for Plane Wave');
xlabel('Freqency (Hz)');
ylabel('Re-Reflection Correction Factor, C (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Shielding Effectiveness For Magnetic Field
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SEm_SA = A_SA + Rm_SA - magCM_SA;
SEm_Al = A_Al + Rm_Al - magCM_Al;
SEm_Mu = A_Mu + Rm_Mu - magCM_Mu;
% Plot Shielding Effectiveness For Magnetic Field
figure (11);
semilogx(Freq, SEm_SA, Freq, SEm_Al, Freq, SEm_Mu);
grid on;
title('Shielding Effectiveness For Magnetic Field');
xlabel('Freqency (Hz)');
ylabel('Shielding Effectiveness (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%Shielding Effectiveness For Electric Field
SEe_SA = A_SA + Re_SA - magCE_SA;
SEe_Al = A_Al + Re_SA - magCE_Al;
SEe_Mu = A_Mu + Re_SA - magCE_Mu;
figure (12);
semilogx(Freq, SEe_SA, Freq, SEe_Al, Freq, SEe_Mu);
grid on;
title('Shielding Effectiveness For Electric Field');
xlabel('Freqency (Hz)');
ylabel('Shielding Effectiveness (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
%Shielding Effectiveness For Plane Wave
SEp_SA = A_SA + Rp_SA - magCP_SA;
SEp_Al = A_Al + Rp_Al - magCP_Al;
SEp_Mu = A_Mu + Rp_Mu - magCP_Mu;
figure (13);
semilogx(Freq, SEp_SA, Freq, SEp_Al, Freq, SEp_Mu);
grid on;
title('Shielding Effectiveness For Plane Wave');
xlabel('Freqency (Hz)');
ylabel('Shielding Effectiveness (dB)');
legend('Superalloy', 'Aluminum', 'Mumetal');
