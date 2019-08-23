function [reducedTerms] = StopWords_Removal(terms)

load stopWords.mat;
reducedTerms =  terms(~ismember(terms, stopWords));
end

