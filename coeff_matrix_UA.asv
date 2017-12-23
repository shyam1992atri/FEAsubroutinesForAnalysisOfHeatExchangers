function coeff_matrix_UA
n=input('speccify the number of streams:');
hc=zeros(n,n);
h=zeros(1,n);
fin_hight=zeros(1,n);
fin_freq=zeros(1,n);
alfa=zeros(1,n);
aw=0.5*1;   %length=1meter bredth=0.5 meter
af=zeros(1,n);

for i=1:1:n
    fprintf('give input values of stream %d \n',i)
    h(1,i)=input('give h value: ');
    fin_freq(1,i)=input('give fin frequency value: ');
    fin_hight(1,i)=input('give fin hight value: ');
    alfa(1,i)=input('specify the value alfa(fraction of area)');
end
 
for j=1:1:n
    af(1,j)=2*0.5*1*fin_hight(1,j)*fin_freq(1,j);
end

for k=1:1:n
    for l=1:1:n
        if l==k
            hc(k,l)=0;
        else
            hc(k,l)=1/((1/(h(1,k)*(aw+alfa(1,k)*af(1,k))))+(1/(h(1,l)*(aw+(1-alfa(1,l))*af(1,l)))));
        end
        
    end
    
end

hc
    
end