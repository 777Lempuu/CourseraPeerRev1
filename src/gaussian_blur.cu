#include "gaussian_blur.hpp"
#include <opencv2/opencv.hpp>
#include <cuda_runtime.h>

__global__ void gaussianBlurKernel(unsigned char* input, unsigned char* output, int width, int height, int channels) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x >= width || y >= height) return;

    int kernel[3][3] = {{1, 2, 1},
                        {2, 4, 2},
                        {1, 2, 1}};
    int sumKernel = 16;

    for (int c = 0; c < channels; c++) {
        int blur = 0;
        for (int ky = -1; ky <= 1; ky++) {
            for (int kx = -1; kx <= 1; kx++) {
                int nx = min(max(x + kx, 0), width - 1);
                int ny = min(max(y + ky, 0), height - 1);
                int idx = (ny * width + nx) * channels + c;
                blur += input[idx] * kernel[ky + 1][kx + 1];
            }
        }
        int out_idx = (y * width + x) * channels + c;
        output[out_idx] = blur / sumKernel;
    }
}

cv::Mat applyGaussianBlurCUDA(const cv::Mat& input) {
    int img_size = input.cols * input.rows * input.channels();
    unsigned char *d_in, *d_out;

    cudaMalloc(&d_in, img_size);
    cudaMalloc(&d_out, img_size);
    cudaMemcpy(d_in, input.data, img_size, cudaMemcpyHostToDevice);

    dim3 block(16, 16);
    dim3 grid((input.cols + 15) / 16, (input.rows + 15) / 16);
    gaussianBlurKernel<<<grid, block>>>(d_in, d_out, input.cols, input.rows, input.channels());

    cv::Mat output(input.size(), input.type());
    cudaMemcpy(output.data, d_out, img_size, cudaMemcpyDeviceToHost);

    cudaFree(d_in); cudaFree(d_out);
    return output;
}
