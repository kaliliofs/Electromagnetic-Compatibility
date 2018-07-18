clear all;
clc;
format long;
sigmar=0.1;
mur=500;
N=250;
dt=0.01; %input('Material thickness [mm] = ?');
d= 30;%input('\n Screen Distance [cm] = ? ');
dt = dt/1e3;
d=d/1e2; 
eps0=10^(-9)/(36*pi);
mu0=4*pi*10^(-7);
z0=sqrt(mu0/eps0);
fmin=1e3;
fmax=1e9;
df=(fmax-fmin)/N;
for k =1:2*N
    fr(k) = fmin +k*df;
    wavel=3e8/fr(k);
    if d < wavel/(2*pi)
        SRe=322+10*log10(sigmar/(mur*fr(k)^3*d^2));
        SRm=14.6+10*log10(fr(k)*d^2*sigmar/mur);
        SA=131.4*dt*sqrt(fr(k)*sigmar*mur);
    else
        SRf=168-10*log10(mur*fr(k)/sigmar);
        SA=131.4*dt*sqrt(fr(k)*sigmar*mur);
        SEf=SRf+SA;
    end
    SEe(k)=SRe+SA;
    SEm(k)=SRm+SA;
end
semilogx(fr,SEe,'k',fr,SEm,'r--');
grid;
xlabel('Freq[MHz]');
ylabel('SE [dB]');
legend('Electrical Shielding','Magnetic Shielding')
