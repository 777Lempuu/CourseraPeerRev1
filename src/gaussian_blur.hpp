#pragma once
#include <opencv2/opencv.hpp>

cv::Mat applyGaussianBlurCUDA(const cv::Mat& input);
