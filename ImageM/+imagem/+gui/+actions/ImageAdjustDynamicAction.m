classdef ImageAdjustDynamicAction < imagem.gui.actions.ScalarImageAction
%IMAGENORMACTION Compute norm of current image
%
%   output = ImageAdjustDynamicAction(input)
%
%   Example
%   ImageAdjustDynamicAction
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-03-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

methods
    function this = ImageAdjustDynamicAction(viewer, varargin)
        % calls the viewer constructor
        this = this@imagem.gui.actions.ScalarImageAction(viewer, 'adjustDynamic');
    end
end

methods
    function actionPerformed(this, src, event) %#ok<INUSD>
        disp('Adjust image dynamic');
        
        % get handle to viewer figure, and current doc
        viewer = this.viewer;
        doc = viewer.doc;
        
        % apply 'norm' operation
        img2 = adjustDynamic(doc.image);
        
        % add image to application, and create new display
        addImageDocument(viewer.gui, img2);
    end
end

end