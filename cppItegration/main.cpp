#include "cusumlib.h"
#include "cmath"
#include <iostream>

#define EPS 0.00001f

using namespace std;

int main(){
    const unsigned int blockSize = pow(2, 10);
    const unsigned int numBlocks = 30;
    const unsigned int numItems = blockSize * numBlocks;

    float* a = new float[numItems];
    float* b = new float[numItems];
    float* c = new float[numItems];

    randomInit(a, numItems);
    randomInit(b, numItems);

    cusum(blockSize, numBlocks, a, b, c);

    bool testPassed = true;
    for (int f = 0; f < numItems; f++){
        if (abs(a[f] + b[f] - c[f]) > EPS){
        cout << "Error at index:" << f << endl;
        testPassed = false;
        }
       // cout << a[f] << '+' << b[f] << " on  CPU = " << (a[f] + b[f]) << "\t|\t";
       // cout << a[f] << '+' << b[f] << " on  GPU = " << c[f] << endl;
    }
    cout << "Is Test passed: " << testPassed << endl;

    delete [] a;
    delete [] b;
    delete [] c;

	return 0;
}
