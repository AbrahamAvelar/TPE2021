function [deciles, ndeciles, pvals, cuales] = GraphDecileBars(indices, names,sigpval) 
if nargin<3
    sigpval=.05;
end
popSize=length(indices);%4193;
tenPrcnt=popSize/(10);
sampleSize=length(find(indices(:,3)));
meanAzar=hygestat(popSize,floor(tenPrcnt),sampleSize);
plot([0 10.8], [meanAzar meanAzar], '-','color',[.7 .7 .7]); hold on
deciles(1)=0;
nums=find(indices(:,3));

for i = 1:10 % calcular los boundaries de los 10porcientos
    deciles(i+1)= i*(length(indices)/10);
    ndeciles(i)=sum(find(indices(:,3))>deciles(i) & find(indices(:,3))<deciles(i+1));
    pvals(i)=1-hygecdf(ndeciles(i), popSize,floor(tenPrcnt), sampleSize);
    cuales(i).names=nums(find(indices(:,3))>deciles(i) & find(indices(:,3))<deciles(i+1));
end
bar(ndeciles,'w')
for i = 1:10
    for j=1:ndeciles(i)
        text(i-.4,j*(ndeciles(i)-1)/ndeciles(i), names(cuales(i).names(j),2), 'FontSize',7 )
    end
    if pvals(i)<sigpval
        text(i-.2,ndeciles(i)+.1, num2str(pvals(i)), 'FontSize', 8, 'Rotation', 90 )
    end
end

xlabel("deciles")
ylabel(strcat("popsize:", num2str(popSize), ".  meanAzar:", num2str(meanAzar), ".   n=", num2str(sampleSize) ) )
xlim([.2 10.7])