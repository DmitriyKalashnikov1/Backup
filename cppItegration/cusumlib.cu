#include "cusumlib.h"
#include "cuda.h"
#include <random>
#include "cuda_runtime_api.h"

__global__ void vectorAdd(float* a, float* b, float* c){
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    /*поскольку это ядро будет выполнятся сразу на множестве
    нитей, каждая из которых сложит свои элементы, нам надо
    узнать индекс текущей нити, чтобы сложить правильные элементы*/
    c[index] = a[index] + b[index];

}

void cusum(int blockSize, int numBlocks, float* a, float* b, float* c){
	cudaSetDevice(0);

	int numItems = blockSize * numBlocks;

	float *adev, *bdev, *cdev;

    cudaMalloc((void**)&adev, numItems * sizeof(float));

	cudaMalloc((void**)&bdev, numItems * sizeof(float));

	cudaMalloc((void**)&cdev, numItems * sizeof(float));

    cudaMemcpy(adev, a, numItems * sizeof(float), cudaMemcpyHostToDevice);

    cudaMemcpy(bdev, b, numItems * sizeof(float), cudaMemcpyHostToDevice);

    vectorAdd<<<numBlocks, blockSize>>>(adev, bdev, cdev);

    cudaMemcpy((void *) c, cdev, numItems * sizeof(float), cudaMemcpyDeviceToHost);

    cudaFree(adev);
    cudaFree(bdev);
    cudaFree(cdev);
}

void randomInit(float* a, int n){
    for (int f = 0; f < n; f++){
        a[f] = rand() / (float) RAND_MAX;
    }
}
