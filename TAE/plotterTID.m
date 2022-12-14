close all

year=2020:2031;
year_str=num2cell(year);

for i=1:length(year_str)
    data=load('./data/dose'+string(year_str{i})+'.dos');
    if i==1
        al_mm=data(:,1);
        TID_year=data(:,end);
    else
        TID_year=[TID_year,data(:,end)];
        al_mm=[al_mm,data(:,1)];
        
    end    
end
for i=2:70
   year=[year;2020:2031]; 
end
% 
% [xi, yi] = meshgrid(year,al_mm);
% F = scatteredInterpolant(year,al_mm,TID_year);
% zi = F(xi,yi);
% surf(xi,yi,zi, 'EdgeAlpha', 0)
% hold on
figure(1)
plot3(al_mm,year,TID_year/1e3,'LineWidth',3)
set(gca,'zscale','log')
xlabel('mm Aluminum','FontWeight','bold')
ylabel('Year','FontWeight','bold')
zlabel('Total Ionizing Dose (krad)','FontWeight','bold')
grid minor
title ('TID influence over the 25th solar cycle (2020-2031)','FontSize',12,'FontWeight','bold')

figure(2)
difference_year=[0,diff(TID_year(11,:))];
plot(year(1,:),difference_year,'LineWidth',3);
grid minor
title('TID @1mm of Aluminium variation over the 25th solar cycle','FontWeight','bold')
xlabel('Year')
ylabel('TID (rads)')

TID_threeY=load('./data/dose3years.dos');

figure(3)
plot(al_mm(:,1),TID_year(:,4)/1e3,'LineWidth',3)
hold on
plot(al_mm(:,1),TID_threeY(:,end)/1e3,'LineWidth',3)
set(gca, 'YScale', 'log')
plot([0 0]+1, ylim, 'LineStyle','--','LineWidth',2,'Color','Black')
title('TID dose in polar orbit','FontWeight','bold')
xlabel('mm Aluminium')
ylabel('TID (krad)')
grid minor
legend('1 Year', '3 Years')
hold off


