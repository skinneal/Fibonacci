;TITLE Assignment 2    (assignment_2.asm)

; Author: Allison Skinner
; Last Modified: 7/11/2020
; OSU email address: skinneal@oregonstate.edu
; Course number/section: CS 271-400
; Assignment Number: 2               Due Date: 7/12/2020
; Description: Calculates Fibonacci numbers.
; 1. Gets user's name and greets user.
; 2. Prompt user to enter the number of Fibonacci terms
; 3. Get and validate user input
; 4. Calculate and display all Fibonacci numbers
; 5. Display goodbye message and end

INCLUDE Irvine32.inc

;Constants
		LOWER= 1
		UPPER= 46


.data
programmer		BYTE	"Name: Allison Skinner", 0
programTitle	BYTE	"Program Title: Assignment #2", 0
namePrompt		BYTE	"Please enter your name: ", 0
usersName		BYTE	50 DUP(0)				;input buffer
usersNameByte	DWORD	?						;holds counter
greetUser		BYTE	"Hello, ", 0
instructions	BYTE	"This program will display the Fibonacci sequence for the number of terms you choose.", 0
numberPrompt	BYTE	"Please enter a number between 1-46: ", 0
numberOfFibs	DWORD	?
goodbye			BYTE	"Thank you! ", 0
goodbye2		BYTE	". Goodbye!", 0
tryAgain		BYTE	"Please make sure the number is between 1-46. Try again.", 0
previous		DWORD	?
space			BYTE	"	", 0
column			DWORD	?
current			DWORD	?
new				DWORD	?


.code
main PROC

;Introduction
	;Programmer Introduction
		mov	edx, OFFSET programmer
		call WriteString
		call Crlf

	;Display Program Title
		mov	edx, OFFSET programTitle
		call WriteString
		call Crlf
	
	;Get user's name and store it
		mov edx, OFFSET namePrompt
		call WriteString
		mov edx, OFFSET usersName
		mov ecx, SIZEOF usersName
		call ReadString

	;Greet user
		mov edx, OFFSET greetUser
		call WriteString
		mov edx, OFFSET usersName
		call WriteString
		call CrlF

;User Instructions
	;Display instructions
		mov edx, OFFSET instructions
		call WriteString
		call CrlF

;Get User Data
	;Get user's integer input and verify it
		numberOfFibsINPUT:
			mov edx, OFFSET numberPrompt
			call WriteString
			call ReadInt
			mov numberOfFibs, eax
			cmp eax, LOWER
			jb invalidInput						;if input LOWER than LOWER LIMIT, jump to error message
			cmp eax, UPPER
			ja invalidInput						;if input GREATER than HIGHER LIMIT, jump to error message
			jmp continue

	;Error message
		invalidInput:
			mov edx, OFFSET tryAgain
			call WriteString
			jmp numberOfFibsINPUT

		continue:
			call CrlF

;Display Fibonacci
	;Initialize current and previous, and print 0 and 1
		mov current, 1
		mov previous, 0
		mov eax, previous
		call WriteDec

		mov edx, OFFSET space
		call WriteString

		mov eax, current
		call WriteDec

		mov edx, OFFSET space
		call WriteString

		inc column
		inc column

	;Start of Fib sequence
		cmp numberOfFibs, 0
		jbe farewell
		dec numberOfFibs
		mov ecx, numberOfFibs

	Label_1:
		mov eax, previous
		mov ebx, current
		add eax, ebx
		call WriteDec

		mov previous, ebx
		mov current, eax

		mov edx, OFFSET space
		call WriteString

		inc column
		cmp column, 5
		jae newRow
		cmp ecx, 0
		jbe farewell
		loop Label_1
		jmp farewell

		newRow:
			call CrlF
			mov column, 0
			dec ecx
			cmp ecx, 0
			ja Label_1

;Goodbye
	;Goodbye message
		farewell:
			call CrlF
				mov edx, OFFSET goodbye
				call WriteString
				mov edx, OFFSET usersName
				call WriteString
				mov edx, OFFSET goodbye2
				call WriteString
				call CrlF

	exit	; exit to operating system

main ENDP
END main