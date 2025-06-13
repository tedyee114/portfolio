function [u_type, v_type, p_type] = set_cell_type_blocked(N, grids)

%% Set cell size
dx = grids.x_u(2)-grids.x_u(1);
dy = grids.y_u(2)-grids.y_u(1);

%% Create the cell types
u_type = zeros(N.y_u,N.x_u);
v_type = zeros(N.y_v,N.x_v);
p_type = zeros(N.y_p,N.x_p);

%% Set obstruction geometry data
y_obs_top = -0.1;
x_obs_front = 2;

%% Set the u-cell types

% Cells with a south face on a no slip boundary
f_x = find( grids.x_u <= x_obs_front & grids.x_u > 0); % Points after the obstruction
u_type(1,f_x) = 4; % Points ON the top of the obstruction
f_x = find(grids.x_u >= x_obs_front & grids.x_u < 3);
f_y = find(grids.y_u > y_obs_top, 1, 'first');
u_type(f_y,f_x) = 4; % Points in the middle that NEIGHBOR the bottom boundary







% west border cell
u_type(:,1) = 6; 

% Cells with the east face above obstruction
f = find( grids.y_u > y_obs_top);
u_type(f,end) = 2; 



% Cells ON the top boundary
u_type(end,2:end-1) = 8; % Points in the middle that NEIGHBOR the top boundary

% Cells with a cell center in or on the obstruction
f_y = find( grids.y_u < y_obs_top);
f_x = find( grids.x_u >= x_obs_front);
u_type(f_y,f_x) = -1; % Points in the middle that NEIGHBOR the top boundary

% Plot the u-type results
[grids.X_u, grids.Y_u] = meshgrid(grids.x_u, grids.y_u);

plot([0 3 3 0 0],[-.5 -.5 .5 .5 -.5],'k','LineWidth',2);
hold on;
plot([x_obs_front x_obs_front 3],[-.5 y_obs_top y_obs_top],'k','LineWidth',2);
s = scatter(grids.X_u(:),grids.Y_u(:),1000,u_type(:),'Marker','.');
colormap jet;

%% Set the v-cell type

% Cells ON the no slip boundary
f_x = find(grids.x_v < x_obs_front); % Points before the obstruction
v_type(1,f_x) = 4; 
f_x = find(grids.x_v > x_obs_front);
f_y = find( abs(grids.y_v-y_obs_top) < 10^-4 );
v_type(f_y,f_x) = 4; % Points ON the top of the obstruction

% Cells ON the free slip boundary
v_type(end,:) = 8; % Points ON the top boundary

% Cells with the West face ON the inlet
v_type(2:end-1,1) = 6; 

% Cells with the East face ON the outlet
f_y = find(grids.y_v > y_obs_top+dy/2 & grids.y_v < 1/2); % Above the obstruction and below the top
v_type(f_y,end) = 2; 

% Cells with the East face on the no-slip obstruction
f_x = find(grids.x_v < x_obs_front , 1, 'last');
f_y = find( abs(grids.y_v - y_obs_top) < 10^-4);
v_type(2:f_y,f_x) = 2; 

% Cells with a cell center in the obstruction
f_y = find( grids.y_v <= y_obs_top);
f_x = find( grids.x_v >= x_obs_front);
v_type(f_y,f_x) = -1; % Points in the middle that NEIGHBOR the top boundary

figure

% Plot the u-type results
[grids.X_v, grids.Y_v] = meshgrid(grids.x_v, grids.y_v);

plot([0 3 3 0 0],[-.5 -.5 .5 .5 -.5],'k','LineWidth',2);
hold on;
plot([x_obs_front x_obs_front 3],[-.5 y_obs_top y_obs_top],'k','LineWidth',2);
s = scatter(grids.X_v(:),grids.Y_v(:),1000,v_type(:),'Marker','.');
colormap jet;

%% Set the p-cell type

% Cells with boundaries on the South and West face
p_type(1,1) = 1;

% Cells with boundaries on the North and West face
p_type(end,1) = 2;

% Cells with boundaries on West face
p_type(2:end-1,1) = 3;

% Cells with boundaries on the South and East face
f_x = find(grids.x_p < x_obs_front,1,'Last');
p_type(1,f_x) = 4;
f_y = find(grids.y_p > y_obs_top,1,'First');
p_type(f_y,end) = 4;

% Cells with boundaries on the North and East face
p_type(end,end) = 5;

% Cells with boundaries on the East face
p_type(f_y+1:end-1,end) = 6;
p_type(2:f_y-1,f_x) = 6;

% Cell with boundaries on the South face
p_type(1,2:f_x-1) = 7;
p_type(f_y,f_x+1:end-1) = 7;

% Cell with boundaries on the North face
p_type(end,2:end-1) = 8;

% Cells IN the obstruction
p_type(1:f_y-1,f_x+1:end) = -1;

figure

% Plot the p-type results
[grids.X_p, grids.Y_p] = meshgrid(grids.x_p, grids.y_p);

plot([0 3 3 0 0],[-.5 -.5 .5 .5 -.5],'k','LineWidth',2);
hold on;
plot([x_obs_front x_obs_front 3],[-.5 y_obs_top y_obs_top],'k','LineWidth',2);
s = scatter(grids.X_p(:),grids.Y_p(:),1000,p_type(:),'Marker','.');
colormap jet;