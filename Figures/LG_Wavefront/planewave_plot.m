Nframes = 1;
t = linspace(0,10*pi,Nframes);
F = struct('cdata', cell(1,Nframes), 'colormap', cell(1,Nframes));
closeFigs(1);
set(gcf,'Renderer','painters')

for J=1:Nframes
    % generates an angle vector
    a = 0:3*pi/100:6*pi;
    radius = linspace(0,1,15);
    theta = linspace(0,2*pi,50);
    h = figure(1);
    %set(h,'visible','off');
    for K=1:3
    for i = 1:14
        % calculates x, y, and z
        [y,z] = pol2cart(theta,radius(i));
        x = mod(3*pi*(K-1)+t(J),9*pi).*ones(size(theta));
        [y2,z2] = pol2cart(theta,radius(i+1));
        x2 = mod(3*pi*(K-1)+t(J),9*pi).*ones(size(theta));
        savex(K,J) = x(1);
        % plots
        hold on
        surface([x;x2],[y;y2],[z;z2],'FaceColor',[32 167 255]./255);
         xlim([0 25])
        ylim([-1 1])
        zlim([-1 1])
    end
    end
    
%     %Arrow
%     xarrow = max(savex(:,J))+0.2;
%     mArrow3([xarrow 0 0],[xarrow 0 1.5],'color','blue','stemWidth',0.03);
%     text(xarrow,0,1.5,'$\vec{E}$','Interpreter','Latex','FontSize',30,'Color','blue');
%     mArrow3([xarrow 0 0],[xarrow -1.5 0],'color','blue','stemWidth',0.03);
%     text(xarrow+1,-1.8,0,'$\vec{B}$','Interpreter','Latex','FontSize',30,'Color','blue');
%     mArrow3([xarrow 0 0],[xarrow+7 0 0],'color','blue','stemWidth',0.03);
%     text(xarrow+7.5,0,0,'$\vec{\Pi}$','Interpreter','Latex','FontSize',40,'Color','blue');
%     set(h,'visible','on');

    
    view([20 30]);
    set(findobj(gcf, 'type','axes'), 'Visible','off')
    set(gcf,'color','w');
   % F(J) = getframe(gcf);
    
%     print('-dpdf',sprintf('Plane_Wave/image%05.5d.pdf', J));
    pause(0.0333);
%     clf(1);
end
% 
% %%
%  figure(2)
%  movie(F,10)
% 
% %% Save movie
% movie2avi(F, 'helix_1.avi', 'compression', 'None'
%%

export_fig 'PlaneWave.png' -r600