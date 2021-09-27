.MODEL SMALL


.STACK 100H


.DATA
	CR EQU 0DH
	LF EQU 0AH
	MSG1 DB 'ENTER VARIABLE X : $'
	MSG2 DB 'ENTER VARIABLE Y : $'
	MSG3 DB 'VALUE OF Z = X - 2Y IS : $'
	MSG4 DB 'VALUE OF Z = 25 - (X + Y ) IS : $'
	MSG5 DB 'VALUE OF Z = 2X - 3Y IS : $'
	MSG6 DB 'VALUE OF Z =  Y - X + 1 IS : $'

	X DB ?
	Y DB ?
	Z DB ?
	
	
.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
        
    ;INPUT X
	LEA DX, MSG1
    MOV AH, 9
    INT 21H
	
	MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV X, AL
	
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	;INPUT Y
	LEA DX, MSG2
    MOV AH, 9
    INT 21H
	
	MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV Y, AL
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	; Z = X - 2Y 
	MOV BH , X
	SUB BH , Y
	SUB BH , Y
	ADD BH,48
	MOV Z,BH
	
	; PRINT Z
	LEA DX, MSG3
    MOV AH, 9
    INT 21H
	
	MOV AH, 2
	MOV DL, Z
	INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	
	; Z = 25 - (X+Y) 
	MOV BH,25
	SUB BH , X
	SUB BH , Y
	ADD BH,48
	MOV Z,BH
	
	; PRINT Z
	LEA DX, MSG4
    MOV AH, 9
    INT 21H
	
	MOV AH, 2
	MOV DL, Z
	INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	; Z = 2X - 3Y
	MOV BH , X
	ADD BH , X
	SUB BH , Y
	SUB BH , Y
	SUB BH,Y
	ADD BH,48
	MOV Z,BH
	
	; PRINT Z
	LEA DX, MSG5
    MOV AH, 9
    INT 21H
	
	MOV AH, 2
	MOV DL, Z
	INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
	; Z = Y- X + 1 
	MOV BH , Y
	SUB BH , X
	ADD BH , 1
	ADD BH,48
	MOV Z,BH
	
	; PRINT Z
	LEA DX, MSG6
    MOV AH, 9
    INT 21H
	
	MOV AH, 2
	MOV DL, Z
	INT 21H
	
	;PRINT NEW LINE
	MOV AH, 2
	MOV DL , LF
	INT 21H
	MOV DL , CR
	INT 21H
	
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN