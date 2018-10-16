//
//  main.c
//  DT
//
//  Created by 佰福大 on 09/10/18.
//  Copyright © 2018年 TOM. All rights reserved.
//

#include <stdio.h>
#include <math.h>
#include <time.h>


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    for (int i=0; i<100; i++) {
        if (i%3==0) {
            printf("%d\n",i);
        }
        
    }
    return 0;
}

void print(int n){
    
    for (int i = 0; i<=n; i++) {
        printf("%d/n",i);
    }
}

