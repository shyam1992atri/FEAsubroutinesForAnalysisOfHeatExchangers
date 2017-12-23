function combine_plot

e=input('specify the number of elements');
s=zeros(4,8);
s(1,1)=-530+(110*3)/(2*e)+(42*3)/(2*e)+(28*3)/(2*e);
s(1,5)=530+(110*3)/(2*e)+(3*42)/(2*e)+(28*3)/(2*e);
s(1,2)=-(110*3)/(2*e);
s(1,6)=-(110*3)/(2*e);
s(1,3)=-(42*3)/(2*e);
s(1,7)=-(42*3)/(2*e);
s(1,4)=-(28*3)/(2*e);
s(1,8)=-(28*3)/(2*e);

s(2,1)=-(110*3)/(2*e);
s(2,5)=-(110*3)/(2*e);
s(2,2)=1100+(110*3)/(2*e)+(131*3)/(2*e)+(18*3)/(2*e);
s(2,6)=-1100+(110*3)/(2*e)+(131*3)/(2*e)+(18*3)/(2*e);
s(2,3)=-(131*3)/(2*e);
s(2,7)=-(131*3)/(2*e);
s(2,4)=-(18*3)/(2*e);
s(2,8)=-(18*3)/(2*e);

s(3,1)=-(42*3)/(2*e);
s(3,5)=-(42*3)/(2*e);
s(3,2)=-(131*3)/(2*e);
s(3,6)=-(131*3)/(2*e);
s(3,3)=-378+(42*3)/(2*e)+(131*3)/(2*e)+(46*3)/(2*e);
s(3,7)=378+(42*3)/(2*e)+(131*3)/(2*e)+(46*3)/(2*e);
s(3,4)=-(46*3)/(2*e);
s(3,8)=-(46*3)/(2*e);

s(4,1)=-(28*3)/(2*e);
s(4,5)=-(3*28)/(2*e);
s(4,2)=-(18*3)/(2*e);
s(4,6)=-(18*3)/(2*e);
s(4,3)=-(46*3)/(2*e);
s(4,7)=-(46*3)/(2*e);
s(4,4)=684+(28*3)/(2*e)+(18*3)/(2*e)+(46*3)/(2*e);
s(4,8)=-684+(28*3)/(2*e)+(18*3)/(2*e)+(46*3)/(2*e);
s;
k=0;
if e==1
    global_stifnes=[s;1 zeros(1,4*(e+1)-1);zeros(1,4*(e+1)-3) 1 0 0;0 0 1 zeros(1,4*(e+1)-3);zeros(1,4*(e+1)-1) 1 ];
    constant=[zeros((4*e),1);76;7;43;15];
    solution=inv(global_stifnes)*constant;
end

if e>1
    
    for i=2:1:e
        sg=[zeros(4,4*(i-1)) s zeros(4,(4*(e-1)-4*(i-1)))];
        for j=1:4
            temp=sg(j,:);
                for l=k+1:k+4
                    gs_f(k+1,:)=temp;
                end
            k=k+1;
        end
    end
    g1=[s,zeros(4,4*(e-1))];
    g3=[1 zeros(1,4*(e+1)-1);zeros(1,4*(e+1)-3) 1 0 0;0 0 1 zeros(1,4*(e+1)-3);zeros(1,4*(e+1)-1) 1 ];
    global_stifnes=[g1;gs_f;g3];
    constant=[zeros((4*e),1);76;7;43;15];
    solution=inv(global_stifnes)*constant;
end

for y=3:-1:0
    t_in(y+1,1)=solution(y+1,:);
    t_out_1(y+1,1)=solution((size(solution,1)-y),:); 
end

for t=1:4
    t_out(t,1)=t_out_1(5-t,:);
end
t_1=1;

for i=1:4:size(solution,1)
    t1(t_1,:)=solution(i,:);
    t2(t_1,:)=solution(i+1,:);
    t3(t_1,:)=solution(i+2,:);
    t4(t_1,:)=solution(i+3,:);
    t_1=t_1+1;
end
x=0:3/e:3;
disp('Tempratures given in journal for inlet in sequence is 76 , 25.75 , 43 , 22.71')
disp('Tempratures given in journal for outlet in sequence is 39.74 , 7 , 25.2989 , 15')
disp('Calculated temperatures using FEA(sub domain method) are given below')
t_in
t_out
ta1=-14.4598-1.33859*exp(0.1859*x)+4.16622*exp(-0.5841*x)+87.6321*exp(-0.15036*x);
ta2=-14.4598-4.1452*exp(0.18549*x)-0.9446*exp(-0.5841*x)+45.3028*exp(-0.15036*x);
ta3=-14.4598-1.2905*exp(0.18549*x)-9.8999*exp(-0.58416*x)+68.6502*exp(-0.15036*x);
ta4=-14.4598+4.9159*exp(0.18549*x)-0.72369*exp(-0.5841*x)+32.985*exp(-0.15036*x);

  
plot(x,t1,x,t2,x,t3,x,t4,x,ta1,'*r',x,ta2,'*r',x,ta3,'*r',x,ta4,'*r')
xlabel('Length')
ylabel('Temperature')
title('Temperature vs length graph,plane lines are Analatical plot and red Stars Depect FEA plot ')



end