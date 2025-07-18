#include "image_utils.hpp"

cv::Mat readImage(const std::string& path) {
    return cv::imread(path, cv::IMREAD_COLOR);
}

void saveImage(const std::string& path, const cv::Mat& img) {
    cv::imwrite(path, img);
}
