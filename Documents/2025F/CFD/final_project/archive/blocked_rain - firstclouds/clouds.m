%% Atmospheric Specifics
scalefactor = 10000;
T_surface = 300;                          % Kelvin
lapse_rate = 9.8/1000*scalefactor;        % Lapse rate (9.8/1000 Kelvin/meter)

[~, altitude] = meshgrid(x_p, y_p);

%Pressure Calcs
TK = T_surface - lapse_rate * altitude;
TK = TK(:);
TC = TK - 273.15;
Volume = dx * dy*scalefactor;
partial_pressure = phi_np1 .* 461.5 .* TK / Volume;
satvap_pressure = 610.94 * exp(17.625 * TC ./ (TC + 243.04));   % August-Roche-Magnus equation

cloudmap = partial_pressure >= satvap_pressure;                 % Array of 0 if evaporation and 1 if condensation/cloud 


%% Plotting
figure("Name", "cloudma")
tiledlayout
colormap("default")
nexttile
imagesc(x_p, y_p, reshape(phi_np1, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('moisture content')
colorbar

nexttile
imagesc(x_p, y_p, reshape(satvap_pressure, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('satvap_pressure')
colorbar

nexttile
imagesc(x_p, y_p, reshape(partial_pressure, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
title('partial_pressure')
colorbar

nexttile
imagesc(x_p, y_p, reshape(cloudmap, length(y_p), length(x_p)))
set(gca, 'YDir','normal')
% rain = [0 0 1];
% cloud = [1 1 1];
% sky = [0 195/255 235/255];
% colormap([sky; cloud; rain])
% set(gca, 'CLim', [0 2]);
title('Cloudmap')