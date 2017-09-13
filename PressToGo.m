function PressToGo(device,keyList)
KbQueueCreate(device,keyList);
KbQueueStart(device)
pressed = 0;
while pressed == 0
    [ pressed, ~] = KbQueueCheck(device); %
end
KbQueueFlush(device);
KbQueueRelease(device);
KbQueueStop(device);
clear pressed
clear firstPress
end