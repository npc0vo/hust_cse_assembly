.model small
.data
    string db 'AAAAAAAAAAABCDEF', 0
    cmpstr db 'AAA', 0
.code
start:
;PREPEND BEGIN
	mov ax, @data
	mov ds, ax
	mov es, ax

    lea di, string  
    mov cx, 16      ; 字符串总长度
    xor ax, ax      ; 结果计数器初始化为0
    xor bx, bx      ; BX 用作临时寄存器
    xor si, si      ; SI 初始化为0，用于索引 cmpstr
;PREPEND END

;TEMPLATE BEGIN        
;补充代码

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

;TEMPLATE END

;APPEND BEGIN
	mov dx, ax
    add dx, 48      ; 将结果转换为 ASCII 编码
    mov ah, 02h     ; 准备输出字符
	int 21h         ; DOS中断调用，输出字符

	mov ah, 4ch     ; 准备退出程序
	int 21h         ; DOS中断调用，退出程序
	end start
;APPEND END