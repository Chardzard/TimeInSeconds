;**************************************************************************************;
; Program Name: Time In Seconds														   ;
; Program Description: Take time input from user and output equivalent time in seconds ;
; Program Author: Parke																   ;
; Creation Date: 03/07/2024			  												   ;
; Revisions: N/A																	   ;
; Date Last Modified: 03/07/2024													   ;
;**************************************************************************************;

;*********************************************;
; 8386, flat memory model, stack size and	  ;
; ExitProcess prototype initalizations as	  ;
; well as Irvine32 library INCLUDE statements ;
;*********************************************;
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDELIB C:\masm32\lib\Irvine32.lib
INCLUDE C:\masm32\include\Irvine32.inc

; Declared and initialized variables
.data
	user_hours BYTE "Enter time in hours: ", 0
	user_minutes BYTE "Enter time in minutes: ", 0
	user_seconds BYTE "Enter time in seconds: ", 0
	output BYTE "Total time in seconds: ", 0
	hours DWORD 3600
	minutes DWORD 60
	final_num DWORD 0

;******************************************************************************************;
; Function: Take hours, minutes and seconds from console input and output				   ;
;			total number of seconds														   ;
;																						   ;
; Return: None																			   ;
;																						   ;
; Procedure: Uses 'ReadDec' procedure from Irvine32 library to read hours, minutes		   ;
;			 and seconds from console input and stores in EBX, ECX and EDX registers,	   ;
;			 respectively. Then procedure uses MUL instruction to mulitply the hours by	   ;
;			 3600 in order to get corresponding equivalent in seconds as well as the	   ;
;			 minutes value by 60 to do the same. EDX is stored in ESI for safe keeping,	   ;
;			 as the second MUL will clear EDX in case of an overflow in EAX. We add these  ;
;			 two values into our 'final_num' variable along with seconds value in order to ;
;			 get our grand total seconds value											   ;
; 																					   	   ;
;******************************************************************************************;
.code
main PROC
	MOV EDX, OFFSET user_hours
	CALL WriteString
	CALL ReadDec
	MOV EBX, EAX
	MOV EDX, OFFSET user_minutes
	CALL WriteString
	CALL ReadDec
	MOV ECX, EAX
	MOV EDX, OFFSET user_seconds
	CALL WriteString
	CALL ReadDec
	MOV EDX, EAX
	MOV EAX, hours
	MOV ESI, EDX
	MUL EBX
	MOV final_num, EAX
	MOV EAX, minutes
	MUL ECX
	ADD final_num, EAX
	ADD final_num, ESI
	MOV EAX, final_num
	CALL Crlf
	PUSH EDX
	MOV EDX, OFFSET output
	CALL WriteString
	POP EDX
	CALL WriteDec
	CALL Crlf
	INVOKE ExitProcess,0
main ENDP
END main
