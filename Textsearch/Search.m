function [] = Search(inputString, dictionary, globalKeys, docs)

fprintf("[+] Extracting search-keys from input-query \n");
inputKeys = StringToKeys(inputString, globalKeys)

fprintf("[+] Performing the search \n");

docsNum = length(docs);
n=3; %number of matches to display in the end

q = double(ismember(globalKeys, inputKeys));
scores = [];


for i_doc=1:docsNum
    k = keys(dictionary);
    docs_vectors = [];
    for i = 1:length(dictionary)
        key = k{i};
        all_docs_with_key = dictionary(key);
        
        docs_vectors(i) = 0;
        for i_match=1:length(all_docs_with_key)
            match = all_docs_with_key{i_match};
            match_doc_id = match{1};
            tf_idf = match{2};
            
            if(match_doc_id == i_doc) %check if this key maps to the document if yes assign tf-idf instead than zero
                docs_vectors(i) = tf_idf;
            end
        end
        
    end
    
    score = dot(q.', docs_vectors) / (norm(q) * norm(docs_vectors));
    scores = [scores; [score, i_doc]];
end

sorted_scores = sortrows(scores, 1, 'descend');


for i = 1:n
    fprintf(i + ". Match: \n Document-ID: " + sorted_scores(i, 2) + "\n")
    fprintf(" Score: " + sorted_scores(i, 1) + "\n\n")
end

answer = questdlg('Do you want to see the content of the best matches?','Content of matches', 'No', 'Yes', 'Yes');
switch answer
    case 'Yes'
        for i = 1:n
            fprintf(i + ". Match: \n Document: " + docs{sorted_scores(i, 2)} + "\n\n\n")
        end
end

