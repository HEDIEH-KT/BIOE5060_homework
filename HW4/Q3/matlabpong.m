function matlabpong
    disp('Game is running...');
end
function varargout = addpath,('C:\Path\To\Your\File');matlabpong(varargin)
% MATLABPONG MATLAB code for matlabpong.fig
%      MATLABPONG, by itself, creates a new MATLABPONG or raises the existing
%      singleton*.
%
%      H = MATLABPONG returns the handle to a new MATLABPONG or the handle to
%      the existing singleton*.
%
%      MATLABPONG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATLABPONG.M with the given input arguments.
%
%      MATLABPONG('Property','Value',...) creates a new MATLABPONG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matlabpong_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matlabpong_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matlabpong

% Last Modified by GUIDE v2.5 03-Dec-2024 09:52:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matlabpong_OpeningFcn, ...
                   'gui_OutputFcn',  @matlabpong_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin >= 1 && ischar(varargin{1})
    callbackName = varargin{1}; % Assign varargin{1} to a local variable first
    gui_State.gui_Callback = str2func(callbackName);
else
    error('No valid callback name provided in varargin');
end

% --- Executes just before matlabpong is made visible.
function matlabpong_OpeningFcn(hObject, ~, handles, varargin) 
    % Check if axCanvas exists
    if isfield(handles, 'axCanvas') && ishandle(handles.axCanvas)
        set(handles.axCanvas, 'Color', [0.8, 0.9, 0.8]); % Change background color to light green
        
        % Try displaying an image or plot to test
        axes(handles.axCanvas);
        imshow('example_image.png'); % or test plot
        % plot(rand(10,1), rand(10,1));
    else
        disp('Error: axCanvas does not exist.');
    end
    
    guidata(hObject, handles);
en
set(handles.plTitle, 'units', 'normalized', 'position', [0 0.85 1 0.15]);
set(handles.axCanvas, 'xlim', [0,1], 'ylim', [0,1], 'xtick', [], 'ytick', [], ...
    'units', 'normalized', 'position', [0.02 0.02 0.96 0.8],'color', [0.9,0.75,0.8]);
axis(handles.axCanvas, 'on');
box(handles.axCanvas, 'on');

set(handles.txRedScore, 'foregroundcolor', 'r');
set(handles.txBlueScore, 'foregroundcolor', 'b');

uidata = get(handles.fmMain, 'userdata');
delete(timerfindall)

uidata.timer = timer('TimerFcn', @updatepong);
uidata.timer.UserData = handles;
uidata.timer.Period = (1 / get(handles.sbSpeed, 'value'));
uidata.timer.ExecutionMode = 'fixedRate';

set(handles.fmMain, 'userdata', uidata);

% --- Outputs from this function are returned to the command line.
function varargout = matlabpong_OutputFcn(~, ~, handles)
varargout{1} = handles.output;
end

% --- Executes on button press in btStart.
function btStart_Callback(~, ~, ~)
end
cla(handles.axCanvas);
hold(handles.axCanvas, 'on');

hpong = plot(0.5, 0.5, 'ko', 'markersize', 15, 'parent', handles.axCanvas);
y1 = rand(1) * 0.8;
y2 = rand(1) * 0.8;
hredbat = plot([0 0], [y1 y1 + 0.2], 'r-', 'linewidth', 8, 'parent', handles.axCanvas);
hbluebat = plot([1 1], [y2 y2 + 0.2], 'b-', 'linewidth', 8, 'parent', handles.axCanvas);

uidata = get(handles.fmMain, 'userdata');
timerdata = get(uidata.timer, 'userdata');
timerdata.pong = hpong;
timerdata.redbat = hredbat;
timerdata.bluebat = hbluebat;
timerdata.dir = rand(1, 2);
timerdata.dir = timerdata.dir / norm(timerdata.dir);

set(uidata.timer, 'userdata', timerdata);
set(handles.fmMain, 'userdata', uidata);

if strcmp(uidata.timer.Running, 'off')
    start(uidata.timer);
end

% --- Executes on button press in btStop.
function btStop_Callback(~, ~, handles)
uidata = get(handles.fmMain, 'userdata');
stop(uidata.timer);
end

% --- Executes during object creation, after setting all properties.
function sbSpeed_CreateFcn(hObject, ~, ~)
if isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', [.9 .9 .9]);
end
end

% --- Executes during object deletion, before destroying properties.
function fmMain_DeleteFcn(~, ~, handles)
uidata = get(handles.fmMain, 'userdata');
stop(uidata.timer);
end

% --- Executes on slider movement.
function sbSpeed_Callback(hObject, ~, handles)
    speed = get(hObject, 'value');  % Slider value
    uidata = get(handles.fmMain, 'userdata');
    % Set a faster period by scaling the slider value
    min_period = 0.1;  % Minimum timer period (adjust for desired speed)
    max_speed = 10;     % Maximum slider value for speed
    set(uidata.timer, 'period', min_period + (1 / speed) * (1 / max_speed));
end


% --- Executes on button press in btClose.
function btClose_Callback(~, ~, handles)
uidata = get(handles.fmMain, 'userdata');
stop(uidata.timer);
delete(handles.fmMain);
end

function updatepong(timerobj, ~)
    timerdata = get(timerobj, 'userdata');
    handles = timerobj.UserData;

    % Get current ball position and direction
    ballPos = get(timerdata.pong, {'xdata', 'ydata'});
    ballPos = [ballPos{:}];
    dir = timerdata.dir;

    % Ball movement step
    movement_step = 0.05;
    ballPos = ballPos + movement_step * dir;

    % Check for top and bottom edge reflection
    if ballPos(2) <= 0 || ballPos(2) >= 1
        dir(2) = -dir(2); % Reflect in y-direction
    end

    % Check for left edge (red bat)
    if ballPos(1) <= 0
        redBatY = get(timerdata.redbat, 'ydata');
        if ballPos(2) >= redBatY(1) && ballPos(2) <= redBatY(2)
            dir(1) = -dir(1); % Reflect in x-direction
        else
            % Ball missed red bat; blue scores
            blueScore = str2double(get(handles.txBlueScore, 'String')) + 1;
            set(handles.txBlueScore, 'String', num2str(blueScore));
            if blueScore >= 5
                stopGame(handles, 'Blue');
                return;
            end
            % Relaunch ball from center
            ballPos = [0.5, 0.5];
            dir = rand(1, 2) - 0.5; % Random new direction
            dir = dir / norm(dir);  % Normalize direction
        end
    end

    % Check for right edge (blue bat)
    if ballPos(1) >= 1
        blueBatY = get(timerdata.bluebat, 'ydata');
        if ballPos(2) >= blueBatY(1) && ballPos(2) <= blueBatY(2)
            dir(1) = -dir(1); % Reflect in x-direction
        else
            % Ball missed blue bat; red scores
            redScore = str2double(get(handles.txRedScore, 'String')) + 1;
            set(handles.txRedScore, 'String', num2str(redScore));
            if redScore >= 5
                stopGame(handles, 'Red');
                return;
            end
            % Relaunch ball from center
            ballPos = [0.5, 0.5];
            dir = rand(1, 2) - 0.5; % Random new direction
            dir = dir / norm(dir);  % Normalize direction
        end
    end

    % Ensure direction is valid
    if norm(dir) < 1e-3
        dir = rand(1, 2) - 0.5; % Reinitialize direction
        dir = dir / norm(dir);
    end

    % Update ball position and direction
    set(timerdata.pong, 'xdata', ballPos(1), 'ydata', ballPos(2));
    timerdata.dir = dir;
    set(timerobj, 'userdata', timerdata);
end


% --- Handles key presses for bat control.
function fmMain_WindowKeyPressFcn(hObject, ~, ~)
uidata = get(hObject, 'userdata');
timerdata = get(uidata.timer, 'userdata');
end
redBatY = get(timerdata.redbat, 'ydata');
blueBatY = get(timerdata.bluebat, 'ydata');

switch eventdata.Key
    case 'w'
        if redBatY(2) < 1
            redBatY = redBatY + 0.05;
            set(timerdata.redbat, 'ydata', redBatY);
        end
    case 's'
        if redBatY(1) > 0
            redBatY = redBatY - 0.05;
            set(timerdata.redbat, 'ydata', redBatY);
        end
    case 'o'
        if blueBatY(2) < 1
            blueBatY = blueBatY + 0.05;
            set(timerdata.bluebat, 'ydata', blueBatY);
        end
    case 'k'
        if blueBatY(1) > 0
            blueBatY = blueBatY - 0.05;
            set(timerdata.bluebat, 'ydata', blueBatY);
        end
end

set(uidata.timer)
end