function plot_shadow(x,y,error)
% plot_shadow(x,y,error,color): Plot a line with the errorbar as a shadow
%
% Syntax
%		plot_shadow(x,y,error,color)
%       e.g. plot_shadow(1:20,10*rand(1,20),rand(1,20),color('blue'))
%
% Input
%		x: a vector
%		y: a vector with the same size of x
%		color: color of line (e.g. color('red'))
%
% Output
%		A line with the errorbar as a shadow
 
% Version: 2.0, 10 August 2018
% Author:  Penglai Liu
% E-mail:  penglailiu@gmail.com


varnm = {'x','y','error'};
for i = 1:3
    var = eval(char(varnm(i)));
    if ~isrow(var)
        var = var';
        eval([char(varnm(i)),'=','var',';'])
    end
end

if numel(error) == 1
    plot(x,y,'color',[0 0 1],'LineWidth',10);
else
%     h = area(x,[y-error, 2*error]);
%     hold on; 
%     set(h(1),'Visible','off');
%     set(h(2),'EdgeColor','none','FaceColor',color);
%     plot(x,y,'color',color,'LineWidth',0.5);
%     alpha(h(2),0.25)
hold on    
% h = fill([x,fliplr(x),x(1)],[y-error,fliplr(y+error),y(1)-error(1)],color,'EdgeColor','none');%预测总体样本的荧光强度会在标准误之内浮动
  h = fill([x,fliplr(x),x(1)],[y-error,fliplr(y+error),y(1)-error(1)],[0 0 1],'EdgeColor','none');
alpha(h,0.25)
plot(x,y,'color',[0 0 1],'LineWidth',2);
hold off
    
end

end