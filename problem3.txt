function sub_domain_p3_shell

e=input('specify the number of elements');
s=zeros(3,6);
s(1,1)=-1+0.25/e+0.25/e;
s(1,5)=-0.25/e;
s(1,2)=-0.25/e;
s(1,6)=-0.25/e;
s(1,3)=-0.25/e;
s(1,4)=1+0.25/e+0.25/e;


s(2,1)=-0.5/e;
s(2,5)=1+0.5/e;
s(2,2)=-1+0.5/e;
s(2,6)=0;
s(2,3)=0;
s(2,4)=-0.5/e;


s(3,1)=-0.5/e;
s(3,5)=0;
s(3,2)=0;
s(3,6)=1+0.5/e;
s(3,3)=-1+0.5/e;
s(3,4)=-0.5/e;


s;
k=0;
if e==1
    global_stifnes=[s;eye(3,6)];
    constant=[zeros((3*e),1);1;0.5;0];
    solution=inv(global_stifnes)*constant;
end

if e>1
    
    for i=2:1:e
        sg=[zeros(3,3*(i-1)) s zeros(3,(3*(e-1)-3*(i-1)))];
        for j=1:3
            temp=sg(j,:);
                for l=k+1:k+3
                    gs_f(k+1,:)=temp;
                end
            k=k+1;
        end
    end
    g1=[s,zeros(3,3*(e-1))];
    g3=[eye(3,3*(e+1))];
    global_stifnes=[g1;gs_f;g3];
    constant=[zeros((3*e),1);1;0.5;0];
    solution=inv(global_stifnes)*constant;
end

t_out=zeros(3,1);
for y=2:-1:0
    t_out(3-y,1)=solution((size(solution,1)-y),:);
end
disp('Tempratures given in journal for outlet in sequence is 0.6534 , 0.6886 , 0.5046 ')
disp('Calculated temperatures using FEA(sub domain method) are given below')
t_out
end