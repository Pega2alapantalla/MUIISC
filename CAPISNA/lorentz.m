close all
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
    figure (1)
    plot(tiemposim,results(:,i*3+1));
    hold on
    
    
    
    figure (2)
    plot(tiemposim,results(:,i*3+2));
    hold on
    
    
    
    figure (3)
    plot(tiemposim,results(:,i*3+3));
    hold on
    
    figure(4)
    plot3(results(:,i*3+1),results(:,i*3+2),results(:,i*3+3))
    hold on
end

figure (1)
    grid minor
    title('Respuesta de x1')
    ylabel('x1')
    xlabel('tiempo (seg)')
figure (2)
    grid minor
    title('Respuesta de x2')
    ylabel('x2')
    xlabel('tiempo (seg)')
figure (3)
    grid minor
    title('Respuesta de x3')
    ylabel('x3')    
    xlabel('tiempo (seg)')
figure (4)
    grid minor
    title('Antifaz de Lorentz')
    xlabel('x1')
    ylabel('x2')
    zlabel('x3')