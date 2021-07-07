function [] = PlotDistBubbles(valores, msize, deciles, ndeciles, pvals)

deciles=floor(deciles);
plot(flip(valores),'-','color',[.79 .57 .79])
hold on
for i = 1:10 % calcular los boundaries de los 10porcientos
	plot([deciles(i+1) deciles(i+1)],[-1 1], ":", 'color', [.8 .8 .8])
    if i==1
        tobubble(i)=mean(valores(1:deciles(i+1)));
    else
        tobubble(i)=mean(valores(deciles(i):deciles(i+1)));
    end
    if pvals(i)<.05
        plot(deciles(11-i)+deciles(2)/2, tobubble(i), 'o', 'color', [.6 .7 .9], 'MarkerSize', msize*ndeciles(i),'Markerfacecolor', [.5 .5 .5])
        %rectangle([deciles(i)+deciles(2)/2,tobubble(i), msize*ndeciles(i), msize*ndeciles(i)],'curvature', [1 1], 'facecolor', [1 .5 .5])
        %circle(deciles(i)+deciles(2)/2,tobubble(i),msize*ndeciles(i))
    else
        plot(deciles(11-i)+deciles(2)/2, tobubble(i), 'o', 'color', [.6 .7 .9], 'MarkerSize', msize*ndeciles(i))
        %rectangle([deciles(i)+deciles(2)/2,tobubble(i), msize*ndeciles(i), msize*ndeciles(i)], [1 1], 'facecolor', [.5 .5 .5])
        %circle(deciles(i)+deciles(2)/2,tobubble(i),msize*ndeciles(i))
    end
end
ylim([-.3 .35])
xlim([-15 length(valores)+15])
ylabel('SI score ratio')
xlabel('deciles')
set(gca, 'xtick',deciles+deciles(2)/2,'xticklabel',num2cell(11-(1:10))  )
end

function circle(x,y,r)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp);
end