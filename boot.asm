[org 0x7c00]  ;Shift all data 7c00 bytes

;|---------------|
   mov ah, 0x02
    mov al, 10
    mov dl, 0x80
    mov ch, 0       ;- All of this loads kernel into memory to be ran
    mov dh, 0
    mov cl, 2
    mov bx, kernel
    int 0x13
;|---------------|

jmp kernel ;Jump to kernel

SECTION .data

;|----|Variables|----|
title db 'UniOS V1.0', 0
cmd db 'UNI>>', 0
cmdnf dw 'Command Not Found', 0
sysend dw 'Ending system', 0
txtmode dw 'Entering Text Mode', 0
escmsg dw 'Press escape to exit', 0
seemsg dw 'Hi my name is camsam and I am British *Easter Egg*', 0
helpmsg dw 'Type h to get a full list of commands/functions', 0
helptxt dw 't: Enter text mode for typing', 0
helpcls dw 'c: Clears all the text off the screen', 0
helpsee dw '...: Hidden command...Easter Egg(s)', 0
helpf1 dw 'F1: Repeats last command that was run', 0
helpf2 dw 'F2: Tests functions that are still beta', 0
helpadd dw 'a: Does addition up to 18', 0
errortxt dw 'Fatal System Error, Ending System', 0
addtxt dw 'What is the first number you want to add (0-9):', 0
addtxt2 dw 'What is the second number you want to add(0-9):', 0
ten$ db '10', 0
eleven$ db '11', 0
twelve$ db '12', 0
thirteen$ db '13', 0
fourteen$ db '14', 0
fifteen$ db '15', 0
sixteen$ db '16', 0
seventeen$ db '17', 0
eighteen$ db '18', 0
whattxt1 dw 'Sometimes you dont understand things.', 0
whattxt2 dw 'WHY did you even run this command? I hate bloody americans :p', 0


;|----|Sys Info|----|
systitle dw 'System Info:', 0

sysOS dw 'OS: ', 0
sysOS1 dw 'UniOS', 0
sysOS2 dw 'CamOS', 0

sysV dw 'Version: ', 0
sysV1 dw '1.0', 0
sysV2 dw '1.1', 0

sysPre dw 'Basic or Pro: ', 0
sysPre1 dw 'Basic', 0
sysPre2 dw 'Pro', 0

sysgph dw 'Graphics: ', 0
sysgph1 dw 'Basic Text', 0
sysgph2 dw 'SuperVGA 600x800', 0

sysmse dw 'Mouse Status: ', 0
sysmse1 dw 'Online', 0
sysmse2 dw 'Offline', 0

syscrd dw 'Credits: ', 0
syscrdj dw 'Lead Dev: Jack Warren ', 0
syscrdc dw 'Helper: Cameron Cox', 0

SECTION .text


;**MAGIC boot number**
times 510-($-$$) db 0
dw 0xaa55

;|KERNEL IMPORTANT|

kernel:

call clear_screen ;Clears screen

call print_nl ;Makes a new line
mov bx, title ;Specifies what text to print
call print ;Prints text
call print_nl
mov bx, escmsg
call print
call print_nl
mov bx, helpmsg
call print

call print_nl ;Makes a new line
call print_nl ;Makes a new line

mov bx, cmd
call print
call type_char_cmd; Starts the command line


;FUNCTIONS;

print:
    pusha

start:
    mov al, [bx]
    cmp al, 0
    je done

    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp start

done:
    popa
    ret

print_nl:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    
    popa
    ret
    
clear_screen:
    pusha
    
    mov ah, 0x07
    mov al, 0x00
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184f
    int 0x10

    popa
    ret
    
clear_screen_small:
    pusha

    mov ah, 0x07
    mov al, 0x01
    mov bh, 0x00
    mov cx, 0x0000
    mov dx, 0x184f
    int 0x10

    popa
    ret
    
type_char:
    pusha
    
    mov ax, 0x00
    int 0x16
    
    cmp ah, 0x1c
    je char_enter
    
    cmp ah, 0x01
    je char_done
    
    mov ah, 0x0e
    int 0x10
    
    jmp type_char
    
char_enter:
    call print_nl
    jmp type_char
    
char_done:
    popa
    ret
    
type_char_cmd:
    pusha
    
    mov ax, 0x00
    int 0x16
    
    cmp ah, 0x1e
    je save_char
    
    cmp ah, 0x30
    je save_char
    
    cmp ah, 0x2e
    je save_char
    
    cmp ah, 0x20
    je save_char
    
    cmp ah, 0x12
    je save_char
    
    cmp ah, 0x21
    je save_char
    
    cmp ah, 0x22
    je save_char
    
    cmp ah, 0x23
    je save_char
    
    cmp ah, 0x17
    je save_char
    
    cmp ah, 0x24
    je save_char
    
    cmp ah, 0x25
    je save_char
    
    cmp ah, 0x26
    je save_char
    
    cmp ah, 0x32
    je save_char
    
    cmp ah, 0x31
    je save_char
    
    cmp ah, 0x18
    je save_char
    
    cmp ah, 0x19
    je save_char
    
    cmp ah, 0x10
    je save_char
    
    cmp ah, 0x13
    je save_char
    
    cmp ah, 0x1f
    je save_char
    
    cmp ah, 0x14
    je save_char
    
    cmp ah, 0x16
    je save_char
    
    cmp ah, 0x2f
    je save_char
    
    cmp ah, 0x11
    je save_char
    
    cmp ah, 0x2d
    je save_char
    
    cmp ah, 0x15
    je save_char
    
    cmp ah, 0x2c
    je save_char
    
    cmp ah, 0x3d
    je up_key_cmd
    
    cmp ah, 0x3e
    je down_key_cmd
    
    cmp ah, 0x3b
    je repeat_char
    
    cmp ah, 0x3c
    je beta_char
    
half:
    
    cmp ah, 0x1c
    je char_enter_cmd
    
    cmp ah, 0x01
    je char_done_cmd
    
    mov ah, 0x0e
    mov bl, 0x0e
    int 0x10
    
    jmp type_char_cmd
    
char_enter_cmd:

    call print_nl
    call print_nl
    call clear_screen_small
    
    cmp dh, 0x1e
    je addition_cmd
    
    cmp dh, 0x14
    je txt_mode
    
    cmp dh, 0x2e
    je cls_cmd
    
    cmp dh, 0x2c
    je see_cmd
    
    cmp dh, 0x23
    je help_cmd
    
    cmp dh, 0x22
    je what_cmd
    
    cmp dh, 0x17
    je sysinfo_cmd
    
    mov bx, cmdnf
    call print
    call print_nl
    
    mov bx, cmd
    call print
    jmp type_char_cmd

save_char:
    mov dh, ah
    jmp half
    
char_done_cmd:
    mov bx, sysend
    call print_nl
    call print
    popa
    ret
    
txt_mode:
    mov ch, dh
    call clear_screen
    mov bx, txtmode
    call print
    call print_nl
    mov bx, escmsg
    call print
    call print_nl
    call print_nl
    
    call type_char
    call clear_screen
    mov bx, cmd
    call print
    jmp type_char_cmd
    
cls_cmd:
    mov ch, dh
    call clear_screen
    
    mov bx, cmd
    call print
    jmp type_char_cmd
    
help_cmd:
    mov ch, dh
    mov bx, helptxt
    call print
    call print_nl
    mov bx, helpcls
    call print
    call print_nl
    mov bx, helpadd
    call print
    call print_nl
    mov bx, helpf1
    call print
    call print_nl
    mov bx, helpf2
    call print
    call print_nl
    mov bx, helpsee
    call print
    call print_nl
    
    mov bx, cmd
    call print
    jmp type_char_cmd
    
see_cmd:
    mov ch, dh
    mov bx, seemsg
    call print
    call print_nl
    
    mov bx, cmd
    call print
    jmp type_char_cmd
    
repeat_char:
    mov dh, ch
    jmp char_enter_cmd
    
beta_char:
    jmp up_key_cmd
    
addition_cmd:
    mov ch, dh
    mov bx, addtxt
    call print
    call print_nl
    
    mov ax, 0x00
    int 0x16
    
    mov cl, al
    
    mov ah, 0x0e
    int 0x10
    call print_nl
    
    mov bx, addtxt2
    call print
    call print_nl
    
    mov ax, 0x00
    int 0x16
    
    mov dl, al
    
    mov ah, 0x0e
    int 0x10
    call print_nl
    
    add cl, dl
    
    cmp cl, '`'
    je zero
    
    cmp cl, 'a'
    je one
    
    cmp cl, 'b'
    je two
    
    cmp cl, 'c'
    je three
    
    cmp cl, 'd'
    je four
    
    cmp cl, 'e'
    je five
    
    cmp cl, 'f'
    je six
    
    cmp cl, 'g'
    je seven
    
    cmp cl, 'h'
    je eight
    
    cmp cl, 'i'
    je nine
    
    cmp cl, 'j'
    je ten
    
    cmp cl, 'k'
    je eleven
    
    cmp cl, 'l'
    je twelve
    
    cmp cl, 'm'
    je thirteen
    
    cmp cl, 'n'
    je fourteen
    
    cmp cl, 'o'
    je fifteen
    
    cmp cl, 'p'
    je sixteen
    
    cmp cl, 'q'
    je seventeen
    
    cmp cl, 'r'
    je eighteen
    
    mov al, cl
    int 0x10
    call print_nl
    
zero:
    mov al, '0'
    int 0x10
    call print_nl
    jmp end_add
    
one:
    mov al, '1'
    int 0x10
    call print_nl
    jmp end_add
    
two:
    mov al, '2'
    int 0x10
    call print_nl
    jmp end_add
    
three:
    mov al, '3'
    int 0x10
    call print_nl
    jmp end_add
    
four:
    mov al, '4'
    int 0x10
    call print_nl
    jmp end_add
    
five:
    mov al, '5'
    int 0x10
    call print_nl
    jmp end_add
    
six:
    mov al, '6'
    int 0x10
    call print_nl
    jmp end_add
    
seven:
    mov al, '7'
    int 0x10
    call print_nl
    jmp end_add
    
eight:
    mov al, '8'
    int 0x10
    call print_nl
    jmp end_add
    
nine:
    mov al, '9'
    int 0x10
    call print_nl
    jmp end_add
    
ten:
    mov bx, ten$
    call print
    call print_nl
    jmp end_add
    
eleven:
    mov bx, eleven$
    call print
    call print_nl
    jmp end_add
    
twelve:
    mov bx, twelve$
    call print
    call print_nl
    jmp end_add
    
thirteen:
    mov bx, thirteen$
    call print
    call print_nl
    jmp end_add
    
fourteen:
    mov bx, fourteen$
    call print
    call print_nl
    jmp end_add
    
fifteen:
    mov bx, fifteen$
    call print
    call print_nl
    jmp end_add
    
sixteen:
    mov bx, sixteen$
    call print
    call print_nl
    jmp end_add
    
seventeen:
    mov bx, seventeen$
    call print
    call print_nl
    jmp end_add
    
eighteen:
    mov bx, eighteen$
    call print
    call print_nl
    jmp end_add
    
end_add:
    mov bx, cmd
    call print
    jmp type_char_cmd
    
what_cmd:
    mov ch, dh
    mov bx, whattxt1
    call print
    call print_nl
    
    mov bx, whattxt2
    call print
    call print_nl
    
    mov bx, cmd
    call print
    jmp type_char_cmd
    
sysinfo_cmd:
    mov ch, dh
    call print_nl
    call print_nl

    mov bx, systitle
    call print
    call print_nl
    call print_nl
    
    mov bx, sysOS
    call print
    call print_nl
    mov bx, sysOS1
    call print
    call print_nl
    call print_nl
    
    mov bx, sysV
    call print
    call print_nl
    mov bx, sysV1
    call print
    call print_nl
    call print_nl
    
    mov bx, sysPre
    call print
    call print_nl
    mov bx, sysPre1
    call print
    call print_nl
    call print_nl
    
    mov bx, sysgph
    call print
    call print_nl
    mov bx, sysgph1
    call print
    call print_nl
    call print_nl
    
    mov bx, sysmse
    call print
    call print_nl
    mov bx, sysmse2
    call print
    call print_nl
    call print_nl
    
    mov bx, syscrd
    call print
    call print_nl
    call print_nl
    
    mov bx, syscrdj
    call print
    call print_nl
    
    mov bx, syscrdc
    call print
    call print_nl

    call print_nl
    mov bx, cmd
    call print
    jmp type_char_cmd
    
up_key_cmd:
    pusha
    
    mov ah, 0x07
    mov al, 0x01
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184f
    int 0x10

    popa
    
    jmp type_char_cmd
    
down_key_cmd:
    pusha
    
    mov ah, 0x06
    mov al, 0x01
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184f
    int 0x10

    popa
    
    jmp type_char_cmd

error:
    mov bx, errortxt
    call print


