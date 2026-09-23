%% 특징 4개를 모두 사용하여, 3개 종을 분류
clear; close all; clc; 

load fisheriris;

spcs2num = [];
for k=1:1:length(species)
    if strcmp(species(k), 'setosa') == 1
        spcs2num(k,1) = 1;
    elseif strcmp(species(k), 'versicolor') == 1
        spcs2num(k,1) = 2;
    elseif strcmp(species(k), 'virginica') == 1
        spcs2num(k,1) = 3;
    end
end

tr_id = [21:1:50 71:1:100 121:1:150];
Training_data = meas(tr_id, :); % sepal length/width, petal length/width 모두 가져오기
Training_label = spcs2num(tr_id,:);

ts_id = [1:1:20 51:1:70 101:1:120];
Test_data = meas(ts_id, :);  % sepal length/width, petal length/width 모두 가져오기
Test_label = spcs2num(ts_id,:);

%%
k = 5;
final_group = [];
for id = 1:1:length(Test_label)
    tmp_data = Test_data(id,:); % 평가해보고 싶은 데이터 가져오기 
    
    % 학습 데이터와 평가해보고 싶은 데이터 간의 거리를 계산
    u_dis = [];
    for i=1:1:length(Training_label)
        u_dis(i,1) = sqrt( sum( (Training_data(i,:) - tmp_data).^2 ) );
    end
    
    % 가장 인접한 k개를 찾는다
    [s_v, s_i] = sort(u_dis, 'ascend');
    k_idx = s_i(1:k);
    
    % 해당 k개의 데이터가 어떤 그룹에 속해있는지 확인
    k_group = Training_label(k_idx,1);
    final_group(id,1) = mode(k_group);
end

figure;
subplot(311); bar(Test_label); axis tight;
subplot(312); bar(final_group); axis tight;
subplot(313); bar(Test_label - final_group); axis tight;


mdl = fitcknn(Training_data, Training_label, 'NumNeighbors', k, 'Distance', 'euclidean');
mat_res = predict(mdl, Test_data);

figure;
subplot(311); bar(Test_label); axis tight; 
subplot(312); bar(final_group); axis tight;
subplot(313); bar(mat_res); axis tight; 
