function [true_anomaly1] = orbitp2anomaly(semi_major_axis, eccentricity, M_0, t_init, t_last)

a = semi_major_axis;
e = eccentricity;
flightime = t_last - t_init;
flightime.Format = 's';
t = seconds(flightime);
mu = 3.986004418*10^5;

M_1(1) = M_0;

for i = 1:1:t
    
    M_1(i+1) = i * sqrt(mu/a^3) + M_0;
    
    fun = @(E) - M_1(i) + E - e*sin(E);
    
    x = M_1(i);
    
    E_1(i) = fzero(fun, x);
    
end

E_1 = E_1';

true_anomaly1 = atan2(sqrt(1-e^2) * sin(E_1(:,1)) ./ (1 - e * cos(E_1(:,1))), (cos(E_1(:,1)) - e) ./ (1 - e * cos(E_1(:,1))));

end