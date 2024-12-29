# Fifth-Order FIR Digital Differentiator Design Using Modified Weighted Least-Squares Technique

This repository contains the MATLAB implementation of a fifth-order FIR digital differentiator designed using the **Modified Weighted Least-Squares (WLS)** technique. The project was undertaken as part of the Digital Signal Processing course (EEE/ECE F434) at Birla Institute of Technology & Science, Pilani.

## 📜 Project Overview

Digital differentiators are essential for estimating the rate of change of discrete-time signals, with applications in communication systems, biomedical signal processing, and control systems. This project focuses on:
- Designing a **fifth-order FIR digital differentiator**.
- Minimizing **relative mean square error (RMSE)** in the frequency response using the modified WLS technique proposed by V.V. Sondur, V.B. Sondur, and N.H. Ayachit.

### Key Features:
1. Implementation of a **Modified Weighted Least-Squares Algorithm**.
2. Iterative weight adjustments to prioritize accuracy for critical frequencies.
3. Design and evaluation of **even- and odd-length FIR digital differentiators**.


## 🛠️ Methodology

The design methodology follows these key steps:

1. **Initialization**: 
   - Set the filter order and length.
   - Define the weighting function `W(ωl)` and the ideal frequency response.

2. **Frequency Response Formulation**:
   - Construct the FIR filter's transfer function using antisymmetric impulse responses for linear-phase response.

3. **System of Equations**:
   - Build and solve a matrix system for filter coefficients using the WLS approach.

4. **Weight Adjustment**:
   - Iteratively update weights based on relative error, normalized for stability.

5. **Convergence**:
   - Iterate until the relative error change is below a threshold, then output results.

## 📊 Results

The implementation successfully minimizes the **relative error** for both even and odd filter lengths, achieving:
- Superior accuracy across the normalized frequency range.
- Robust and practical results for real-time applications.

Plots comparing the ideal and actual responses, as well as error visualizations, can be found in the `figures/` directory.

### How to Use This
- Replace placeholders like `<your-repo-name>` with the actual repository name.
- Ensure the directory structure in the repository matches what is described in the README file.
- Include relevant MATLAB code and any additional dependencies in the repository.

Let me know if you need help with code refinement or further customization!

