clc
clear
%%%410
clear
new1=csvread('H:\�����ƶ����ݻָ�\fiber data analysis update\c127 kcnq 410.csv');%%%导入410数据--填写相应的数据路�?
[m,n]=size(new1);
new=new1(1:m,1);
x=reshape(new,1,m)
lambda=5000000000;
[xbc,xb]=airPLS(x, lambda,2,0.05);
figure(1)
plot(x,'r')
hold on
plot(xbc,'g')
plot(xb,'k')
rr=reshape(xbc,m,1)
%%%488
new2=csvread('H:\�����ƶ����ݻָ�\fiber data analysis update\c127 kcnq 470.csv');%%%导入488数据--填写相应的数据路�?
[mm,nn]=size(new2);
neww=new2(1:mm,1);
x1=reshape(neww,1,mm)
[xbcc,xxb]=airPLS(x1, lambda,2,0.05);
figure(2)
plot(x1,'r')
hold on
plot(xbcc,'g')
plot(xxb,'k')
ss=reshape(xbcc,mm,1);
reference=rr(1:min(m,mm),:);
signal=ss(1:min(m,mm),:);
rsignal=(signal-reference) ./ reference;
[m,n]=size(rsignal);
iti = 30;%%%trial与trial的间隔时�?
stimu = 10;%%%给声音的时间
fs = 50;%%%频率
pre = 5;%%%刺激（如电击的前5秒）
post = 20;%%% 刺激（如电击的后20秒）
x=1/fs:1/fs:m/ fs;
startpoint = 100;%%%第一次给电击的时�?
fig1 = figure('name','Fiber_Photometry','numbertitle','off');
plot(x,rsignal,'color',[0.81,0.44,0.27]);
set(gca,'linewidth',2,'Fontname', 'Arial','fontsize',13,'FontWeight','bold','box','off');
xlabel('Time (s)','fontsize',14);ylabel(('Fluorescence intensity '),'fontsize',14);
% Find Event
for trial = 1:3 %%%行为中包含的总trial数，这里做的AFC，共三个trial，故冒号后数字为3
    event(trial) = (startpoint+(trial-1)*(stimu+iti))*fs;
end

for trial = 1:length(event)
    fiber(trial,:) = rsignal(event(trial)-pre*fs+1:event(trial)+post*fs);
end

fiber = (fiber-abs(mean(fiber(:,1:pre*fs),2)))./abs(mean(fiber(:,1:pre*fs),2));

fig1 = figure('name','Fiber_Photometry','numbertitle','off');
set(gcf,'unit','centimeters','PaperUnits','centimeters','PaperPosition',[0,0,20,15],'color','w','PaperSize',[20,15]);
plot_shadow(-pre+1/fs:1/fs:post,mean(fiber,1),sem(fiber,1));
set(gca,'linewidth',2,'Fontname', 'Arial','fontsize',13,'FontWeight','bold','box','off');
title('AFC-training','fontname','Times New Roman','Color','k','linewidth',5,'FontWeight','bold');
xlabel('Time(s)','fontsize',14,'FontWeight','bold');ylabel(('ΔF/F(%)'),'fontsize',14,'FontWeight','bold');%%%这里给figure的title是AFC-training，此处内容可根据users的需求自定义
% hold on
% h1=fill([0,10,10,0],[-10,-10,10,10],[0.5,0.5,0.5],'EdgeColor','none')
% %%%tone的时间区间，即其中第�?个�?�[]”里是x轴坐标位置（�?10s的声音），第二个“[]”里是y轴的坐标位置（整个时间段的amplitude为[-10,10]�?
% alpha(h1,0.1)
% h2=fill([10,11,11,10],[-10,-10,10,10],'r','EdgeColor','none')%%%shock的时间区间，这里是给1s的声音，数�?�含义同�?
% alpha(h2,0.1)
% hold off