function total = calories()
i = 1;
total = 0;

% Looking through the data and looking at speeds to calculate calories
% burned
while i < length(speed)
    if (speed(i) < 1.8)
        met = 3.5;
        s = (time(i+1) - time(i))/60;
    elseif (speed(i) >= 1.8 & speed(i) < 2.2)
        met = 6;
        s = (time(i+1) - time(i))/60;
    elseif (speed(i) >= 2.2 & speed(i) < 3.6)
        met=8;
        s = (time(i+1) - time(i))/60;
    elseif (speed(i) >=3.6 & speed(i) < 4.5)
        met = 16;
        s = (time(i+1) - time(i))/60;
    else
        met = 18;
        s = (time(i+1) - time(i))/60;
    end
    total = total + (s * (met * 3.5 * weight)/ 200);
    i = i + 1;
end
end