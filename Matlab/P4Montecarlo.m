clear all; close all; clc;

% Montecarlo A=10%

% Repetidor Digital %
h=0.5;
N=1000000; %Iteraciones
S=0; %Sumador para indicadora de error
A=10; 
k=1;

for SNRdB=5:25

  SNR=10^(SNRdB/10);

  sigma=(A*h)/(sqrt(SNR));
  

  for j=1:N
    U=rand(1);  %Genero X inicial con distr. Ber(1/2)
    if U<0.5 
      X1=-A;
    else
      X1=A;
    end

    X=X1;
    for i=1:9   % 9 repetidores 
      W=(sigma)*randn(1);
      Y=h*X+W;
      if Y<0  % Decisiï¿½n 
        X=-A;
      elseif Y>0
        X=A;
      end
    
    end
    
    if 	X~=X1 % Si la salida es distinta que el inicial, sumo un evento de error
      S=S+1;
    end
  end  
  
  PeDig(k)=S/N;  % Prob de error (estimada) para cada SNR
  k=k+1;
  S=0; % Reseteo para proxima iteracion %
end

k=1;

% Busco PeDigital teorico para comparar con PeDigital del Montecarlo %

  for SNRdBp=5:25
    SNRp=10.^(SNRdBp/10);
    PeDigTeorica(k)=(1/2)*(1-((1-(2*qfunc(sqrt(SNRp)))).^9));
    k=k+1;
  end
  
% Grafico para comparar %

figure;
% semilogy(5:25,PeDig,'*b');
% ylim([10^-6  1]);
% hold on;
% semilogy(5:25,PeDigTeorica,'m','linewidth', 2);
% ylim([10^-6  1]);
% grid on;
% grid minor;
% xlabel('SNR [dB]');
% ylabel('log(P_{error})');
% legend('P(error) digital simulada', 'P(error) digital teórica');
% axis([5 25 10^-6  1]);
  
  
  
% Repetidor Analogico %

k=1;
for SNRdB=5:25

  SNR=10^(SNRdB/10);
  sigma=h*A/(sqrt(SNR));
  G=sqrt(SNR/(h^2*(SNR+1)));
  
  for j=1:N
    U=rand(1);
    if U<0.5 
      X1=-A;
    else
      X1=A;
    end

    X=X1;
    for i=1:8 % 8 repetidores para que sea n=9 %
      W=(sigma)*randn(1);
      Y=h*X+W;
      X=G*Y;       
    end
    
    W=(sigma)*randn(1);
    Y=X+W;
        
    if Y<0  % Decisiï¿½n final
        X=-A;
    elseif Y>0
        X=A;
    end
    
    if 	X~=X1
      S=S+1;
    end
  end
  
  PeAnalog(k)=S/N;
  k=k+1;
  S=0;
end

% Busco SNRn teorico parar verificar PeAnalogica y armo vector %
 
k=1;
 
 for SNRprueba=5:25
  SNRp=10^(SNRprueba/10);
  sigma=A*h/(sqrt(SNRp));
  G=sqrt(SNRp/(h^2*(SNRp+1)));
  Sum=1;

  for j=1:8
     Gprod=1;
     for i=(j+1):9
         Gprod=Gprod*G;
     end
     Gprod=Gprod^2;
     Sum=Sum+Gprod;
  end
 
  VarRuido=Sum*sigma^2;
  Gprod=1;
  for i=2:9
    Gprod=Gprod*G;
  end
  SNRn=((Gprod^2)*h^2*A^2)/VarRuido;
 
  PeAnalogTeorico(k)=qfunc(sqrt(SNRn)); 
  k=k+1;
 end
 
figure;
grid on;
semilogy(5:25,PeDig,'ob');
hold on;
semilogy(5:25,PeDigTeorica,'c','linewidth', 2);

semilogy(5:25,PeAnalog,'or');
hold on;
semilogy(5:25,PeAnalogTeorico,'k','linewidth', 2);
xlabel('SNR [dB]');
ylabel('Probabilidad de Error');
legend('Digital simulada', 'Digital teórica','Analógica simulada', 'Analógica teórica');
axis([5 25 10^-6  1]);
grid on;
 