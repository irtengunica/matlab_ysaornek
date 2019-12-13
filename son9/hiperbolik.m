function [y]=hiperbolik (x)
    for i=1:length(x)
        y(i)=(1-exp(-2*x(i)))/(1+exp(-2*x(i)));
  %       if y(i)>0.5
   %          y(i)=1;
    %     else y(i)=0;
     %    end
    end    
end

