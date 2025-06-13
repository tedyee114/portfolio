function [u_type, v_type, p_type] = set_cell_type(Ny_u, Nx_u, Ny_v, Nx_v, Ny_p, Nx_p, x_u, y_u, x_v, y_v, x_p, y_p)

u_type = zeros(Ny_u,Nx_u);
v_type = zeros(Ny_v,Nx_v);
p_type = zeros(Ny_p,Nx_p);

%% Set the u-cell types

% Outlet cells: Cell centers on the right boundary above the obstruction
u_type(:,end) = 1; 

% Inlet cells: Cell centers on the right boundary
u_type(:,1) = 2; 

% Cells with a south face on a no slip boundary
u_type(1,2:end-1) = 3; % Points in the middle that NEIGHBOR the bottom boundary

% Cells with a north face on a free slip boundary
u_type(end,2:end-1) = 4; % Points in the middle that NEIGHBOR the top boundary

% Plot the u-type results
[X_u, Y_u] = meshgrid(x_u, y_u);

plot([0 3 3 0 0],[-.5 -.5 .5 .5 -.5],'k','LineWidth',2);
hold on;
s = scatter(X_u(:),Y_u(:),1000,u_type(:),'Marker','.');
colormap jet;


%% Set the v-cell type

% Cells ON the no slip boundary
v_type(1,:) = 1; 

% Cells ON the free slip boundary
v_type(end,:) = 2; % Points ON the top boundary

% Cells with the West face ON the inlet
v_type(2:end-1,1) = 3; 

% Cells with the East face ON the outlet
v_type(2:end-1,end) = 4; 

figure

% Plot the u-type results
[X_v, Y_v] = meshgrid(x_v, y_v);

plot([0 3 3 0 0],[-.5 -.5 .5 .5 -.5],'k','LineWidth',2);
hold on;
s = scatter(X_v(:),Y_v(:),1000,v_type(:),'Marker','.');
colormap jet;


%% Set the p-cell type

% Cells with boundaries on the South and West face
p_type(1,1) = 1;

% Cells with boundaries on the North and West face
p_type(end,1) = 2;

% Cells with boundaries on West face
p_type(2:end-1,1) = 3;

% Cells with boundaries on the South and East face
p_type(1,end) = 4;

% Cells with boundaries on the North and East face
p_type(end,end) = 5;

% Cells with boundaries on the East face
p_type(2:end-1,end) = 6;

% Cell with boundaries on the South face
p_type(1,2:end-1) = 7;

% Cell with boundaries on the North face
p_type(end,2:end-1) = 8;

figure

% Plot the p-type results
[X_p, Y_p] = meshgrid(x_p, y_p);

plot([0 3 3 0 0],[-.5 -.5 .5 .5 -.5],'k','LineWidth',2);
hold on;
colormap jet;