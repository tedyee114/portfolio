%% Atmospheric Specifics

T_surface       = 300;                      %Default = 300 Kelvin. Temperature at sea level
lapse_rate      = 9.8/1000*scalefactor;     %Default = 9.8/1000 Kelvin/meter.  Lapse rate
criticalmass    = 3.2;%.14;                      %Default = 3.2 for phi_wall=1,phi_in=0. Nonrealistic parameter controlling rain threshold
rainremovalrate = .6;                       %default = 0.6 under 0.5 is 100% removal,  up to 1 is 50%. it skips over cells via round(rainremovalrate*rand)


%% Clouds
[~, altitude] = meshgrid(x_p, y_p);
TK = T_surface - lapse_rate * altitude;
TK = TK(:);
TC = TK - 273.15;
Volume = dx * dy*scalefactor;
partial_pressure = phi_np1 .* 461.5 .* TK / Volume;
satvap_pressure = 610.94 * exp(17.625 * TC ./ (TC + 243.04));   % August-Roche-Magnus equation
cloudmap = partial_pressure >= satvap_pressure;                 % Array of 0 if evaporation and 1 if condensation/cloud
N.y_p = length(y_p);
N.x_p = length(x_p);


%% Plotting
figure('name',[num2str(n)])
tiledlayout

nexttile
imagesc(x_p, y_p, reshape(satvap_pressure, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('satvap pressure')
colorbar

nexttile
imagesc(x_p, y_p, reshape(partial_pressure, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('partial pressure')
colorbar

nexttile
imagesc(x_p, y_p, reshape(phi_np1, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('moisture content')
colorbar


%% Rain
disp('rain')
rain

nexttile
imagesc(x_p, y_p, reshape(rainmapwithclouds, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('rainmapwithclouds')
set(gca, 'YDir','normal')
raincolor = [0 0 1];
cloud = [1 1 1];   
sky = [0 195/255 235/255];
colormap(gca, [sky; cloud; raincolor])
set(gca, 'CLim', [0 2]);
title('Rain and Clouds')

nexttile
imagesc(x_p, y_p, reshape(phi_np1, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('moisture content after rain')
colorbar