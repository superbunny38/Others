//17478
//재귀함수가 뭔가요?
//류채은
#include <iostream>
using namespace std;

int fun(int X[26], int Y[26], int N) {
	int ret = 0;
	for (int a = X[i]; a <= Y[i]; ++a) {
		fun(X, Y, N - 1);
	}
}

int main(void) {
	int X[26];
	int Y[26];
	int N;
	cin >> N;
	for (int i = 0; i < N; i++) {
		cin >> X[i] >> Y[i];
	}

	return 0;
}