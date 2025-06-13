%%%mesh_generation
% This script should generate the three types of cell centers

% Create the domain
[grids.x_u, grids.y_u, grids.x_v, grids.y_v, grids.x_p, grids.y_p] = grid_generation(dx,dy,x_min,x_max,y_min,y_max);

% Calculate the size of each of the meshes and store the data in a structure
N.y_u = length(grids.y_u); 
N.x_u = length(grids.x_u);
N.y_v = length(grids.y_v); 
N.x_v = length(grids.x_v);
N.y_p = length(grids.y_p); 
N.x_p = length(grids.x_p);

% Create cell types
% [u_type, v_type, p_type] = Copy_of_set_cell_type(N, grids, cell_visualizations_on_off, panel_1);
% [u_type, v_type, p_type] = Autoset_cell_type(N, grids, cell_visualizations_on_off, panel_1);
% [u_type, v_type, p_type] = set_cell_type(N, grids, cell_visualizations_on_off, panel_1);  %%this works with A_u_efficient
set_cell_type_blocked