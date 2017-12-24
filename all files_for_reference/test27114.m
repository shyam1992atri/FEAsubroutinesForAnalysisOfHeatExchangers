function test27114

a=[1 -1;-1 1];
n=input('number of elements');
ga=zeros(n+1,n+1);


for i=1:n
    ga(i,i+1)=a(1,2);
    ga(i+1,i)=ga(i,i+1);
    ga(i,i)=2;
    
end
ga(1,1)=1;
ga(n+1,n+1)=1;
ga(1,2:n)=0;

ga

end
