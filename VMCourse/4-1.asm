.model small
.stack
.data
    num1 dw ?       ; 输入的第一个整数 (a)
    num2 dw ?       ; 输入的第二个整数 (b)
    buffer db 8 dup(0) ; 
.code
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段

    call read
    mov num1, ax
    call read
    mov num2, ax
    call GCD        ; 调用 GCD 子程序
    mov dx, num1  ; 将结果保存到dx
    call print_num
    ; 程序结束
    mov ah, 4Ch
    int 21h 
GCD proc near
    cmp num2, 0
    je done
    xor dx, dx       ; 清空 DX 因为 DIV 指令需要 AX:DX 作为被除数
    mov ax, num1     ; AX = num1
    mov bx,num2   
    div bx         ; AX = num1 / num2, DX = 余数 (num1 % num2)

    mov num1, bx   ; 更新 num1 为原来的 num2
    mov num2, dx     ; 更新 num2 为余数
    call GCD         ; 递归调用 GCD 直到 num2 == 0

done:
    mov ax, num1     ; 当 num2 == 0 时，num1 即为 GCD

    ret
GCD endp


print_num proc 
    ;;//TEMPLATE BEGIN
    ;;//书写代码
    xor cx,cx
    mov ax,dx
    mov dx,0
    mov bx,10
again:
    cmp ax,0
    je output_l
    mov dx,0
    div bx
    add dx,030h ;将数字转为ASCII字符
    push dx
    inc cx
    jmp again


output_l:
    mov ah,02h
    pop dx
    int 21h
    loop output_l
    ret
    
    ;;//TEMPLATE END
print_num endp


Read proc
	push bx
	push cx
	push dx
	xor bx,bx
	xor cx,cx
read1:	mov ah,1
	int 21h
	cmp al,'0'
	jb read4
	cmp al,'9'
	ja read4
	sub al,30h
	shl bx,1
	mov dx,bx
	shl bx,1
	shl bx,1
	add bx,dx
	mov ah,0
	add bx,ax
	jmp read1
read4:	mov ax,bx
	pop dx
	pop cx
	pop bx
	ret
Read	endp



end main