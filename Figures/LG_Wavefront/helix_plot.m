Nframes =1;
t = linspace(0,2*pi,Nframes);
F = struct('cdata', cell(1,Nframes), 'colormap', cell(1,Nframes));
closeFigs(1);
% opengl('software')
set(gcf,'Renderer','painters')
for J=1:Nframes
    % generates an angle vector
    a = 0:3*pi/100:6*pi;
    radius = linspace(0,1,15);
    
    h = figure(1);
    %set(h,'visible','off');
    for i = 1:14
        % calculates x, y, and z
        y = radius(i).*cos(-a+t(J));
        z = radius(i).*sin(-a+t(J));
        x = a;
        y2 = radius(i+1).*cos(-a+t(J));
        z2 = radius(i+1).*sin(-a+t(J));
        x2 = a;
        
        % plots
        hold on
        surface([x;x2],[y;y2],[z;z2],'FaceColor',[32 167 255]./255);
        xlim([0 25])
        ylim([-1 1])
        zlim([-1 1])
    end
    
%     %spiral
%     dt = 0.5;
%     st = 0.5*sin(-a+pi/2);
%     ct = 0.5*cos(-a+pi/2);
%     hold on
%     plot3(a,ct,st,'r','LineWidth',1)
%     for i = 1:14
%         % calculates x, y, and z
%         y = radius(i).*cos(-a+t(J)+pi);
%         z = radius(i).*sin(-a+t(J)+pi);
%         x = a;
%         y2 = radius(i+1).*cos(-a+t(J)+pi);
%         z2 = radius(i+1).*sin(-a+t(J)+pi);
%         x2 = a;
%         
%         % plots
%         hold on
%         surface([x;x2],[y;y2],[z;z2],'FaceColor',[32 167 255]./255);
% %         xlim([0 25])
%         ylim([-1 1])
%         zlim([-1 1])
%     end
%     for i = 1:14
%         % calculates x, y, and z
%         y = radius(i).*cos(-a+t(J)+2*pi/3);
%         z = radius(i).*sin(-a+t(J)+2*pi/3);
%         x = a;
%         y2 = radius(i+1).*cos(-a+t(J)+2*pi/3);
%         z2 = radius(i+1).*sin(-a+t(J)+2*pi/3);
%         x2 = a;
%         
%         % plots
%         hold on
%         surface([x;x2],[y;y2],[z;z2],'FaceColor',[32 167 255]./255);
% %         xlim([0 25])
%         ylim([-1 1])
%         zlim([-1 1])
%     end
       
        %%Arrows
%         b = a(186); c=a(185);i=10; K=1;
%         y3 = radius(i).*cos(-b+t(J));
%         z3 = radius(i).*sin(-b+t(J));
%         x3 = b+0.2;
%         y4 = radius(i+1).*cos(-b+t(J));
%         z4 = radius(i+1).*sin(-b+t(J));
%         x4 = b+0.2;
%         y5 = radius(i).*cos(-b+t(J));
%         z5 = radius(i).*sin(-b+t(J));
%         x5 = b+0.2;
%         y6 = radius(i).*cos(-c+t(J));
%         z6 = radius(i).*sin(-c+t(J));
%         x6 = c+0.2;
%         p = cross([(x4-x3);(y4-y3);(z4-z3)],[(x6-x5);(y6-y5);(z6-z5)]);
%     
%         mArrow3([x3 y3 z3],[10*(x4-x3)+x4 10*(y4-y3)+y4 10*(z4-z3)+z4],'color','blue','stemWidth',0.02,'tipWidth',0.05);
%         text(10*(x4-x3)+x4,10*(y4-y3)+y4,10*(z4-z3)+z4,'$\vec{E}$','Interpreter','Latex','FontSize',30,'Color','blue');
%         mArrow3([x5 y5 z5],[10*(x6-x5)+x6 10*(y6-y5)+y6 10*(z6-z5)+z6],'color','blue','stemWidth',0.02,'tipWidth',0.05);
%         text(10*(x6-x5)+x6,10*(y6-y5)+y6,10*(z6-z5)+z6-0.1,'$\vec{B}$','Interpreter','Latex','FontSize',30,'Color','blue');
%         mArrow3([x5 y5 z5],[(2000*p(1)+x5) (200*p(2)+y5) (200*p(3)+z5)],'color','blue','stemWidth',0.02,'tipWidth',0.03);
%         text((2000*p(1)+x5),(200*p(2)+y5),(200*p(3)+z5),'$\vec{\Pi}$','Interpreter','Latex','FontSize',40,'Color','blue');
%     
    set(h,'visible','on');
    
    view([20 30]);
    set(findobj(gcf, 'type','axes'), 'Visible','off')
    set(gcf,'color','w');
%     set(gcf, 'InvertHardCopy', 'off');
    %F(J) = getframe(gcf);
    %     print('-dpdf',sprintf('Helix_Poynting/image%05.5d.pdf', J));
    pause(0.0333);
    %     clf(1);
end
%%
export_fig 'L2Wf.png' -r400
%%
figure(2)
movie(F,10)

%% Save movie
movie2avi(F, 'helix_1.avi', 'compression', 'None');