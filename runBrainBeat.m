%% Settings

%Folder and file settings
strFile = '20141121_xyt02_NatMovie.avi';
strPath = 'D:\Documents\Misc\2pArt\';

%Whether to play the sample upon pressing the number keys
boolPlayOnNumber = false; 

%Interval and threshold for samples
dblInterval = 0.5;
dblThreshold = 1.5;

%Colors of circles
matColors = [1 0 0 ; 1 1 0 ; 0 1 0 ; 0 0 1 ; 1 1 1 ; 0 1 1]*255;


%% Read in video file

objVideo = mmreader([strPath strFile]);
sVid.frameRate = 40;
sVid.vidFrames = read(objVideo);
sVid.numFrames = get(objVideo, 'numberOfFrames');


%% Define samples

%Set filenames of samples (must be present in working directory)
cellSamplesFiles{1} = 'Kick.wav';
cellSamplesFiles{2} = 'Clap.wav';
cellSamplesFiles{3} = 'Whistle.wav';
cellSamplesFiles{4} = 'Snap.wav';
cellSamplesFiles{5} = 'Cowbell.wav';
cellSamplesFiles{6} = 'Bass_d.wav';
cellSamplesFiles{7} = 'Bass_a.wav';
cellSamplesFiles{8} = 'Bass_f.wav';

%Load samples into workspace
cellSamples = cell(1,length(cellSamplesFiles));
for s = 1:length(cellSamples)
    cellSamples{s} = wavread(cellSamplesFiles{s});
end


%% Open screen and audio

%Initialize
Screen('Preference', 'SkipSyncTests', 1);
KbName('UnifyKeyNames');
HideCursor;
timerText = tic;

%Some laptops have an always down key (e.g. to indicate the screen is
%up), in my case this is key number 233
DisableKeysForKbCheck(233);

%Open a grey screen on the secondary display (if there is not already a
%open screen)
if isempty(Screen('Windows'))
    dblScreenID = max(Screen('Screens'));
    ptrWindow = Screen('OpenWindow', dblScreenID, 128);
end

%Get screen parameters
dblFrameRate = Screen('FrameRate', ptrWindow);
[dblScreenX, dblScreenY] = Screen('WindowSize', ptrWindow);
vecScreenRect = Screen('Rect', ptrWindow);

%Initialize Psych Port Audio
InitializePsychSound;
structDev = PsychPortAudio('GetDevices');
intDeviceID = [];
for d = 1:length(structDev)
    if strcmp(structDev(d).DeviceName,'Speakers (Realtek High Definition Audio)')
        intDeviceID = structDev(d).DeviceIndex;
    end
end
ptrMaster = PsychPortAudio('Open', intDeviceID, 9, 0, [], 2, 2048);
PsychPortAudio('Start', ptrMaster, 0, 0, 1);
ptrSlave = nan(1,length(cellSamples));
cellBuffer = nan(1,length(cellSamples));
for s = 1:length(cellSamples)
    ptrSlave(s) = PsychPortAudio('OpenSlave', ptrMaster, 1, 2);
    cellBuffer(s) = PsychPortAudio('CreateBuffer', ptrSlave(s), cellSamples{s}');
end

%% Run script

try
    %Welcome message
    Screen('DrawText', ptrWindow, 'Welcome to BrainBeat', dblScreenX/3, dblScreenY/2-40, [1 1 1]*255);
    Screen('DrawText', ptrWindow, 'Press any key to continue...', dblScreenX/3, dblScreenY/2+40, [1 1 1]*255);
    Screen('Flip', ptrWindow);
    KbWait;
    
    %Initialize
    boolRunning = true;
    intSwitch = 1;
    timePlay = tic;
    vecROI = zeros(1,20);
    cellROI = cell(1,20);
    timerVisual = tic;
    timerAudio(1:length(cellSamples)) = tic;
    boolKeyDown = false;
    intBass = 0;
    matTraces = nan(length(cellSamples),sVid.numFrames);
    
    %Start Assembly
    while boolRunning

        %Fill video buffer with current movie frame 
        intFrame = round((rem(toc(timerVisual), sVid.numFrames/sVid.frameRate) / (sVid.numFrames/sVid.frameRate)) * sVid.numFrames);
        if intFrame == 0 || intFrame == 1; intFrame = 2; end
        vidTex = Screen('MakeTexture', ptrWindow, squeeze(sVid.vidFrames(:,:,:,intFrame)));
        matRectVid = CenterRect([0 0 size(sVid.vidFrames,1) size(sVid.vidFrames,2)], vecScreenRect);
        Screen('DrawTexture', ptrWindow, vidTex, [], matRectVid);
        
        %Check for keyboard press
        [keyIsDown, ~, keyCode] = KbCheck();
        if keyIsDown == 1 && boolKeyDown == false;
            boolKeyDown = true;
            
            if keyCode(KbName('1!'))
                intSwitch = 1;
                if boolPlayOnNumber == true
                    PsychPortAudio('Stop', ptrSlave(intSwitch));
                    PsychPortAudio('FillBuffer', ptrSlave(intSwitch), cellBuffer(intSwitch)); %Play sample
                    PsychPortAudio('Start', ptrSlave(intSwitch));
                end
            elseif keyCode(KbName('2@')) 
                intSwitch = 2;
                if boolPlayOnNumber == true
                    PsychPortAudio('Stop', ptrSlave(intSwitch));
                    PsychPortAudio('FillBuffer', ptrSlave(intSwitch), cellBuffer(intSwitch)); %Play sample
                    PsychPortAudio('Start', ptrSlave(intSwitch));
                end
            elseif keyCode(KbName('3#'))
                intSwitch = 3;
                if boolPlayOnNumber == true
                    PsychPortAudio('Stop', ptrSlave(intSwitch));
                    PsychPortAudio('FillBuffer', ptrSlave(intSwitch), cellBuffer(intSwitch)); %Play sample
                    PsychPortAudio('Start', ptrSlave(intSwitch));
                end
            elseif keyCode(KbName('4$')) 
                intSwitch = 4;
                if boolPlayOnNumber == true
                    PsychPortAudio('Stop', ptrSlave(intSwitch));
                    PsychPortAudio('FillBuffer', ptrSlave(intSwitch), cellBuffer(intSwitch)); %Play sample
                    PsychPortAudio('Start', ptrSlave(intSwitch));
                end
            elseif keyCode(KbName('5%'))
                intSwitch = 5;
                if boolPlayOnNumber == true
                    PsychPortAudio('Stop', ptrSlave(intSwitch));
                    PsychPortAudio('FillBuffer', ptrSlave(intSwitch), cellBuffer(intSwitch)); %Play sample
                    PsychPortAudio('Start', ptrSlave(intSwitch));
                end
            elseif keyCode(KbName('6^'))
                intSwitch = 6;
                if boolPlayOnNumber == true
                    PsychPortAudio('Stop', ptrSlave(intSwitch));
                    PsychPortAudio('FillBuffer', ptrSlave(intSwitch), cellBuffer(intSwitch)); %Play sample
                    PsychPortAudio('Start', ptrSlave(intSwitch));
                end
            elseif keyCode(KbName('q'))
                vecROI(1) = 0;
                matTraces(1,:) = NaN;
            elseif keyCode(KbName('w'))
                vecROI(2) = 0;
                matTraces(2,:) = NaN;
            elseif keyCode(KbName('e'))
                vecROI(3) = 0;
                matTraces(3,:) = NaN;
            elseif keyCode(KbName('r')) 
                vecROI(4) = 0;
                matTraces(4,:) = NaN;
            elseif keyCode(KbName('t'))
                vecROI(5) = 0;
                matTraces(5,:) = NaN;
            elseif keyCode(KbName('y'))
                vecROI(6) = 0;
                matTraces(6,:) = NaN;
            elseif keyCode(KbName('UpArrow')) && toc(timerText) > dblInterval  %Increase threshold
                dblThreshold = dblThreshold+0.1;
                timerText = tic;
            elseif keyCode(KbName('DownArrow')) && toc(timerText) > dblInterval  %Decrease threshold
                dblThreshold = dblThreshold-0.1;
                timerText = tic;
            elseif keyCode(KbName('Escape')) %Stop program
                boolRunning = false;
            end
            
        elseif keyIsDown == 0 && boolKeyDown == true
            boolKeyDown = false;
        end
            
        %Draw text if necessary
        if toc(timerText) < 1
            Screen('DrawText', ptrWindow, ['Threshold: ' num2str(dblThreshold)], dblScreenX-dblScreenX/5, dblScreenY-dblScreenY/5, [1 1 1]*255);
        end
        
        %Present circle at location of cursor
        [dblMouseX, dblMouseY, vecButtons, boolFocus] = GetMouse(ptrWindow);
        matRect = [0 0 30 30];
        matRect = CenterRectOnPoint(matRect, dblMouseX, dblMouseY);
        Screen('FrameOval', ptrWindow, matColors(intSwitch,:), matRect, 3); 
        
        %Check for button press
        if vecButtons(1) ~= 0 
            vecROI(intSwitch) = 1;
            cellROI{intSwitch} = matRect;
            matTraces(intSwitch,:) = NaN;
        end
        
        %Draw circles at clicked neurons and get their images
        for c = find(vecROI)
            Screen('FrameOval', ptrWindow, matColors(c,:), cellROI{c}, 3);
            matGreenFrame = sVid.vidFrames(:,:,2,intFrame);
            matNeuron = matGreenFrame(cellROI{c}(2)-matRectVid(2):cellROI{c}(4)-matRectVid(2),cellROI{c}(1)-matRectVid(1):cellROI{c}(3)-matRectVid(1));
            matTraces(c,intFrame) = mean(mean(matNeuron));
            
            %Play sample if fluorescence exeeds threshold
            if mean(mean(matNeuron)) > nanmean(matTraces(c,:))+nanstd(matTraces(c,:))*dblThreshold && toc(timerAudio(c)) > dblInterval && sum(~isnan(matTraces(c,:))) > 20
                PsychPortAudio('Stop', ptrSlave(c));
                if c == 6
                    PsychPortAudio('FillBuffer', ptrSlave(c), cellBuffer(c+intBass));
                    intBass = mod(intBass + 1, 3);
                else
                    PsychPortAudio('FillBuffer', ptrSlave(c), cellBuffer(c));
                end
                PsychPortAudio('Start', ptrSlave(c));
                timerAudio(c) = tic;
            end
                
        end
           
        %Flip video buffer to screen
        Screen('Flip', ptrWindow);
        Screen('Close',vidTex);
    end
        
catch WentWrong
    
    %Catch error and close down
    ShowCursor;
    Screen('CloseAll');
    PsychPortAudio('Close');
    rethrow(WentWrong);
end
    
%Close down
ShowCursor;
Screen('CloseAll');
PsychPortAudio('Close');




