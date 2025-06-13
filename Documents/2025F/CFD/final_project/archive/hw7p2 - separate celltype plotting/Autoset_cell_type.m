function [u_type, v_type, p_type] = Copy_of_set_cell_type(N, grids, cell_visualizations_on_off, panel_1)
%% Set cell size, assuming uniform mesh
dx = grids.x_u(2)-grids.x_u(1);
dy = grids.y_u(2)-grids.y_u(1);

%% Create the cell type matrices
u_type = zeros(N.y_u,N.x_u);
v_type = zeros(N.y_v,N.x_v);
p_type = zeros(N.y_p,N.x_p);

%obstructions
y_obs_top = 0.5;
x_obs_front = 0.5;
%%

u_type=zeros(N.x_u,N.y_u);
v_type=zeros(N.x_v,N.y_v);
p_type=zeros(N.x_p,N.y_p);

u_type(1,2:end-1) = 8;      %%Left&Right Overrule at Corners
u_type(end,2:end-1) = 4;
u_type(:,1) = 6;
u_type(:,end) = 2

v_type(1,:) = 8;
v_type(end,:) = 4;
v_type(2:end-1,1) = 6;     %%Top&Bottom Overrule at Corners
v_type(2:end-1,end) = 2

p_type(1,end)       = 1;
p_type(2:end-1,end) = 2;
p_type(end,end)     = 3;
p_type(end,2:end-1) = 4;
p_type(end,1)       = 5;
p_type(2:end-1,1)   = 6;
p_type(1,1)         = 7;
p_type(1,2:end-1)   = 8;


create_mountain

[X_u, Y_u] = meshgrid(grids.x_u, grids.y_u);
[X_v, Y_v] = meshgrid(grids.x_v, grids.y_v);
[X_p, Y_p] = meshgrid(grids.x_p, grids.y_p);
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