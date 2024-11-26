#include<stdio.h>

// __global__: 告诉编译器这个是可以在设备上执行的核函数
__global__ void hello_world(void) {
  printf("GPU: Hello world!\n");
}

int main(int argc, char **argv) {
  printf("CPU: Hello world!\n");
  hello_world<<<1,10>>>();  // <<<...>>>: 对设备进行配置的参数
  cudaDeviceReset();  // if no this line ,it can not output hello world from gpu (隐式同步)
  return 0;
}

/*
 * 知识点:
 * 1. CPU和GPU执行程序是异步的, 核函数调用后会立刻到主机线程继续执行
 *    而不管GPU端核函数是否执行完毕
 * 2. 一般CUDA程序分为如下步骤: 
 *    2.1 分配GPU内存
 *    2.2 拷贝内存到设备
 *    2.3 调用CUDA内核函数来执行计算
 *    2.4 把计算完成的数据拷贝回主机端
 *    2.5 内存销毁
 */