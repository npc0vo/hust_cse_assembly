;;//PREPEND BEGINcL
.model small
.stack
.data
    PosArr db 3 dup(?)  ; 存放正数的数组
    fuyi db '-1','$';
.code
start:
    mov ax,@data    ; 初始化DS
    mov ds,ax    ; 初始化DS
    mov cx, 3 ; 输入的整数数量
    mov di , 0 ; 数组下标

InputLoop:
    ; 读取一个整数
    mov ah, 01h ; DOS的输入服务号
    int 21h     ; 调用DOS的输入服务
    sub al, 30h ; 将ASCII码转换为数字
    mov PosArr[di], al ; 将输入的数字存入数组  
    inc di  ; 数组下标加1
    loop InputLoop  ; 循环输入
;;//PREPEND END
    
    ;;//TEMPLATE BEGIN
    ;;//书写代码
    xor si,si
    mov al,PosArr[si]
    add al,PosArr[si+1]
    cmp al,PosArr[si+2]
    jz op0
    jg op1
    jmp op_1
    ;;//TEMPLATE END
op0:
    mov dl,'0'
    jmp output
op1:
    mov dl,'1'
output:
    mov ah, 02h           ; 功能号 02h - 输出单个字符
    int 21h
    jmp Exit

op_1:
    lea dx,fuyi
    mov ah,09h
    int 21h

Exit:
    mov ah, 4ch ; DOS的退出服务号
    int 21H     ; 调用DOS的退出服务
;;//APPEND BEGIN
end start
;;//APPEND END