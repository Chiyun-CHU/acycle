function [xx,datopt,xcl,sr_p] =timeOptAc(dat,sedmin,sedmax,numsed,nsim,linLog,fit,fl,fh,roll,targetE,targetP,detrend,cormethod,genplot)

%% timeOpt script to conduct the timeOpt analysis
%   to evaluate the most likely sedimentation rate from a data series.
%
% This script is largely based on: 
%   Steve Meyers's timeOpt script in astrochron R package, 
%   Steve Meyers's paper (Meyers, 2015, Paleoceanography. doi: 10.1002/2015PA002850), 
%   Linda Hinnov's "TimeSeries" lecture at Geroge Mason University, and 
%   Linda Hinnov's tanerhilbert.m MatLab script in Kodama & Hinnov (2015).
%
%% Input
% 
%   dat:    data, 2 column depth-domain series. No header. The unit has to be cm
%   sedmin: minimum tested sedimentation rate
%   sedmax: maximum tested sedimentation rate
%   numsed: number of tested sedimentation rate
%   nsim: number of Monte Carlo simulations
%       to generate AR1 surrogates (red noise series) with a rho estimated from "dat" 
%   linLog: linear or logarithmic scaling for sedimentation rate grid spacing
%            (1=linear, 2=log; default value is 1)
%   fit:    Test for (1) precession amplitude modulation or 
%                    (2) short eccentricity amplitude modulation
%                     astrochron notes that the Option #2 is experimental
%                    (default value is 1)
%   fl:     Low frequency cut-off for Taner bandpass
%   fh:     High frequency cut-off for Taner bandpass
%   roll:   Taner filter roll-off rate, in dB/octave; 
%           [to do: need to adjust this]
%   targetE:A vector of eccentricity periods to evaluate (in kyr). 
%           In constract to astrochron, these may not be in order of 
%           decreasing period, with a first value of 405 ka
%   targetP: A vector of precession periods to evaluate (in kyr).
%   detrend: Remove linear trend from data series?
%   cormethod: correlation method.
%           (1 = pearson; 2 = spearman; default = 2)
%   genplot: Generate summary plots? 0 = no, 1 = yes
%
%% Output:
%
%   xx: a 4 columns matrix:
%       1st: all tested sedimentation rate;
%       2nd: r^2_envelope at the corresponding sed. rate
%       3rd: r^2_power at the corresponding sed. rate
%       4th: r^2_opt at the corresponding sed. rate
%   datopt: optimal time series, bandpassed series, envelope, reconstructed eccentricity model
%   xcl:
%   sr_p: output optimal sed. rate for xx
%
%% Calls for
%
%   sortrows : MatLab function
%   tanerhilbertML.m : taner hilbert filter
%   fitItls.m   least square fit
%   harm1ML.m   least squares estimate a and b:  fy = a*cos(w*t) + b*sin(w*t)
%   timeOptSimAc.m :  Monte carlo simulation estimating significance
%               intervals for the peak of r^_opt
%   rhoAR1.m    AR1 rho estimation
%
%% References: 
%
%   Meyers, S.R., 2015. The evaluation of eccentricity?related 
%       amplitude modulation and bundling in paleoclimate data: 
%       An inverse approach for astrochronologic testing and 
%       time scale optimization. Paleoceanography. doi: 10.1002/2015PA002850
%
%   Meyers, S.R., 2014. astrochron: An R Package for Astrochronology. 
%       http://cran.r-project.org/package=astrochron.
%
%   Kodama, K.P., Hinnov, L., 2015. Rock Magnetic Cyclostratigraphy. Wiley-Blackwell.
%
%% Examples:
%
%% #1 generate a 200 random number and run the timeOpt
%   timeOptAc();
%% #2 calls for a txt file entitled "la04-1-2kRed.txt"
% a file with 1 cm/kyr sed. rate from
%           La2004 astronomical solution from 1 to 2000 kyr added with a rho=0.5 red
%           noise series, or a red noise series with rho=0.7
%
%   la04red=load('la04-1-2kRed-new.txt');
%   timeOptAc(la04red,0.1,10,200,1000);
%
%% #3 calls for a txt file entitled "la04-1-2kRed.txt"
%
% dat=load('la04-1-2kRed.txt');  
% dat(:,1) = dat(:,1)*2;
% sedmin = 1;
% sedmax = 10;
% numsed = 100;
% nsim = 1000;
% linLog = 2; 
% fit =1;
% fl=0.035; 
% fh=0.065;
% roll = 10^12;
% targetE = [405.6795,130.719,123.839,98.86307,94.87666];
% targetP = [23.62069,22.31868,19.06768,18.91979];
% detrend = 0;
% cormethod =2;
% genplot = 1;
% [xx,datopt]=timeOptAc(dat,sedmin,sedmax,numsed,nsim,linLog,fit,fl,fh,roll,targetE,targetP,detrend,cormethod,genplot);
%
%% By Mingsong Li, Penn State
%   Date:   Jan.  5, 2019
%   update: Mar. 14, 2020
%   mul450@psu.edu; www.mingsongli.com
%
%%
if nargin < 15; genplot = 1; end % default: plot 1= multiple plot; 2 = one plot
if nargin < 14; cormethod = 2; end
if nargin < 13; detrend = 0; end % default: no detrending
if nargin < 12; targetP = [23.62069,22.31868,19.06768,18.91979]; end % default: precession
if nargin < 11; targetE = [405.6795,130.719,123.839,98.86307,94.87666]; end % default: eccentricity
if nargin < 10; roll = 10^12; end % default: roll off rate
if nargin < 9; fh = 0.065; end % default: high cutoff freq
if nargin < 8; fl = 0.035; end % default: low cutoff freq
if nargin < 7; fit = 1;  end  % default: fit to precession amplitude modulation
if nargin < 6; linLog = 1; end % linear (1) or log (2) sedimentation rate grid
if nargin < 5; nsim = 1000; end
if nargin < 4; numsed = 100; end % tested 100 sed. rates
if nargin < 3; sedmax = 30; end  % max sed. rate is 30 cm/kyr
if nargin < 2; sedmin = 0.1;end % min sed. rate is 0.1 cm/kyr
if nargin < 1 % if no input date ...
    n = 300; dat(:,1) = (1:n)'; dat(:,2) = filter(1,[1;-0.5],randn(n,1));
end 

%%
lsmethod = 1;  % least square method, useless
%%
datx = dat(:,1);  % unit should be cm
daty = dat(:,2);
diffx = diff(datx);
npts = length(datx);
sr_p =[];
% cormethod = 2;
fc=(fh+fl)/2;
% precession amplitude modulation
if fit == 1
    targetTot = [targetE,targetP]; 
elseif fit == 2
    targetTot = targetE;
end
% check data
if sum(diffx <= 0) > 0
    disp('>>  Waning: data has to be in ascending order, no duplicated number allowed')
    dat = sortrows(dat);
end

% check data
if abs((max(diffx)-min(diffx))/2) > 10* eps;
    disp('>>  Waning: data may not be evenly spaced')
end

dt = median(diff(dat(:,1)));
fnyq = sedmin/(2*dt);
if fh > fnyq
    sedmin1 = 2*dt*fh;
    disp('>>  Waning: minimum sedimentation rate is too low')
    disp(['        minimum sedimentation rate may be reset to ',num2str(sedmin1)])
end
fray = sedmax/(npts*dt);
flow = 1/max(targetE);
if fray > flow
    sedmax1 = npts * dt * flow;
    disp('>>  Waning: maximum sedimentation rate is too high')
    disp(['       maximum sedimentation rate may be reset to ',num2str(sedmax1)])
end

if linLog == 1
    sedrate = linspace(sedmin,sedmax,numsed);
elseif linLog == 2
    sedinc = (log10(sedmax) - log10(sedmin))/(numsed-1);
    sedrate = zeros(1,numsed);
    for ii = 1: numsed
        sedrate(ii) = 10^(  log10(sedmin)  +  (ii-1) * sedinc ) ;
    end
end

if detrend == 1
    sdat = polyfit(datx,daty,1);
    datalinear = datx * sdat(1) + sdat(2);
    dat(:,2) = dat(:,2) - datalinear;
end

% normalization, follow timeOpt in astrochron
data(:,2) = (dat(:,2) - mean(dat(:,2)))/std(dat(:,2));
% output data
xx = zeros(numsed,4);
%
for i = 1:numsed
    sedrate1 = sedrate(i);
    data(:,1) = dat(:,1)/sedrate1;
    %
    [tanhilb,~,~] = tanerhilbertML(data,fc,fl,fh,roll);
    timeSeries(:,1) = tanhilb(:,1);
    timeSeries(:,2) = tanhilb(:,3);
    if fit == 1
        [rsq, ~] = fitItls(timeSeries, sedrate1,targetE, cormethod,lsmethod);
        [rsqpwrOut, ~] = fitItls(data, sedrate1,targetTot, cormethod,lsmethod);
    elseif fit == 2
        [rsq, ~] = fitItls(timeSeries, sedrate1,targetE(1), cormethod,lsmethod);
        [rsqpwrOut, ~] = fitItls(data, sedrate1, targetTot, cormethod,lsmethod);
    end
    xx(i,1) = sedrate1;
    xx(i,2) = rsq;
    xx(i,3) = rsqpwrOut;
    xx(i,4) = rsq*rsqpwrOut;
end

%% Find max
r2env = xx(:,2);
maxr2env = max(r2env);
locj = find(r2env == maxr2env);
if length(locj) > 1
    disp('>>  WARNING: Multiple envelope maxima detected.')
end
r2pwr = xx(:,3);
maxr2pwr = max(r2pwr);
locm = find(r2pwr == maxr2pwr);
if length(locm) > 1
    disp('>>  WARNING: Multiple spectral power maxima detected.')
end
r2opt = xx(:,4);
maxr2opt = max(r2opt);
loci = find(r2opt == maxr2opt);
if length(loci) > 1
    disp('>>  WARNING: Multiple (spectral power*envelope) maxima detected.')
end

%% display
disp(['>>  Maximum envelope r^2 = ',num2str(maxr2env)])
disp(['>>       at sedimentation rate of ',num2str(sedrate(locj(1))),' cm/kyr'])
disp(['>>  Maximum spectral power r^2 = ',num2str(maxr2pwr)])
disp(['>>       at sedimentation rate of ', num2str(sedrate(locm(1))),' cm/kyr'])
disp(['>>  Maximum (envelope r^2) x (spectral power r^2) = ',num2str(maxr2opt)])
disp(['>>       at sedimentation rate of ', num2str(sedrate(loci(1))),' cm/kyr'])
sr_p = [sedrate(locm(1)), maxr2pwr, sedrate(locj(1)), maxr2env, sedrate(loci(1)), maxr2opt];
%
data(:,1) = dat(:,1)/sedrate(loci(1));
data(:,1) = data(:,1) - min(data(:,1));
[tanhilb,~,~] = tanerhilbertML(data,fc,fl,fh,roll);

timeSeries(:,1) = tanhilb(:,1);
timeSeries(:,2) = tanhilb(:,3);
if fit == 1
    [~, datay] = fitItls(timeSeries, sedrate(loci(1)), targetE, cormethod,lsmethod, genplot);
elseif fit == 2
    [~, datay] = fitItls(timeSeries,sedrate(loci(1)), targetE(1), cormethod,lsmethod,genplot);
end

datopt = data;
datopt(:,3) = tanhilb(:,2);
datopt(:,4) = tanhilb(:,3);

if genplot == 1
    figure;
    set(gcf,'Name','Acycle: TimeOpt #2')
    set(gcf,'Units','normalized','Position',[0.33, 0.5, 0.33, 0.4])
    subplot(2,1,1)
    plot(tanhilb(:,1),tanhilb(:,2),'b-','LineWidth',2);hold on;
    plot(tanhilb(:,1),tanhilb(:,3),'r','LineWidth',3);
    %legend('Taner filtered','Envolope')
    title(['Taner filtered (blue) vs. envelope (red) @ ', num2str(sedrate(loci(1))), ' cm/kyr'])
    xlabel('Time (kyr)')
    ylabel('Std. value')
    xlim([min(tanhilb(:,1)), max(tanhilb(:,1))])
    
    subplot(2,1,2)
    dt = median(diff(data(:,1)));
    [po,fd1]=periodogram(data(:,2),[],[],1/dt);
    plot(fd1,po,'k','LineWidth',1);
    xlabel('Frequency (cycles/kyr)') 
    ylabel('Power')
    title('Periodogram (black) vs. astronomical frequencies (dashed red)')
    xlim([0,.1])
    hold on;
    for i = 1: length(targetTot)
        line([1/targetTot(i) 1/targetTot(i)],[min(po) max(po)],'Color','red','LineStyle','--')
    end
end
    
%% generate plot
if genplot == 1
    figure;
    
    set(gcf,'Name','Acycle: TimeOpt #3')
    set(gcf,'Units','normalized','Position',[0.66, 0.5, 0.33, 0.4])
    set(gcf,'color','w');
    
    subplot(3,1,1)
    plot(sedrate,xx(:,2),'ro','LineWidth',2);
    line([sedrate(locj(1)) sedrate(locj(1))],[min(xx(:,2)) max(xx(:,2))],'Color','red','LineStyle','--')
    %legend('r^2_e_n_v_e_l_o_p_e')
    xlabel('Sedimentation rate (cm/kyr)')
    ylabel('r^2_e_n_v_e_l_o_p_e')
    xlim([sedmin,sedmax])
    
    subplot(3,1,2)
    plot(sedrate,xx(:,3),'-','color',[0,0,0]+.5,'LineWidth',2);
    line([sedrate(locm(1)) sedrate(locm(1))],[min(xx(:,3)) max(xx(:,3))],'Color','red','LineStyle','--')
    %legend('r^2_p_o_w_e_r')
    xlabel('Sedimentation rate (cm/kyr)')
    ylabel('r^2_p_o_w_e_r')
    xlim([sedmin,sedmax])
    
    subplot(3,1,3)
    plot(sedrate,xx(:,4),'k-','LineWidth',3);
    line([sedrate(loci(1)) sedrate(loci(1))],[min(xx(:,4)) max(xx(:,4))],'Color','red','LineStyle','--')
    %legend('r^2_o_p_t')
    xlabel('Sedimentation rate (cm/kyr)')
    ylabel('r^2_o_p_t')
    xlim([sedmin,sedmax])
end

if genplot == 2
    figure;
    set(gcf,'Name','Acycle: TimeOpt Plot')
    set(gcf,'Units','normalized','Position',[0.06, 0.1, 0.8, 0.8])
    set(gcf,'color','w');
    
    subplot(3,2,1)
    plot(sedrate,xx(:,4),'k-','LineWidth',3);
    line([sedrate(loci(1)) sedrate(loci(1))],[min(xx(:,4)) max(xx(:,4))],'Color','red','LineStyle','--')
    xlabel('Sedimentation rate (cm/kyr)')
    ylabel('r^2')
    xlim([sedmin,sedmax])
    title('Optimal fit: r^2_o_p_t')
    %
    subplot(3,2,2)
    plot(datay(:,1), datay(:,2),'r','LineWidth',3);
    hold on;
    plot(datay(:,1), datay(:,3),'k','LineWidth',2);
    title(['Envelope (red) vs. reconstructed model (black) @ ', num2str(sedrate(loci(1))),' cm/kyr'])
    xlabel('Time (kyr)')
    ylabel('Std. value')
    xlim([min(datay(:,1)), max(datay(:,1))])
    
    subplot(3,2,3)
    yyaxis right
    plot(sedrate,xx(:,2),'ro','LineWidth',2);
    line([sedrate(locj(1)) sedrate(locj(1))],[min(xx(:,2)) max(xx(:,2))],'Color','red','LineStyle','--')
    xlabel('Sedimentation rate (cm/kyr)')
    ylabel('r^2')
    %ylabel('r^2_p_o_w_e_r')
    xlim([sedmin,sedmax])
    yyaxis left
    plot(sedrate,xx(:,3),'-','color',[0,0,0]+.5,'LineWidth',2);
    line([sedrate(locm(1)) sedrate(locm(1))],[min(xx(:,3)) max(xx(:,3))],'Color','red','LineStyle','--')
    %ylabel('r^2_e_n_v_e_l_o_p_e')
    xlim([sedmin,sedmax])
    title('Fit: r^2_e_n_v_e_l_o_p_e (red) vs. r^2_p_o_w_e_r (gray)')
    ax = gca;
    ax.YAxis(1).Color = [0,0,0]+.5;
    ax.YAxis(2).Color = 'r';
  
    subplot(3,2,4)
    plot(tanhilb(:,1),tanhilb(:,2),'b-','LineWidth',2);hold on;
    plot(tanhilb(:,1),tanhilb(:,3),'r','LineWidth',3);
    title(['Taner filtered (blue) vs. envelope (red) @ ', num2str(sedrate(loci(1))), ' cm/kyr'])
    xlabel('Time (kyr)')
    ylabel('Std. value')
    xlim([min(tanhilb(:,1)), max(tanhilb(:,1))])  
    
    subplot(3,2,5)
    plot(datay(:,2), datay(:,3),'ko','MarkerSize',10)
    hold on;
    plot(datay(:,2), datay(:,4),'r--','LineWidth',3)
    xlabel('Envelope')
    ylabel('Reconstructed model')
    title(['Envelope vs. reconstructed model (dot) @ ', num2str(sedrate(loci(1))),' cm/kyr & linear fit (red)'])
    
    subplot(3,2,6)
    dt = median(diff(data(:,1)));
    [po,fd1]=periodogram(data(:,2),[],[],1/dt);
    plot(fd1,po,'k','LineWidth',1);
    xlabel('Frequency (cycles/kyr)') 
    ylabel('Power')
    title('Periodogram (black) vs. astronomical frequencies (dashed red)')
    xlim([0,.1])
    hold on;
    for i = 1: length(targetTot)
        line([1/targetTot(i) 1/targetTot(i)],[min(po) max(po)],'Color','red','LineStyle','--')
    end
    
end
%% Monte Carlo simulation
xcl = [];
if nsim > 1
    disp('>>  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *')
    disp(['>>  Wait, Monte Carlo # Simulations = ',num2str(nsim)])
    disp('>>  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *')
    
    choice = questdlg(['Full range of test sed. rate or the optimal sed. rate at ', num2str(sedrate(loci(1))), ' cm/kyr only?'], ...
	'Acycle: TimeOpt Monte Carlo selection', 'Optimal sed. rate only','Full range of test sed. rate','Cancel','Optimal sed. rate only');
    % Handle response
    switch choice
        case 'Optimal sed. rate only'
            nsim_yes = 0;
        case 'Full range of test sed. rate'
            nsim_yes = 1;
        case 'Cancel'
            nsim_yes = 2;
    end
    if nsim_yes == 1
        %hwarndlg = warndlg('Monte Carlo simulation. Very Slow. Please Wait ...');
        xcl  = ones(numsed,4);
        % Waitbar
        hwaitbar = waitbar(0,'TimeOpt: Monte Carlo simulation. processing ...',...    
           'WindowStyle','modal');
        hwaitbar_find = findobj(hwaitbar,'Type','Patch');
        set(hwaitbar_find,'EdgeColor',[0 0.9 0],'FaceColor',[0 0.9 0]) % changes the color to blue
        setappdata(hwaitbar,'canceling',0)
        steps = numsed;
        % step estimation for waitbar
        waitbarstep = 0;
        waitbar(waitbarstep / steps)
        defaultcl = 1/(nsim+1);
        for i = 1:numsed
            sedrate1 = sedrate(i);
            xsim = timeOptSimAc(dat,sedrate1,nsim,fit,cormethod,targetE,targetP,fc,fl,fh,roll);
            xcl(i,1) = sedrate1;
            xs1 = xsim(:,1);
            xcl(i,2) = length(xs1(xs1>r2env(i)))/nsim;
            if xcl(i,2) == 0
                xcl(i,2) = defaultcl;
            end
            xs2 = xsim(:,2);
            xcl(i,3) = length(xs2(xs2>r2pwr(i)))/nsim;
            if xcl(i,3) == 0
                xcl(i,3) = defaultcl;
            end
            xs3 = xsim(:,3);
            xcl(i,4) = length(xs3(xs3>r2opt(i)))/nsim;
            if xcl(i,4) == 0
                xcl(i,4) = defaultcl;
            end
            % waitbar
            pause(0.0001);%
            waitbar(i / steps)
            if getappdata(hwaitbar,'canceling')
                break
            end
            
            % display
            disp(' ')
            disp(['>>  At sedimentation rate of ', num2str(sedrate1)])
            disp(['>>    Envelope r^2 p-value = ',num2str(xcl(i,2),'%.5f')])    
            disp(['>>    Power    r^2 p-value = ',num2str(xcl(i,3),'%.5f')])
            disp(['>>    Optimal  r^2 p-value = ',num2str(xcl(i,4),'%.5f')])
            
        end
        
        % close hwaitbar
        try close(hwaitbar)
        catch
        end
        
        % plot
        figure;
        set(gcf,'Units','normalized','Position',[0.1, 0.1, 0.4, 0.6])
        set(gcf,'Name','Acycle: TimeOpt Null Hypothesis Testing')
        set(gcf,'color','w');
        sr1 = min(sedrate);
        sr2 = max(sedrate);
        
        ax1 = subplot(3,1,1);
        semilogy(ax1, xcl(:,1),xcl(:,2),'r','LineWidth',1); 
        xlabel(ax1, 'Sedimentation rate (cm/kyr)')
        ylabel(ax1, 'H_0 significance level')
        title(ax1, 'r^2_e_n_v_e_l_o_p_e null hypothesis')
        ylim(ax1, [0.5*min(xcl(:,2)) 1])
        line([sr1, sr2],[.10, .10],'LineStyle',':','Color','k')
        line([sr1, sr2],[.05, .05],'LineStyle',':','Color','k')
        line([sr1, sr2],[.01, .01],'LineStyle','--','Color','k')
        line([sr1, sr2],[.001, .001],'LineStyle',':','Color','k')
        xlim(ax1,[sr1, sr2])
        %legend('H_0 Sig.level','10 %','5 %','1 %','0.1 %')
        set(ax1,'Ydir','reverse')
        
        ax2 = subplot(3,1,2);
        semilogy(ax2, xcl(:,1),xcl(:,3),'r','LineWidth',1); 
        xlabel(ax2, 'Sedimentation rate (cm/kyr)')
        ylabel(ax2, 'H_0 significance level')
        title(ax2, 'r^2_p_o_w_e_r null hypothesis')
        ylim(ax2, [0.5*min(xcl(:,3)) 1])
        line([sr1, sr2],[.10, .10],'LineStyle',':','Color','k')
        line([sr1, sr2],[.05, .05],'LineStyle',':','Color','k')
        line([sr1, sr2],[.01, .01],'LineStyle','--','Color','k')
        line([sr1, sr2],[.001, .001],'LineStyle',':','Color','k')
        %legend('H_0 Sig.level','10 %','5 %','1 %','0.1 %')
        xlim(ax2,[sr1, sr2])
        set(ax2,'Ydir','reverse')
        
        ax3 = subplot(3,1,3);
        semilogy(ax3, xcl(:,1),xcl(:,4),'r','LineWidth',1); 
        xlabel(ax3, 'Sedimentation rate (cm/kyr)')
        ylabel(ax3, 'H_0 significance level')
        title(ax3, 'r^2_o_p_t null hypothesis')
        ylim(ax3, [0.5*min(xcl(:,4)) 1])
        line([sr1, sr2],[.10, .10],'LineStyle',':','Color','k')
        line([sr1, sr2],[.05, .05],'LineStyle',':','Color','k')
        line([sr1, sr2],[.01, .01],'LineStyle','--','Color','k')
        line([sr1, sr2],[.001, .001],'LineStyle',':','Color','k')
        legend('H_0 Sig.level','10 %','5 %','1 %','0.1 %')
        xlim(ax3,[sr1, sr2])
        set(ax3,'Ydir','reverse')
    end
    
    if nsim_yes == 0
        xcl  = ones(1,4);
        hwarndlg = warndlg('Monte Carlo simulation. Please Wait ...');
        xsim = timeOptSimAc(dat,sedrate(loci(1)),nsim,fit,cormethod,targetE,targetP,fc,fl,fh,roll);
        assignin('base','xsim',xsim)
%   sxim: a 3 columns matrix of nsim simulations:
%       1st: r^2_envelope at the corresponding sed. rate
%       2nd: r^2_power at the corresponding sed. rate
%       3rd: r^2_opt at the corresponding sed. rate
        xcl(1) = sedrate(loci(1));
        xs1 = xsim(:,1);
        xcl(2) = length(xs1(xs1>r2env(loci(1))))/nsim;
        xs2 = xsim(:,2);
        xcl(3) = length(xs2(xs2>r2pwr(loci(1))))/nsim;
        xs3 = xsim(:,3);
        xcl(4) = length(xs3(xs3>r2opt(loci(1))))/nsim;
        %
        disp(['>>  At sedimentation rate of ', num2str(sedrate(loci(1)),'%.3f')])
        disp(['>>       Envelope r^2 p-value = ',num2str(xcl(2),'%.5f')])    
        disp(['>>       Power    r^2 p-value = ',num2str(xcl(3),'%.5f')])
        disp(['>>       Optimal  r^2 p-value = ',num2str(xcl(4),'%.5f')])

        figure;
        set(gcf,'Units','normalized','Position',[0.0, 0.05, 0.33, 0.4])
        set(gcf,'Name','Acycle: TimeOpt Null Hypothesis Testing')
        set(gcf,'color','w');
        xi=[];f=[];
        subplot(3,1,1)
        %[f,xi] = ksdensity(xsim(:,1));
        [f,xi] = ksdensity(xs1);
        X1 = [maxr2env,maxr2env];
        X2 = [maxr2pwr,maxr2pwr];
        Y = [0, 1.1*max(f)];

        plot(xi,f,'r','LineWidth',2);
        %legend('r^2_e_n_v_e_l_o_p_e')
        ylabel('# Simulations')
        ylim(Y)

        line(X1,Y,'Color','r','LineStyle','--','LineWidth',2)
        text(.6*maxr2env,.8*max(f),['r^2_e_n_v_e_l_o_p_e = ',num2str(maxr2env)],'Color','r')
        text(.6*maxr2env,.6*max(f),[' p-value = ',num2str(xcl(2),'%.5f')],'Color','r')
        title(['Null hypothesis at sedimentation rate of ', ...
            num2str(sedrate(loci(1)),'%.3f'),' cm/kyr. # simulations = ',num2str(nsim)])

        subplot(3,1,2)
        xi=[];f=[];
        [f,xi] = ksdensity(xsim(:,2));
        Y = [0, 1.1*max(f)];
        plot(xi,f,'color',[0,0,0]+.5,'LineWidth',2);
        %legend('r^2_p_o_w_e_r')
        ylabel('# Simulations')
        line(X2,Y,'Color',[0,0,0]+.5,'LineStyle','--','LineWidth',2)
        text(.6*maxr2pwr,.8*max(f),['r^2_p_o_w_e_r = ',num2str(maxr2pwr)],'Color',[0,0,0]+.5)
        text(.6*maxr2pwr,.6*max(f),[' p-value = ',num2str(xcl(3),'%.5f')],'Color',[0,0,0]+.5)
        ylim(Y)

        subplot(3,1,3)
        xi=[];f=[];
        [f,xi] = ksdensity(xsim(:,3));
        plot(xi,f,'k-','LineWidth',3);
        hold on
        %legend('r^2_o_p_t')
        ylabel('# Simulations')
        X = [maxr2opt, maxr2opt];
        Y = [0, 1.1*max(f)];
        line(X,Y,'Color','k','LineStyle','--')
        text(.6*maxr2opt,.8*max(f), ['r^2_o_p_t = ',num2str(maxr2opt)],'Color','k')
        text(.6*maxr2opt,.6*max(f),[' p-value = ',num2str(xcl(4),'%.5f')],'Color','k')
        ylim(Y)
        
        try
            close(hwarndlg)
        catch
        end
    end
    %%
end