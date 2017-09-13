% Generic symbolic distance paradigm
% L.J Colling
% https://github.com/ljcolling/SymbolicDistanceEffect

%% Start of function


KbName('UnifyKeyNames');

d = IntializeDisplay;
[device,keyList,LeftKey,RightKey] = SetupKeyboard;


%% general paradigm options


% instructions and block markers
pracStartText = 'Start of practise block';
expStartText = 'Start of Block';


% stimlus and trial options

p.trialsPerStim = 10; % number of experimental trials per block
p.nBlocks = 2; % number of experimental blocks
p.pracBeforeEveryBlock = 0; % practise block before each experimental
% block 1 = YES; 0 = N0
p.pracTrialsPerStim = 2; % number of trials for each practice stimulus
p.stimItems = {'1' '4' '6' '9'}; % the actual stimuli to be used

% trial timing

p.tFixate = 200; % fixation cross time
p.tPostFixatePause = 1000; % Pause after fixation cross
p.tTimeout = 3000; % trial timeout
p.tInterTrial = 400; % inter trial interval

%% generate the trial arrays



% generate practice block

% mark where the instructions will be presented and the type of
% instructions


practiseBlockStims = repmat(p.stimItems,1,p.pracTrialsPerStim);
practiseBlockMarks = repmat(zeros(1,length(p.stimItems)),1,p.pracTrialsPerStim);
practiseBlockMarks(1) = 1;


practiseBlockTypes = repmat(zeros(1,length(p.stimItems))+1,1,p.pracTrialsPerStim);

% generate experimental block
experimentalBlockStims = repmat(p.stimItems,1,p.trialsPerStim);
experimentalBlockMarks = repmat(zeros(1,length(p.stimItems)),1,p.trialsPerStim);
experimentalBlockMarks(1) = 2;
experimentalBlockTypes = repmat(zeros(1,length(p.stimItems))+2,1,p.trialsPerStim);






if p.pracBeforeEveryBlock == 0
    allExperimentalTrials = [];
    allExperimentalMarks = [];
    allExperimentalTypes = [];
    for i = 1 : p.nBlocks
        allExperimentalTrials = [allExperimentalTrials,shuffle(experimentalBlockStims)];
        allExperimentalMarks = [allExperimentalMarks,experimentalBlockMarks];
        allExperimentalTypes = [allExperimentalTypes,experimentalBlockTypes];
    end,
    
    allTrials = [practiseBlockStims,allExperimentalTrials];
    allMarks = [practiseBlockMarks,allExperimentalMarks];
    allTypes = [practiseBlockTypes,allExperimentalTypes];
    
else
    error('Whoops! Haven''t coded that option!')
end

%% present the instructions

MainInstructions = 'The main instructions go in here';

fontSize = 50;
textWrap = 10;
vSpacing = 1;
Screen('TextSize',d.window,fontSize);
DrawFormattedText(d.window, MainInstructions, 'center', 'center', d.white, textWrap,[],[],vSpacing);
Screen('Flip', d.window);

PressToGo(device,keyList)
Screen('Flip', d.window);

%% present the trials
responseStruct = struct();
blockCounter = 1;
ListenChar(2)

for t = 1 : size(allTrials,2)
    
    thisMark = allMarks(t);
    
    switch thisMark
        case 1
            ShowText(d,fontSize,device,keyList,textWrap,vSpacing,pracStartText);
        case 2
            ShowText(d,fontSize,device,keyList,textWrap,vSpacing,[expStartText ' ' num2str(blockCounter) ' of ' num2str(p.nBlocks)]);
    end
    
    KbQueueCreate(device,keyList);
    responseStruct = DoTrial(responseStruct,d,p,allTrials,device,LeftKey,RightKey,t);
    
    
end