function test_cross_28114

k=[1 2 3 4;5 6 7 8];
e=input('number of elements : ');

gc=zeros(2*e*(e+1));


for i=1:2:2*e
    gc(i:i+1,ceil((i+1)/2):ceil((i+1)/2)+1)=k(:,1:2);
end

j=1;
a=1;
b=1;
a=a+2*e;
b=b+e+1;
while j<e

    gc(a:a+2*e,b:b+e+1)=gc(1:1+2*e,1:1+e+1);
    a=a+2*e;
    b=b+e+1;
    j=j+1;
end


if e>=3
    gc((2*e^2+1),(e*(e+1)+1))=0;
end
%


p=e*(e+1);
d=e*(e+1)+1;
z=zeros(2*e,1);

for h=1:2:2*e 
    z(h,1)=d;
    d=d+e+1;
end

for u=1:2:2*e
    gc(u:u+1,z(u,1):z(u,1)+1)=k(:,3:4);

end

aa=e*(e+1); 
g_temp=gc(1:2*e,aa+1:aa+e*e+1);

co=2*e;
for w=2:e
    gc((co+1):(co+2*e),(aa+w):(aa+w+e*e))=gc(1:2*e,aa+1:aa+e*e+1);
    co=co+2*e;
    
end

f=2*e*(e+1)-2*e+1;
    
for g=1:e+1:2*e*(e+1)
    gc(f,g)=1;
    f=f+1;

end

gc  

end
