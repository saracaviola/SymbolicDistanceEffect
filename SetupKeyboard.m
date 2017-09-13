function [device,keyList,LeftKey,RightKey] = SetupKeyboard

[keyboardIndices, productNames, ~] = GetKeyboardIndices;
for ki = 1 : length(productNames)
    useKeyboard = input(['Would you like to use ' productNames{ki} ' (y/n)? '],'s');
    if strcmpi(useKeyboard(1),'y')
        device = keyboardIndices(ki);
        break
    end
end

if ~exist('device','var')
    error('please select a keyboard to use')
end


KbName('UnifyKeyNames'); %used for cross-platform compatibility of keynaming
keys = KbName('space');



KbQueueCreate(device);
KbQueueFlush(device);
KbQueueStart(device);

pressed = 0;
thekey = 0;
ListenChar(2)


disp('Press the key you want for the LEFT BUTTON press')
LeftKey = DoCollectKeyStrokes(device);
disp(['We collected the key press ' LeftKey])

disp('Press the key you want for the RIGHT BUTTON press')
RightKey = DoCollectKeyStrokes(device);
disp(['We collected the key press ' RightKey])

keyList = zeros(1,256);
keyList(keys) = 1;
keys = KbName('q');
keyList(keys) = 1;

keys = KbName(LeftKey);
keyList(keys) = 1;

keys = KbName(RightKey);
keyList(keys) = 1;
ListenChar;

function thekey = DoCollectKeyStrokes(device)
pressed = 0; 
while pressed == 0
    [ pressed, firstPress] = KbQueueCheck(device); %  check if any key was pressed.
    firstPress(firstPress==0)=NaN; %little trick to get rid of 0s
    [pressTime, Index]=min(firstPress); % gets the RT of the first key-press and its ID
    thekey=KbName(Index); %converts KeyID to keyname
end


