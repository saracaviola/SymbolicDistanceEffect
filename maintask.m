% Generic symbolic distance paradigm 
% L.J Colling
% https://github.com/ljcolling/SymbolicDistanceEffect

%% Start of function

%% general paradigm options 

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
practiseBlockStims = repmat(p.stimItems,1,p.pracTrialsPerStim);
    
% generate experimental block
experimentalBlockStims = repmat(p.stimItems,1,p.trialsPerStim);

% mark where the instructions will be presented and the type of
% instructions




if p.pracBeforeEveryBlock == 0
    allExperimentalTrials = [];
    for i = 1 : p.nBlocks
       allExperimentalTrials = [allExperimentalTrials,shuffle(experimentalBlockStims)]; 
    end
    
    allTrials = [practiseBlockStims,allExperimentalTrials];
    
else
    error('Whoops! Haven''t coded that option!')
end

%% present the instructions



%% present the trials 

for t = 1 : size(size(allTrials,2))
    
    
end
    

