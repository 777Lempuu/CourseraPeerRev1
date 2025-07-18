#include <iostream>
#include <dirent.h>
#include <sys/stat.h>
#include "image_utils.hpp"
#include "gaussian_blur.hpp"

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: ./main input_dir output_dir\n";
        return -1;
    }

    std::string input_dir = argv[1], output_dir = argv[2];

    DIR *dir;
    struct dirent *ent;
    if ((dir = opendir(input_dir.c_str())) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            std::string filename = ent->d_name;

            if (filename == "." || filename == "..") continue;

            std::string full_path = input_dir + "/" + filename;
            cv::Mat input = readImage(full_path);
            if (input.empty()) continue;

            cv::Mat output = applyGaussianBlurCUDA(input);

            std::string out_path = output_dir + "/" + filename;
            saveImage(out_path, output);
            std::cout << "Processed: " << filename << "\n";
        }
        closedir(dir);
    } else {
        perror("Cannot open input directory");
        return -1;
    }

    return 0;
}
