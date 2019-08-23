inputString = inputdlg("Please input your search query in form of a string","Input Search", 1, {'the annual capital meeting'});
inputString = inputString{1};

db = LoadDatabase();
MakeRules();

answer = questdlg('Should the creation of the dictionary be skipped?','Dictionary', 'Skip', 'Create', 'Create');
switch answer
    case 'Create'
        [keys, textDatabase] = TextPreprocessing(db);
        dictionary = Dictionary(textDatabase, keys);
end


docs = textDatabase{1};
Search(inputString, dictionary, keys, docs)