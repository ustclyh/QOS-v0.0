T1_1('qubit','q2','biasAmp',[-1.5e4:250:3e4],'biasDelay',16,...
    'time',[0:16*15:20e3],...
      'gui',false,'save',true); 

ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[10]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[10]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[5]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[5]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[3]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*4:10e3],'detuning',[2]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);

ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[10]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[10]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[5]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[5]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*2:10e3],'detuning',[3]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
ramsey_df01('qubit','q2',...
      'time',[0:16*4:10e3],'detuning',[2]*1e6,...
      'dataTyp','P','notes','','gui',false,'save',true);
  

  
spectroscopy1_zpa('qubit','q2',...
       'biasAmp',[-3.5e4:1000:1e4],'driveFreq',[5.85e9:0.2e6:6.15e9],...
       'gui',false,'save',true);
  