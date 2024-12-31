;这里要用寄存器来传递参数
.model  small
.stack
.data
    num1 dw ?       ; 输入的第一个整数 (a)
    num2 dw ?       ; 输入的第二个整数 (b)

.code
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段

    call read
    mov num1, ax
    call read
    mov num2, ax
 
    ; 加载输入的两个整数
    mov ax, num1    ; a -> ax
    mov bx, num2    ; b -> bx
    call GCD        ; 调用 GCD 子程序
    mov dx, ax  ; 将结果保存到dx
    call print_num
    ; 程序结束
    mov ah, 4Ch
    int 21h   

GCD proc
;;//TEMPLATE BEGIN
;;//书写代码
    push bp
    mov bp,sp

    push dx

    cmp bx,0
    je rettt

    mov dx,0
    div bx  ;dx=num1%num2
    mov ax,bx
    mov bx,dx
    call GCD

rettt:
    pop dx
    pop bp  
    ret
;;//TEMPLATE END
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
    add dx,030h
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
