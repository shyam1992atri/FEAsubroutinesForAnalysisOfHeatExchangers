function test
disp('test programme')
e=input('number');
s=rand(4,8);
k=0;

for i=2:1:e
    sg=[zeros(4,4*(i-1)) s zeros(4,(4*(e-1)-4*(i-1)))];
    for j=1:4
        d=sg(j,:);
        for l=k+1:k+4
            f(k+1,:)=d;
        end
    k=k+1;
    end
    
end

g1=[s,zeros(4,4*(e-1))];
g3=[eye(4,4*(e+1))];
gs=[g1;f;g3];
constant=[zeros((4*e),1);1;0;1;0];
solution=inv(gs)*constant
for y=3:-1:0
    theta_out=solution((size(solution,1)-y),:);
    t_out=theta_out*(41.93-34.93)+41.93
end
end




    
