close all; clear; clc

% define language and base dir
languages = {'german', 'english'};

% x1 Item id
% x2 item name
% 3 is_dichotom
% 4 is_unipolar
% x5 item category
% 6 is_degree_scale
saqi = struct();


for ll = 1:2
    language = languages{ll};
    % load data
    run(fullfile('..', ['saqi_categories_' language]))
    run(fullfile('..', ['saqi_items_' language]))
    run(fullfile('..', ['saqi_definition_' language]))
    run(fullfile('..', ['saqi_scale_label_' language]))

    % re-format to single json file
    for ii = 1:size(SAQI_Items, 1)
        % item name and id
        saqi(ii,1).name = SAQI_Items{ii, 2};
        saqi(ii,1).name_id = ii-1;

        % item definition
        definition = SAQI_definition{ii, 2};
        if iscell(definition)
            defi = '';
            for dd = 1:length(definition)
                defi = strcat(defi, [definition{dd} '\n']);
            end
            definition = defi;
        end
        saqi(ii,1).definition = strrep(definition, '"', '''');

        % item category and id
        if SAQI_Items{ii, 5}
            saqi(ii,1).category = SAQI_categories{SAQI_Items{ii, 5}, 2};
        else
            saqi(ii,1).category = NaN;
        end
        saqi(ii,1).category_id = SAQI_Items{ii, 5};

         % scale label
        saqi(ii,1).scale_label = {SAQI_scale_label{ii, 2}, SAQI_scale_label{ii, 3}};

        % scale categorization
        saqi(ii,1).is_unipolar = SAQI_Items{ii, 4};
        saqi(ii,1).is_dichotom = SAQI_Items{ii, 3};
        saqi(ii,1).is_degree_scale = SAQI_Items{ii, 6};
    end

    %encode to json
    json = jsonencode(saqi, PrettyPrint=true);
    
    % write to disk
    fileID = fopen(['saqi_' language '.json'],'w');
    fprintf(fileID,json);
    fclose(fileID);

end