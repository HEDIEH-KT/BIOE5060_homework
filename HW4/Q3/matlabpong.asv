function varargout = matlabpong(varargin)
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

% Last Modified by GUIDE v2.5 21-Nov-2024 14:04:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matlabpong_OpeningFcn, ...
                   'gui_OutputFcn',  @matlabpong_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before matlabpong is made visible.
function matlabpong_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matlabpong (see VARARGIN)

% Choose default command line output for matlabpong
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.plTitle, 'units', 'normalized', 'position', [0 0.85 1 0.15]);
set(handles.axCanvas, 'xlim', [0,1], 'ylim', [0,1], 'xtick', [], 'ytick', [], ...
    'units', 'normalized', 'position', [0.02 0.02 0.96 0.8]);
axis(handles.axCanvas, 'on');
box(handles.axCanvas, 'on');

set(handles.txRedScore, 'foregroundcolor', 'r')
set(handles.txBlueScore, 'foregroundcolor', 'b')

uidata=get(handles.fmMain, 'userdata');

delete(timerfindall)

uidata.timer=timer('TimerFcn', @updatepong);
uidata.timer.UserData=handles;
uidata.timer.Period=(1/get(handles.sbSpeed, 'value'));
uidata.timer.ExecutionMode  = 'fixedRate';

set(handles.fmMain, 'userdata', uidata);

% UIWAIT makes matlabpong wait for user response (see UIRESUME)
% uiwait(handles.fmMain);


% --- Outputs from this function are returned to the command line.
function varargout = matlabpong_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btStart.
    function btStart_Callback(hObject, eventdata, handles)
    % Set the initial position and direction of the ball
    handles.ball.Position = [0.5, 0.5]; % Initial center position
    handles.ball.Direction = [rand-0.5, rand-0.5]; % Random direction
    handles.ball.Speed = 0.02; % Initial speed
    start(handles.timer); % Start the timer
    guidata(hObject, handles);
end
% hObject    handle to btStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axCanvas);
hold(handles.axCanvas, 'on');

hpong=plot(0.5, 0.5, 'ro', 'markersize', 8, 'parent', handles.axCanvas);
y1=rand(1)*0.8;
y2=rand(1)*0.8;
hredbat=plot([0 0], [y1 y1+0.2], 'r-', 'linewidth', 8, 'parent', handles.axCanvas);
hbluebat=plot([1 1], [y2 y2+0.2], 'b-', 'linewidth', 8, 'parent', handles.axCanvas);

uidata=get(handles.fmMain, 'userdata');

timerdata=get(uidata.timer, 'userdata');
timerdata.pong = hpong;        % this is the handle to the pingpong dot object
timerdata.redbat = hredbat;    % this is the handle to the red-bat line object
timerdata.bluebat = hbluebat;  % this is the handle to the blue-bat line object
timerdata.dir = rand(1,2);     % this is a random direction
timerdata.dir = timerdata.dir./norm(timerdata.dir);

set(uidata.timer, 'userdata', timerdata);
set(handles.fmMain, 'userdata', uidata);

start(uidata.timer);

% --- Executes on button press in btStop.
function btStop_Callback(hObject, eventdata, handles)
% hObject    handle to btStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uidata=get(handles.fmMain, 'userdata');
stop(uidata.timer);


% --- Executes during object creation, after setting all properties.
function sbSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sbSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object deletion, before destroying properties.
function fmMain_DeleteFcn(hObject, eventdata, handles)
uidata = get(handles.fmMain, 'userdata');
stop(uidata.timer)


%%  Your work is mostly focused on completing the functions below


% --- Executes on slider movement.
function sbSpeed_Callback(hObject, eventdata, handles)
%% TODO: when this slider bar changes, you should set the timer's period accordingly
    function sbSpeed_Callback(hObject, eventdata, handles)
    newSpeed = get(hObject, 'Value'); % Read the slider value
    handles.ball.Speed = newSpeed; % Set the ball's speed
    guidata(hObject, handles);
end

uidata = get(handles.fmMain, 'userdata');
get(uidata.timer, 'period')
get(handles.sbSpeed, 'value')

% --- Executes on button press in btClose.
function btClose_Callback(hObject, eventdata, handles)
%% TODO: write this function to 1) stop the timer, 
    function btClose_Callback(hObject, eventdata, handles)
    stop(handles.timer); % Stop the timer
    delete(handles.figure1); % Close the window
end


function updatepong(timerobj, event)
%% TODO: please write this timer event function to move the pingpong ball
    function updatepong(hObject, eventdata)
    handles = guidata(hObject);

    % Update the ball's position
    ballPos = handles.ball.Position;
    ballDir = handles.ball.Direction;
    ballSpeed = handles.ball.Speed;
    newBallPos = ballPos + ballDir * ballSpeed;

    % Check for ball reflection from the edges
    if newBallPos(2) <= 0 || newBallPos(2) >= 1 % Reflection from top and bottom
        ballDir(2) = -ballDir(2);
    end

    % Check for ball reflection from players or scoring
    if newBallPos(1) <= 0 % Collision on the left side
        if checkBatCollision(handles.redBat, newBallPos)
            ballDir(1) = -ballDir(1);
        else
            handles.blueScore = handles.blueScore + 1; % Blue team scores
            resetBall(handles);
        end
    elseif newBallPos(1) >= 1 % Collision on the right side
        if checkBatCollision(handles.blueBat, newBallPos)
            ballDir(1) = -ballDir(1);
        else
            handles.redScore = handles.redScore + 1; % Red team scores
            resetBall(handles);
        end

    % Save the new position
    handles.ball.Position = newBallPos;
    handles.ball.Direction = ballDir;
    guidata(hObject, handles);
end

timerdata = get(timerobj, 'userdata');

% use these variables to move the pingpong or changing direction, or
% restart the game

get(timerdata.pong, {'xdata', 'ydata'})    % use timer.pong to get its x/y data
get(timerdata.redbat, 'ydata')             % use timer.redbat/timer.bluebat to get their ydata
timerdata.dir                              % this is the current direction, need to modify it if reflected


% at the end of the function, save the updated timerdata to timerobj.userdata
set(timerobj, 'userdata', timerdata);

% --- Executes on key press with focus on fmMain or any of its controls.
function fmMain_WindowKeyPressFcn(hObject, eventdata, handles)
%% TODO: write this function to move the two red/blue bats up and down 
    function WindowKeyPressFcn(hObject, eventdata, handles)
    key = eventdata.Key;

    % Control for the red player
    if strcmp(key, 'w') % Move up
        moveBat(handles.redBat, -0.05);
    elseif strcmp(key, 's') % Move down
        moveBat(handles.redBat, 0.05);
    end

    % Control for the blue player
    if strcmp(key, 'o') % Move up
        moveBat(handles.blueBat, -0.05);
    elseif strcmp(key, 'k') % Move down
        moveBat(handles.blueBat, 0.05);
    end

    guidata(hObject, handles);
end

uidata = get(handles.fmMain, 'userdata');
timerdata = get(uidata.timer, 'userdata');

disp(eventdata.Key)             % the keystroke that triggers this event
get(timerdata.redbat, 'ydata')  % the y-positions of the red-bat
get(timerdata.bluebat, 'ydata') % same for the blue-bat; bat length should always 0.2
function collided = checkBatCollision(bat, ballPos)
    batPos = bat.Position;
    collided = ballPos(2) >= batPos(2) && ballPos(2) <= batPos(2) + batPos(4);
end

function moveBat(bat, deltaY)
    newY = bat.Position(2) + deltaY;
    newY = max(min(newY, 1 - bat.Position(4)), 0); % Constrain the movement
    bat.Position(2) = newY;
end

function resetBall(handles)
    handles.ball.Position = [0.5, 0.5]; % Reset ball position to the center
    handles.ball.Direction = [rand-0.5, rand-0.5]; % Set a random direction
    guidata(handles.figure1, handles); % Update the handles
end