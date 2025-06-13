%% Mesh Generation

% This script should generate the three types of cell centers


%% Create the domain

dx = 1/20;
dy = 1/50;

[x_u, y_u, x_v, y_v, x_p, y_p] = grid_generation(dx,dy);

%% Calculate the size of each of the meshs

Ny_u = length(y_u); 
Nx_u = length(x_u);
Ny_v = length(y_v); 
Nx_v = length(x_v);
Ny_p = length(y_p); 
Nx_p = length(x_p);

%% Create cell types

[u_type, v_type, p_type] = set_cell_type(Ny_u, Nx_u, Ny_v, Nx_v, Ny_p, Nx_p);
