close all


year=2020:2031;
year_str=num2cell(year);

for i=1:length(year_str)
    data=load('./data/LET'+string(year_str{i})+'.let');
    if i==1
        LET_level=data(:,1);
        Flux_year=data(:,2);
    else
        Flux_year=[Flux_year,data(:,2)];
        LET_level=[LET_level,data(:,1)];
        
    end    
end
for i=2:1000
   year=[year;2020:2031]; 
end
% 
% [xi, yi] = meshgrid(year,al_mm);
% F = scatteredInterpolant(year,al_mm,TID_year);
% zi = F(xi,yi);
% surf(xi,yi,zi, 'EdgeAlpha', 0)
% hold on
figure(1)
plot3(LET_level/1e3,year,Flux_year,'LineWidth',3)
set(gca,'zscale','log')
set(gca,'xscale','log')
xlabel('LET level (MeV*cm^2/mg)','FontWeight','bold')
xlim([1 100])
ylabel('Year','FontWeight','bold')
zlabel('Flux (cm^2/s)','FontWeight','bold')
grid minor
title ('TID influence over the 25th solar cycle (2020-2031)','FontSize',12,'FontWeight','bold')



i1=find(LET_level>1e3);
i15=find(LET_level>15e3);
i30=find(LET_level>30e3);
i60=find(LET_level>60e3);
i100=find(LET_level>1e5);

figure(2)
plot(year(1,:),Flux_year(i1(1),:)/Flux_year(i1(1),1),'LineWidth',3);
hold on
plot(year(1,:),Flux_year(i15(1),:)/Flux_year(i15(1),1),'LineWidth',3);

plot(year(1,:),Flux_year(i30(1),:)/Flux_year(i30(1),1),'LineWidth',3);

plot(year(1,:),Flux_year(i60(1),:)/Flux_year(i60(1),1),'LineWidth',3);

plot(year(1,:),Flux_year(i100(1),:)/Flux_year(i100(1),1),'LineWidth',3);
grid minor
title('Flux variation at different LET levels over the 25th solar cycle','FontWeight','bold')
xlabel('Year')
ylabel('Flux (cm^2/s)')
legend('1 MeV*cm2/mg','15 MeV*cm2/mg','30 MeV*cm2/mg','60 MeV*cm2/mg','100 MeV*cm2/mg' )


LET_oneyear=load('./data/LET1year.let');

LET_threeyear=load('./data/LET3year.let');

figure(3)
plot(LET_oneyear(:,1)/1e3,LET_oneyear(:,2),'LineWidth',2)
hold on
plot(LET_threeyear(:,1)/1e3,LET_threeyear(:,2),'LineWidth',2)
grid minor
set(gca,'yscale','log')
title('Estimated LET spectra in UCAnFly mission for different mission durations','FontSize',12)
xlabel('LET (MeV*cm2/mg)')
legend('One year','Three years')
xlim([1 100])
ylabel('Flux (cm^2/s)')
% TID_threeY=load('./data/dose3years.dos');
% 
% figure(3)
% plot(LET_level(:,1),Flux_year(:,4)/1e3,'LineWidth',3)
% hold on
% plot(LET_level(:,1),TID_threeY(:,end)/1e3,'LineWidth',3)
% set(gca, 'YScale', 'log')
% plot([0 0]+1, ylim, 'LineStyle','--','LineWidth',2,'Color','Black')
% title('TID dose in polar orbit','FontWeight','bold')
% xlabel('mm Aluminium')
% ylabel('TID (krad)')
% grid minor
% legend('1 Year', '3 Years')
% hold off
