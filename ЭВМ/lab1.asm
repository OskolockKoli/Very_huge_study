;Простая программа:
;вариант3;
;(A+B)*C-D  3is   ;
;uint32 max 2 147 483 647;

	.global _c_int00 ;точка входа
_c_int00:

 .text

 MVKL .S1 5,A0 ;A
 MVKH .S1 5,A0

 MVKL .S1 4,A1 ;B
 MVKH .S1 4,A1

 MVKL .S1 66000,A2 ;c
 MVKH .S1 66000,A2

 MVKL .S1 123000,A3 ;d
 MVKH .S1 123000,A3

 ADD .L1 A0,A1,A0 ;A+B;
 ;Умножение;
 MPYLH .M1      A0,A2,A6
 MPYLH .M1      A2,A0,A5
 MPYU .M1       A0,A2,A4
 nop
 ADD .L1        A5,A6,A1
 SHL .S1        A1,0x10,A1
 ADD .L1        A4,A1,A0
 ;()-D;
 SUB .L1 A0, A3, A0

