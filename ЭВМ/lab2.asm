	.global _c_int00 ;����� �����
_c_int00:
 .data
array1: .int 0,-8,-200,4  	;var 3is
array2: .int  1,2,-100,600
array3: .int 0,0,0,0
size .set 4 ;������

 .text
 MVK .S1 array1, A10 ;����� i-�� ��������
 MVK .S2 array2, B10 ;����� i+1-�� ��������
 MVK .S2 array3, B11 ;����� i+1-�� ��������
 MVK .S2 size,B2


LOOP: ;DO

 LDW  .D1 *A10++, A5                 ;�������� i-�� �������� 1-�� �������
 LDW  .D2 *B10++, B5      ;�������� i-�� �������� 2-�� �������
 NOP 4

 SUB .S2 A5, B5, B6

 STW .D2  B6,  *B11++           ;������ i-�� ��������

 SUB .S2 B2, 1, B2      ;���������� ��������
 CMPLT.L1 B2,1, A0      ;�������� �� ���������� �����

 [!A0] B .S2 LOOP
 NOP 5
