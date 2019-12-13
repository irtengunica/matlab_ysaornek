clc;
x=egitim;%girisler
noronsayisi=2;
girissayisi=7;
cikissayisi=2;
w=rand(noronsayisi,girissayisi);%ara katman aðýrlýklarý
dw=rand(noronsayisi,girissayisi);%ara katman aðýrlýklarý deðiþimi
b=rand(noronsayisi,1);% arakatman biaslarý
db=zeros(noronsayisi,1);%ara katman bias deðiþiklikleri
o=zeros(noronsayisi,1); %ara katman çýkýþlarý
rpp=zeros(noronsayisi,1);%ara katman hata faktörler
wp=rand(cikissayisi,noronsayisi);%çýkýþ katman aðýrlýklarý
dwp=rand(cikissayisi,noronsayisi);%çýkýþ katmaný aðýrlýklarýndaki deðiþim
bp=rand(cikissayisi,1);%çikýþ katmaný biaslarý
dbp=zeros(cikissayisi,1);%çýkýþ katmaný biaslarýndaki deðiþim
rp=zeros(cikissayisi,1);%çýkýþ katmaný hata faktörleri
y=zeros(cikissayisi,1);%üretilen çýkýþlar
t=etarget;%hedeflenen çikýþlar

alpha=0.8;%momentum
n=0.5;%öðrenme oraný
s=0.01;%çürüme oraný (s)

%hata=(1/2)*((t(1)-y(1))*2+(t(2)-y(2))*2);
 %hata=1;
for k=1:length(egitim)
    hata=1;
    while(hata>0.9)
        %ara katman çýkýþlarýnýn bulunmasý
        %O'1=f(x1.w'11+x2.w'12+...+xn.w'1n+b'1
        for i=1:noronsayisi
            top=0;
            for n=1:girissayisi
                top=top+x(n,k)*w(i,n);
            end
            o(i)=sigmoid(top+b(i));
        end
        %çikýþ katmalarýnýn bulunmasý
        %y1=f(O'1.w11+O'2.w12+.....+O'n.w1n+b1)
        %y2=f(O'1.w21+O'2.w22+.....+O'n.w2n+b2
        for n=1:cikissayisi
            top=0;
            for i=1:noronsayisi
                top=top+o(i)*wp(n,i);
            end
            y(n)=sigmoid(top+bp(n));
            
            
        end
        %%çýkýþ katmaný güncellemesi
        %çýkýþ hata faktörlerinin hesaplanmasý
        %rp1=(tp1-y1).y1.(1-y1)
        
        for i=1:cikissayisi
            rp(i)=(t(i,k)-y(i))*y(i)*(1-y(i));
        end
        %çýkýþ aðýrlýklarýnýn güncellenmesi
        %dw11=n.rp1.o'1+alpha.dw11
        for i=1:cikissayisi
            for j=1:noronsayisi
                dwp(i,j)=n*rp(i)*o(j)+alpha*dwp(i,j);
            end
        end
        wp=wp+dwp;
        %çýkýþ katmaný biaslarýnýn güncellenmesi
        %db1=n*rp1+alpha*db1
        for j=1:cikissayisi
            dbp(j)=n*rp(j)+alpha*dbp(j);
            %%bp(j)=bp(j)+dbp(j);
        end
        bp=bp+dbp;
        %%ara katman güncellemesi
        
        %ara katman hata faktörlerinin hesaplanmasý
        %rpp1=o'1.(1-o'1).(rp1.w11+rp2.w21)
        for i=1:noronsayisi
            rpp(i)=o(i)*(1-o(i))*(rp(1)*w(1)+rp(2)*w(2));
            %for j=1:girissayisi
            %rpp(i)=rpp(i)+rp(j)*w(j);
            %end
        end
        %ara katman aðýrlýklarýnýn güncellenmesi
        for i=1:noronsayisi
            for j=1:girissayisi
                %dw(i,j)=n*o(i)*(1-o(i))*wp(1,i)*rp(1)*x(j,k);
                dw(i,j)=n*rpp(i)*x(j,k)+alpha*dw(i,j);
                %%w(i,j)=w(i,j)+dw(i,j);
                %dw(i,j)=n*o(i)*(1-o(i))*wp(2,j)*rp(2)*x(j,k);
                %w(i,j)=w(i,j)+dw(i,j);
            end
        end
        w=w+dw;
        %ara katman biaslarýnýn güncellemesi
        for i=1:noronsayisi
            %db(i)=n*o(i)*(1-o(i))*wp(1,i)*rp(1);
            db(i)=n*rpp(i)+alpha*db(i);
            %%b(i)=b(i)+db(i);
            %db(i)=n*o(i)*(1-o(i))*wp(2,i)*rp(2);
            %b(i)=b(i)+db(i);
        end
        b=b+db;
     %   for i=1:cikissayisi
   % if y(i)>0.8
    %    y(i)=1;
    %else
     %   y(i)=0;
    %end
     %   end
        hata=(1/2)*((t(1,k)-y(1))^2+((t(2,k)-y(2))^2));
        disp(hata)
        alpha=alpha/(1+s*k);
        n=n/(1+s*k);
    end
    y
    %figure(1)
    %hold on
    %plot(y,'.')
    %plot(t(:,k),'*')
    %hold off
    
%axis([0 2 0 2]);
%axis square,grid;
    hata
    t(:,k)
    
end

%%%TEST Aþamasý
dogru=0;
for k=1:length(test)
    %ara katman çýkýþlarýnýn bulunmasý
for i=1:noronsayisi
    top=0;
    for n=1:girissayisi
        top=top+test(n,k)*w(i,n);
    end
    o(i)=sigmoid(top+b(i));
end
%çýkýþ katmaný çýkýþlarýnýn bulunmasý(testtttt)
for n=1:cikissayisi
    top=0;
    for i=1:noronsayisi
        top=top+o(i)*wp(n,i);
    end
    y(n)=sigmoid(top+bp(n));
    %plot(top+bp(n),y,'r');
end
for i=1:cikissayisi
    if y(i)>0.8
        y(i)=1;
    else
        y(i)=0;
    end
end
if (ttarget(1,k)==y(1))&&(ttarget(2,k)==y(2))
    dogru=dogru+1;
    
end
end

yeee =sprintf('Verilen test verilerine göre aðýn baþarý oraný %f dir',100*dogru/length(test)); 
disp(yeee);
dogru
