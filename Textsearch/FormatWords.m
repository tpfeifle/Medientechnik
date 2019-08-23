function [reducedTerms] = FormatWords(terms)

reducedTerms = regexprep(terms,'[\n\r]+',''); %remove new-line symbols

end

