#include "../common/common.h"
#include <iostream>
#include <curand.h>
#include <curand_kernel.h>
#include <helper_cuda.h>

/*
Project: Lab1 Radix Sort
Class: UCSD ECE 285
Year: Spring 2018
Name: Yen Chang
PID: A53243772
*/

const int particles_num = 32;
const int cells_num = 16;

__global__ void rand_alloc(unsigned int* keys, unsigned int* value) {
	unsigned int idx = threadIdx.x + threadIdx.y*gridDim.x + blockIdx.x*gridDim.x*gridDim.y;
	curandState_t state;
	curand_init(0, 0, 0, &state);

	if (idx < particles_num) {
		keys[idx] = curand(&state) % cells_num;
		value[idx] = idx;
	}
}

__global__ void radix_sort(unsigned int* keys, unsigned int* value) {
	unsigned int idx = threadIdx.x + threadIdx.y*gridDim.x + blockIdx.x*gridDim.x*gridDim.y;
};

__global__ void particle_count(unsigned int* keys, unsigned int* value) {
	unsigned int idx = threadIdx.x + threadIdx.y*gridDim.x + blockIdx.x*gridDim.x*gridDim.y;
	//std::cout << keys[idx] << '\t' << value[idx] << std::endl;
}

int main() {
	unsigned int keys_mem_size = sizeof(unsigned int)*particles_num;
	unsigned int value_mem_size = sizeof(unsigned int)*particles_num;

	unsigned int *d_keys, *d_value;
	cudaMalloc((void**)d_keys,  keys_mem_size);
	cudaMalloc((void**)d_value, value_mem_size);

	dim3 threads(particles_num / 32, particles_num / 1024);
	dim3 blocks(particles_num / 2014 / 32);

	rand_alloc <<<blocks, threads >>> (d_keys, d_value);
	//radix_sort <<<blocks, threads >>> (d_keys, d_value);
	//particle_count <<<blocks, threads >>> (d_keys, d_value);

	unsigned int *h_keys, *h_value;
	cudaMemcpy(h_keys, d_keys, sizeof(d_keys), cudaMemcpyDeviceToHost);
	cudaMemcpy(h_value, d_value, sizeof(d_value), cudaMemcpyDeviceToHost);
	for(int i=0;i<particles_num;i++)
		std::cout << h_keys[i] << '\t' << h_value[i] << std::endl;


	CHECK(cudaDeviceReset());
	char c;
	std::cin >> c;
	return 0;
}