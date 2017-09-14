function d = IntializeDisplay
global ME;

try
Screen('Preference','SkipSyncTests',1)


% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = min(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);


[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black,[0 0 640 360]);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);



    for i = 1 :  100
        Screen('TextSize',window,i);
        %[nx,ny,bbox] = DrawFormattedText(window, '0', 'center', 'center', [1 1 1]);
        bbox = TextCenteredBounds(window,'0');
        pixelWidth  =  bbox(3) - bbox(1); %x
        pixelHeight = bbox(4) - bbox(2); %y
        d.fontSize(i,1) = pixelWidth;
        d.fontSize(i,2) = pixelHeight;
        
    end
catch
    error('something went wrong!')
end



d.window = window;
d.windoRect = windowRect;
d.screenNumber = screenNumber;
d.white = white;
d.black = black;
d.screenXpixels = screenXpixels;
d.screenYpixels = screenYpixels;
d.xCenter = xCenter;
d.yCenter = yCenter;