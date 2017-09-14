try
fid = fopen('Instructions.txt','rt');
c = fread(fid,'uint8=>char');
fclose all;

instructionsText = reshape(c,size(c,2),size(c,1));



[device,keyList,LeftKey,RightKey] = SetupKeyboard;





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
catch ME
    ListenChar
    sca
end