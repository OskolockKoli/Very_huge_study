TITLE CHANGE 

;текстовая переменная MYTEXT 
.MODEL SMALL 
.STACK 256 
.DATA
 MYTEXT DB 'SpeciaL Thanks bridgE August', 13, 10, '$' 
 lenght= ($-MYTEXT)-3
 ;объявляем текстовую 

 ;---------------------- процедура коррекции кода символа--------------------- 
 .CODE
 Begin: 
 
 ;-----------------------------основная программа------------------------------------ 
	 MOV AX, @DATA 
	 MOV DS, AX 
	 XOR AX, AX 
	 LEA BX, MYTEXT 
	 MOV CX, lenght ;загрузить счетчик циклов 
	 ;---------------------------------начало тела цикла---------------------------------- 
	 MT1: MOV AH, [BX]
	 	CMP AH, 'b' 
	 	JE CT
	 	CMP AH, 'c'
	 	JNE CF
	 	
	 	CT:CALL COR
	 	JMP MT2

		CF:CMP AH, 'A'
	 	JB MT2 
	 	CMP AH, 'Z'
	 	JA MT2 
	 	CALL COR 
	 	
	 	MT2: INC BX 
	 ;------------------------конец тела цикла-------------------------------------------- 
	 LOOP MT1 			;повторить цикл, если (CX) ≠0 
	 	LEA DX, MYTEXT 	;вывести переменную 
	 	MOV AH, 09h 	;MYTEXT 
	 	INT 21h 		;на экран 
	 	NOP 			;холостая команда 
	 	MOV AX, 4C00h 	;завершить 
	 	INT 21h 		;программу 

COR PROC NEAR
 	NOP
 	XOR AH, 020h 
 	MOV [BX], AH 
 	RET 
 COR ENDP 
 UP PROC NEAR
 	NOP
 	XOR AH, 020h 
 	MOV [BX], AH 
 	RET 
 UP ENDP 
 END Begin