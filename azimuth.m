%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Week#13 Homework
%% 우주궤도역학(001)
%% 18012618 김기현
%% Azimuth angle calculator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [az] = azimuth(ENU)

n = size(ENU,1);
az = zeros(1,n);

    for i = 1 : n
    
        E = ENU(i,1);
        N = ENU(i,2);
        U = ENU(i,3);
        
        az(1,i) = rad2deg(atan2(E,N));
    
        if(az(1,i) <= 0)
            
            az(1,i) = az(1,i) + 360;
            
        end
    end
end