.model small
.stack 100h

.data
    array dw 8 dup(0)  ; 定义数组，存储8个数字
    maxNum dw 0             ; 出现次数最多的数
    maxCount dw 0           ; 出现次数
.code
start:
    ; 初始化数据段
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov cx, 8            
    lea si, array        

read_loop:
    mov ah, 08h          
    int 21h              
    sub al, '0'          
    mov [si], al         
    inc si               
    inc si               
    loop read_loop       

          
;;//TEMPLATE BEGIN
;;//补充代码
    xor si,si
outer_loop:
    mov bx, array[si]   ; 当前数字加载到 BX
    xor cx, cx          ; CX 清零用于计数
    xor di, di          ; DI 用于遍历数组

inner_loop:
    mov ax, array[di]   ; 获取数组当前值
    cmp ax, bx          ; 比较是否等于当前数字
    jne not_equal
    inc cx              ; 计数 +1

not_equal:
    add di, 2           ; 下一个数组元素（16位=2字节）
    cmp di, 16          ; 判断是否超出数组范围（8 * 2）
    jl inner_loop       ; 若未超出，继续内层循环

    ; 更新最大值和最大次数
    cmp cx, maxCount
    jle skip_update
    mov maxCount, cx    ; 更新最大次数
    mov maxNum, bx      ; 更新出现次数最多的数

skip_update:
    add si, 2           ; 移动到下一个数组元素
    cmp si, 16          ; 判断是否处理完数组（8 * 2）
    jl outer_loop       ; 若未处理完，继续外层循环

    ; 将结果存入 AX 和 CX
    mov ax, maxNum
    mov cx, maxCount

    ; 输出结果
    xor dx, dx
    add ax, '0'          
    mov dx, ax
    mov ah, 02h
    int 21h              

    xor dx, dx
    add cx, '0'          
    mov dx, cx
    mov ah, 02h
    int 21h              

    ; 结束程序
    mov ah, 4Ch
    int 21h

end start
  