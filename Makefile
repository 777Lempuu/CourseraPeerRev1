CXX = g++-10
NVCC = nvcc
CXXFLAGS = -std=c++14 `pkg-config --cflags opencv4`
LDFLAGS = `pkg-config --libs opencv4` -lcudart
NVCCFLAGS = -ccbin g++-10

all: main

main: src/main.cu src/image_utils.cpp src/gaussian_blur.cu
	$(NVCC) $(NVCCFLAGS) $(CXXFLAGS) -Xcompiler -fPIC src/main.cu src/image_utils.cpp src/gaussian_blur.cu -o main $(LDFLAGS)

clean:
	rm -f main
