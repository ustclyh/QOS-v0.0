classdef Y2p < sqc.op.physical.gate.XY_base
    % half pi around Y axis
    
% Copyright 2016 Yulin Wu, University of Science and Technology of China
% mail4ywu@gmail.com/mail4ywu@icloud.com

    methods
        function obj = Y2p(qubit)
            obj = obj@sqc.op.physical.gate.XY_base(qubit);
            obj.logical_op = sqc.op.logical.gate.Y2p;
%             if obj.logical_op_max_qubit_num >= numel(obj.qubits)
%                 for ii = 1:numel(obj.allQubitNames)
%                     if obj.qubits{1} == obj.allQubitNames{ii}
%                         if ii == 1
%                             obj.logical_op = sqc.op.logical.gate.Y2p;
%                         else
%                             obj.logical_op = sqc.op.logical.gate.Y2p.*obj.logical_op;
%                         end
%                     else
%                         if ii == 1
%                             obj.logical_op = sqc.op.logical.gate.I;
%                         else
%                             obj.logical_op = sqc.op.logical.gate.I.*obj.logical_op;
%                         end
%                     end
%                 end
%             end
			obj.length = obj.qubits{1}.g_XY2_ln;
            obj.amp = obj.qubits{1}.g_XY2_amp;
            obj.addPhase(pi/2);
        end
    end
end