sigma=10;
beta=8/3;
rho=28;

init1=10;
init2=-10;
init3=10;

for i=0:0.01:0.05
    init1=10-i;
    init2=-10-i;
    init3=10-i;  
    [tiemposim,resultados]=sim("lorentzsimu.slx");
    
    if i==0
        results=resultados;
    else
    
    results=[results(:,:),resultados(:,:)];
    end
end  

sizeresultados=size(results);
for i=0:sizeresultados(2)/3-1
    plot(tiemposim,results(:,i*3+1));
    hold on
    
end
