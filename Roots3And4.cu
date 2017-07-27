
// nvcc -arch=sm_30 Roots3And4.cu -run ; rm a.out 

#include "Roots3And4.h"
#include <stdio.h>


__global__ void solve_real_quartic(double a4, double a3, double a2, double a1, double a0)
{
    printf("..solve_real_quartic %d, a4=%g a3=%g a2=%g a1=%g a0=%g \n", threadIdx.x, a4,a3,a2,a1,a0 );
    printf("cbrt(27) %g \n", cbrt(27.0) );

    double poly[5];
    poly[4] = a4 ; 
    poly[3] = a3 ;
    poly[2] = a2 ;
    poly[1] = a1 ;
    poly[0] = a0 ;
 
    double sols[4];

    printf("..chk %d \n", 0 );
    const int num_sols = SolveQuartic( poly, sols);

    printf("..num_sols %d \n", num_sols);
    for (int i = 0; i < num_sols; ++i) printf("%f\n", sols[i]);
}



int main()
{
    double a[5] ; 
    a[4] = 1. ; 
    a[3] = -10. ;
    a[2] =  35. ;
    a[1] = -50. ;
    a[0] = 24. ; 

    size_t limit = 0;

    cudaDeviceGetLimit(&limit, cudaLimitStackSize);
    printf("cudaLimitStackSize: %u\n", (unsigned)limit);

    // cudaDeviceSetLimit(cudaLimitStackSize, limit*2 );


    solve_real_quartic<<<1, 1>>>( a[4], a[3], a[2], a[1], a[0] );

    cudaDeviceReset();
    return 0;
}




