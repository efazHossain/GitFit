figure;
plot(t,Xacc);
hold on;
plot(t,Yacc);
plot(t,Zacc);
xlim([0 50])
legend('X Acceleration', 'Y Acceleration', 'Z Acceleration');
xlabel('Time (secs)')
ylabel('Acceleration (m/s^2)');
title('Acceleration Data Vs. Time');
hold off