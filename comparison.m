clc
clear all 
close all 

load Results_ACO.mat
BER_ACO = BER; 
received_ACO = received_power; 
SNR_ACO = OSNR ; 
attenuation_ACO = attenuation ; 
load Results_MC.mat
BER_MC = BER; 
received_MC = received_power; 
SNR_MC = OSNR ; 
attenuation_MC = attenuation ; 
load save_str.mat
BER_RC = BER; 
received_RC = received_power; 
SNR_RC = OSNR ; 
attenuation_RC = attenuation
%figures for comparison 
%=======================
%attenuation 
figure
semilogy(attenuation_ACO,BER_ACO,attenuation_MC, BER_MC ,attenuation_RC ,BER_RC)
legend('ACO','MC','RC')
ylabel('BER')
xlabel('attenuation')
grid on 
% Received power
figure 
semilogy(received_ACO,BER_ACO,received_MC, BER_MC ,received_RC , BER_RC)
legend('ACO','MC','RC')
ylabel('BER')
xlabel('Received power')
grid on 
% SNR 
figure 
semilogy(SNR_ACO,BER_ACO,SNR_MC, BER_MC , SNR_RC , BER_RC)
legend('ACO','MC','RC')
ylabel('BER')
xlabel('SNR')
grid on 

