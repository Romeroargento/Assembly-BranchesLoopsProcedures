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
	xor eAx,eAx ; Обнуление регистров
	xor eBx,eBx
	xor eCx,eCx
	xor eDx,eDx

	mov cx,1 ; Количество итераций цикла 

first:
	xor ax,X
	xor ax,Y
	xor ax,Z ; Сложение X, Y, Z по модулю 2
	loop first ; Цикл first

	mov L,ax ; L - результат сложения X, Y, Z по модулю 2
	mov bx,X

	and bx,00F0h ; логическое умножение X и 00F0h
	mul tw ; умножение L на 2
	sub ax,bx ; вычитание (X & 00F0h) из L*2
	mov M,ax ; Результат записывается в M
	cmp ax,3111h ; Сравнение M с числом 3111h
	jbe PP2 ; переход к PP2, если M меньше или равно 3111h

	call PP1
	jmp third
	call PP2

third:
	test ax,1 ; проверка числа R на четность 
	JZ ADR1 ; Четное
	JNZ ADR2 ; Нечетное

ADR1:
	add ax,0999h ; сложение R и 0999h
	jmp exit ; переход в конец

ADR2:
	or ax,5A5Ah ; логическое сложение R и 5A5Ah
	jmp exit ; переход в конец

PP1 proc 
	neg ax ; отрицание M
	mov R,ax ; результат в R
	ret
PP1 endp

PP2 proc
	not ax ; логическое отрицание M
	mov R,ax ; результат в R
	ret
PP2 endp

exit: 
Invoke ExitProcess,ax 
End Start