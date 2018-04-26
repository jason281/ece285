#include "../common/common.h"
#include <stdio.h>
#include <iostream>

/*
 * A simple introduction to programming in CUDA. This program prints "Hello
 * World from GPU! from 10 CUDA threads running on the GPU.
 */

__global__ void helloFromGPU()
{
    printf("Hello World from GPU! 1\n");
}

int main(int argc, char **argv)
{
    helloFromGPU<<<1, 10>>>();
	printf("Hello World from CPU!\n");
    CHECK(cudaDeviceReset());
	char c;
	std::cin>>c;
    return 0;
}


