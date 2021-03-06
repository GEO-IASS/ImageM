classdef ImageRegionalMaximaAction < imagem.gui.actions.CurrentImageAction
%IMAGEEXTENDEDMAXIMAACTION Extract extended maxima in a grayscale image
%
%   output = ImageRegionalMaximaAction(input)
%
%   Example
%   ImageRegionalMaximaAction
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-11-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
end

methods
    function this = ImageRegionalMaximaAction(viewer)
        % calls the parent constructor
        this = this@imagem.gui.actions.CurrentImageAction(viewer, 'regionalMaxima');
    end
end

methods
    function actionPerformed(this, src, event) %#ok<INUSD>
        % apply regional maxima to current image
        
        % get handle to viewer figure, and current doc
        viewer = this.viewer;
        img = viewer.doc.image;
        
        if ~isScalarImage(img)
            warning('ImageM:WrongImageType', ...
                'Regional maxima can be applied only on scalar images');
            return;
        end
        
        app = viewer.gui.app;
        conn = getDefaultConnectivity(app, ndims(img));
        bin = regionalMaxima(img, conn);
        
        newDoc = addImageDocument(this.viewer.gui, bin, [], 'rmax');
        
        % add history
        string = sprintf('%s = regionalMaxima(%s, %d);\n', ...
            newDoc.tag, this.viewer.doc.tag, conn);
        addToHistory(this.viewer.gui.app, string);

    end    
end


methods
    function b = isActivable(this)
        doc = this.viewer.doc;
        b = ~isempty(doc) && ~isempty(doc.image) && isScalarImage(doc.image);
    end
end

end