[numeros.YFR, names.YFR]=xlsread('Correlations_for_screening_TPE.xlsx','YFR057Wscree','a2:c4194');
[numeros.COS12B, names.COS12B]= xlsread('Correlations_for_screening_TPE.xlsx','COS12scree2','a2:c3717');
[numeros.TPE21, names.TPE21]= xlsread('Correlations_for_screening_TPE.xlsx','listagenes_TPE_2021','a2:b133');
%% Ordenar las listas
clear Y I

[Y I]=sort( numeros.YFR(:,2), 'descend' );
numeros.YFR(:,2)=numeros.YFR(I,2);
names.YFR(:,2)=names.YFR(I,2);



%% Hacer dos indices para relacionar la lista de TPE21 con la lista de YFR y la de COS12B
for i=1:length(names.YFR)
    i
    clf
    genA=names.YFR(i,1);
    campos = fieldnames(names);
    for j = length(campos)
            [A B]=sort(log2(numeros.(str2mat(campos(j)))));
        for k = 1:length(names.(str2mat(campos(j))))
            genB=names.(str2mat(campos(j)))(k);
            if strcmp(genA, genB)
                indicesYFR(i,j)=k;
            end
        end
    end
end
for i=1:length(names.COS12B)
    i
    clf
    genA=names.COS12B(i,1);
    campos = fieldnames(names);
    for j = length(campos)
            [A B]=sort(log2(numeros.(str2mat(campos(j)))));
        for k = 1:length(names.(str2mat(campos(j))))
            genB=names.(str2mat(campos(j)))(k);
            if strcmp(genA, genB)
                indicesCOS12B(i,j)=k;
            end
        end
    end
end

%% hacer gráficas de barras por cuantiles
figure(33); clf;
subplot(1,2,1)
[decilesC, ndecilesC, pvalsC, cualesC] = GraphDecileBars(indicesCOS12B, names.COS12B);
title('TPE21 en COS12B')

subplot(1,2,2)
[decilesY, ndecilesY, pvalsY, cualesY] = GraphDecileBars(indicesYFR, names.YFR);
title('TPE21 en YFR')

%%
figure(11);clf;
subplot(2,1,1)
valores=log2(numeros.COS12B(:,2));
msize=1.3;
PlotDistBubbles(valores, msize, decilesC, ndecilesC, pvalsC);
title('TPE21 en COS12B')

subplot(2,1,2)
valores=log2(numeros.YFR(:,2));
msize=1.3;
PlotDistBubbles(valores, msize, decilesY, ndecilesY, pvalsY);
title('TPE21 en YFR')


set(gcf,'Units','centimeters','PaperUnits','centimeters')
set(gcf,'PaperPositionMode','auto')
set(gcf,'Position',[1 1 20 10])
print(gcf,'-depsc','Fig3F_DecileBubbles_YFRyCOS12.eps')

%% ESTO NO ES PARA LA FIGURA DEL ARTÍCULO, ES PARA CORRER TODO EL SHOW CON LA NUEVA LISTA
clear numeros names
[numeros.YFR, names.YFR]=xlsread('Correlations_for_screening_TPE.xlsx','YFR057Wscree','a2:c4194');
[numeros.COS12A names.COS12A]= xlsread('Correlations_for_screening_TPE.xlsx','COS12scree1','a2:c3727');
[numeros.COS12B, names.COS12B]= xlsread('Correlations_for_screening_TPE.xlsx','COS12scree2','a2:c3717');
[numeros.Telshort names.Telshort]= xlsread('Correlations_for_screening_TPE.xlsx','Telomere-long','a2:c53');
[numeros.Telarge names.Telarge]= xlsread('Correlations_for_screening_TPE.xlsx','Telomere-short','a2:c11');
[numeros.Telshort names.Telshort]= xlsread('Correlations_for_screening_TPE.xlsx','Telomere-long','a2:c53');
[numeros.Telength names.Telength]= xlsread('Correlations_for_screening_TPE.xlsx','Telomere-length','a2:c173');
[numeros.lifespan names.lifespan]= xlsread('Correlations_for_screening_TPE.xlsx','LifespanGaray','a2:i3879');
[numeros.TPE names.TPE]= xlsread('Correlations_for_screening_TPE.xlsx','TPE-reported','a2:b164');
[numeros.TPEdecrease names.TPEdecrease]= xlsread('Correlations_for_screening_TPE.xlsx','Lista_curada_decrease_TPE','a2:b66');
[numeros.TPEincrease names.TPEincrease]= xlsread('Correlations_for_screening_TPE.xlsx','Lista_curada_increase_TPE','a2:b29');
[numeros.CincoPCT names.CincoPCT]= xlsread('Correlations_for_screening_TPE.xlsx','5percent_combinado','a2:b345');
[numeros.TresPCT names.TresPCT]= xlsread('Correlations_for_screening_TPE.xlsx','3percent_combined','a2:b210');
[numeros.TPECurated names.TPECurated]= xlsread('ListaLiteraturaAffectingTPE.xlsx','B3:B93');
[numeros.TPE21, names.TPE21]= xlsread('Correlations_for_screening_TPE.xlsx','listagenes_TPE_2021','a2:b133');

%% Ordenar todos los datos numéricos con sort
campos=fieldnames(names);
for X=1:length(campos)
    CampoToCompute = campos(X);
    if X<8
        if X<4
            columna=2;
        else 
            columna=1;
        end
        [Y I]=sort( numeros.(str2mat(CampoToCompute))(:,columna), 'descend');
        numeros.(str2mat(CampoToCompute))=numeros.(str2mat(CampoToCompute))(I,columna);
        names.(str2mat(CampoToCompute))=names.(str2mat(CampoToCompute))(I,1);
    end
end

%% Esta no se necesita para las figugenera los quantiles con respecto a Todos los campos!!
campos=fieldnames(names);
clear valores quantiles
for X=1:length(campos)
 CampoToCompute = campos(X)
  for i=1:length(names.(str2mat(CampoToCompute)) )
    genA=names.(str2mat(CampoToCompute))(i,1);
    campos = fieldnames(names);
    for j = 1:length(campos)
            [A B]=sort(numeros.(str2mat(campos(j))));
        for k = 1:length(names.(str2mat(campos(j))))
            genB=names.(str2mat(campos(j)))(k);
            if strcmp(genA, genB)
                if j>7% == 5 || j>6 % estas son las que tienen un valor cualitativo, les pone 1 o 0
                    valores.(str2mat(CampoToCompute))(i,j)=1;
                    quantiles.(str2mat(CampoToCompute))(i,j)=1;
                else
                    valores.(str2mat(CampoToCompute))(i,j)=numeros.(str2mat(campos(j)))((k));
                    quantiles.(str2mat(CampoToCompute))(i,j)=1-k/length(A(:,1));
                end
                break;
            end
        end
    end
    i
  end
end

%% Bar PLOTS (SE PUEDE CORRER DESPUÉS DE TODO LO ANTERIOR O DESPUES DE 
%load 210706_AllComparisons.mat.mat
for X=length(campos)%[1:4 5 6:12] %1:length(campos)%  Telarge no estuvo en 2, creo que en Cinco y tres PCT
CampoToCompute = campos(X);
clear interseccion pvals
fctr = 1;
figure(X+130)
clf
con=0;
for numCampo = 1:7
    
    quants=quantiles.(str2mat(CampoToCompute));
    con=con+1;
    subplot(2,4,con)


    popSize=length((numeros.(str2mat(campos(numCampo)))));%4193;
    tenPrcnt=floor(popSize/(10*fctr));
    sampleSize=length(find( quants(:,numCampo) ));
    meanAzar=hygestat(popSize,tenPrcnt, sampleSize );
	plot([0 i+.8], [meanAzar meanAzar], '-','color',[.7 .7 .7])
    hold on
    for i=1:10*fctr
        uno=find(quants(:,numCampo)>(i-1)*.1/fctr);
        dos=find(quants(:,numCampo)<(i)*.1/fctr);
        interseccion(i) = length(intersect(uno,dos));
        pvals(i)=1-hygecdf(interseccion(i), popSize,tenPrcnt, sampleSize);
        cualesintersecion(i, 1:interseccion(i))=intersect(uno,dos)
    end
    fdrs=mafdr(pvals,'BHFDR','true');
	bar(interseccion,'w');
	for i=1:10*fctr
        if pvals(i)<.05
            %text(i-.3, interseccion(i)+1, mat2str(pvals(i)),'Rotation', 90,'FontSize',8)
            %text(i+.3,  interseccion(i)+1, mat2str(fdrs(i)),'Rotation', 90,'FontSize',8)
            text(i-.2, .25, mat2str(pvals(i)),'Rotation', 90,'FontSize',8)
            text(i+.2, .25, mat2str(fdrs(i)),'Rotation', 90,'FontSize',7)
            plot(2,interseccion(i)+5)
            for x=1:interseccion(i)
            %    text( i-.29,x-.65,names.(str2mat(CampoToCompute))(cualesintersecion(i,x),2), 'fontsize',7 )
            end
        end
        hold on
    end
    ylabel(strcat('hygecdf interseccion=',num2str(interseccion(i)), '  PopSize= ', num2str(popSize),'  tenPrcnt=',num2str(tenPrcnt), '  SampleSize=',num2str(sampleSize)))
    ylabel(strcat('exp=',num2str(interseccion(i)), ' n_p_o_p= ', num2str(popSize),'  10%=',num2str(tenPrcnt), '  n_s_a_m_p_l_e=',num2str(sampleSize)))

    hold on
    xlabel(strcat('quantiles.  n= ',num2str(sum(interseccion) )))
    xlim([0 i+.8])
    title(strcat('Posiciones de:', CampoToCompute, ' en:', campos(numCampo) )) 
end
end






