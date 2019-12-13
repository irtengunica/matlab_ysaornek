function [y]=sinus (x)
    for i=1:length(x)
        y(i)=sin(-x(i));
  %       if y(i)>0.5
   %          y(i)=1;
    %     else y(i)=0;
     %    end
    end    
end

