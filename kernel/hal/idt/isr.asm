global isrInitGates
extern registerHandler
%define IDT_GATE_TYPE_INT 0xE
section .text
extern handleInt
%macro ISR_NOERRORCODE 1
    global isrHandler%1:
    isrHandler%1:
        push qword 0 ; dummy error code (0xB0)
        push qword %1 ; interrupt number (0xA8)
        jmp isrCommon
%endmacro
%macro ISR_ERRORCODE 1
    global isrHandler%1:
    isrHandler%1:
        push qword %1 ; interrupt number (0xA8)
        jmp isrCommon
%endmacro
%include "kernel/hal/idt/isr.inc"

global isrCommon
isrCommon:
    push rax ; 0xA0
    push rbx ; 0x98
    push rcx ; 0x90
    push rdx ; 0x88
    push rsp ; 0x80
    push rbp ; 0x78
    push rsi ; 0x70
    push rdi ; 0x68
    push r8 ; 0x60
    push r9 ; 0x58
    push r10 ; 0x50
    push r11 ; 0x48
    push r12 ; 0x40
    push r13 ; 0x38
    push r14 ; 0x30
    push r15 ; 0x28
    xor rax, rax
    mov ax, ds
    push rax ; 0x20
    mov ax, es
    push rax ; 0x18
    mov ax, fs
    push rax ; 0x10
    mov ax, gs
    push rax ; 0x8
    mov rax, cr3
    push rax ; 0x0
    cld
    lea rdi, [rsp]
    call handleInt
    pop rbx
    mov cr3, rbx
    xor rbx, rbx
    pop rbx
    mov gs, bx
    pop rbx
    mov fs, bx
    pop rbx
    mov es, bx
    pop rbx
    mov ds, bx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rbp
    pop rsp
    pop rdx
    pop rcx
    pop rbx
	pop rax
	
    add rsp, 16
    iretq

isrInitGates:
    mov rdx, IDT_GATE_TYPE_INT
	mov rsi, isrHandler0
	mov rdi, 0
	call registerHandler
	mov rsi, isrHandler1
	mov rdi, 1
	call registerHandler
	mov rsi, isrHandler2
	mov rdi, 2
	call registerHandler
	mov rsi, isrHandler3
	mov rdi, 3
	call registerHandler
	mov rsi, isrHandler4
	mov rdi, 4
	call registerHandler
	mov rsi, isrHandler5
	mov rdi, 5
	call registerHandler
	mov rsi, isrHandler6
	mov rdi, 6
	call registerHandler
	mov rsi, isrHandler7
	mov rdi, 7
	call registerHandler
	mov rsi, isrHandler8
	mov rdi, 8
	call registerHandler
	mov rsi, isrHandler9
	mov rdi, 9
	call registerHandler
	mov rsi, isrHandler10
	mov rdi, 10
	call registerHandler
	mov rsi, isrHandler11
	mov rdi, 11
	call registerHandler
	mov rsi, isrHandler12
	mov rdi, 12
	call registerHandler
	mov rsi, isrHandler13
	mov rdi, 13
	call registerHandler
	mov rsi, isrHandler14
	mov rdi, 14
	call registerHandler
	mov rsi, isrHandler15
	mov rdi, 15
	call registerHandler
	mov rsi, isrHandler16
	mov rdi, 16
	call registerHandler
	mov rsi, isrHandler17
	mov rdi, 17
	call registerHandler
	mov rsi, isrHandler18
	mov rdi, 18
	call registerHandler
	mov rsi, isrHandler19
	mov rdi, 19
	call registerHandler
	mov rsi, isrHandler20
	mov rdi, 20
	call registerHandler
	mov rsi, isrHandler21
	mov rdi, 21
	call registerHandler
	mov rsi, isrHandler22
	mov rdi, 22
	call registerHandler
	mov rsi, isrHandler23
	mov rdi, 23
	call registerHandler
	mov rsi, isrHandler24
	mov rdi, 24
	call registerHandler
	mov rsi, isrHandler25
	mov rdi, 25
	call registerHandler
	mov rsi, isrHandler26
	mov rdi, 26
	call registerHandler
	mov rsi, isrHandler27
	mov rdi, 27
	call registerHandler
	mov rsi, isrHandler28
	mov rdi, 28
	call registerHandler
	mov rsi, isrHandler29
	mov rdi, 29
	call registerHandler
	mov rsi, isrHandler30
	mov rdi, 30
	call registerHandler
	mov rsi, isrHandler31
	mov rdi, 31
	call registerHandler
	mov rsi, isrHandler32
	mov rdi, 32
	call registerHandler
	mov rsi, isrHandler33
	mov rdi, 33
	call registerHandler
	mov rsi, isrHandler34
	mov rdi, 34
	call registerHandler
	mov rsi, isrHandler35
	mov rdi, 35
	call registerHandler
	mov rsi, isrHandler36
	mov rdi, 36
	call registerHandler
	mov rsi, isrHandler37
	mov rdi, 37
	call registerHandler
	mov rsi, isrHandler38
	mov rdi, 38
	call registerHandler
	mov rsi, isrHandler39
	mov rdi, 39
	call registerHandler
	mov rsi, isrHandler40
	mov rdi, 40
	call registerHandler
	mov rsi, isrHandler41
	mov rdi, 41
	call registerHandler
	mov rsi, isrHandler42
	mov rdi, 42
	call registerHandler
	mov rsi, isrHandler43
	mov rdi, 43
	call registerHandler
	mov rsi, isrHandler44
	mov rdi, 44
	call registerHandler
	mov rsi, isrHandler45
	mov rdi, 45
	call registerHandler
	mov rsi, isrHandler46
	mov rdi, 46
	call registerHandler
	mov rsi, isrHandler47
	mov rdi, 47
	call registerHandler
	mov rsi, isrHandler48
	mov rdi, 48
	call registerHandler
	mov rsi, isrHandler49
	mov rdi, 49
	call registerHandler
	mov rsi, isrHandler50
	mov rdi, 50
	call registerHandler
	mov rsi, isrHandler51
	mov rdi, 51
	call registerHandler
	mov rsi, isrHandler52
	mov rdi, 52
	call registerHandler
	mov rsi, isrHandler53
	mov rdi, 53
	call registerHandler
	mov rsi, isrHandler54
	mov rdi, 54
	call registerHandler
	mov rsi, isrHandler55
	mov rdi, 55
	call registerHandler
	mov rsi, isrHandler56
	mov rdi, 56
	call registerHandler
	mov rsi, isrHandler57
	mov rdi, 57
	call registerHandler
	mov rsi, isrHandler58
	mov rdi, 58
	call registerHandler
	mov rsi, isrHandler59
	mov rdi, 59
	call registerHandler
	mov rsi, isrHandler60
	mov rdi, 60
	call registerHandler
	mov rsi, isrHandler61
	mov rdi, 61
	call registerHandler
	mov rsi, isrHandler62
	mov rdi, 62
	call registerHandler
	mov rsi, isrHandler63
	mov rdi, 63
	call registerHandler
	mov rsi, isrHandler64
	mov rdi, 64
	call registerHandler
	mov rsi, isrHandler65
	mov rdi, 65
	call registerHandler
	mov rsi, isrHandler66
	mov rdi, 66
	call registerHandler
	mov rsi, isrHandler67
	mov rdi, 67
	call registerHandler
	mov rsi, isrHandler68
	mov rdi, 68
	call registerHandler
	mov rsi, isrHandler69
	mov rdi, 69
	call registerHandler
	mov rsi, isrHandler70
	mov rdi, 70
	call registerHandler
	mov rsi, isrHandler71
	mov rdi, 71
	call registerHandler
	mov rsi, isrHandler72
	mov rdi, 72
	call registerHandler
	mov rsi, isrHandler73
	mov rdi, 73
	call registerHandler
	mov rsi, isrHandler74
	mov rdi, 74
	call registerHandler
	mov rsi, isrHandler75
	mov rdi, 75
	call registerHandler
	mov rsi, isrHandler76
	mov rdi, 76
	call registerHandler
	mov rsi, isrHandler77
	mov rdi, 77
	call registerHandler
	mov rsi, isrHandler78
	mov rdi, 78
	call registerHandler
	mov rsi, isrHandler79
	mov rdi, 79
	call registerHandler
	mov rsi, isrHandler80
	mov rdi, 80
	call registerHandler
	mov rsi, isrHandler81
	mov rdi, 81
	call registerHandler
	mov rsi, isrHandler82
	mov rdi, 82
	call registerHandler
	mov rsi, isrHandler83
	mov rdi, 83
	call registerHandler
	mov rsi, isrHandler84
	mov rdi, 84
	call registerHandler
	mov rsi, isrHandler85
	mov rdi, 85
	call registerHandler
	mov rsi, isrHandler86
	mov rdi, 86
	call registerHandler
	mov rsi, isrHandler87
	mov rdi, 87
	call registerHandler
	mov rsi, isrHandler88
	mov rdi, 88
	call registerHandler
	mov rsi, isrHandler89
	mov rdi, 89
	call registerHandler
	mov rsi, isrHandler90
	mov rdi, 90
	call registerHandler
	mov rsi, isrHandler91
	mov rdi, 91
	call registerHandler
	mov rsi, isrHandler92
	mov rdi, 92
	call registerHandler
	mov rsi, isrHandler93
	mov rdi, 93
	call registerHandler
	mov rsi, isrHandler94
	mov rdi, 94
	call registerHandler
	mov rsi, isrHandler95
	mov rdi, 95
	call registerHandler
	mov rsi, isrHandler96
	mov rdi, 96
	call registerHandler
	mov rsi, isrHandler97
	mov rdi, 97
	call registerHandler
	mov rsi, isrHandler98
	mov rdi, 98
	call registerHandler
	mov rsi, isrHandler99
	mov rdi, 99
	call registerHandler
	mov rsi, isrHandler100
	mov rdi, 100
	call registerHandler
	mov rsi, isrHandler101
	mov rdi, 101
	call registerHandler
	mov rsi, isrHandler102
	mov rdi, 102
	call registerHandler
	mov rsi, isrHandler103
	mov rdi, 103
	call registerHandler
	mov rsi, isrHandler104
	mov rdi, 104
	call registerHandler
	mov rsi, isrHandler105
	mov rdi, 105
	call registerHandler
	mov rsi, isrHandler106
	mov rdi, 106
	call registerHandler
	mov rsi, isrHandler107
	mov rdi, 107
	call registerHandler
	mov rsi, isrHandler108
	mov rdi, 108
	call registerHandler
	mov rsi, isrHandler109
	mov rdi, 109
	call registerHandler
	mov rsi, isrHandler110
	mov rdi, 110
	call registerHandler
	mov rsi, isrHandler111
	mov rdi, 111
	call registerHandler
	mov rsi, isrHandler112
	mov rdi, 112
	call registerHandler
	mov rsi, isrHandler113
	mov rdi, 113
	call registerHandler
	mov rsi, isrHandler114
	mov rdi, 114
	call registerHandler
	mov rsi, isrHandler115
	mov rdi, 115
	call registerHandler
	mov rsi, isrHandler116
	mov rdi, 116
	call registerHandler
	mov rsi, isrHandler117
	mov rdi, 117
	call registerHandler
	mov rsi, isrHandler118
	mov rdi, 118
	call registerHandler
	mov rsi, isrHandler119
	mov rdi, 119
	call registerHandler
	mov rsi, isrHandler120
	mov rdi, 120
	call registerHandler
	mov rsi, isrHandler121
	mov rdi, 121
	call registerHandler
	mov rsi, isrHandler122
	mov rdi, 122
	call registerHandler
	mov rsi, isrHandler123
	mov rdi, 123
	call registerHandler
	mov rsi, isrHandler124
	mov rdi, 124
	call registerHandler
	mov rsi, isrHandler125
	mov rdi, 125
	call registerHandler
	mov rsi, isrHandler126
	mov rdi, 126
	call registerHandler
	mov rsi, isrHandler127
	mov rdi, 127
	call registerHandler
	mov rsi, isrHandler128
	mov rdi, 128
	call registerHandler
	mov rsi, isrHandler129
	mov rdi, 129
	call registerHandler
	mov rsi, isrHandler130
	mov rdi, 130
	call registerHandler
	mov rsi, isrHandler131
	mov rdi, 131
	call registerHandler
	mov rsi, isrHandler132
	mov rdi, 132
	call registerHandler
	mov rsi, isrHandler133
	mov rdi, 133
	call registerHandler
	mov rsi, isrHandler134
	mov rdi, 134
	call registerHandler
	mov rsi, isrHandler135
	mov rdi, 135
	call registerHandler
	mov rsi, isrHandler136
	mov rdi, 136
	call registerHandler
	mov rsi, isrHandler137
	mov rdi, 137
	call registerHandler
	mov rsi, isrHandler138
	mov rdi, 138
	call registerHandler
	mov rsi, isrHandler139
	mov rdi, 139
	call registerHandler
	mov rsi, isrHandler140
	mov rdi, 140
	call registerHandler
	mov rsi, isrHandler141
	mov rdi, 141
	call registerHandler
	mov rsi, isrHandler142
	mov rdi, 142
	call registerHandler
	mov rsi, isrHandler143
	mov rdi, 143
	call registerHandler
	mov rsi, isrHandler144
	mov rdi, 144
	call registerHandler
	mov rsi, isrHandler145
	mov rdi, 145
	call registerHandler
	mov rsi, isrHandler146
	mov rdi, 146
	call registerHandler
	mov rsi, isrHandler147
	mov rdi, 147
	call registerHandler
	mov rsi, isrHandler148
	mov rdi, 148
	call registerHandler
	mov rsi, isrHandler149
	mov rdi, 149
	call registerHandler
	mov rsi, isrHandler150
	mov rdi, 150
	call registerHandler
	mov rsi, isrHandler151
	mov rdi, 151
	call registerHandler
	mov rsi, isrHandler152
	mov rdi, 152
	call registerHandler
	mov rsi, isrHandler153
	mov rdi, 153
	call registerHandler
	mov rsi, isrHandler154
	mov rdi, 154
	call registerHandler
	mov rsi, isrHandler155
	mov rdi, 155
	call registerHandler
	mov rsi, isrHandler156
	mov rdi, 156
	call registerHandler
	mov rsi, isrHandler157
	mov rdi, 157
	call registerHandler
	mov rsi, isrHandler158
	mov rdi, 158
	call registerHandler
	mov rsi, isrHandler159
	mov rdi, 159
	call registerHandler
	mov rsi, isrHandler160
	mov rdi, 160
	call registerHandler
	mov rsi, isrHandler161
	mov rdi, 161
	call registerHandler
	mov rsi, isrHandler162
	mov rdi, 162
	call registerHandler
	mov rsi, isrHandler163
	mov rdi, 163
	call registerHandler
	mov rsi, isrHandler164
	mov rdi, 164
	call registerHandler
	mov rsi, isrHandler165
	mov rdi, 165
	call registerHandler
	mov rsi, isrHandler166
	mov rdi, 166
	call registerHandler
	mov rsi, isrHandler167
	mov rdi, 167
	call registerHandler
	mov rsi, isrHandler168
	mov rdi, 168
	call registerHandler
	mov rsi, isrHandler169
	mov rdi, 169
	call registerHandler
	mov rsi, isrHandler170
	mov rdi, 170
	call registerHandler
	mov rsi, isrHandler171
	mov rdi, 171
	call registerHandler
	mov rsi, isrHandler172
	mov rdi, 172
	call registerHandler
	mov rsi, isrHandler173
	mov rdi, 173
	call registerHandler
	mov rsi, isrHandler174
	mov rdi, 174
	call registerHandler
	mov rsi, isrHandler175
	mov rdi, 175
	call registerHandler
	mov rsi, isrHandler176
	mov rdi, 176
	call registerHandler
	mov rsi, isrHandler177
	mov rdi, 177
	call registerHandler
	mov rsi, isrHandler178
	mov rdi, 178
	call registerHandler
	mov rsi, isrHandler179
	mov rdi, 179
	call registerHandler
	mov rsi, isrHandler180
	mov rdi, 180
	call registerHandler
	mov rsi, isrHandler181
	mov rdi, 181
	call registerHandler
	mov rsi, isrHandler182
	mov rdi, 182
	call registerHandler
	mov rsi, isrHandler183
	mov rdi, 183
	call registerHandler
	mov rsi, isrHandler184
	mov rdi, 184
	call registerHandler
	mov rsi, isrHandler185
	mov rdi, 185
	call registerHandler
	mov rsi, isrHandler186
	mov rdi, 186
	call registerHandler
	mov rsi, isrHandler187
	mov rdi, 187
	call registerHandler
	mov rsi, isrHandler188
	mov rdi, 188
	call registerHandler
	mov rsi, isrHandler189
	mov rdi, 189
	call registerHandler
	mov rsi, isrHandler190
	mov rdi, 190
	call registerHandler
	mov rsi, isrHandler191
	mov rdi, 191
	call registerHandler
	mov rsi, isrHandler192
	mov rdi, 192
	call registerHandler
	mov rsi, isrHandler193
	mov rdi, 193
	call registerHandler
	mov rsi, isrHandler194
	mov rdi, 194
	call registerHandler
	mov rsi, isrHandler195
	mov rdi, 195
	call registerHandler
	mov rsi, isrHandler196
	mov rdi, 196
	call registerHandler
	mov rsi, isrHandler197
	mov rdi, 197
	call registerHandler
	mov rsi, isrHandler198
	mov rdi, 198
	call registerHandler
	mov rsi, isrHandler199
	mov rdi, 199
	call registerHandler
	mov rsi, isrHandler200
	mov rdi, 200
	call registerHandler
	mov rsi, isrHandler201
	mov rdi, 201
	call registerHandler
	mov rsi, isrHandler202
	mov rdi, 202
	call registerHandler
	mov rsi, isrHandler203
	mov rdi, 203
	call registerHandler
	mov rsi, isrHandler204
	mov rdi, 204
	call registerHandler
	mov rsi, isrHandler205
	mov rdi, 205
	call registerHandler
	mov rsi, isrHandler206
	mov rdi, 206
	call registerHandler
	mov rsi, isrHandler207
	mov rdi, 207
	call registerHandler
	mov rsi, isrHandler208
	mov rdi, 208
	call registerHandler
	mov rsi, isrHandler209
	mov rdi, 209
	call registerHandler
	mov rsi, isrHandler210
	mov rdi, 210
	call registerHandler
	mov rsi, isrHandler211
	mov rdi, 211
	call registerHandler
	mov rsi, isrHandler212
	mov rdi, 212
	call registerHandler
	mov rsi, isrHandler213
	mov rdi, 213
	call registerHandler
	mov rsi, isrHandler214
	mov rdi, 214
	call registerHandler
	mov rsi, isrHandler215
	mov rdi, 215
	call registerHandler
	mov rsi, isrHandler216
	mov rdi, 216
	call registerHandler
	mov rsi, isrHandler217
	mov rdi, 217
	call registerHandler
	mov rsi, isrHandler218
	mov rdi, 218
	call registerHandler
	mov rsi, isrHandler219
	mov rdi, 219
	call registerHandler
	mov rsi, isrHandler220
	mov rdi, 220
	call registerHandler
	mov rsi, isrHandler221
	mov rdi, 221
	call registerHandler
	mov rsi, isrHandler222
	mov rdi, 222
	call registerHandler
	mov rsi, isrHandler223
	mov rdi, 223
	call registerHandler
	mov rsi, isrHandler224
	mov rdi, 224
	call registerHandler
	mov rsi, isrHandler225
	mov rdi, 225
	call registerHandler
	mov rsi, isrHandler226
	mov rdi, 226
	call registerHandler
	mov rsi, isrHandler227
	mov rdi, 227
	call registerHandler
	mov rsi, isrHandler228
	mov rdi, 228
	call registerHandler
	mov rsi, isrHandler229
	mov rdi, 229
	call registerHandler
	mov rsi, isrHandler230
	mov rdi, 230
	call registerHandler
	mov rsi, isrHandler231
	mov rdi, 231
	call registerHandler
	mov rsi, isrHandler232
	mov rdi, 232
	call registerHandler
	mov rsi, isrHandler233
	mov rdi, 233
	call registerHandler
	mov rsi, isrHandler234
	mov rdi, 234
	call registerHandler
	mov rsi, isrHandler235
	mov rdi, 235
	call registerHandler
	mov rsi, isrHandler236
	mov rdi, 236
	call registerHandler
	mov rsi, isrHandler237
	mov rdi, 237
	call registerHandler
	mov rsi, isrHandler238
	mov rdi, 238
	call registerHandler
	mov rsi, isrHandler239
	mov rdi, 239
	call registerHandler
	mov rsi, isrHandler240
	mov rdi, 240
	call registerHandler
	mov rsi, isrHandler241
	mov rdi, 241
	call registerHandler
	mov rsi, isrHandler242
	mov rdi, 242
	call registerHandler
	mov rsi, isrHandler243
	mov rdi, 243
	call registerHandler
	mov rsi, isrHandler244
	mov rdi, 244
	call registerHandler
	mov rsi, isrHandler245
	mov rdi, 245
	call registerHandler
	mov rsi, isrHandler246
	mov rdi, 246
	call registerHandler
	mov rsi, isrHandler247
	mov rdi, 247
	call registerHandler
	mov rsi, isrHandler248
	mov rdi, 248
	call registerHandler
	mov rsi, isrHandler249
	mov rdi, 249
	call registerHandler
	mov rsi, isrHandler250
	mov rdi, 250
	call registerHandler
	mov rsi, isrHandler251
	mov rdi, 251
	call registerHandler
	mov rsi, isrHandler252
	mov rdi, 252
	call registerHandler
	mov rsi, isrHandler253
	mov rdi, 253
	call registerHandler
	mov rsi, isrHandler254
	mov rdi, 254
	call registerHandler
    mov rsi, isrHandler255
	mov rdi, 255
	call registerHandler
    ret