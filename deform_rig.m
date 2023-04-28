function deform_rig(V, F, W, p0, p_out_file )
%DEFORM_RIG Summary of this function goes here
%   Detailed explanation goes here
close all;
fprintf( ...
    ['Make a LBS rig: \n' ...
    '- CLICK on mesh to add handle \n', ...
    '- PRESS w to compute weights\n', ...
    '- PRESS s to save rest parameters,weights, and mesh\n'] ...
    );


p = zeros(size(p0, 1), 1); %tracks deformed rig parameters
J = lbs_matrix(V, W); %rig jacobain
U = V; % tracks deformed mesh
C0 = positions_from_parameters(p0); %handle original positions
C = C0; %tracks deforming handle positions
I = 1; %tracks currently selected handle
dragging = false;

figure();
hold on;

set(gcf,'windowbuttondownfcn',@onmousedown);
t = tsurf(F, V, 'CData', W(:, I), fphong);
s = scatter(C(:, 1),C(:, 2),...
    'o','MarkerFaceColor',[0.9 0.8 0.1], 'MarkerEdgeColor','k',...
    'LineWidth',2,'SizeData',100); %   'ButtonDownFcn',@onhandledown);
set(gcf,'KeyPressFcn',@onkeypress);
title("Deform Rig");
axis equal;
hold off;


function onmousedown(src, ev);
    disp("onmousedown");
    down_pos=get(gca,'currentpoint');
     p = down_pos(1, 1:2);
     I = dsearchn(C, p);
     t.CData = W(:, I);
    dragging = true;
    set(gcf,'windowbuttonmotionfcn',@onmousedrag);
    set(gcf,'windowbuttonupfcn',@onmouseup);
end     

function onmousedrag(src, ev)
   % disp("onmousedrag");
    if dragging == true
        down_pos=get(gca,'currentpoint');
        pos = down_pos(1, 1:2);
        C(I, :) = pos;
        s.XData = C(:, 1);
        s.YData = C(:, 2);
        
        D = C - C0;
        p = parameters_from_positions(D);
        u = J * p;
        U = reshape(u, size(V, 1), size(V, 2));
        t.Vertices = U;
        drawnow;
    end
end

function onmouseup(src, ev)
    disp("onmouseup");
    dragging = false;
end

function onkeypress(src, ev)
    if (strcmp(ev.Character, 's'))
         p0 = parameters_from_positions(C);
         mkdir(strcat(p_out_file, "/../"))
         writeDMAT(p_out_file, p);
    end
end

end

