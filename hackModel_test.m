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