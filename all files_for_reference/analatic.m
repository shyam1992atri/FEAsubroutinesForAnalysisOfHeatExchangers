function analatic

e=input('specify the number of elements');
s=zeros(4,8);
s(1,1)=-530*11+110/(2*e)+42/(2*e)+28/(2*e);
s(1,5)=530*11+110/(2*e)+42/(2*e)+28/(2*e);
s(1,2)=-110/(2*e);
s(1,6)=-110/(2*e);
s(1,3)=-42/(2*e);
s(1,7)=-42/(2*e);
s(1,4)=-28/(2*e);
s(1,8)=-28/(2*e);

s(2,1)=-110/(2*e);
s(2,5)=-110/(2*e);
s(2,2)=1100*11+110/(2*e)+131/(2*e)+18/(2*e);
s(2,6)=-1100*11+110/(2*e)+131/(2*e)+18/(2*e);
s(2,3)=-131/(2*e);
s(2,7)=--131/(2*e);
s(2,4)=-18/(2*e);
s(2,8)=-18/(2*e);

s(3,1)=-42/(2*e);
s(3,5)=-42/(2*e);
s(3,2)=-131/(2*e);
s(3,6)=-131/(2*e);
s(3,3)=-378*11+42/(2*e)+131/(2*e)+46/(2*e);
s(3,7)=378*11+42/(2*e)+131/(2*e)+46/(2*e);
s(3,4)=-46/(2*e);
s(3,8)=-46/(2*e);

s(4,1)=-28/(2*e);
s(4,5)=-28/(2*e);
s(4,2)=-18/(2*e);
s(4,6)=-18/(2*e);
s(4,3)=-46/(2*e);
s(4,7)=-46/(2*e);
s(4,4)=684*11+28/(2*e)+18/(2*e)+46/(2*e);
s(4,8)=-684*11+28/(2*e)+18/(2*e)+46/(2*e);
s;
k=0
if e==1
    global_stifnes=[s;1 zeros(1,4*(e+1)-1);zeros(1,4*(e+1)-3) 1 0 0;0 0 1 zeros(1,4*(e+1)-3);zeros(1,4*(e+1)-1) 1 ];
    constant=[zeros((4*e),1);1;-1.0909;0;-28/33];
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
    constant=[zeros((4*e),1);1;-1.0909;0;-28/33];
    solution=inv(global_stifnes)*constant;
end

for y=3:-1:0
    theta_in(y+1,1)=solution(y+1,:);
    t_in=theta_in*(76-43)+43;
    theta_out(y+1,1)=solution((size(solution,1)-y),:);
end
for z=1:4
    t_out=theta_out(z,:)*(76-43)+43;
end

theta_in
t_in
theta_out
t_out

end