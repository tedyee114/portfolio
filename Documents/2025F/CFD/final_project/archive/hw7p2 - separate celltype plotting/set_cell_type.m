%% Set cell size, assuming uniform mesh
dx = grids.x_u(2)-grids.x_u(1);
dy = grids.y_u(2)-grids.y_u(1);

%% Create the cell type matrices
u_type = zeros(N.y_u,N.x_u);
v_type = zeros(N.y_v,N.x_v);
p_type = zeros(N.y_p,N.x_p);

%% Set the u-cell types
u_type(:,end)       = 2;            %%Right/East Edge 
u_type(1,2:end-1)   = 4;            %%Bottom/South Edge
u_type(:,1)         = 6;            %%Left/West Edge
u_type(end,2:end-1) = 8;            %%Top/North Edge

%% Set the v-cell type
v_type(2:end-1,end) = 2;            %%Right/East Edge 
v_type(1,:)         = 4;            %%Bottom/South Edge
v_type(2:end-1,1)   = 6;            %%Left/West Edge 
v_type(end,:)       = 8;            %%Top/North Edge

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

plot_cell_type