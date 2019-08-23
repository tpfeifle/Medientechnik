function [dictionary] = Dictionary(textDatabase, keys)

fprintf("[+] Creating the dictionary \n");

dictionary = containers.Map('KeyType','char','ValueType','any');

doc_num = textDatabase{2}; % also called N

for i=1:length(keys)
    key = keys{i};
    df = 0;
    key_mapping = {};
    for doc_idx=1:textDatabase{2}
        tf = nnz(strcmp(textDatabase{4}{doc_idx}, key));
        if tf ~= 0
            df = df + 1;
            key_mapping{length(key_mapping)+1} = {doc_idx, tf};
        end
    end
    idf = log(doc_num/df);
    key_mapping{:, 1}{2} = key_mapping{:, 1}{2} * idf;
    dictionary(key) = key_mapping;
end

save Dictionary.mat dictionary

end

