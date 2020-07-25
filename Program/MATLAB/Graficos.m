clear all
close all
clc

%Open file
M = dlmread('DATALOG.TXT');
%---------

%Create an array for each day
Dia1 = M(M(:,3)==1,:);
Dia2  = M(M(:,3)==2,:);
Dia3  = M(M(:,3)==3,:);
Dia4  = M(M(:,3)==4,:);
Dia5  = M(M(:,3)==5,:);
Dia6  = M(M(:,3)==6,:);
Dia7  = M(M(:,3)==7,:);
Dia8  = M(M(:,3)==8,:);
Dia9  = M(M(:,3)==9,:);
Dia10  = M(M(:,3)==10,:);
Dia11  = M(M(:,3)==11,:);
Dia12  = M(M(:,3)==12,:);
Dia13  = M(M(:,3)==13,:);
Dia14  = M(M(:,3)==14,:);
Dia15  = M(M(:,3)==15,:);
Dia16  = M(M(:,3)==16,:);
Dia17  = M(M(:,3)==17,:);
Dia18  = M(M(:,3)==18,:);
Dia19  = M(M(:,3)==19,:);
Dia20  = M(M(:,3)==20,:);
Dia21  = M(M(:,3)==21,:);
Dia22  = M(M(:,3)==22,:);
Dia23  = M(M(:,3)==23,:);
Dia24  = M(M(:,3)==24,:);
Dia25  = M(M(:,3)==25,:);
Dia26  = M(M(:,3)==26,:);
Dia27  = M(M(:,3)==27,:);
Dia28  = M(M(:,3)==28,:);
Dia29  = M(M(:,3)==29,:);
Dia30  = M(M(:,3)==30,:);
Dia31  = M(M(:,3)==31,:);
%-------------------------

%Remove empty arrays
a=who; 
for var=1:length(a)
   b=eval([a{var}]);
   if isempty(b)
       eval(['clear ' a{var} ';'])
   end
end
clear a b
%-------------------

%Plot all temperatures
fig = figure;
hax = axes;
hold on
T1 = plot(1:length(M),M(:,7));
T2 = plot(1:length(M),M(:,8));
T3 = plot(1:length(M),M(:,9));
T4 = plot(1:length(M),M(:,10));
T5 = plot(1:length(M),M(:,11));
A = M(:,6)';
A([false, all([A(1:end-2); A(3:end)] == 1), false]) = 0;   %replace any value between two 1s by a 0
SP = find(A');
for i=1:2:length(SP)
    line([SP(i) SP(i)],get(hax,'YLim'),'Color',[0 1 0],'LineWidth',1.5);
end
for i=2:2:length(SP)
    line([SP(i) SP(i)],get(hax,'YLim'),'Color',[1 0 0],'LineWidth',1.5);
end
title('Histórico Temperaturas');
legend('T1','T2','T3','T4','T5');
ylabel('Temp (ºC)');
xlabel('Time (Min)');
%----------------------