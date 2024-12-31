;;//PREPEND BEGIN
.model small

.code
start:

    mov ah, 08h
    int 21h
    sub al, '0'
    xor ah,ah
    mov bx, ax
    ;;//向bx寄存器输入数据
    mov ah, 08h
    int 21h
    sub al, '0'
    xor ah,ah
    mov cx, ax
    ;;//向cx寄存器输入数据
    mov ah, 08h 
    int 21h
    xor ah,ah
    sub al, '0'
    ;;//向ax寄存器输入数据
;;//PREPEND END


;;//TEMPLATE BEGIN
;;//书写代码
    mov dx,ax
    add ax,cx
    mul dx
    add ax, 0fh
    div bx
    mov dx,ax
;;//TEMPLATE END


;;//APPEND BEGIN ;;输出dx寄存器数据
    add dx, '0'	
    mov ah, 02h
    mov dh, 0
    int 21h

    mov ah, 4ch
    int 21h
end start
;;//APPEND END