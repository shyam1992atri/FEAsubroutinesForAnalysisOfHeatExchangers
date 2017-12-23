function temperature_analitic
e=input('give the number of elements');
x=0:3/e:3;
t1=-14.4598-1.33859*exp(0.1859*x)+4.16622*exp(-0.5841*x)+87.6321*exp(-0.15036*x);
t2=-14.4598-4.1452*exp(0.18549*x)-0.9446*exp(-0.5841*x)+45.3028*exp(-0.15036*x);
t3=-14.4598-1.2905*exp(0.18549*x)-9.8999*exp(-0.58416*x)+68.6502*exp(-0.15036*x);
t4=-14.4598+4.9159*exp(0.18549*x)-0.72369*exp(-0.5841*x)+32.985*exp(-0.15036*x);
plot(x,t1,x,t2,x,t3,x,t4)
xlabel('length')
ylabel('Temperature')
title('Temperature vs length Analitical plot')
end
