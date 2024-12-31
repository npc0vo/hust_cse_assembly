.model small
.stack
.code
;这里需要用栈来传递入口参数和出口参数
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段
    call read
    push ax
    call read
    push ax
    call GCD        ; 调用 GCD 子程序
    add sp, 2
    pop dx  ; 将结果保存到dx
    call print_num
    ; 程序结束
    mov ah, 4Ch
    int 21h  

GCD proc 
    push bp
    mov bp,sp

    ;保存现场
    push ax
    push bx
    push dx
    ;
    mov dx,0
    mov ax,[bp+6] ; ax = num1
    mov bx,[bp+4] ; bx = num2
    ;
    cmp bx,0
    jz rettt



    div bx 
    ;  
    push bx ;arg1: num2
    push dx ;arg2: num1%num2
    call GCD
    pop bx  ;出口参数:存放
    pop ax  ;真正的结果


rettt:
    mov [bp+4],bx
    mov [bp+6],ax

    ;恢复现场
    pop dx
    pop bx
    pop ax
    pop bp
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
