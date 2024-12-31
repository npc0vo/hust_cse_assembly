.model small
.code
start:
// PREPEND BEGIN
    mov bx, 0
    
inputloop:   

    mov ah, 8   
    int 21h
    
    cmp al, 35
    je startcalc
    
    mov ah, 0
    
    cmp al, '9'
    jbe convert_digit
    sub al, 7
    convert_digit:
    sub al, '0'
    
    shl bx, 1   
    shl bx, 1   
    shl bx, 1   
    shl bx, 1   
    add bx, ax
    
    jmp inputloop
startcalc:
    mov ax, bx
    mov bx, 0
// PREPEND END

//TEMPLATE BEGIN
//书写代码
    mov dx,ax
    mov cl,12
    shr dx,cl
    or bx,dx  

    mov dx,ax
    mov cl,4
    shr dx,cl
    and dx,00f0h
    or bx,dx

    mov dx,ax
    mov cl,4
    shl dx,cl
    and dx,0f00h
    or bx,dx

    mov dx,ax
    mov cl,12
    shl dx,cl
    and dx,0f000h
    or bx,dx
//TEMPLATE END
    
//APPEND BEGIN   

    mov dx, bx
    and dx, 000fh
    add dx, '0'
    mov ah, 02h          
    int 21h              

    mov dx, bx
    and dx, 00f0h
    mov cl, 4
    shr dx, cl
    add dx, '0'
    mov ah, 02h          
    int 21h              

    mov dx, bx
    and dx, 0f00h
    mov cl, 8
    shr dx, cl
    add dx, '0'
    mov ah, 02h          
    int 21h              

    mov dx, bx
    and dx, 0f000h
    mov cl, 12
    shr dx, cl
    add dx, '0'
    mov ah, 02h          
    int 21h             

    mov ah, 4ch        
    int 21h            

end start
//APPEND END