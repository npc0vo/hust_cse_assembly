.model small
.data
	string db 16 dup(?)  
	cmpstr db 3 dup(?)
.code
start:
//PREPEND BEGIN
	mov ax, @data
	mov ds, ax
	mov es, ax

    lea di, string  
    mov cx, 16      
inputloop1:
    mov ah, 08h      
    int 21h         
    mov [di], al
    inc di           
    loop inputloop1   


    lea di, cmpstr 
    mov cx, 3      
inputloop2:
    mov ah, 08h      
    int 21h          
    mov [di], al
    inc di           
    loop inputloop2   


    xor ax, ax
    xor bx, bx
    xor dx, dx
    xor cx, cx
    xor di, di  
//PREPEND END

//TEMPLATE BEGIN        
//补充代码

    ;直接暴力对比
    xor di,di
    xor cx,cx
count_loop:
    mov si, 0      
    mov cx, di      
inner_loop:
    mov bl, string[di]
    cmp bl, cmpstr[si]
    jne skip        
    inc di         
    inc si         
    cmp si, 3    
    jl inner_loop   
    inc ax          
skip:
    mov di, cx      
    inc di          
    cmp di, 15
    jl count_loop   
    
//TEMPLATE END

//APPEND BEGIN
	mov dx, ax
    add dx, 48	
    mov ah, 02h
	int 21h

	mov ah, 4ch
	int 21h
	end start
//APPEND END