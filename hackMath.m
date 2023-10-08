clear
clc
%loading data
load('sitting.mat');
load('walking.mat');
load('running.mat');

Xacc = Acceleration.X;
Yacc = Acceleration.Y;
Zacc = Acceleration.Z;
aDC =Acceleration.Timestamp;
t = timeElapsed(aDC);

%Processing Data
posVar = Position.Variables;
latData = Position.latitude;
longData = Position.longitude;
posTime = Position.Timestamp;
posTime = timeElapsed(posTime);

%Developing Model
earthCircumference = 24901;
totalDistance = 0;
for i=1: (length(latData)-1)
    lat1 = latData(i);
    lat2 = latData(i+1);
    lon1 = longData(i);
    lon2 = longData(i+1);
    difference = distance(lat1,lon1,lat2,lon2);
    dis = (difference/360)* earthCircumference;
    totalDistance = totalDistance+dis;
end

%since the average stride of a man is 31 inches, convert to ft
avgStride = 2.58;
totalDist_feet = totalDistance*5280;
steps_taken = totalDist_feet/avgStride;

%Visualization
%Classifying the data obtained
sit = load('sitting.mat');
walk = load('walking.mat');
run = load('running.mat');
Log = [sit,walk,run];

sitAccel = sit.Acceleration;
sitLabel = 'sitting';
sitLabel = repmat(sitLabel, size(sitAccel,1),1);
sitAccel.Log = sitLabel

walkAccel = walk.Acceleration;
walkLabel = 'walking';
walkLabel = repmat(walkLabel, size(walkAccel,1),1);
walkAccel.Log = walkLabel

runAccel = run.Acceleration;
runLabel = 'running';
runLabel = repmat(runLabel, size(runAccel,1),1);
runAccel.Log = runLabel

modelAccel = [sitAccel ; walkAccel ; runAccel];
modelAccel = timetable2table(modelAccel,"ConvertRowTimes",false)

%ML Model training
classificationLearner
test = load("test.mat");
testAccel = test.Acceleration;
testAccel;

testOnlyAccel = timetable2table(testAccel,"ConvertRowTimes",false);
yfit = trainedModel.predictFcn(testOnlyAccel);

%Plots
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
