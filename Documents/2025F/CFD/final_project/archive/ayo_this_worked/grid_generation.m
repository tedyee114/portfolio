function [x_u, y_u, x_v, y_v, x_p, y_p] = grid_generation(dx,dy,x_min,x_max,y_min,y_max)

x_u = x_min:dx:x_max;
y_u = y_min+dy/2:dy:y_max-dy/2;

x_v = x_min+dx/2:dx:x_max-dx/2;
y_v = y_min:dy:y_max;

x_p = x_min+dx/2:dx:x_max-dx/2;
y_p = y_min+dy/2:dy:y_max-dy/2;