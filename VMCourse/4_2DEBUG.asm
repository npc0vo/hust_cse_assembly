.model small
.stack 100h
.data
    num1 dw 10       
    num2 dw 50       

.code
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段
    mov ax,num1
    push ax
    mov ax,num2
    push ax
    call GCD        
    add sp, 2
    pop dx  
    ; 将 GCD 结果保存到 dx 以便打印

    call print_num  ; 打印结果

    ; 程序结束
    mov ah, 4Ch
    int 21h                                  ;      bp
                                            ;     ip
;gcd(50,15)  -> gcd(15,5) -> gcd(5,0)      ;      arg2
GCD proc 
    push bp
    mov bp,sp

    ;保存现场
    push ax
    push bx
    push cx
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
    pop cx
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
    push dx
    inc cx
    jmp again


output_l:
    mov ah,02h
    pop dx
    add dx,030h
    int 21h
    loop output_l
    ret
    
    ;;//TEMPLATE END
print_num endp

end main