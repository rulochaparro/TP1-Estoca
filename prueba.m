clear all; close all; clc;

% Fdp con SNRdB=10dB (elijo esa), condicionando a X1=A %

N=100000;
A=10;                               %Aca mepa que A=1. En el script dice 10
h=1;                               %Agrego el valor de h                                                      
  SNRdB=10; 
  SNR=10^(SNRdB/10);
  sigma=(h*A)/(sqrt(SNR)); %multiplico por h
  G=sqrt((SNR)/(h*(SNR+1))); %Cambiar G por el nuestro
  Densidad=[];
  for j=1:N
    X1=A;
    X=X1;
    for i=1:8 % 8 repetidores para que sea n=9 %
      W=(sigma)*randn(1);
      Y= h*X+W;            %multiplicar por h
      X=G*Y;       
    end
    
    W=(sigma)*randn(1);
    Y=h*X+W;              %multiplicar por h
    Densidad(j)=Y;
  end
  
  
  % Genero los parametros para obtener la varianza del ruido %
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
 
  % Condiciono X1=-A %
 
 Densidad2=[];
  for j=1:N
    X1=-A;
    X=X1;
    for i=1:8 % 8 repetidores para que sea n=9 %
      W=(sigma)*randn(1);
      Y=h*X+W;        %multiplico por h
      X=G*Y;       
    end
    
    W=(sigma)*randn(1);
    Y=h*X+W;          %multiplico por h
    Densidad2(j)=Y;
  end
 
 % Grafico histograma %
 xHist=-25.5:1:40.5;
 
 figure;
 
 xHistErr=xHist(1:26);   % Corto en x=0 parar graficar con distinto color %
 xHistOk=xHist(27:67);
 
 [Histo,c]=hist(Densidad,xHist); 
 dif=c(2)-c(1);
 HistoErr=Histo(1:26)/(N*dif);
 HistoOk=Histo(27:67)/(N*dif);
 
 hold on;
 
  HErr=bar(xHistErr,HistoErr);
  HOk=bar(xHistOk,HistoOk);
  
  set(HErr,'Facecolor','g');
  set(HOk,'Facecolor','r');
  
 
 hold on;
  xHist2=-40.5:1:25.5;
 %figure;
 
 xHist2Ok=xHist2(1:41);   % Corto en x=0 parar graficar con distinto color %
 xHist2Err=xHist2(42:67);
 
 [Histo2,b]=hist(Densidad2,xHist2);
 dif=b(2)-b(1);
 Histo2Ok=Histo2(1:41)/(N*dif);
 Histo2Err=Histo2(42:67)/(N*dif);
 
 hold on;
  
  H2Ok=bar(xHist2Ok,Histo2Ok);
  H2Err=bar(xHist2Err,Histo2Err);
  
 % set(H2Ok,'Facecolor','m');
  %set(H2Err,'Facecolor','r');
 % Grafico la fdp teorica %
 
 x=-25.5:0.1:40.5;
 DesvioRuido=sqrt(VarRuido);
 Media1=A*G^8;
 
 Media2=-Media1;
 
 x2=-40.5:0.1:25.5;
 
 FdpSalida2=normpdf(x2,Media2,DesvioRuido);
 
% plot(x2,FdpSalida2,'b','LineWidth',3);

% legend('Histograma sin error', 'Histograma de error', 'f_{Y_{n}|X=-A}');
 %grid on;
 %grid minor;
 
 
 FdpSalida1=normpdf(x,Media1,DesvioRuido);
 
 %plot(x,FdpSalida1,'m','LineWidth',3);
 %legend('Histograma de error', 'Histograma sin error', 'f_{Y_{n}|X=A}');
 grid on;
 grid minor;
 hold on;

  
 

  
 
 %hold on;
 