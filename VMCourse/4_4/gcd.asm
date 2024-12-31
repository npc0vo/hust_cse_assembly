.model flat, c  ;c ����Լ��
.stack 100h
.code
public GCD       ; ��������Ϊ���������Ա��ⲿ����

GCD proc near 
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]    ; AX = num1
    mov ebx, [ebp+12]   ; BX = num2
    cmp ebx,0
    je done
    xor edx, edx       ; ��� DX ��Ϊ DIV ָ����Ҫ AX:DX ��Ϊ������
    div ebx         ; AX = num1 / num2, DX = ���� (num1 % num2)
    mov eax,ebx    
    mov ebx,edx
    push ebx     ;arg2
    push eax    ;arg1
    call GCD         ; �ݹ���� GCD ֱ�� num2 == 0
    add esp, 8
done:

    pop ebp
    ret
GCD endp

end
