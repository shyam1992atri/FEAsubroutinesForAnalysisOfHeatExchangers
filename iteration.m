function iteration
xo=zeros(1,5);
x=1;
dt=0.01;
for i=1:5
    xo(1,i)=x+x*dt;
    x=x+x*dt;
end
xo
end
