function [reducedTerms] = Normalise_Trigger(terms)

load Synonyme.mat; %now in variable synonyme

reducedTerms = [];
for i=1:length(terms)
    char_term = convertStringsToChars(terms(i));
    if isKey(synonyme, char_term)
        reducedTerms = [reducedTerms, synonyme(terms{i})];
    else
        reducedTerms = [reducedTerms, terms(i)];
    end
end
end