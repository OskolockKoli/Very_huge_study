s_s segment

s_s ends


d_s segment
   A Dw 150
   B Dw 0111b
   C Dw 048h
   D Dw 4
   X DW ?
d_s ends


c_s segment
assume ss:s_s, ds:d_s, cs:c_s
begin:
mov ax, d_s
mov ds, ax
mov ax, 0

mov ax,A    ;(1-A/5)
mov bx,5
div bx
mov bx,1
sub bx,ax

mov ax,C
mov cx,D
mul cx
mov cx,ax

mov ax,B
mul bx

sub ax,cx



mov X, ax      ;

mov ah, 4ch
int 21h
c_s ends
end begin