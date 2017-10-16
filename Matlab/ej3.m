%% Ejercicio 3
%% 3.1

SNR = -5:1:30;
SNR_mod = 10.^(SNR/10);
h=0.5;
figure;
set(gca, 'YScale', 'log');
ylim([10^-6 10^0])
hold on;
grid on;

n=1;
h1=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^1),'Color','blue','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','blue','LineStyle','--');
n=5;
h2=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^5),'Color','red','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','red','LineStyle','--');
n=9;
h3=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^9),'Color','green','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','green','LineStyle','--');
n=13;
h4=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^13),'Color','cyan','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','cyan','LineStyle','--');
n=17;
h5=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^17),'Color','black','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','black','LineStyle','--');
n=21;
h6=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^21),'Color','magenta','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','magenta','LineStyle','--');
n=25;
h7=plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^25),'Color','yellow','LineStyle','-');
plot(SNR,qfunc(h^2*sqrt(SNR_mod.^n)./(sqrt((SNR_mod+1).^n-SNR_mod.^n))),'Color','yellow','LineStyle','--');

xlabel('SNR [dB]');
ylabel('Probabilidad de Error');
legend([h1 h2 h3 h4 h5 h6 h7],{'n = 1','n = 5','n = 9','n = 13','n = 17','n = 21','n = 25'},'Location','southwest');
