#include <stdio.h>
#pragma warning(disable: 4996)

int max1 = 0;
int max2 = 0;

void update_max(int x) {
	if (max1 == 0) {
		max1 = x;
	}
	else {
		if (max2 == 0) {
			max2 = x;
		}
	}
	if (max1 < max2) {
		int tmp2 = max1;
		max1 = max2;
		max2 = tmp2;
	}

	if (max1 < max2) {
		int tmp = max1;
		max1 = max2;
		max2 = tmp;
		
	}//max1과 max관계 확실히
	//x개입
	if (x > max1) {
		max2 = max1;
		max1 = x;
	}
	else {
		if (x > max2) {
			max2 = x;
		}
	}
	printf("현재 x:%d, max1: %d max2: %d\n", x, max1, max2);
}

int main(void) {
	int N;
	
	do {
		scanf("%d", &N);
			update_max(N);
	} while (N != 0);

	printf("%d %d", max1, max2);
	return 0;
}
