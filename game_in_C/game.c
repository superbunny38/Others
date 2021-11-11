#include "game.h"//게임 헤더 파일 불러오기

int main(void) {//메인함수
	int nMainMenu;//선택한 메뉴 번호
	//int bIterationFlag = 0; 

	srand(time(NULL));//씨드값을 NULL로 설정

	while (1) {//반복문 while
		system("cls");//현재까지 출력된 화면 지움
		nMainMenu = displayMainMenu();//메인 메뉴 선택지 출력
		system("cls");//메뉴 선택지 출력한 것 지움
		switch (nMainMenu) {//메뉴 선택지에 따라서 달라짐
		case DIE_SIMULATION://DIE_SIMULATION의 메뉴 선택시
			dieSimulation();//dieSimulation함수로 이동
			break;//반복문 종료
		case GAME_SHOW://GAME_SHOW 메뉴 선택시
			gameShow();//gameShow함수로 이동
			break;//반복문 종료
		case UPDOWN_GAME://UPDOWN_GAME 메뉴 선택시
			upDownGame();//upDownGame함수로 이동
			break;//반복문 종료
		case WORD_GAME://WORD_GAME 선택시
			wordGame();//wordGame 함수로 이동
			break;//반복문 종료
		case OX_GAME://OX_GAME선택시
			OXGame();//OXGame 함수로 이동
			break;//반복문 종료
		case PERSONALITY://PERSONALITY 선택시
			myPersonality();//myPersonality()함수로 이동
			break;//반복문 종료
		case ABOUT: //About선택시
			about();//about함수로 이동
			break;//반복문 종료
		case 0://0을 골랐으면
			printf("\n\n");
			printf("\t==================================\n\n");
			printf("\n\tNice meeting you....!\n");
			printf("\tGood bye...!★\n\n");
			printf("\t==================================\n\n");
			exit(0);//main함수 종료(프로그램 종료)
			///bIterationFlag = 0;//escape condition
			break;//반복문 종료
		default://선택지에 포함안될 시 
			printf("\n\n");
			printf("\t Wrong Number!\n");
			break;//반복문 종료
		}//switch

		system("pause");//콘솔창 멈춤

	}//while
	return 0;
}

int displayMainMenu() {//메뉴 선택지 출력 함수
	int nSelectedMainMenu;//선택한 문제 번호
	printf("\n\n");
	printf("\t ==================================\n");
	printf("\t             ★MAIN MENU★\n");
	printf("\t ----------------------------------\n");
	printf("\t 1. DIE SIMULATION\n");
	printf("\t 2. GAME SHOW\n");
	printf("\t 3. UP DOWN GAME\n");
	printf("\t 4. WORD GAME\n");
	printf("\t 5. OX GAME\n");
	printf("\t 6. ABOUT\n");
	printf("\t 7. TEST MY PERSONALITY\n");
	printf("\t ----------------------------------\n");
	printf("\t 0. EXIT\n");
	printf("\t ==================================\n");
	printf("\t    >> ");
	scanf("%d", &nSelectedMainMenu);//입력 받음
	return nSelectedMainMenu; //선택한 문제 정수형 번호 반환

}//displayMainMenu()


void dieSimulation() {//주사위 돌리기
	int nFace, nSum = 0, nCount = 0;//nFace는 나온 주사위 수, nSum은 나온 주사위 수의 합 nCount는 주 사위 굴린 횟수


	printf("\n\n");
	printf("\t ==================================\n");
	printf("\t             DIE SIMULATION\n");
	printf("\t ----------------------------------\n\n");

	for (int i = 0; i < 100000; i++, nSum=0) {//100000번동안 반복
		while (nSum < 100) {//나온 주사위 결과의 합이 100보다 작을 때
			nFace = (rand() % 6) + 1;//주사위 값을 랜덤으로 정함(1~6까지)
			nSum += nFace;//주사위의합에 주사위 값을 누적시킴
			nCount++;//주사위 굴린 횟수 증가
			
		}//while 

	}//for
	
	printf("\t컴퓨터 시뮬레이션 결과,\n \t주사위의 누적 합이 100을 넘으려면\n\t약 %d회 정도 굴리면 됩니다\n\n", (int)((double)nCount/100000+0.5));//결과 소수점에서 반올림
	printf("\t ==================================\n");

}//menu1

void gameShow() {
	int nPrizeDoor, nSelectDoor;//nPrizeDoor은 상품이 있는 문, nSelectDoor은 처음 선택한 문
	int nRevealDoor, nSwitchDoor;//nReveal Door은 마지막에 열게된 문, nSwitchDoor은 바꾼 문
	int nSelectCount = 0, nSwitchCount = 0;//nSelectCount는 문을 선택한 횟수, nSwitchCount는 선택한 문을 바꾼 횟수
	printf("\n\n\t ==================================\n");
	printf("\t             GAMESHOW\n");
	printf("\t ----------------------------------\n");
	//case 1
	for (int i = 0; i < 100000; i++) {//100000번 동안 반복

		nPrizeDoor = rand() % 3;//nPrizeDoor을 정수 0~2에서 임의로 정함
		nSelectDoor = rand() % 3;//nSelectDoor을 정수 0~2에서 임의로 정함
		if (nPrizeDoor == nSelectDoor)nSelectCount++;//만약 nPrizeDoor와 nSelectDoor이 같으면 nSelectCount 1씩 증가


	}//for문

	printf("\t   Select >> %.2lf %%\n\n", (double)nSelectCount / 1000);//처음 고른걸 고수했을 때 상품 받을 확률 출력

	//case2

	for (int i = 0; i < 100000; i++) {//100000번 동안 반복

		nPrizeDoor = rand() % 3;//nPrizeDoor을 정수 0~2에서 임의로 정함
		nSelectDoor = rand() % 3;//nSelectDoor을 정수 0~2에서 임의로 정함
		nRevealDoor = 0;//열어본 횟수
		while (nRevealDoor == nPrizeDoor || nRevealDoor == nSelectDoor) {//열어본 문이 상품이 든 문과 같거나 고른 문과 같을 때
			nRevealDoor++;//열어본 문을 증가
		}
		nSwitchDoor = 0;
		while (nSwitchDoor == nSelectDoor || nSwitchDoor == nRevealDoor) {//바꾼 문이 고른문과 같거나 바꾼 문이 열어본 문과 같을 때
			nSwitchDoor++;//바꾼 문을 증가
		}
		if (nPrizeDoor == nSwitchDoor)nSwitchCount++;//바꾼 문과 상품 문이 같을 때 바꾼 횟수 증가
	}//for

	printf("\t   Switch >> %.2lf %%\n\n", (double)nSwitchCount / 1000);//바꿨을 때 상품을 받게 된 경우의 확률 출력

	printf("\n\n\t ==================================\n");//0 0 1~2
	//0 1 2
	//0 2 1

}//gameShow

void upDownGame() {//업다운 게임 함수
	int nAnswer, nInput;//nAnswer은 답, nInput은 사용자가 입력한 숫자
	int nCount = 0;//nCount는 몇 번 동안 입력(guess)했는지
	int nMin = 1, nMax = 100; //답의 범위는 1~100
	int bFlag = TRUE;//bFlag는 TRUE
	nAnswer = rand() % 100 + 1;//nAnswer의 범위는 1~100

	//printf("%d", nAnswer);

	while (bFlag) {//while(TRUE)
		system("cls");//현재까지 출력된 화면 지움
		printf("\t ==================================\n");
		printf("\t             UPDOWN GAME\n");
		printf("\t ----------------------------------\n\n");
		printf("\t %3d to %3d \n",nMin,nMax);//1에서 100사이의 숫자를 입력하라는 뜻
		printf("\t input number >> ");
		scanf("%d", &nInput);//nInput에 사용자로부터 숫자를 입력받음

		nCount++;//입력할 때마다 nCount증가

		if (nInput < nAnswer) {//사용자 입력이 답보다 작을 때
			nMin = nInput + 1;//사용자 추측의 범위의 최소값을 nInput+1로 알려줌
			printf("\n\t UP\n\n");
		}
		else if (nInput > nAnswer) {//사용자 입력이 답보다 클 때
			nMax = nInput - 1;//사용자 추측의 범위의 최대값을 nInput-1로 알려줌
			printf("\n\t DOWN\n\n");
		}
		else { //사용자 입력이 정답일 때
			printf("\n\t RIGHT (%d times)\n\n",nCount);//nCount번에 맞췄다고 알려줌
			bFlag = FALSE;//while문 종료
			break;//escape condition
		}//if..else
		printf("\t ==================================\n");
		if (bFlag) system("pause");//콘솔창 멈춤
	}//while
	
	
}//upDownGame

void wordGame() {

	char strWords[20][40] = {//[row][column] 2차원배열로 선언
		"computer",
		"programming",
		"education",
		"mouse",
		"keyboard",//5
		"monitor",
		"president",
		"warning",
		"return",
		"studio",//10
		"outstanding",
		"different",
		"student",
		"university",
		"professor",//15
		"object",
		"class",
		"online",
		"community",
		"windows"//20
	};
	//nSelected는 단어를 랜덤으로 선택
	//nCount몇번만에 맞췄는지
	//nInputLength 입력한 단어의 길이
	//strInput 실제로 입력한 문자 처리  + 출력
	//chInput문자 하나 입력받기 위함
	//strEnter은 문자열 입력경우
	int nSelected, nWordLength, nCount = 0, nInputLength;//nWordLength = 선택된 단어의 길이
	char strInput[40], strEnter[40];
	char strAlphabet[] = "abcdefghijklmnopqrstuvwxyz";

	nSelected = rand() % 20;//nSelected의 범위는 0~19

	//printf("정답: %s\n", strWords[nSelected]); //cheating code
	nWordLength = strlen(strWords[nSelected]);//정답의 길이
	//printf("%d\n", nWordLength);

	for (int i = 0; i < nWordLength; i++) {
		strInput[i] = '_';
	}
	strInput[nWordLength] = '\0';//NULL
	while (TRUE) {
		system("cls");
		printf("\t ==================================\n");
		printf("\t             WORD GAME\n");
	 	printf("\t ----------------------------------\n");
		printf("\t", strAlphabet);
		for (int i = 0; i < 26; i++) {//알파벳 출력 위한 for문
			printf("%c ", strAlphabet[i]);
			if (!((i + 1) % 13)) printf("\n\n\t ");
		}//for
		printf("\n\t");
		printf("\n\n\t  ");

		//정답 길이 만큼 _ 출력
		for (int i = 0; i < nWordLength; i++)printf("%c ", strInput[i]);
		
		//입력과 정답 비교
		if (!strcmp(strInput, strWords[nSelected])) {//strWords[nselected]가 정답, strInput은 문자열
			printf("\n\n\t");
			printf("    Congratulations!\n\n");
			printf("\t You got the right answer in the %d times\n\n", nCount);
			printf("\t ==================================\n");
			break;//escape condition 탈출 조건

		}//if
		//화면 출력 이후 체크

		printf("\n\n\n");
		printf("\t   Input >>");
		//fflush(stdin);//문자 입려받을 수 있게 버퍼 날림
		getchar();//엔터값 날림
		scanf("%s", strEnter);//문자열 입력
		nCount++;//입력시 count값증가

		nInputLength = strlen(strEnter);//길이
		for (int i = 0; i < nInputLength; i++) {
			if (strEnter[i] >= 'A' && strEnter[i] <= 'Z') {//대문자 입력시 소문자로 바꿔 줌
				strEnter[i] = strEnter[i] + 32;//대문자를 소문자로 바꿈
			}
		}//for

		if (nInputLength == 1) {//입력받은 문자 길이가 1 one character
			
			strAlphabet[strEnter[0] - 'a'] = ' ';//알파벳 지움

			for (int i = 0; i < nWordLength; i++) {
				if (strEnter[0] == strWords[nSelected][i]) {//해당문자가 정답에 있는지
					strInput[i] = strEnter[0];//_를 해당문자로 바꿈
				}//if
			}//for(i)

		}
		else {//string 문자열의 경우
			if (!strcmp(strEnter, strWords[nSelected])) {//입력과 정답이 같은 경우
				strcpy(strInput, strEnter);//string copy
				//strInput = strEnter은 배열이기에 하면 안됨
			}//if
		}//else

		
	}//while
	printf("\t");
	


	
}//wordGame

void OXGame() {//OXGame 함수
	char strNumber[11] = "0123456789";//문자형 1차원 배열 strOX
	char chPlayer = 'O', chWin = NULL;//chPlayer은 O로 초기화 해둠
	int nCount = 0;
	//과제1.중복 V
	//과제2.비겼을때 V
	//과제3. 이겼을 때 반영 V
	while (TRUE) {

		displayNumber(strNumber);//displayNumber함수 출력
		playOX(chPlayer, strNumber);//playOX함수 출력
		chPlayer = (chPlayer == 'O') ? 'X' : 'O';
		nCount++;
		chWin = winCheck(strNumber);
		if (chWin != NULL) break;
		if (nCount == 9) break;
	}//while
	printf("\n\n\t");
	displayNumber(strNumber);
	printf("\n\n\t");
	if (chWin) {//이긴 사람이 있을 때
		printf("WINNER IS %c\n\n", chWin);
	}
	else {//비겼을 때
		printf("DRAW!\n\n");
	}
	
}//OXGame

char winCheck(char str[])//이겼을 때
{
	char chReturn = NULL;
	if (str[1] == str[2] && str[2] == str[3]) chReturn = str[1];
	else if (str[4] == str[5] && str[5] == str[6]) chReturn = str[4];
	else if (str[7] == str[8] && str[8] == str[9]) chReturn = str[7];
	else if (str[1] == str[4] && str[4] == str[7]) chReturn = str[1];
	else if (str[2] == str[5] && str[5] == str[8])chReturn = str[2];
	else if (str[3] == str[6] && str[6] == str[9]) chReturn = str[3];
	else if (str[1] == str[5] && str[5] == str[9]) chReturn = str[1];
	else if (str[3] == str[5] && str[5] == str[7]) chReturn = str[3];
	return chReturn;//정답이 아니면 NULL, 이겼으면 정수형 chReturn 반환
}//winCheck()

void displayNumber(char str[]) {//displayOX 함수
	system("cls");//현재까지 출력된 화면 지움

	printf("\t ==================================\n");
	printf("\t             OX Game\n");
	printf("\t ----------------------------------\n");
	printf("\n\t    ");//tab
	for (int i = 1; i < 10; i++) {//9개 출력
		printf("%c", str[i]);
		if (!(i % 3))printf("\n\n\t    ");//숫자 3개마다 줄 바꿈
		else printf("\t    ");

	}

	printf("\n\t----------------------------------\n");

}//displayOX

void playOX(char player, char str[]) {//playOX 함수
	char chInput;

AA:	printf("\t  %c's turn >>", player);//누구 차례인지 출력
	getchar();//keyboard buffer없앰
	scanf("%c", &chInput);
	if (49 > chInput || chInput > 57) {//사용자 입력이 1~9가 아닐 때
		printf("\twrong input! type again!\n");
		goto AA;
	}
	if (str[chInput-'0'] == 'O' || str[chInput - '0'] == 'X') {//사용자 선택이 이미 선점되었을 때
		printf("\t  %d is already taken!\n\t  Select Again!\n",chInput-'0');
		goto AA;
	}
	str[chInput - '0'] = player;
	

}//playOX

void about() {//about 메뉴
	system("cls");
	printf("\t =====================================\n");
	printf("\t             Console Menu Program v0.8\n");
	printf("\t -------------------------------------\n");
	printf("\t             Programmed by Chaeeun Ryu\n\n");
	printf("\t             성균관대학교\n\n");
	printf("\t             <기본프로그래밍>\n\n");
	printf("\t             안용학 교수님\n\n");
	printf("\t             2020.\n\n");
	printf("\t             Composed by C Language\n\n");
	printf("\t =====================================\n");

}//about
int cal_degree() {//degree 점수 계산
	int tmp = 0;
	int nDegree = 0;//degree점수
	char survey[5][100] = {//질문지
		"나는: 1. 이성적인 사람에 가깝다. 2. 감성적인 사람에 가깝다.",
		"나는: 1. 냉철하다는 평가를 많이 듣는다. 2. 감수성이 풍부하다는 평가를 많이 듣는다.",
		"나의 MBTI 결과는: 1.T이다 2.F이다.",
		"나는: 1. 감정 기복이 별로 없다, 2. 하루에 느끼는 감정이 다양한 편이다.",
		"나는: 1. 생각이 지배하는 사람이다, 2. 감정이 지배하는 사람이다."
	};
	for (int i = 0; i < 5; i++) {
		system("cls");
		printf("\t =====================================\n");
		printf("\t             myPersonality\n");
		printf("\t -------------------------------------\n");
		printf("\n\t%s\n", survey[i]);//질문지 출력
		printf("\t입력>> ");
		scanf("%d", &tmp);
		getchar();
		if (tmp == 1) {//1번 선택시
			tmp = -1;
			nDegree = nDegree + tmp;//nDegree에 tmp를 누적
		}
		else if (tmp == 2) {//2번 선택시
			tmp = 1;
			nDegree = nDegree + tmp;//nDegree에 tmp를 누적
		}
		else {//잘못된 선택
			printf("wrong input!! select either 1 or 2\n");
			i--;
			system("pause");//콘솔 창 정지
		}
		
	}
	return nDegree;//Degree 점수 반환
	
}
int cal_socio() {//Socio점수 계산
	int tmp = 0;
	int nSocio = 0;//Socio점수 
	char survey[5][100] = {//질문지
		"나는 타인의 시선을 : 1. 많이 신경 쓴다. 2. 신경쓰지 않는다",
		"나는 나에 대한 타인의 평가가: 1.중요하다. 2. 상관 없다",
		"타인의 일에 공감력이: 1. 매우 높은 편이다 2. 조금 떨어지는 편이다.",
		"사람들의 관심을 1. 받고싶다 2.신경 쓰지 않는다",
		"연예인을 되고싶다는 생각이: 1.주로 들곤 한다 2. 왜 하는지 모르겠다"
	};
	for (int i = 0; i < 5; i++) {
		system("cls");
		printf("\t =====================================\n");
		printf("\t             myPersonality\n");
		printf("\t -------------------------------------\n");
		printf("\n\t%s\n", survey[i]);
		printf("\t입력>> ");
		scanf("%d", &tmp);//입력
		getchar();
		
		if (tmp == 1) {//1번 선택
			tmp = 1;
			nSocio = nSocio + tmp;//tnSocio에 mp누적하여 더함
		}
		else if (tmp == 2) {//2번선택
			tmp = -1;
			nSocio = nSocio + tmp;//tnSocio에 mp누적하여 더함
		}
		else {//잘못선택
			printf("wrong input!! select either 1 or 2\n");
			i--;
			system("pause");
		}
	}
	return nSocio;//Socio점수 반환
}
int cal_pessi() {//pessi점수 계산
	int tmp = 0;
	int nPessi = 0;
	char survey[5][140] = {//질문지
		"나는 애인으로부터: 1.완전한 사랑은 애초에 존재하지 않기에 기대하지 않는다. 2. 완전한 사랑을 바란다",
		"인생은 1. 원래 대부분 고통스럽다 2. 언제나 희망이 있다",
		"인간은: 1. 악한 부분이 더 많다 2. 선한 부분이 더 많다.",
		"행복이란: 1. 집착할 수록 괴로운 것 2. 언제나 찾고자 하면 찾을 수 있는 것",
		"자살하고자 하는 사람을 구하는 것은: 1. 자신이 책임질 것 아니면 무책임 한 일, 2. 무조건 해야하는 행위"
	};
	for (int i = 0; i < 5; i++) {
		system("cls");
		printf("\t =====================================\n");
		printf("\t             myPersonality\n");
		printf("\t -------------------------------------\n");
		printf("\n\t%s\n", survey[i]);
		printf("\t입력>> ");
		scanf("%d", &tmp);
		getchar();
		
		if (tmp == 1) {//1번 선택
			tmp = -1;
			nPessi = nPessi + tmp;//pessi에 tmp누적시킴
		}
		else if (tmp == 2) {//2번 선택
			tmp = 1;
			nPessi = nPessi + tmp;//pessi에 tmp누적시킴
		}
		else {//잘못된 선택
			printf("wrong input!! select either 1 or 2\n");
			i--;
			system("pause");
		}
	}
	return nPessi;
}
int cal_material() {//material점수 계산
	int tmp = 0;
	int nMaterial = 0;//material점수
	char survey[5][120] = {//질문지
		"역시 1. 돈과 스펙이 짱이다 2. 눈에 보이지 않는 가치가 더 중요하다",
		"친구는: 1. 자본주의 사회에선, 돈으로 살 수 있다. 2. 돈으로 절대 살 수 없다",
		"취미와 일이 주객전도되는 일은 1. 절대 있어선 안된다 2. 때때론 그럴 수도 있다",
		"나에게 돈이란: 1. 많을 수록 좋은 것 2. 만족하는 만큼만 있으면 된다",
		"결혼에 있어선: 1. 사랑만큼, 혹은 그보다 중요한건 경제력이다. 2. 서로의 사랑이 최우선이다"
	};
	for (int i = 0; i < 5; i++) {
		system("cls");
		printf("\t =====================================\n");
		printf("\t             myPersonality\n");
		printf("\t -------------------------------------\n");
		printf("\n\t%s\n", survey[i]);//질문지 출력
		printf("\t입력>> ");
		scanf("%d", &tmp);//사용자 입력
		getchar();
		if (tmp == 1) {//1번 선택
			tmp = -1;
			nMaterial = nMaterial + tmp;//tmp 누적
		}
		else if (tmp == 2) {//2번 선택
			tmp = 1;
			nMaterial = nMaterial + tmp;//tmp누적
		}
		else {//잘못 선택
			printf("wrong input!! select either 1 or 2\n");
			i--;
			system("pause");
		}
	}//for
	return nMaterial;

}
int cal_character() {//character 점수 계산
	int tmp = 0;
	int nCharacter = 0;//character점수
	char survey[5][130] = {//질문지
		"운명이란: 1. 맡기라고 있는 것이다 2. 내가 주체적으로 바꿔나가는 것이다.",
		"나의 인생관과 가까운 것은: 1.만족할 줄 아는 것이 가장 미덕이다 2. 게으름만큼 악한게 없다.",
		"자신에게 현실적으로 도움이 되지 않는 물건을 사는 행위는 1.한심하다. 2. 개인 행복을 위해 충분히 가능하다",
		"워커홀릭으로 살다가 건강을 잃으면: 1. 내 자신이 최우선. 일보단 건강이 우선이다. 2. 노력만큼은 존경스럽다",
		"만약 둘 중 하나로 살아야 한다면: 1. 죽림칠현으로 지내다가 죽기 2. 일에 영혼을 다 해 살다가 죽기"
	};
	for (int i = 0; i < 5; i++) {
		system("cls");
		printf("\t =====================================\n");
		printf("\t             myPersonality\n");
		printf("\t -------------------------------------\n");
		printf("\n\t%s\n", survey[i]);//질문지 출력
		printf("\t입력>> ");
		scanf("%d", &tmp);//사용자 입력
		getchar();
		if (tmp == 1) {//1번 선택
			tmp = -1;
			nCharacter = nCharacter + tmp;//tmp 누적
		}
		else if (tmp == 2) {//2번 선택
			tmp = 1;
			nCharacter = nCharacter + tmp;//tmp누적
		}
		else {//1과 2가 아닌 잘못 선택
			printf("wrong input!! select either 1 or 2\n");
			i--;
			system("pause");
		}
	}//for
	return nCharacter;//nCharactere반환
}
void myPersonality() {
	char degree[2][10] = { "차가운", "뜨거운" };//degree 가능한 결과(이성적인지 감성적인지)
	char socio[2][20] = { "마이웨이를 걷는","연예인 태생" };//socio가능한 결과(타인 시선 의식 정도)
	char pessi[2][13] = { "회의주의적", "낙천주의적" };//pessi 가능한 결과(회의주의적인지 낙천주의적인지)
	char materialistic[2][20] = { "실용주의적","가치주의적" };//materialistic 가능한 결과(실용주의적인지 가치주의적인지)
	char character[2][13] = { "감자", "유노윤호" };// character 가능한 결과(열정의 정도)
	int tmp = 0;
	int nDegree = 0, nSocio=0,nPessi=0,nCharacter=0, nMaterial = 0;
	system("cls");
	printf("\t =====================================\n");
	printf("\t             myPersonality\n");
	printf("\t -------------------------------------\n");
	nDegree = cal_degree();//degree점수 계산
	nSocio = cal_socio();//socio점수계산
	nPessi = cal_pessi();//pessi점수계산
	nMaterial = cal_material();//material점수계산
	nCharacter = cal_character();//character점수계산

	//결과출력
	printf("\n\t===========결과==========\n");
	printf("\t당신은!! \n\t");
	//음수인지 양수인지에 따라 다른 Degree 결과 출력(이성적인지 감성적인지)
	if (nDegree < 0) {
		printf("▶");
		printf(degree[0]);
	}
	else {
		printf("▶");
		printf(degree[1]);
	}
	printf("\n\t");
	//음수인지 양수인지에 따라 다른 Socio결과 출력 (타인 시선 의식 정도)
	if (nSocio < 0) {
		printf("▶");
		printf(socio[0]);
	}
	else {
		printf("▶");
		printf(socio[1]);
	}
	printf("\n\t");
	//음수인지 양수인지에 따라 다른 Pessi 결과 출력 (회의주의적인지 낙천주의적인지)
	if (nPessi < 0) {
		printf("▶");
		printf(pessi[0]);
	}
	else {
		printf("▶");
		printf(pessi[1]);
	}
	printf("\n\t");
	//음수인지 양수인지에 따른 materialistic 결과 출력(실용주의적인지 가치주의적인지)
	if (nMaterial < 0) {
		printf("▶");
		printf(materialistic[0]);
	}
	else {
		printf("▶");
		printf(materialistic[1]);
	}
	printf("\n\t");
	//음수인지 양수인지에 따른 character 결과 출력(열정의 정도)
	if (nCharacter < 0) {
		printf("▶");
		printf(character[0]);
	}
	else {
		printf("▶");
		printf(character[1]);
	}
	printf("입니다! ⊙v⊙\n\n");
	//printf("%d %d %d %d %d\n\n", nDegree, nSocio, nPessi, nMaterial, nCharacter);
}//myPersonality()

