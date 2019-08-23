function [validInputKeys] = StringToKeys(inputString, keys)

terms = strsplit(inputString, ' ');
terms = Normalise_Trigger(terms);
terms = FormatWords(terms);
terms = unique(StopWords_Removal(terms));

%only input terms that match with keys that are present in our index
validInputKeys =  terms(ismember(terms, keys));
end

