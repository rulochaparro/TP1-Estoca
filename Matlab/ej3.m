%% Ejercicio 3
%% 3.1

SNR = -5:1:30;
figure;
set(gca, 'YScale', 'log');
ylim([10^-6 10^0])
hold on;

plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^1));
plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^5));
plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^9));
plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^13));
plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^17));
plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^21));
plot(SNR,1/2*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^25));

legend('n = 1','n = 5','n = 9','n = 13','n = 17','n = 21','n = 25');
legend('Location','southwest');