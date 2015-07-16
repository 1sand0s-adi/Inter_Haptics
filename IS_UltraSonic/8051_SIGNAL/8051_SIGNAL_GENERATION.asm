
 ;* Copyright (C) 2015 ADITYA T 
 ;* ORG: Interactive Spaces
 ;* This library is free software; you can redistribute it and/or
 ;* modify it under the terms of the GNU Library General Public
 ;* License as published by the Free Software Foundation; either
 ;* version 2 of the License, or (at your option) any later version.
 ;*
 ;* This library is distributed in the hope that it will be useful,
 ;* but WITHOUT ANY WARRANTY; without even the implied warranty of
 ;* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 ;* Library General Public License for more details.
ORG 0000H

LJMP SETTINGS

ORG 0003H
	
		 CLR TR1
		 CLR TR0
		 MOV TH1,#0FDH
		 SETB IE.4
		 RETI
		 
ORG 000BH
	
		 CLR A 
		 MOVC A,@A+DPTR
		 INC DPTR
 		 MOV P2,A
		 SETB P3.6
		 CLR P3.6
		 DJNZ R6,PROC3
		 MOV R6,#18h
		 MOV DPTR,#SINE
PROC3:	 	 RETI

ORG 0023H
		
		 MOV A,SBUF
		 CLR RI
		 MOV @60H,A
		 INC 60H
		 RETI
		 
SINE: 	 	 db 127,160,191,217,237,250,255,250,237,217,191,160,127,94,63,37,17,4,0,4,17,37,63,94,127

SETTINGS:	 MOV DPTR,#SINE
		 MOV R1,#38h
STORE:		 CLR A
		 MOVC A,@A+DPTR
		 INC DPTR
		 MOV @R1,A
		 INC R1
		 CJNE R1,#50h,STORE

ORG 0080H
	
MAIN:	 	 MOV P3,#0FFH
	     	 MOV TCON,#1H
		 MOV P2,#0H
		 MOV P1,#0H
		 MOV TMOD,#22H
		 MOV IE,#93H
		 MOV IP,#11H
		 MOV DPTR,#SINE
		 MOV R0,#38h
		 MOV R6,#18h
		 MOV 60H,#03H

LOCK:		 CJNE 60H,#05H,LOCK
		 
TRANS:	 	 CLR IE.4
		 MOV 60H,#03H
		 MOV TL0,R4
		 MOV TL1,R3
		 MOV TH0,R4
		 MOV TH1,R3
		 SETB TR0
		 SETB TR1
PROC1:	 	 JNB TF1,PROC1
		 CLR TF1
		 MOV P1,@R0
		 SETB P3.7
		 CLR P3.7
		 INC R0
		 CJNE R0,#50h,PRC
		 MOV R0,#38h
PRC:	 	 JMP PROC1
END
