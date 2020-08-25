% =========================================================================
% Copyright (c) 2008-2014 Audio Communication Group, TU Berlin
% 
% This file is part of WhisPER, a package of interacting MATLAB scripts for 
% designing and controlling experiments in the field of auditory perceptive 
% measurement and evaluation.
% 
% WhisPER is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option) 
% any later version. 
% 
% WhisPER is distributed in the hope that it will be useful, but WITHOUT ANY 
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
% FOR A PARTICULAR PURPOSE.
% See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see <http://www.gnu.org/licenses/>. 
% 
% http://www.ak.tu-berlin.de/whisper/ 
% =========================================================================
% 
% This file:  Exports Rating-Data to gridXML File (*.xml); 
%             (e.g. Import to Gridsuite by Martin Fromm)
%
% Author :   Johannes Blickensdorff, alumni at FG Audiokommunikation, TU Berlin
% Email  :   hannes AT blickensdorff DOT com
% Date   :   21-Dec-2010
% Version:   1.0
% Updated:   
% Tested on :   OSX 10.6.5 w/ Matlab R2009b (7.9.0, OSX)
%               WinXP(32) w/ Matlab R2010b  (7.11.0.58, Win)
%
% Known Bugs: 
%       
% to do:   
% - Skalen-Strings von Gridsuite (keine Vollversion hier, def: 'ordinal')
% - Plausibilität (z.B. Anzahl Bezeichner <> size(RatingGrid))
% - Konstrukt-Kommentare des VLs (wird vom XML unterstützt, erstmal
% weggelassen)
% =========================================================================



function [] = save_export_whisper2gridXML(xmlfile, xmlElements, xmlConstructs, xmlGridData, xmlMetha)

%Erklärung der zu übergebenen Parameter:
% xmlfile        : Voller Dateiname ohne ".xml"-Extension
% xmlElements    : Bezeichner der Elemente [Anzahl x 1];  Bsp: Elements = {'E1';'E2';'E3'};
% xmlConstructs  : Bezeichner der Konstrukt-Pole; [Anzahl x 2] (1: low/neg, 2: high/pos)
% xmlGridData    : Rating-Matrix, [Konstrukte (Zeilen) x Elemente (Spalten)]
% xmlMetha: Matlab-struct mit den Feldern:
% xmlMetha.HeaderTopic
% xmlMetha.HeaderClientName
% xmlMetha.HeaderConsultantName
% xmlMetha.HeaderDatumHV
% xmlMetha.HeaderComment
% xmlMetha.ElementeComment
% xmlMetha.RatingsScale: leerlassen, wird dann default auf 'ordinal' gesetzt
% kenne noch nicht alle von Gridsuite unterstützten skalen und string-Entsprechungen im
% xml

%default scale
if isempty(xmlMetha.RatingsScale) == 1 
xmlMetha.RatingsScale = 'ordinal';
end

%Dim des Rating-Grids
[AnzahlConstructs,AnzahlElemente] = size(xmlGridData);

%Extrema der Ratings
grdMin          = min(min(xmlGridData));  
grdMax          = max(max(xmlGridData));  

%rootNode
docNode = com.mathworks.xml.XMLUtils.createDocument('grid');
%XML-Schema(XSD)-Attribute setzen:
docRootNode = docNode.getDocumentElement;
docRootNode.setAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance'); 
docRootNode.setAttribute('xmlns:noNameSpaceLocation','Grid.xsd'); 
docRootNode.setAttribute('id','1058564332812');

%Header Zweig anlegen
header_node = docNode.createElement('header');
docNode.getDocumentElement.appendChild(header_node);

    %topic
    topic_node = docNode.createElement('topic');
    header_node.appendChild(topic_node);
    topic_text = docNode.createTextNode(xmlMetha.HeaderTopic);
    topic_node.appendChild(topic_text); %text einhängen
    
    %name
    name_node = docNode.createElement('name');
    header_node.appendChild(name_node);
    name_text = docNode.createTextNode(xmlMetha.HeaderClientName);
    name_node.appendChild(name_text); %text einhängen
    
    %interviewer
    interviewer_node = docNode.createElement('interviewer');
    header_node.appendChild(interviewer_node);
    interviewer_text = docNode.createTextNode(xmlMetha.HeaderConsultantName);
    interviewer_node.appendChild(interviewer_text); %text einhängen
    
    %Date
    date_node = docNode.createElement('date');
    header_node.appendChild(date_node);
    if isempty(xmlMetha.HeaderDatumHV) == 1
    date_text = docNode.createTextNode(date); %eigtl. Datum des Interviews!
    else
    date_text = docNode.createTextNode(xmlMetha.HeaderDatumHV);
    end
    date_node.appendChild(date_text); %text einhängen

    %Comment
    header_comment_node = docNode.createElement('comment');
    header_node.appendChild(header_comment_node);
    header_comment_text = docNode.createTextNode(xmlMetha.HeaderComment);
    header_comment_node.appendChild(header_comment_text); %text einhängen

%Elemente Zweig
elements_node = docNode.createElement('elements');
docNode.getDocumentElement.appendChild(elements_node);

    for i=1:AnzahlElemente
    element_node = docNode.createElement('element'); 
    element_node.appendChild(docNode.createTextNode(xmlElements{i}));
    %attribute setzen:
    element_node.setAttribute('class',''); %class attribute
    element_node.setAttribute('id',num2str(i)); %id nummer
    elements_node.appendChild(element_node);
    end
    %elements-comment
    comment_node = docNode.createElement('comment');
    comment_text = docNode.createTextNode(xmlMetha.ElementeComment);
    elements_node.appendChild(comment_node);
    comment_node.appendChild(comment_text); %text einhängen

%Zweig der Konstrukt-Bezeichner

constructs_node = docNode.createElement('constructs');
docNode.getDocumentElement.appendChild(constructs_node);

for i=1:AnzahlConstructs
    construct_node = docNode.createElement('construct'); 
    construct_node.setAttribute('id',num2str(i)); %id nummer
    constructs_node.appendChild(construct_node);
    
    left_pole_node = docNode.createElement('pole'); 
    left_pole_node.setAttribute('type',''); %type
    left_pole_node_text = docNode.createTextNode(xmlConstructs{i,1});
    
    construct_node.appendChild(left_pole_node);
    left_pole_node.appendChild(left_pole_node_text);
    
    right_pole_node = docNode.createElement('pole'); 
    right_pole_node.setAttribute('type',''); %type
    right_pole_node_text = docNode.createTextNode(xmlConstructs{i,2});
    construct_node.appendChild(right_pole_node);
    right_pole_node.appendChild(right_pole_node_text);
    
    %zu jedem construct kann noch ein Comment-Node angefügt werden....
    %habs ertmal weggelassen... ("Bei C2 hat VP3 sehr lange überlegt")
end

%Ratings
ratings_node = docNode.createElement('ratings');
docNode.getDocumentElement.appendChild(ratings_node);
ratings_node.setAttribute('max',num2str(grdMax)); %max
ratings_node.setAttribute('min',num2str(grdMin)); %min
ratings_node.setAttribute('scale',xmlMetha.RatingsScale); %scale

for c=1:AnzahlConstructs

    for e=1:AnzahlElemente
    rating_node = docNode.createElement('rating');
    rating_node.setAttribute('con_id',num2str(c)); %construct-id attribut
    rating_node.setAttribute('ele_id',num2str(e)); %elemente-id  attribut
    rating_node_text = docNode.createTextNode(num2str(xmlGridData(c,e)));%grid data zuweisen
    ratings_node.appendChild(rating_node);
    rating_node.appendChild(rating_node_text);
    end
end

xmlwrite([xmlfile '.xml'], docNode);

