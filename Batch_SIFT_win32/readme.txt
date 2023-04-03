--DSift.exe 为提取DoG SIFT的32位可执行程序，其输入参数有两个，分别为“待处理图象所在文件夹路径”，“图象最长边缩放的尺寸”

--batch_run.bat 中通过设置参数，可以调用DSift.exe。双击batch_run.bat，即可自动提出指定文件夹下的图象的DoG SIFT特征。每幅图象的SIFT特征文件保存在该图像的同一个目录下，命名在图象名称之上加“.dsift”。SIFT特征文件中的数据为binary格式，开头四字节为整数，表示SIFT特征的数量；其后逐个保存各个SIFT特征的结构体数据，每个结构体占144字节，具体格式为
{
unsigned char descriptor[128];
float x;
float y;
float scale;
float orientation;
}

--执行DSift.exe时需要调用的三个动态链接库：cv210.dll, cxcore210.dll, highgui210.dll，已放置在同一个目录下。

--DSift.exe is a 32-bit executable program that extracts DoG SIFT. Its input parameters include "Path of the folder where the image to be processed is located" and "Scale size of the longest edge of the image"
--DSiff. exe can be called by setting parameters in batch_run.bat. Double click batch_run.bat to automatically propose DoG SIFT features for images in the specified folder. The SIFT feature file for each image is stored in the same directory as the image, and is named with ". dsift" added to the image name. The data in the SIFT feature file is in binary format, with the first four bytes being integers indicating the number of SIFT features; Thereafter, the structure data of each SIFT feature is saved one by one, with each structure accounting for 144 bytes. The specific format is
{
unsigned char descriptor[128];
float x;
float y;
float scale;
float orientation;
}
--The three dynamic link libraries that need to be called when executing DSift.exe: cv210.dll, cxcore210.dll, and highgui210.dll have been placed in the same directory.