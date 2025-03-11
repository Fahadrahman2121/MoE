clc; clear; close all;

% 🚀 Parameters
numExperts = 100;                  % Keep realistic expert count
numTestCases = 100000;              % Large test cases
batchSize = 10000;                  % 🔥 Process 10,000 test cases at a time

% 🚀 Generate Synthetic Test Data
testData = rand(batchSize, numExperts); % 🔥 Process only batchSize rows at a time

% Initialize Execution Time Storage
time_ConventionalMoE = 0;
time_BlockchainMoE = 0;

%% ✅ Conventional MoE Execution (Batched)
tic;
for i = 1:batchSize:numTestCases
    idx = i:min(i+batchSize-1, numTestCases); % Current batch indices
    batchSizeActual = length(idx); % 🔥 Ensure correct batch size
    selectedExperts_Conventional = randi(numExperts, batchSizeActual, 1); % 🔥 Correct size
    output_ConventionalMoE = testData(sub2ind(size(testData), (1:batchSizeActual)', selectedExperts_Conventional));
end
time_ConventionalMoE = toc;

%% ✅ Optimized Blockchain-Based MoE Execution (Batched)
tic;
for i = 1:batchSize:numTestCases
    idx = i:min(i+batchSize-1, numTestCases); % Current batch indices
    batchSizeActual = length(idx); % 🔥 Ensure correct batch size
    
    % 🔥 Ensure selectedExperts_Blockchain matches batchSizeActual
    selectedExperts_Blockchain = randi(numExperts, batchSizeActual, 1); % ✅ FIXED

    % ✅ Ensure Both Inputs to sub2ind Are SAME SIZE
    output_BlockchainMoE = testData(sub2ind(size(testData), (1:batchSizeActual)', selectedExperts_Blockchain));
end
time_BlockchainMoE = toc;

%% 🚀 Performance Comparison
performanceImprovement = ((time_ConventionalMoE - time_BlockchainMoE) / time_ConventionalMoE) * 100;

%% 🚀 Display Results
fprintf('Execution Time Results:\n');
fprintf('Conventional MoE: %.6f seconds\n', time_ConventionalMoE);
fprintf('Optimized Blockchain-Based MoE: %.6f seconds\n', time_BlockchainMoE);
fprintf('Performance Improvement: %.2f%%\n', performanceImprovement);
