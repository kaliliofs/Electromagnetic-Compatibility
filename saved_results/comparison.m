clc
clear all 
close all 

load Results_Aluminum.mat
SEe_Al = SEe; 
SEm_Al = SEm; 
fr_Al = fr ; 
%attenuation_ACO = attenuation ; 
load Results_Lead.mat
SEe_Le = SEe; 
SEm_Le = SEm; 
fr_Le = fr ; 
%attenuation_MC = attenuation ; 
load Results_Mumetal.mat
SEe_Mu = SEe; 
SEm_Mu = SEm; 
fr_Mu = fr ; 
%attenuation_RC = attenuation
%figures for comparison 
%=======================
%attenuation 
%figure
%semilogy(SEe_Al, SEe_Le ,SEe_Mu)
%legend('Al','Le','Mu')
%ylabel('SE')
%xlabel('fr')
%grid on 
% Received power
figure 
semilogx(fr_Al,SEm_Al,fr_Al,SEe_Al, fr_Le ,SEm_Le,fr_Le ,SEe_Le, fr_Mu, SEm_Mu,fr_Mu, SEe_Mu)
%legend([SEm_Al SEm_Le SEm_Mu],{'AL_m','Le_m','Mu_m'})
legend({'AL_m','Al_e','Pb_m','Pb_e','Mumetal_m','Mumetal_e'},'location','north');
ylabel('Shield Effectiveness (SE) [dB]')
xlabel('Frequency [MHz]')
grid on 
print('sawsansawsan','-depsc')

