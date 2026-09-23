clear; close all; clc;

%meas 1열: sepal length
%meas 2열: sepal width
%meas 3열: petal length
%meas 4열: petal width
%species: 꽃 종류

load fisheriris;

%%특징 그려보기(sepal length, width)
figure;
plot(meas(:,1), meas(:,2), 'k.');
xlabel('Sepal length');
ylabel('Sepal width');

%%각 종을 숫자로 표현 1: Setosa 2: versicolor, 3. virginica
spcs2num=[];
for k=1:1:length(species)
    if strcmp(species(k), 'setosa')==1
        spcs2num(k,1)=1;
    elseif strcmp(species(k), 'versicolor')==1
        spcs2num(k,1)=2;
    elseif strcmp(species(k), 'virginica')==1
        spcs2num(k,1)=3;
    end
end    

%%종별로 다른 색 그려보기
idx1=find(spcs2num==1); %setosa만 찾기
idx2=find(spcs2num==2); %versicolor만 찾기
idx3=find(spcs2num==3); %virginica만 찾기

figure;
plot(meas(idx1,1), meas(idx1,2),'r.'); hold on; %setosa는 빨간색으로
plot(meas(idx2,3), meas(idx2,4), 'go'); hold on; %versicolor는 녹색으로
plot(meas(idx3,3), meas(idx3,4), 'bx'); hold on; %virginica는 파란색으로

%%학습데이터와 평가데이터 나누기
%두개의 그룹만 먼저 나눠봅시다 versicolor vs. viginica
%오늘은 편의상 아래와 같이 나누겠음
%1~50: setosa, 51~100: versicolor, 101~150: virginica
%학습데이터. 71~100:versicolor, 121~150: virginica 총 60개
%평가데이터. 51~70: versicolor, 101~120: virginica 총 40개
tr_id=[71:1:100 121:1:150];
Training_data=meas(tr_id,:);
Training_label=spcs2num(tr_id,:);

ts_id=[51:1:70 101:1:120];
Test_data=meas(ts_id,:);
Test_label=spcs2num(ts_id, :);