## LBYARCH - S11A
## Members
Chu, Andrei Benedict                                                             
De Jesus, Andrei Zarmin

## Instructions Specs in docs:
https://docs.google.com/document/d/1JE-423jma3mnTaQ7Hq1oRWzfxqjsY0t8/edit?usp=sharing&ouid=116961756974305697096&rtpof=true&sd=true


## Instructions for running the machine project:
Go to your root folder via command line and put the commands inside the terminal:
1. nasm -f win64 asmfunc.asm
2. gcc -c main.c -o main.obj
3. gcc main.obj asmfunc.obj -o main.exe -m64
4. .\main.exe


## During runtime:
When prompted to enter a filename, enter `input.txt`
