function [y]=sigmoid (x)
    for i=1:length(x)
        y(i)=1/(1+exp(-x(i)));
        %figure(1)
        %hold on
       %plot(x(i),y(i));
  %       if y(i)>0.5
   %          y(i)=1;
    %     else y(i)=0;
     %    end
    end    
end

