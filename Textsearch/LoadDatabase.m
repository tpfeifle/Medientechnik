function [database] = LoadDatabase()

reuterDb = load('reuters-21578.mat');
size = inputdlg("On how many documents do you want to perform the search and create the dictionary?","Size of the Dictionary", 1, {'100'});
size = str2num(size{1});

fprintf("[+] Loading " + string(size) + " documents \n");

database = {reuterDb.docs(1:size), length(reuterDb.docs(1:size)), {}, {}};
end

