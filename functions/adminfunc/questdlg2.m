% questdlg2() - questdlg function clone with coloring and help for 
%               eeglab().
%
% Usage: same as questdlg()
%
% Warning: 
% Case of button text and result might be changed by the function
%
% Author: Arnaud Delorme, CNL / Salk Institute, La Jolla, 11 August 2002
%
% See also: inputdlg2(), errordlg2(), supergui(), inputgui()

% Copyright (C) Arnaud Delorme, CNL / Salk Institute, arno@salk.edu
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

function [result] = questdlg2(Prompt,Title,varargin);

result = '';
if nargin < 2
   help questdlg2;
   return;
end;
if isempty(varargin)
    varargin = { 'Yes' 'No' 'Cancel' 'Yes' };
end;
result = varargin{end};
if Prompt(end) == 10, Prompt(end) = []; end;
if Prompt(end) == 10, Prompt(end) = []; end;
if Prompt(end) == 10, Prompt(end) = []; end;
if Prompt(end) == 10, Prompt(end) = []; end;

fig = figure('visible', 'off');
set(gcf, 'name', Title);

geometry = {[1]};
listui = {{ 'Style', 'text', 'string' Prompt } {} };

geometry = { geometry{:} 1 ones(1,length(varargin)-1) };
for index = 1:length(varargin)-1 % ignoring default val
	listui = {listui{:} { 'width' 80 'align' 'center' 'Style', 'pushbutton', 'string', varargin{index}, 'callback', ['set(gcbf, ''userdata'', ''' varargin{index} ''');'] }  };
	if strcmp(varargin{index}, varargin{end})
		listui{end}{end+1} = 'fontweight';
		listui{end}{end+1} = 'bold';
	end;
end;

cr = length(find(Prompt == char(10)))+1;
if cr == 1
	cr = size(Prompt,1);
end;
if cr >= 8, cr = cr-1; end;
if cr >= 4, cr = cr-1; end;
[tmp tmp2 allobj] = supergui( 'fig', fig, 'geomhoriz', geometry, 'geomvert', [cr 1 1], 'uilist', listui, ...
    'borders', [0.02 0.015 0.08 0.06], 'spacing', [0 0], 'horizontalalignment', 'left' );

waitfor( fig, 'userdata');
try,
	result = get(fig, 'userdata');
	close(fig);
    drawnow;
end;
