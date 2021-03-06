.MODEL SMALL


.STACK 100H


.DATA
	CR EQU 0DH
	LF EQU 0AH
	MSG1 DB 'ENTER MATRIX A : $'
	MSG2 DB 'ENTER MATRIX B : $'
	MSG3 DB 'PRINTING RESULTANT MATRIX : $'
	A DB DUP(0)
	  DB DUP(0)

	
.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
	
	;INPUT A
	LEA DX, MSG1
    MOV AH, 9
    INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	MOV BX,0
	MOV CX,2
OUTERLOOP:
    XOR SI,SI
    PUSH CX
    MOV CX,2
INNERLOOP:
	MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV A[BX][SI], AL
	
	;PRINT A SPACE
	MOV AH, 2
	MOV DL , 32
	INT 21H
	ADD SI,1
	LOOP INNERLOOP
    
    ;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
    POP CX
    ADD BX,2
    LOOP OUTERLOOP
	
	
	;INPUT B
	LEA DX, MSG2
    MOV AH, 9
    INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	MOV BX,0
	MOV CX,2
OUTERLOOP2:
    XOR SI,SI
    PUSH CX
    MOV CX,2
INNERLOOP2:
	MOV AH, 1
    INT 21H
    SUB AL, 48
    ADD A[BX][SI], AL
	
	;PRINT A SPACE
	MOV AH, 2
	MOV DL , 32
	INT 21H
	ADD SI,1
	LOOP INNERLOOP2
    
    ;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
    POP CX
    ADD BX,2
    LOOP OUTERLOOP2
    
	
	;PRINT RESULT
	LEA DX, MSG3
    MOV AH, 9
    INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
    MOV BX,0
	MOV CX,2
OUTERLOOP4:
    XOR SI,SI
    PUSH CX
    MOV CX,2
INNERLOOP4:
	;PRINT RES[BX][SI]
	XOR AX,AX
    MOV AL,A[BX][SI]
	CALL OUTPUT 

	
	;PRINT A SPACE
	MOV AH, 2
	MOV DL , 32
	INT 21H
	ADD SI,1
	LOOP INNERLOOP4
    
    ;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
    POP CX
    ADD BX,2
    LOOP OUTERLOOP4
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
OUTPUT PROC
	;PRINTS THE NUMBER STORED IN AX
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	CMP AX,0
	JGE HERE
	;NEGATIVE NUMBER
	PUSH AX
	MOV AH, 2
	MOV DL, '-'
	INT 21H
	POP AX
	NEG AX
HERE:
	XOR CX,CX ; COUNTER = 0
	MOV BX , 10 ;DIVISOR = 10
	
	
LOOP_:
	CMP AX,0
	JE END_LOOP
	
	XOR DX,DX
	DIV BX ;REMINDER IS IN DX
	PUSH DX ; SAVING REMINDERS IN STACK
	INC CX
	JMP LOOP_
END_LOOP:
	CMP CX,0
	JNE PRINTER
	MOV AH,2
	MOV DL,'0'
	INT 21H
	JMP ENDER
PRINTER:
	MOV AH,2
	POP DX
	OR DL,30H
	INT 21H
	LOOP PRINTER
	
ENDER:
	POP DX
	POP CX
	POP BX
	POP AX
	RET
OUTPUT ENDP

END MAIN
