.MODEL SMALL


.STACK 100H


.DATA
	CR EQU 0DH
	LF EQU 0AH
	X DW ?
	OPERATOR DB ?
	Y DW ?
	MSG DB 'Wrong operator$'
.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
	
	CALL INPUT
	MOV X,AX
	
	;INPUT OPERATOR
	MOV AH , 1
	INT 21H
	CMP AL,'q'
	JE EXIT_PROG
	CMP AL,'['
	JNE WRONG
	
	MOV AH , 1
	INT 21H
	CMP AL,'q'
	JE EXIT_PROG
	CMP AL,'+'
	JE THIK
	CMP AL,'-'
	JE THIK
	CMP AL,'*'
	JE THIK
	CMP AL,'/'
	JE THIK
	JMP WRONG
	
	
THIK:
	MOV OPERATOR , AL
	MOV AH , 1
	INT 21H
	CMP AL,'q'
	JE EXIT_PROG
	CMP AL,']'
	JNE WRONG
	
	
	CALL INPUT
	MOV Y,AX  
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	CMP OPERATOR , '+'
	JE PLUS
	CMP OPERATOR , '-'
	JE MINUS
	CMP OPERATOR , '*'
	JE MULTIPLY
	JMP DIVIDE

PLUS:
	MOV AX , X
	ADD AX , Y
	JMP PRINTANS
	
MINUS:
	MOV AX,X
	SUB AX,Y
	JMP PRINTANS
	
MULTIPLY:
	MOV AX, X
    MOV BX, Y
	IMUL BX
	JMP PRINTANS
	
DIVIDE:
	MOV AX, X
	CWD 
    MOV BX, Y
	IDIV BX
	JMP PRINTANS

PRINTANS:
	CALL OUTPUT
	JMP EXIT_PROG
	
WRONG:
    ;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	LEA DX, MSG
    MOV AH, 9
    INT 21H
	
EXIT_PROG:
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP

INPUT PROC
	;INPUT NUMBER IS IN AX
	;SAVE REGISTERS
	PUSH BX
	PUSH CX
	PUSH DX
	
	XOR BX,BX ;TOTAL = 0
	XOR CX,CX ;SIGN = 0
	
	;READ [
	MOV AH,1
	INT 21H
	
	MOV AH,1
	INT 21H
	
	CMP AL , '-' ;CHECK FOR NEGATIVE SIGN
	JNE TAKE ;NOT NEGATIVE
	MOV CX,1
	INT 21H
	
TAKE:
	;CHECK IF DONE
	CMP AL,']'
	JE FINISH
	;IF(AL >= '0' && AL <= '9') TOTAL = TOTAL * 10 + AL
	CMP AL ,'0'
	JNGE INVALID
	CMP AL,'9'
	JNLE INVALID
	AND AX,000FH
	PUSH AX
	MOV AX,10
	MUL BX
	POP BX
	ADD BX,AX
INVALID:
	MOV AH,1
	INT 21H
	JMP TAKE


FINISH:
	MOV AX,BX
	CMP CX,0
	JE LAST
	NEG AX
LAST:
	POP DX
	POP CX
	POP BX
	RET
INPUT ENDP


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
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H

	POP DX
	POP CX
	POP BX
	POP AX
	RET
OUTPUT ENDP

END MAIN













