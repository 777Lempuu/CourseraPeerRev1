#pragma once
#include <opencv2/opencv.hpp>
#include <string>

cv::Mat readImage(const std::string& path);
void saveImage(const std::string& path, const cv::Mat& img);
