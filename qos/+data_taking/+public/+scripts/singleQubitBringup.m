% bring up qubits one by one
% Yulin Wu, 2017/3/11
%% initialization, run this code section before doing anything else,
% and run it whenever your are not sure whether the system is ready to run,
% repeatedly run the initialization process will not bring your any harm.
<<<<<<< HEAD
cd('D:\code\matlab\QOS\qos');addpath('D:\code\matlab\QOS\qos\dlls');
disp('Initializing...');
import data_taking.public.xmon.*  % because all xmon data taking functions that your are going to need are here 
QS = qes.qSettings.GetInstance('D:\code\matlab\QOS\settings');  % create the settings object, the settings root directory must be correct
=======
cd('D:\QOS\qos');addpath('D:\QOS\qos\dlls');
disp('Initializing...');
import data_taking.public.xmon.*  % because all xmon data taking functions that your are going to need are here 
QS = qes.qSettings.GetInstance('D:\QOS\settings');  % create the settings object, the settings root directory must be correct
>>>>>>> fc56515f8bf7c089caf4e435946a93e16224507d
QS.SU('yulin');     % switch to your private settings directory, make your own settings directory(by copy and paste other's repo and make changes)
QS.SS('s170302');   % it's good habit to start a new session now and then by copy an old session so that you can always trace back if something gose wrong
QS.CreateHw();      % create all necessary hardware objects
disp('Initialization done.'); % now you are all setup(if nothing gose wrong of course)
%% S21 fine scan for each qubit dip, you can scan the power(by scan amp in log scale) to find the dispersive shift
% s21_rAmp('qubit','q1','freq',[dips(9):0.05e6:dips(9)+2*scanRange/3]+200e6,'amp',[logspace(log10(1000),log10(32768),25)],...
%       'notes','attenuation:26dB','gui',false,'save',true);
s21_rAmp('qubit','q2','freq',[dips(2)-5e6:0.05e6:dips(2)+5e6],'amp',[5500],...
      'notes','attenuation:26dB','gui',true,'save',true);
%% now you should have located all qubit dips by now:
% dips = [6.5079 6.5517 6.5945 6.6316 6.6791 6.7176 6.7593 6.7882 6.8018 6.8408]*1e9;
dips = [7.04356,7.00419,6.9900]*1e9; % by qubit idex
scanRange = 5e6; % fine scan each qubit dips
%% spectroscopy1_zpa_s21 function signiture
spectroscopy1_zpa_s21('qubit','q2',...
       'biasAmp',[-5000:200:-2000],'driveFreq',[5.955e9:0.05e6:5.98e9],...
       'notes','','gui',true,'save',true);
%%
spectroscopy111_zpa_s21('biasQubit','q2','biasAmp',[-3e4:25e2:3e4],...
       'driveQubit','q1','driveFreq',[6.2e9:5e6:6.4e9],...
       'readoutQubit','q1',...
       'notes','','gui',false,'save',true);
%%
rabi_amp1('qubit','q1','biasAmp',[0],'biasLonger',0,...
      'xyDriveAmp',[0:500:3e4],'detuning',[0],'driveTyp','X/2',...
      'dataTyp','S21','notes','','gui',true,'save',true);
%%
tuneup.iq2prob_01('qubit','q1','numSamples',2e4,...
      'gui',true,'save',true);
%%
spectroscopy1_zdc('qubit','q1',...
       'biasAmp',[-3e4:100e2:3e4],'driveFreq',[5.5e9:15e6:6.3e9],...
       'notes','','gui',true,'save',false);
%%
s21_01('qubit','q1',...
      'freq',[7.0435e+09-3e6:0.1e6:7.0435e+09+3e6],...
      'notes','','gui',true,'save',false);
%%
ramsey_df('qubit','q1',...
      'time',[0:5:600],'detuning',[5]*1e6,...
      'dataTyp','S21','notes','','gui',true,'save',true);