#ifndef __CUSUMLIB_H__
#define __CUSUMLIB_H__

void cusum(int blockSize, int numBlocks, float* a, float* b, float* c);
void randomInit(float* a, int n);

#endif
