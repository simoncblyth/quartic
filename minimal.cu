// nvcc -arch=sm_30 minimal.cu -run ; rm a.out 
#define CUDA_BOTH __device__ __host__
#include <stdio.h>


CUDA_BOTH
static double cubic_root(double x) ;

__global__ void fquartic(float a4, float a3, float a2, float a1, float a0)
{
      printf("fquartic %d, a4=%g a3=%g a2=%g a1=%g a0=%g \n", threadIdx.x, a4,a3,a2,a1,a0 );
}

__global__ void dquartic(double a4, double a3, double a2, double a1, double a0)
{
      double a[5] ; 
      a[4] = a4 ; 
      a[3] = a3 ;
      a[2] = a2 ;
      a[1] = a1 ;
      a[0] = a0 ;

      printf("dquartic %d, a[4]=%g a[3]=%g a[2]=%g a[1]=%g a[0]=%g \n", threadIdx.x, a[4],a[3],a[2],a[1],a[0] );
      printf("cubic_root(27) %g \n", cubic_root(27) );
}

CUDA_BOTH
static double cubic_root(double x) {
    const double t = pow(fabs(x), 1.0 / 3.0);
    return x >= 0.0 ? t : -t;
}


int main()
{
    double a[5] ; 
    //float a[5] ; 

    a[4] = 1. ; 
    a[3] = -10. ;
    a[2] =  35. ;
    a[1] = -50. ;
    a[0] = 24. ; 


    dquartic<<<1, 1>>>( a[4], a[3], a[2], a[1], a[0] );

    cudaDeviceReset();
    return 0;
}



