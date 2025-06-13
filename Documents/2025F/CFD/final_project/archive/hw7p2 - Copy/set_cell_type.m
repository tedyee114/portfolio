function [u_type, v_type, p_type] = set_cell_type(N, grids, cell_visualizations_on_off)
%% Set cell size, assuming uniform mesh
dx = grids.x_u(2)-grids.x_u(1);
dy = grids.y_u(2)-grids.y_u(1);

%% Create the cell type matrices
u_type = zeros(N.y_u,N.x_u);
v_type = zeros(N.y_v,N.x_v);
p_type = zeros(N.y_p,N.x_p);

%% Set the u-cell types
% Outlet cells: Cell centers on the right boundary above the obstruction
u_type(:,end) = 1; 
% Inlet cells: Cell centers on the right boundary
u_type(:,1) = 2; 
% Cells with a south face on a no slip boundary
u_type(1,2:end-1) = 3; % Points in the middle that NEIGHBOR the bottom boundary
% Cells with a north face on a free slip boundary
u_type(end,2:end-1) = 4; % Points in the middle that NEIGHBOR the top boundary

%% Set the v-cell type
% Cells ON the no slip boundary
v_type(1,2:end) = 1; 
% Cells ON the free slip boundary
v_type(end,2:end) = 2; % Points ON the top boundary
% Cells with the West face ON the inlet
v_type(:,1) = 3; 
% Cells with the East face ON the outlet
v_type(:,end) = 4; 

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


[X_u, Y_u] = meshgrid(grids.x_u, grids.y_u);
[X_v, Y_v] = meshgrid(grids.x_v, grids.y_v);
[X_p, Y_p] = meshgrid(grids.x_p, grids.y_p);
%% Plotting
if cell_visualizations_on_off == 1
    tiledlayout(1,3)
    
    % Plot u-type results
    nexttile
    scatter(X_u(:), Y_u(:), 300, u_type(:), 'Marker', '.');
    colormap jet;
    hold on;
    cmap = colormap;
    colors = cmap(round(linspace(1, size(cmap, 1), 4)), :);
    legend_list = {'Type 0, Interior'};
    for q = 2:length(colors)+1
        scatter(NaN, NaN, 300, 'Marker', '.', 'MarkerEdgeColor', colors(q-1, :));
        legend_list{q} = ['Type ' num2str(q-1)];
    end
    legend(legend_list)
    title('Horizontal (u) Cell Types')
    
    % Plot v-type results
    nexttile
    scatter(X_v(:), Y_v(:), 300, v_type(:), 'Marker', '.');
    colormap jet;
    hold on;
    cmap = colormap;
    colors = cmap(round(linspace(1, size(cmap, 1), 4)), :);
    legend_list = {'Type 0, Interior'};
    for q = 2:length(colors)+1
        scatter(NaN, NaN, 300, 'Marker', '.', 'MarkerEdgeColor', colors(q-1, :));
        legend_list{q} = ['Type ' num2str(q-1)];
    end
    legend(legend_list)
    title('Vertical (v) Cell Types')
    
    % Plot p-type results
    nexttile
    s = scatter(X_p(:), Y_p(:), 300, p_type(:), 'Marker', '.');
    hold on;
    cmap = colormap;
    colors = cmap(round(linspace(1, size(cmap, 1), 8)), :);
    legend_list = {'Type 0, Interior'};
    for q = 2:length(colors)+1
        scatter(NaN, NaN, 300, 'Marker', '.', 'MarkerEdgeColor', colors(q-1, :));
        legend_list{q} = ['Type ' num2str(q-1)];
    end
    legend(legend_list)
    title('Pressure (p) Cell Types')
end