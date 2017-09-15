clear;
close all;

try
    addpath('functions')
    fid = fopen('Instructions.txt','rt');
    c = fread(fid,'uint8=>char');
    fclose all;
    
    instructionsText = reshape(c,size(c,2),size(c,1));
    
    fprintf(['\n\n\nThis is the setup function. It will take you through some basic calibration.\n'...
        'The first step will be to setup the keyboard. You will be asked to press the\n'...
        'key that you want for the LEFT and RIGHT button press. After this you will be\n'...
        'asked to set up the font size for the instructions. You will do this using the\n'...
        'arrow keys on your keyboard.\n\n']);
    
    
    fprintf('Please set up the keyboard now\n');
    [device,deviceName,keyList,LeftKey,RightKey] = SetupKeyboard;
    
    
    fprintf(['\n\nThe keyboard setup is done. At the next screen use the arrow keys\n'...
        'to adjust the fontsize and line length. The left and right arrow\n'...
        'adjust the font size and the up and down arrow to adjust how many\n'...
        'words fit on each line. Once you are happy with the font size, hit\n'...
        'the "q" key. When you are ready to do this, press SPACE to continue.\n\n']);
    PressToGo(device,keyList)
    
    
    ListenChar(2)
    d = IntializeDisplay;
    KbName('UnifyKeyNames')
    
    escapeKey = KbName('q');
    upKey = KbName('UpArrow');
    downKey = KbName('DownArrow');
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');
    moreSpace = KbName('=+');
    lessSpace = KbName('-_');
    
    fontSize = 50;
    textWrap = 10;
    vSpacing = 2;
    Screen('TextSize',d.window,fontSize);
    DrawFormattedText(d.window, instructionsText, 'center', 'center', [1 1 1], 80);
    
    
    
    Screen('Flip', d.window);
    
    % resize the box
    
    resizing = 1;
    while resizing == 1
        
        [keyIsDown,~, keyCode] = KbCheck(device);
        
        if keyCode(escapeKey)
            resizing = 0;
        elseif keyCode(leftKey)
            fontSize = fontSize - 1;
        elseif keyCode(rightKey)
            fontSize = fontSize + 1;
        elseif keyCode(upKey)
            textWrap = textWrap - 1;
        elseif keyCode(downKey)
            textWrap = textWrap + 1;
        elseif keyCode(moreSpace)
            vSpacing = vSpacing + 1;
        elseif keyCode(lessSpace)
            vSpacing = vSpacing - 1;
            
        end
        WaitSecs(.05);
        Screen('TextSize',d.window,fontSize);
        DrawFormattedText(d.window, instructionsText, 'center', 'center', d.white, textWrap,[],[],vSpacing);
        Screen('Flip', d.window);
        
    end
    
    
    
    ListenChar
    sca
    fprintf('\n\nALL DONE!\n\nYou can now run the main experiment.\n\n');
    
    params.device = device;
    params.deviceName = deviceName;
    params.LeftKey = LeftKey;
    params.RightKey = RightKey;
    params.instructionsText = instructionsText;
    params.vSpacing = vSpacing;
    params.textWrap = textWrap;
    params.fontSize = fontSize;
    params.keyList = keyList;
    save('params','params');
    
catch ME
    ListenChar
    sca
end