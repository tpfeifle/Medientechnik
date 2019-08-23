function [unique_keys, textDatabase] = TextPreprocessing(textDatabase)

fprintf("[+] Processing the text-database to create the dictionary \n");
docs_num = textDatabase{2};
unique_keys = {};
for i=1:docs_num
    terms = strsplit(textDatabase{1}{i}, ' ');
    textDatabase{3}{i} = terms; %before applying rules
    terms = Normalise_Trigger(terms);
    terms = FormatWords(terms);
    textDatabase{4}{i} = StopWords_Removal(terms); %filtered after applying rules
    textDatabase{5}{i} = unique(textDatabase{4}{i}); %unique terms
    unique_keys = [unique_keys, textDatabase{4}{i}];
end

unique_keys = unique(unique_keys);
end

