;;PREPEND BEGIN
.model small
.data
	array dw 1,1,1,2,2,3,4,4
    maxNum dw 0             ; 出现次数最多的数
    maxCount dw 0   
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
;;PREPEND END

;;//TEMPLATE BEGIN
    xor si, si          ; SI 指向数组起始地址
	mov bx, array[si]   ; 当前数字加载到 BX
    xor cx, cx          ; CX 清零用于计数
    xor di,di

    
outer_loop:
    mov bx,array[di]    ; 当前数字加载到 BX
    xor cx, cx          ; CX 清零用于计数
inner_loop:
    cmp bx,array[si]
    jne not_equal
    inc cx
    add si, 2           ; 下一个数组元素（16位=2字节）
    cmp si, 16          ; 判断是否超出数组范围（8 * 2）
    jl inner_loop       ; 若未超出，继续内层循环  // !!!jl!!!
not_equal:
    mov di,si
    cmp maxCount,cx
    jge skip_update
    mov maxCount,cx
    mov maxNum,bx
skip_update:
    cmp di, 16          ; 判断是否处理完数组（8 * 2）
    jl outer_loop

    ; 将结果存入 AX 和 CX
    mov ax, maxNum
    mov cx, maxCount
;;//TEMPLATE END

;;//APPEND BEGIN
	mov dx, ax
	add dx, 48	
    mov ah, 02h
	int 21h
	mov dx, cx
	add dx, 48
	mov ah, 02h
	int 21h
	mov ah, 4ch
	int 21h
end start
;;//APPEND END