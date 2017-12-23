% this program runs on sub domain method applied for multi fluid 4 chanel
%heat exchanger
%writen by ShyamPrasad V Atri and Abhishek bhat
function stifnes 

e=input('specify the number of elements');
s=zeros(4,8);
s(1,1)=-1+0.25/e;
s(1,5)=1+0.25/e;
s(1,2)=-0.25/e;
s(1,6)=-0.25/e;
s(1,3)=0;
s(1,7)=0;
s(1,4)=0;
s(1,8)=0;

s(2,1)=-0.25/e;
s(2,5)=-0.25/e;
s(2,2)=-1+0.25/e+0.25/e;
s(2,6)=1+0.25/e+0.25/e;
s(2,3)=-0.25/e;
s(2,7)=-0.25/e;
s(2,4)=0;
s(2,8)=0;

s(3,1)=0;
s(3,5)=0;
s(3,2)=-0.25/e;
s(3,6)=-0.25/e;
s(3,3)=-1+0.25/e+0.25/e;
s(3,7)=1+0.25/e+0.25/e;
s(3,4)=-0.25/e;
s(3,8)=-0.25/e;

s(4,1)=0;
s(4,5)=0;
s(4,2)=0;
s(4,6)=0;
s(4,3)=-0.25/e;
s(4,7)=-0.25/e;
s(4,4)=-1+0.25/e;
s(4,8)=1+0.25/e;
s
if e==1
    global_stifnes_1=[s;eye(4,8)]
    constant_1=[zeros(4,1);1;0;1;0]
    solution_1=inv(global_stifnes_1)*constant_1
end
if e==2
    global_stifnes_2=[s,zeros(4,4);zeros(4,4),s;eye(4,12)]
    constant_2=[zeros(8,1);1;0;1;0]
    solution_2=inv(global_stifnes_2)*constant_2
end
if e==3
    global_stifnes_3=[s,zeros(4,8);zeros(4,4),s,zeros(4,4);zeros(4,8),s;eye(4,16)]
    constant_3=[zeros(12,1);1;0;1;0]
    solution_3=inv(global_stifnes_3)*constant_3
end
if e==4
    global_stifnes_4=[s,zeros(4,12);zeros(4,4),s,zeros(4,8);zeros(4,8),s,zeros(4,4);zeros(4,12),s;eye(4,20)]
    constant_4=[zeros(16,1);1;0;1;0]
    solution_4=inv(global_stifnes_4)*constant_4
end
if e==5
    global_stifnes_5=[s,zeros(4,16);zeros(4,4),s,zeros(4,12);zeros(4,8),s,zeros(4,8);zeros(4,4),s,zeros(4,12);zeros(4,16),s;eye(4,24)]
    constant_5=[zeros(20,1);1;0;1;0]
    determanent_global_stifnes_5=det(global_stifnes_5)
    disp('Since dtermanent value is zero we dont have uneque solution')
    %null_space_of_global_stifnes_5=null(global_stifnes_5)
    %[L,U]=lu(global_stifnes_5)
    %solution_5=inv(global_stifnes_5)*constant_5
end

    






