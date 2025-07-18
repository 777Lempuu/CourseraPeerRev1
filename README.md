# CUDA Gaussian Blur Image Processing (Peer Review Project)

## About This Project

Hi, I’m Lempuu and this is my submission for the CUDA at Scale course project. I worked on an **image processing project** where I applied **Gaussian blur** to a batch of images using CUDA. The goal of this assignment was to process either large images or a large number of images efficiently using GPU acceleration. I specifically chose to work with images from the **SIPI Textures Dataset**.

This project involves a complete CUDA-based pipeline using **OpenCV for image I/O**, **CUDA custom kernels** for applying Gaussian blur, and proper directory handling to process **multiple images** in a single execution.

---

## Folder Structure

```
CourseraPeerRev1/
├── src/                   # CUDA + OpenCV C++ code
├── data/                  # Input images (SIPI Textures Dataset)
├── output/                # Output blurred images
├── Makefile               # Compilation instructions
├── run.sh                 # Simple bash script to compile and run
├── Proof of work.png      # Compilation and execution proof
├── Proof of work 2.png    # Original image example
├── Proof of work 3.png    # Blurred image example
└── README.md              # This file
```

---

## How To Compile and Run (CLI Flow)

**Step 1:** Install dependencies (CUDA, OpenCV, GCC 10):

```bash
sudo apt update
sudo apt install libopencv-dev gcc-10 g++-10
```

**Step 2:** Build the project:
```bash
make clean
make
```

**Step 3:** Run the program:
```bash
bash run.sh
```

Or manually using:
```bash
./main data/ output/
```
✅ This will apply Gaussian blur to all images inside `data/` folder and store processed images inside `output/`.

---

## CUDA and Algorithm Details

I used a **custom CUDA kernel** to apply a Gaussian blur effect on each image. Each image is read using OpenCV, transferred to the GPU, blurred using CUDA, and written back to disk. The pipeline efficiently processes batches of images using **directory traversal via `dirent.h`**, making it compatible with CUDA's compiler limitations.

I avoided `std::filesystem` because CUDA’s compiler does not support C++17 filesystem features reliably, so I handled file reading using POSIX functions. Additionally, I ensured compatibility between CUDA and GCC versions by configuring the Makefile to use **GCC-10**.

---

## Proof of Execution

I ran this project on **WSL Ubuntu with CUDA support** and successfully applied Gaussian blur to multiple images from the SIPI Textures Dataset. You can find sample input images in the `data/` folder and processed images in the `output/` folder.

### 📷 Terminal Compilation and Execution:
![Compilation and Execution Proof](Proof%20of%20work.png)

### 📷 Example Output Comparison:

| LEFT ORIGINAL/RIGHT BLURRED | LEFT ORIGINAL/RIGHT BLURRED |
|----------------|---------------------|
| ![Original](Proof%20of%20work2.png) | ![Blurred](Proof%20of%20work3.png) |

✅ This table shows the effect of the Gaussian blur algorithm applied on a sample image.

---

## Summary & Lessons Learned

Through this project, I learned how to:
- Efficiently set up a CUDA project in Linux/WSL,
- Resolve compatibility issues between **CUDA, GCC, and OpenCV**,
- Optimize basic image processing tasks using GPU acceleration,
- Handle batch file processing in CUDA-friendly ways without advanced libraries.

This project went beyond a basic “Hello World” by applying CUDA concepts on **multiple real-world images** with practical performance improvements.

---

## ✅ Peer Review Checklist (Grading Criteria Alignment)

- [x] **Code Repository with Full Code & README.md**
- [x] **Command Line Interface (CLI) Arguments Implemented**
- [x] **Google C++ Style Guidelines Followed**
- [x] **Makefile + run.sh Included**
- [x] **Proof of Execution with Output Images & Terminal Logs**
- [x] **Detailed Description of Work and Lessons Learned**

---

## Notes

Thank you for reviewing my work! Full repository link:  
➡️ https://github.com/777Lempuu/CourseraPeerRev1
