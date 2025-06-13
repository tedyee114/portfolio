create_mountain

% Parameters
rise_slope = 1;
fall_slope = -1;
start_mountain = floor(N.x_p*20/100);
peak = floor(N.x_p*50/100);
end_mountain = floor(N.x_p*80/100);

% Left Side of Mountain
for i = start_mountain+1 : peak
    j = round(rise_slope * (i - start_mountain));
    if j <= N.y_u
        u_type(1:j, i) = -1;
    end
end

% Right Side Of Mountain
for i = peak+1 : end_mountain
    j = round(fall_slope * (i - peak) + j);  % continue from where rise ended
    if j >= 1 && j <= N.y_u
        u_type(1:j, i) = -1;
    end
end

%%%Boundary cells
for i = 1:N.y_u-1
    for j = 2:N.x_u-1
        if u_type(i,j) == 0
            below = u_type(i-1, j);
            above  = u_type(i+1, j);
            right = u_type(i, j+1);
            left  = u_type(i, j-1);            
            
            if below == -1 && left == -1
                u_type(i,j) = 11;
            elseif left == -1
                u_type(i,j) = 12;
            elseif above == -1 && left == -1
                u_type(i,j) = 13;    
            elseif above == -1
                u_type(i,j) = 14;
            elseif above == -1 && right == -1
                u_type(i,j) = 15;
            elseif right == -1
                u_type(i,j) = 16;
            elseif below == -1 && right == -1
                u_type(i,j) = 17;
            elseif below == -1
                u_type(i,j) = 10;
            
            end
        end
    end
end