function dupe_images()

mainDir = '/home/zhenyang/Workspace/devel/project/vision/duplicate-image-finder'
dataDir = fullfile(mainDir, 'data','images_nodirs');

cubdata = imageDatastore(dataDir);
imageIndex = indexImages(cubdata);

queryDir = fullfile(mainDir, 'data', 'n01503061');
querydata = dir([queryDir '/*.JPEG'])
num_queries = length(querydata)

fp = fopen('dupe_images_results.txt','w');

for ii = 1:num_queries
    queryFile = querydata(ii).name;
    [~,name1,ext1] = fileparts(imageIndex.ImageLocation{queryFile});
    queryImageFile = [name1 ext1];
    queryImage = imread(queryFile);
    imageIDs = retrieveImages(queryImage, imageIndex);

    bestMatch = imageIDs(1);
    [~,name2,ext2] = fileparts(imageIndex.ImageLocation{bestMatch});
    bestImageFile = [name2 ext2];

    fprintf('%s %s\n', queryImageFile, bestImageFile);
    fprintf(fp, '%s %s\n', queryImageFile, bestImageFile);
end

fclose(fp)

