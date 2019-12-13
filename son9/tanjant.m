function [y]=tanjant (x)
    for i=1:length(x)
        y(i)=(exp(x(i))+exp(-x(i)))/(exp(x(i))-exp(-x(i)));
  %       if y(i)>0.5
   %          y(i)=1;
    %     else y(i)=0;
     %    end
    end    
end

