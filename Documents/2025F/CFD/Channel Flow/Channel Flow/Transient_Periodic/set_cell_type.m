function [u_type, v_type, p_type] = set_cell_type(Ny_u, Nx_u, Ny_v, Nx_v, Ny_p, Nx_p)

u_type = zeros(Ny_u,Nx_u);
v_type = zeros(Ny_v,Nx_v);
p_type = zeros(Ny_p,Nx_p);

u_type(:,end) = 1; % All points on the periodic boundary
u_type(1,1) = 2;   % Point ON the left boundary NEIGHBORING the bottom boundary
u_type(end,1) = 3; % Point ON the left boundary NEIGHBORING the top boundary
u_type(2:end-1,1) = 4; % Points ON the left boundary that do not neighbor the top or bottom boundary
u_type(1,2:end-1) = 5; % Points in the middle that NEIGHBOR the bottom boundary
u_type(end,2:end-1) = 6; % Points in the middle that NEIGHBOR the top boundary

v_type(1,:) = 1; % Points ON the bottom boundary
v_type(end,:) = 2; % Points ON the top boundary
v_type(2:end-1,1) = 3; % Cells with the periodic boundary on the west face
v_type(2:end-1,end) = 4; % Cells with the periodic boundary on the east face

p_type(1,1) = 1;
p_type(end,1) = 2;
p_type(2:end-1,1) = 3;
p_type(1,end) = 4;
p_type(end,end) = 5;
p_type(2:end-1,end) = 6;
p_type(1,2:end-1) = 7;
p_type(end,2:end-1) = 8;