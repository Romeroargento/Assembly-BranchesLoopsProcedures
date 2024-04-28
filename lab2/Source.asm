.686 
.model flat,stdcall 
 
.stack 100h 
 
.data 
X dw 714Ah
Y dw 6B15h
Z dw 431Bh
L dw ?
M dw ?
R dw ?
tw dw 2
 
.code 
ExitProcess PROTO STDCALL :DWORD 
Start: 
	xor eAx,eAx ; ��������� ���������
	xor eBx,eBx
	xor eCx,eCx
	xor eDx,eDx

	mov cx,1 ; ���������� �������� ����� 

first:
	xor ax,X
	xor ax,Y
	xor ax,Z ; �������� X, Y, Z �� ������ 2
	loop first ; ���� first

	mov L,ax ; L - ��������� �������� X, Y, Z �� ������ 2
	mov bx,X

	and bx,00F0h ; ���������� ��������� X � 00F0h
	mul tw ; ��������� L �� 2
	sub ax,bx ; ��������� (X & 00F0h) �� L*2
	mov M,ax ; ��������� ������������ � M
	cmp ax,3111h ; ��������� M � ������ 3111h
	jbe PP2 ; ������� � PP2, ���� M ������ ��� ����� 3111h

	call PP1
	jmp third
	call PP2

third:
	test ax,1 ; �������� ����� R �� �������� 
	JZ ADR1 ; ������
	JNZ ADR2 ; ��������

ADR1:
	add ax,0999h ; �������� R � 0999h
	jmp exit ; ������� � �����

ADR2:
	or ax,5A5Ah ; ���������� �������� R � 5A5Ah
	jmp exit ; ������� � �����

PP1 proc 
	neg ax ; ��������� M
	mov R,ax ; ��������� � R
	ret
PP1 endp

PP2 proc
	not ax ; ���������� ��������� M
	mov R,ax ; ��������� � R
	ret
PP2 endp

exit: 
Invoke ExitProcess,ax 
End Start