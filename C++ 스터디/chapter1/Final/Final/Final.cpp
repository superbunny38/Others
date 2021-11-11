
//#include "stdafx.h"
#include <string>
#include <cstdio>
#include <iostream>
using namespace std;

void Swap(int& a, int& b) {
	int nTmp = a;
	a = b;
	b = nTmp;
}

/*
int main()
{
	//연습문제 1
	std::cout << "연습문제 1" << std:: endl;
	std::string strName;
	std::cout << "이름을 입력하세요: ";
	std::cin >> strName;
	
	int age;
	std::cout << "나이를 입력하세요: ";
	std::cin >> age;

	std::cout << "이름은 " << strName << "이고, 나이는" << age << "살입니다." << std :: endl;

	std::cout << "연습문제 2" << std::endl;
	//,연습문제 2
	//auto 는 초기값의 형식에 맞춰 선언하는 인스턴스의 형식이 자동으로 결정
	int a = 10;
	int b(a);
	auto c(b);
	std::cout << "a+b+c="<<a + b + c << std::endl;


	std::cout << "연습문제 3" << std::endl;
	
	char* arr = new char[12];
	for (int i = 0; i < 5; i++) {
		std::cout << "문자 입력: ";
		std::cin >> arr[i];
	}
	
	for (int j = 0; j < 5; j++) {
		std::cout << arr[j]<<std::endl;
	}

	delete[] arr;

	std::cout << "연습문제 4" << std::endl;
	int A, B;
	std::cout << "Swap" << std::endl;
	std::cout << "A입력:";
	std::cin >> A;
	std::cout << "B입력:";
	std::cin >> B;
	Swap(A, B);
	cout << "A:" << A << endl;
	cout << "B:" << B << endl;

	std::cout << "연습문제 5" << std::endl;
	std::cout << "상수형 참조가 기존의 참조 형식과 크게 다른 점은 상수에는 참조자를 선언할 수 없다는 것이다." << std::endl;
	cout << "(X) int *a = &3; 불가능" << endl;
	cout << "(X) int &a = 3; 상수에 대한 참조 불가능" << endl;
	cout << "(X) int &a; 참조 원본이 없어서 불가능" << endl;


	std::cout << "연습문제 6" << std::endl;
	int max;
	int aList[5] = { 10,20,30,40,50 };
	int result[5];
	int tmp;
	//정렬
	for (int i = 0; i < 5; i++) {
		for (int j = i + 1; j < 5; j++) {
			if (aList[i] < aList[j]) {
				tmp = aList[i];
				aList[i] = aList[j];
				aList[j] = tmp;
			}
		}
	}

	for (auto n : aList) {
		cout << n << endl;
	}

	return 0;
}



int main() {
	int N;//좌석수
	int count = 0;//컵홀더수
	int L_count = 0;//L좌석 수
	string seats;//좌석 입력 변수

	std::cin >> N;//좌석 수 입력
	std::cin >> seats;//좌석 종류 순서대로 입력

	for (int i = 0; i < N; i++) {//좌석 수 만큼 반복
		if (i == 0) {
			count++;
		}
		if (seats[i] == 'S') {//S일때
			count++;//컵홀더 수 비례하여 증가
		}
		else if (seats[i] == 'L') {//L일때
			L_count++;//L좌석 수 증가
			if (L_count == 2) {//L좌석 수가 2개이면
				count++;//컵홀더수 증가
				L_count = 0;//L이 2개일 때 컵홀더 수가 1개 증가하기에 초기화
			}
		}
	}
	if (count > N) {
		cout << N << endl;
	}
	else {
		cout << count << endl;
	}
	//for 문은 i<N까지 돌기에 마지막 좌석의 오른쪽 컵홀더 반영 x, 따라서 +1로 반영함
	
	cout << "how seats and cupholders are allocated" << endl;
	L_count = 0;
	for (int j = 0; j < N; j++) {
		if (j == 0) {
			cout << "*";
		}
		if (seats[j] == 'S') {
			cout << "S*";
		}
		else if (seats[j] == 'L') {
			cout << 'L';
			L_count++;
			if (L_count == 2) {
				cout << "*";
				L_count = 0;
			}
			
		}
	}
	//cout << "*";
	return 0;
}

//3985

int MAX(int a, int b) {
	if (a > b) {
		return a;
	}
	else {
		return b;
	}
}

int main() {
	int L;
	std::cin >> L;
	int N;
	std::cin >> N;
	int P;
	int K;
	int sub;
	int m = 0;//max
	int cake[1000] = { 0, };
	int count[1000] = { 0. };
	for (int i = 1; i <= N; i++) {
		std::cin >> P >> K;
		sub = K - P;
		//std::cout << P << ',' << K << std::endl;
		m = MAX(m, sub);
		for (int j = P; j < K + 1; j++) {
			if (cake[j] == 0) {
				//cout << "cake" << j << "번째 조각" << i<<"번째 사람이 차지" << endl;
				cake[j] = i;
				count[i]++;
			}
		}
	}
	//cout << "\n첫번째 줄 출력: " <<m << endl;
	cout << m << endl;
	int m2 = 0;
	for (int p = 1; p <= N;p++) {
		if (count[p] != 0) {
			m2 = MAX(m2, count[p]);
		}
	}
	//cout << "m2: " << m2<<endl;
	int result;
	for (int o = 1; o <= N;o++) {
		if (m2 == count[o]) {
			result = o;
			break;
		}
		o = o + 1;
	}
	
	cout << result << endl;
	return 0;
}


//2798
//블랙잭

int main() {

	int N;
	int M;
	int cards[100] = { 0, };
	std::cin >> N >> M;
	for (int q = 0; q < N; q++) {
		cin>>cards[q];
	}
	int sum = 0;
	for (int i = 0; i < N; i++) {
		for (int j = i + 1; j < N; j++) {
			for (int k = j + 1; k < N; k++) {
				int tmp = cards[i] + cards[j] + cards[k];
				if (tmp > sum) {
					if (tmp <= M) {
						sum = tmp;
					}
				}
				
			}
		}
	}
	cout << sum;
	return 0;
}*/

//2993
//류채은
//세부분