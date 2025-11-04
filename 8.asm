stdin equ -10
%macro input 0
    enter 0,0
    push 0
    push InputLength
    push 256
    lea eax, [InputBuffer]
    push eax
    push dword [InputHandle]
    call _ReadFile@20
    leave
%endmacro
section .data
    sig db 0
section .bss
    InputHandle resd 1
    InputBuffer resd 256
    InputLength resd 1
    Number resd 1
section .text
    global Start
    extern _GetStdHandle@4, _ReadFile@20, _ExitProcess@4
Start:
    push stdin
    call _GetStdHandle@4
    mov dword [InputHandle], eax
    input
    mov edx, InputBuffer
    mov cl, [edx]
    cmp cl, '-'
    je signed
    sign_deleted:
    call string_to_number
    call num
    call _ExitProcess@4
signed:
    inc eax
    inc edx
    inc [sig]
    jmp sign_deleted
num:
    cmp [sig], 0
    je sign_ok
    neg eax
    sign_ok:
    mov [Number], eax
    call _ExitProcess@4
string_to_number:
    xor eax, eax 
.top:
    movzx ecx, byte [edx] 
    inc edx 
    cmp ecx, '0' 
    jb .done
    cmp ecx, '9'
    ja .done
    sub ecx, '0' 
    mul eax, 10
    add eax, ecx 
    jmp .top 
.done:
    ret