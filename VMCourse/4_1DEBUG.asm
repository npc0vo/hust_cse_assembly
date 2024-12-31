.model small
.stack 100h
.data
    num1 dw 10       ; 预定义的第一个整数 (a)
    num2 dw 50       ; 预定义的第二个整数 (b)

.code
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段

    ; 调用 GCD 子程序，并保证结果存放在 AX 中
    call GCD        ; 计算 GCD 并将结果存储在 AX 中

    ; 将 GCD 结果保存到 dx 以便打印
    mov dx, ax

    call print_num  ; 打印结果

    ; 程序结束
    mov ah, 4Ch
    int 21h 

GCD proc near  4-1
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

end main