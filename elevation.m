%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Week#13 Homework
%% 우주궤도역학(001)
%% 18012618 김기현
%% Elevation angle calculator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [el] = elevation(ENU,el_mask)

n = size(ENU,1);
el = zeros(1,n);

    for i = 1 : num
    
        E = ENU(i,1);
        N = ENU(i,2);
        U = ENU(i,3);
    
        el(1,i) = rad2deg(atan2(U,sqrt(E^2+N^2)));
    
        if(el(1,i) <= el_mask)
            
            el(1,i) = NaN;
            
        end
    end
end