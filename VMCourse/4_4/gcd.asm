.model flat, c  ;c 调用约定
.stack 100h
.code
public GCD       ; 声明函数为公共，可以被外部调用

GCD proc near 
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]    ; AX = num1
    mov ebx, [ebp+12]   ; BX = num2
    cmp ebx,0
    je done
    xor edx, edx       ; 清空 DX 因为 DIV 指令需要 AX:DX 作为被除数
    div ebx         ; AX = num1 / num2, DX = 余数 (num1 % num2)
    mov eax,ebx    
    mov ebx,edx
    push ebx     ;arg2
    push eax    ;arg1
    call GCD         ; 递归调用 GCD 直到 num2 == 0
    add esp, 8
done:

    pop ebp
    ret
GCD endp

end
