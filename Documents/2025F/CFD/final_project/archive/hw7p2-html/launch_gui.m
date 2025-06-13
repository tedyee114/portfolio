function BC = launch_gui(grids, N)
    % Create UI as a figure
    base = uifigure('Name', 'ANTSSSSS', "Icon", "tyicon-transparent.png", 'color', [.3, .3, .3]);
    fig = uigridlayout(base, [20, 4]);

    %% Create all dropdowns and textboxes
    [u_lef_type_dropdown, u_lef_value_box] = add_BC_block(fig, 'u_left', 3, 'cos(8*pi*y)', ["Dirichlet", "FreeSlip", "Neumann"]);
    [u_rig_type_dropdown, u_rig_value_box] = add_BC_block(fig, 'u_right', 5, '0', ["Neumann", "FreeSlip", "Dirichlet"]);
    [u_bot_type_dropdown, u_bot_value_box] = add_BC_block(fig, 'u_bottom', 7, '0', ["FreeSlip", "Dirichlet", "Neumann"]);
    [u_top_type_dropdown, u_top_value_box] = add_BC_block(fig, 'u_top', 9, '0', ["FreeSlip", "Dirichlet", "Neumann"]);

    [v_lef_type_dropdown, v_lef_value_box] = add_BC_block(fig, 'v_left', 12, '0', ["FreeSlip", "Dirichlet", "Neumann"]);
    [v_rig_type_dropdown, v_rig_value_box] = add_BC_block(fig, 'v_right', 14, '0', ["FreeSlip", "Dirichlet", "Neumann"]);
    [v_bot_type_dropdown, v_bot_value_box] = add_BC_block(fig, 'v_bottom', 16, 'cos(8*pi*x)', ["Dirichlet", "FreeSlip", "Neumann"]);
    [v_top_type_dropdown, v_top_value_box] = add_BC_block(fig, 'v_top', 18, '0', ["Neumann", "FreeSlip", "Dirichlet"]);

    % Optional side panels
    uipanel(fig, 'Layout', struct('Row', [1, 18], 'Column', 3));
    uipanel(fig, 'Layout', struct('Row', [1, 18], 'Column', 4));

    % Store UI handles
    handles = struct(...
        'u_lef_value', u_lef_value_box, ...
        'u_rig_value', u_rig_value_box, ...
        'u_bot_value', u_bot_value_box, ...
        'u_top_value', u_top_value_box, ...
        'v_lef_value', v_lef_value_box, ...
        'v_rig_value', v_rig_value_box, ...
        'v_bot_value', v_bot_value_box, ...
        'v_top_value', v_top_value_box ...
    );
    guidata(base, handles);

    % Submit button
    uibutton(fig, 'Text', 'Submit', 'Position', [10, 220, 120, 30], ...
        'ButtonPushedFcn', @(btn, event) uiresume(base));

    % Disable closing
    base.CloseRequestFcn = @(src, event) disp('Use Submit to close.');

    uiwait(base);  % Pause here until Submit pressed

    % After submit, evaluate all values
    data = guidata(base);

    BC.u_lef_value = eval_expr(data.u_lef_value.Value, grids, N);
    BC.u_rig_value = eval_expr(data.u_rig_value.Value, grids, N);
    BC.u_bot_value = eval_expr(data.u_bot_value.Value, grids, N);
    BC.u_top_value = eval_expr(data.u_top_value.Value, grids, N);

    BC.v_lef_value = eval_expr(data.v_lef_value.Value, grids, N);
    BC.v_rig_value = eval_expr(data.v_rig_value.Value, grids, N);
    BC.v_bot_value = eval_expr(data.v_bot_value.Value, grids, N);
    BC.v_top_value = eval_expr(data.v_top_value.Value, grids, N);

    close(base); % Close the GUI
end

function [dropdown, textbox] = add_BC_block(fig, label_text, row, default_value, items)
    label = uilabel(fig, 'Text', label_text);
    dropdown = uidropdown(fig, "Items", items);
    textbox = uieditfield(fig, 'text', 'Value', default_value);

    label.Layout.Row = row;
    label.Layout.Column = 1;

    dropdown.Layout.Row = row + 1;
    dropdown.Layout.Column = 1;

    textbox.Layout.Row = row + 1;
    textbox.Layout.Column = 2;
end

function value = eval_expr(expr_str, grids, N)
    try
        expr_str = strrep(expr_str, 'x', 'grids.x_p');
        expr_str = strrep(expr_str, 'y', 'grids.y_p');
        func = str2func(['@(grids) ' expr_str]);
        value = func(grids);

        if isscalar(value)
            value = value * ones(N.y_p, 1);  % Or N.x_p if needed
        end
    catch ME
        error('Error evaluating expression "%s": %s', expr_str, ME.message);
    end
end
