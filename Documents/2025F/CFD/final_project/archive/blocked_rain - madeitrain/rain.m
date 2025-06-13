% Rain Calculations
rainmap = zeros(length(cloudmap),1);
cumulative_moisture_map = zeros(length(cloudmap),1);
grid_width = N.y_p; % Assuming N.y_p represents the width of the grid
grid_height = length(cloudmap) / grid_width;

for i = 1:length(cloudmap)
    % Initialize total moisture
    total_moisture = 0;
    
    % Calculate row and column from 1D index
    row = ceil(i / grid_width);
    col = mod(i - 1, grid_width) + 1;
    
    % Check left neighbor
    if col > 1 % Not at left edge
        left_idx = i - 1;
        if cloudmap(left_idx) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(left_idx);
        end
    else % At left edge, use own value
        if cloudmap(i) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(i);
        end
    end
    
    % Check right neighbor
    if col < grid_width % Not at right edge
        right_idx = i + 1;
        if cloudmap(right_idx) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(right_idx);
        end
    else % At right edge, use own value
        if cloudmap(i) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(i);
        end
    end
    
    % Check above neighbor
    if row > 1 % Not at top edge
        above_idx = i - grid_width;
        if cloudmap(above_idx) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(above_idx);
        end
    else % At top edge, use own value
        if cloudmap(i) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(i);
        end
    end
    
    % Check below neighbor
    if row < grid_height % Not at bottom edge
        below_idx = i + grid_width;
        if cloudmap(below_idx) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(below_idx);
        end
    else % At bottom edge, use own value
        if cloudmap(i) == 1 % If it's a cloud
            total_moisture = total_moisture + phi_np1(i);
        end
    end
    
    cumulative_moisture_map(i) = total_moisture;
    
    % Check if critical mass is reached
    if total_moisture > criticalmass
        for k = 1:grid_width
            row_idx = (row - 1) * grid_width + k +round(rainremovalrate*rand);
            rainmap(row_idx) = 2; % Set each element in the row to 2
            phi_np1(row_idx) = 0; % Reset moisture to 0 in this row
        end
    end
end


rainmap_reshaped = reshape(rainmap, grid_width, grid_height);
rainmapwithclouds = rainmap_reshaped; cloudmap_mask = (cloudmap == 1); rainmapwithclouds(cloudmap_mask) = cloudmap(cloudmap_mask);