
%% read target data
targetdir = char(get(handles.edit1,'String'));
targetname = char(get(handles.edit2,'String'));
target    = load(fullfile(targetdir,targetname));
target = datapreproc(target,0);
sr_target = median(diff(target(:,1)));

% start and end of the 1st column of the target
tar1 = min(target(:,1));
tar2 = max(target(:,1));
target1 = target;
%% read series datasets
list_content = cellstr(get(handles.listbox2,'String')); % read contents of listbox 2
nrow = length(list_content);
% time direction
timedir = get(handles.popupmenu2,'Value');
%% read parameters
methodstr = get(handles.popupmenu1, 'String');
methodval = get(handles.popupmenu1,'Value');

cohthreshold = str2double(get(handles.edit7,'string'));
windowsize1 = str2double(get(handles.edit5,'string'));
windowsize = round(windowsize1/sr_target);
nooverlap1 = str2double(get(handles.edit6,'string'));
nooverlap = round(nooverlap1/sr_target);

if get(handles.radiobutton1,'value') == 1
    forp = 1; % plot freq
end
if get(handles.radiobutton2,'value') == 1
    forp = 2; % plot period
end

plotx1 = str2double(get(handles.edit8,'string'));
plotx2 = str2double(get(handles.edit9,'string'));
if get(handles.checkbox1,'value') == 1
    qplot1 = 1; % plot freq
else
    qplot1 = 0;
end
if get(handles.checkbox2,'value') == 1
    qplot2 = 1; % plot freq
else
    qplot2 = 0;
end
if get(handles.checkbox3,'value') == 1
    save1 = 1; % plot freq
else
    save1 = 0; % plot freq
end
%%
for i = 1:nrow
    data_name = char(list_content(i,1));
    [~,dat_name,~] = fileparts(data_name);
    data = load(fullfile(targetdir,data_name));
    % sort
    data = sortrows(data);
    % unique
    data=findduplicate(data);
    % remove empty
    data(any(isinf(data),2),:) = [];
    % start and end of the 1st column of the series
    ser1 = min(data(:,1));
    ser2 = max(data(:,1));
    
    series = data;
    %
    % interpolate series to reference
    series2int = interp1(series(:,1),series(:,2),target1(:,1));
    data  = [target1(:,1),series2int];
    
    % common interval
    sel1 = max(ser1, tar1); % lower bound
    sel2 = min(ser2, tar2); % upper bound
    if sel1 >= sel2
        error('Error: no overlap')
    else
        sel21 = sel2 - sel1;
        if sel21/2 < windowsize1
            warning('Window size is too large. Reset it... Done.')
            windowsize1 = sel21/2;
            windowsize = round(windowsize1/sr_target);
            nooverlap1 = round(windowsize1 * 0.5);
            nooverlap = round(nooverlap1/sr_target);
            set(handles.edit5,'string',num2str(windowsize1))
            set(handles.edit6,'string',num2str(nooverlap1))
        end
    end
    % Select the common interval for both target and series
    [series3] = select_interval(data,sel1,sel2);
    [target2] = select_interval(target1,sel1,sel2);
    
    %series2int = interp1(series3(:,1),series3(:,2),target2(:,1));
    %series4  = [target2(:,1),series2int]
    
    y = series3(:,2);
    y = (y - mean(y))/std(y);
    
    x = (target2(:,2) - mean(target2(:,2)))/std(target2(:,2));
    
    if methodval == 1
        % mscohere estimates the magnitude-squared coherence function
        % using Welch’s overlapped averaged periodogram method 
        % https://www.mathworks.com/help/signal/ref/mscohere.html
        [Cxy,F1,Pxy,F2] = cohac(x,y,sr_target,'hamming',windowsize,nooverlap,cohthreshold,0);
        Pxy = angle(Pxy);
        if save1 == 1
            %assignin('base','Cxy',Cxy)
            %assignin('base','F1',F1)
            %assignin('base','Pxy',Pxy)
            %assignin('base','F2',F2)
            pre_dirML = pwd;
            CDac_pwd; % cd working dir
            add_list = [dat_name,'-COH-',targetname];
            dlmwrite(add_list, [F1,Cxy], 'delimiter', ' ', 'precision', 9);
            add_list2 = [dat_name,'-Phase-',targetname];
            dlmwrite(add_list2, [F2,Pxy/pi * 180], 'delimiter', ' ', 'precision', 9);
            d = dir; %get files
            set(handles.listbox1,'String',{d.name},'Value',1) %set string
            %
            % refresh AC main window
            figure(handles.acfigmain);
            refreshcolor;
            cd(pre_dirML); % return view dir
        end
        
        % coherence_update
        if qplot1 == 1
            % plot subplot
            try figure(handles.subfigure)
                %clf;
                %clf('reset')
            catch
                handles.subfigure = figure;
                set(gcf,'units','norm') % set location
                set(gcf,'position',[0.005,0.45,0.38,0.45]) % set position
            end
            set(gcf,'color','w');
            set(gcf,'Name','Acycle: coherence and phase | coherence');
            
            subplot(2,1,1)
            if forp == 1
                plot(F1,Cxy,'k-o','LineWidth',2)
                xlabel('Frequency')
            else
                plot(1./F1(2:end),Cxy(2:end),'k-o','LineWidth',2)
                xlabel('Period')
            end
            xlim([plotx1, plotx2])
            ylim([0 1])
            hold on
            plot(xlim, [1 1]*cohthreshold, '-.b')
            title('Magnitude-Squared Coherence')
            ylabel('Coherence')
            set(gca,'XMinorTick','on','YMinorTick','on')
            hold off

            subplot(2,1,2)
            if forp == 1
                plot(F2,Pxy/pi * 180,'r-o','LineWidth',2)
                xlabel('Frequency')
            else
                plot(1./F2(2:end),Pxy(2:end)/pi * 180,'r','LineWidth',2)
                xlabel('Period')
            end
            xlim([plotx1, plotx2])
            ylim([-180 180])
            hold on
            plot(xlim, [1 1]*90, '--k')
            plot(xlim, [1 1]*45, ':k')
            plot(xlim, [1 1]*0, '-k')
            plot(xlim, [1 1]*-45, ':k')
            plot(xlim, [1 1]*-90, '--k')
            title('Cross Spectrum Phase')
            if timedir == 1
                ylabel(['Series lead (',char(176),')'])
            else
                ylabel(['Series lag (',char(176),')'])
            end
            set(gca,'XMinorTick','on','YMinorTick','on')
            hold off
        else
            try close handles.subfigure
            catch
            end
        end
        if qplot2 == 1
            try figure(handles.polarfigure)
                %clf;
            catch
                handles.polarfigure = figure;
                set(gcf,'units','norm') % set location
                set(gcf,'position',[0.385,0.45,0.38,0.45]) % set position
            end
            set(gcf,'color','w');
            set(gcf,'Name','Acycle: coherence and phase | phase');
            if forp == 1
                polarscatter(Pxy,F2,'filled','MarkerFaceAlpha',.5)
            else
                polarscatter(Pxy(2:end),1./F2(2:end),'filled','MarkerFaceAlpha',.5)
            end
            hold on
            rlim([plotx1, plotx2])
            if timedir == 1
                title(['Series leads (0-180',char(176),') or lags behind (180-360',char(176),') the reference'])
            else
                title(['Series lags behind (0-180',char(176),') or leads (180-360',char(176),') the reference'])
            end
            hold off
        else
            try close handles.polarfigure
            catch
            end
        end
    end
end
%% Plot
figure(handles.cohgui)