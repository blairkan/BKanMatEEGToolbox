function plotElgarLines(blah)
load colors.mat
yyl = get(gca, 'ylim')
yymin = yyl(1); yymax = yyl(2);
xx = [1*60+23 2*60+7 2*60+31 3*60+19 6*60+15 6*60+39 7*60+2];

ccolors = [19 14 13 0 19 14 13];
tt = {'A1', 'B1', 'C1', 'D', 'A2', 'B2', 'C2'};

for i = 1:length(ccolors)
    if ccolors(i)==0
        currCol = [0 0 0];
    else
        currCol = rgb20(ccolors(i),:);
    end
   plot([xx(i) xx(i)], [yymin yymax], '--', 'linewidth', 3,... 
       'color', currCol)
   if blah
      text(xx(i), yymax*1.35, tt{i}, 'fontweight', 'bold',...
          'horizontalalignment', 'center', 'fontsize', 14)
   end
    
    
end