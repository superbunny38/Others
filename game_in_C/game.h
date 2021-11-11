#pragma once
#include <stdio.h>
#include <time.h>
#include <string.h>

#pragma warning(disable: 4996)
//declaration of constants
#define TRUE 1
#define FALSE 0

#define DIE_SIMULATION 1
#define GAME_SHOW 2
#define UPDOWN_GAME 3
#define WORD_GAME 4
#define OX_GAME 5
#define ABOUT 6
#define PERSONALITY 7
#define EXIT 0

//declaration of functions
int displayMainMenu();
void dieSimulation();
void gameShow();
void upDownGame();
void wordGame();
void OXGame();
void displayNumber(char strOX[]);
void playOX(char player, char str[]);
char winCheck(char str[]);
void myPersonality();
int cal_degree();
int cal_socio();
int cal_pessi();
int cal_material();
int cal_character();
void about();