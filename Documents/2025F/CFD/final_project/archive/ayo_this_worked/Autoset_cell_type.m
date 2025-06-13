function [u_type, v_type, p_type] = Copy_of_set_cell_type(N, grids, cell_visualizations_on_off, panel_1)
%% Set cell size, assuming uniform mesh
dx = grids.x_u(2)-grids.x_u(1);
dy = grids.y_u(2)-grids.y_u(1);

[X_u, Y_u] = meshgrid(grids.x_u, grids.y_u);
[X_v, Y_v] = meshgrid(grids.x_v, grids.y_v);
[X_p, Y_p] = meshgrid(grids.x_p, grids.y_p);

%% Create the cell type matrices
u_type = zeros(N.y_u,N.x_u);
v_type = zeros(N.y_v,N.x_v);
p_type = zeros(N.y_p,N.x_p);

%obstructions
y_obs_top = 0.5;
x_obs_front = 0.5;

% obs_y_u = find(grids.y_u <  y_obs);
% obs_x_u = find(grids.x_u <= x_obs);
% reg_y_u = find(grids.y_u >  y_obs);
% reg_x_u = find(grids.x_u >= x_obs & grids.x_u > 0);                 %%like the 2:end-1, but only the 2
% obs_y_v = find(grids.y_v <= y_obs);
% obs_x_v = find(grids.x_v <  x_obs);
% reg_y_v = find(grids.y_v > y_obs +dy/2 & grids.y_v < 1/2); % Above the obstruction and below the top
% reg_x_v = find(grids.x_v >  x_obs);

%% Set the u-cell types
% % Cells with a south face on a no slip boundary
% f_x = find(grids.x_u > x_obs_front); % Points after the obstruction
% u_type(1,f_x) = 4;  % Points ON the top of the obstruction
% % f_x = find(abs(grids.x_u - x_obs_front) < dx/2);
% % f_y = find(grids.y_u > y_obs_top , 1, 'first');
% % u_type(f_y,2:f_x+1) = 4; % Points ON the top of the obstruction
% 
% 
% 
% 
% 
% % east border cell
% u_type(:,end) = 2; 
% 
% % Cells with the West face above obstruction
% f_y = find(grids.y_u > y_obs_top);
% u_type(f_y:end,1) = 6; 
% 
% 
% 
% % Cells ON the top boundary
% u_type(end,2:end-1) = 8; % Points in the middle that NEIGHBOR the top boundary
% 
% % Cells with a cell center in or on the obstruction
% f_y = find(grids.y_u < y_obs_top);
% f_x = find(grids.x_u <= x_obs_front);
% u_type(f_y,f_x) = -1; % Points in the middle that NEIGHBOR the top boundary


% Outlet cells: Cell centers on the right boundary above the obstruction
u_type(:,end) = 2; 

% Inlet cells: Cell centers on the left boundary
f = find(grids.y_u > y_obs_top);
u_type(f,1) = 6; 
% Cells with the west face on the no-slip obstruction
f_x = find(grids.x_u > x_obs_front , 1, 'first');
f_y = find( abs(grids.y_u - y_obs_top) < 10^-4);
v_type(2:f_y,f_x) = 7; 

% Cells with a south face on a no slip boundary
f_x = find(grids.x_u >= x_obs_front);
u_type(1,f_x) = 4; % Points in the middle that NEIGHBOR the bottom boundary

f_x = find(grids.x_u <= x_obs_front & grids.x_u > 3);
f_y = find(grids.y_u > y_obs_top, 1, 'first');
u_type(f_y,f_x) = 4; % Points in the middle that NEIGHBOR the bottom boundary

% Cells with a north face on a free slip boundary
u_type(end,2:end-1) = 8; % Points in the middle that NEIGHBOR the top boundary

% Cells with a cell center in or on the obstruction
f_y = find(grids.y_u < y_obs_top);
f_x = find(grids.x_u <= x_obs_front);
u_type(f_y,f_x) = -1; % Points in the middle that NEIGHBOR the top boundary

%% Set the v-cell type
% Cells ON the bottom boundary
f_x = find(grids.x_v > x_obs_front); % Points after the obstruction
v_type(1,f_x) = 4; 
f_x = find(grids.x_v <= x_obs_front);
f_y = find( abs(grids.y_v-y_obs_top) < dy/2);
v_type(f_y+1,f_x+1) = 4; % Points ON the top of the obstruction

% Cells ON the top boundary
v_type(end,:) = 8; % Points ON the top boundary

% Cells with the West face ON the inlet
f_y = find(grids.y_v > y_obs_top+dy/2); % Above the obstruction and below the top
v_type(f_y,1) = 6; 

% Cells with the west face on the obstruction
f_x = find(grids.x_v > x_obs_front , 1, 'first');
f_y = find( abs(grids.y_v - y_obs_top) < dy/2);
v_type(2:f_y,f_x) = 7; 

% Cells with the East face ON the outlet
v_type(2:end-1,end) = 2; 


% Cells with a cell center in the obstruction
f_y = find(grids.y_v <= y_obs_top);
f_x = find(grids.x_v <= x_obs_front);
v_type(f_y,f_x) = -1; % Points in the middle that NEIGHBOR the top boundary

%% Set the p-cell type

% Cells with boundaries on the South and West face
p_type(1,1) = 1;
% Cells with boundaries on the South and West face
f_x = find(grids.x_p > x_obs_front,1,'First');
p_type(1,f_x) = 1;
f_y = find(grids.y_p > y_obs_top,1,'First');
p_type(f_y,1) = 1;

% Cells with boundaries on the North and West face
p_type(end,1) = 2;

% Cells with boundaries on West face
p_type(f_y+1:end-1,1) = 3;
p_type(2:f_y-1,f_x) = 3;

% Cells with boundaries on the South and East face
p_type(1,end) = 4;

% Cells with boundaries on the North and East face
p_type(end,end) = 5;

% Cells with boundaries on the East face
p_type(2:end-1,end) = 6;

% Cell with boundaries on the South face
p_type(f_y,2:f_x) = 7;
p_type(1,f_x+1:end-1) = 7;

% Cell with boundaries on the North face
p_type(end,2:end-1) = 8;

% Cells IN the obstruction
p_type(1:f_y-1,1:f_y-1) = -1;

% %%
% u_type=zeros(N.x_u,N.y_u);
% v_type=zeros(N.x_v,N.y_v);
% p_type=zeros(N.x_p,N.y_p);
% 
% u_type(1,2:end-1) = 8;      %%Left&Right Overrule at Corners
% u_type(end,2:end-1) = 4;
% u_type(:,1) = 6;
% u_type(:,end) = 2
% 
% v_type(1,:) = 8;
% v_type(end,:) = 4;
% v_type(2:end-1,1) = 6;     %%Top&Bottom Overrule at Corners
% v_type(2:end-1,end) = 2;
% 
% p_type(1,end)       = 1;
% p_type(2:end-1,end) = 2;
% p_type(end,end)     = 3;
% p_type(end,2:end-1) = 4;
% p_type(end,1)       = 5;
% p_type(2:end-1,1)   = 6;
% p_type(1,1)         = 7;
% p_type(1,2:end-1)   = 8;
% 
% 
% % create_mountain


%% Plotting
if cell_visualizations_on_off == 1
        % u types plot
        ax1 = axes('Parent', panel_1, 'Position', [0.05, 0.95, 0.9, 0.3]);
        scatter(ax1, X_u(:), Y_u(:), 300, u_type(:), 'Marker', '.');
        colormap(ax1, 'jet');
        hold(ax1, 'on');
        cmap = colormap(ax1);
        colors = cmap(round(linspace(1, size(cmap, 1), 4)), :);
        legend_list = {'Type 0, Interior'};
        for q = 2:length(colors)+1
            scatter(ax1, NaN, NaN, 300, 'Marker', '.', 'MarkerEdgeColor', colors(q-1, :));
            legend_list{q} = ['Type ' num2str(q-1)];
        end
        legend(ax1, legend_list)
        title(ax1, 'Horizontal (u) Cell Types')

        % v types plot
        ax2 = axes('Parent', panel_1, 'Position', [0.05, 0.5, 0.9, 0.3]);
        scatter(ax2, X_v(:), Y_v(:), 300, v_type(:), 'Marker', '.');
        colormap(ax2, 'jet');
        hold(ax2, 'on');
        cmap = colormap(ax2);
        colors = cmap(round(linspace(1, size(cmap, 1), 4)), :);
        legend_list = {'Type 0, Interior'};
        for q = 2:length(colors)+1
            scatter(ax2, NaN, NaN, 300, 'Marker', '.', 'MarkerEdgeColor', colors(q-1, :));
            legend_list{q} = ['Type ' num2str(q-1)];
        end
        legend(ax2, legend_list)
        title(ax2, 'Vertical (v) Cell Types')

        %p types plot
        ax3 = axes('Parent', panel_1, 'Position', [0.05, 0.1, 0.9, 0.3]);
        scatter(ax3, X_p(:), Y_p(:), 300, p_type(:), 'Marker', '.');
        hold(ax3, 'on');
        cmap = colormap(ax3);
        colors = cmap(round(linspace(1, size(cmap, 1), 8)), :);
        legend_list = {'Type 0, Interior'};
        for q = 2:length(colors)+1
            scatter(ax3, NaN, NaN, 300, 'Marker', '.', 'MarkerEdgeColor', colors(q-1, :));
            legend_list{q} = ['Type ' num2str(q-1)];
        end
        legend(ax3, legend_list)
        title(ax3, 'Pressure (p) Cell Types')
end