;-----------------------------MACROS--------------------------

DIVSTEPBYSTEP MACRO VAR 
local loop1
local loop2
local loop3
local loop4
local cont1
local cont2
local cont3
local cont4
;DIVSTEPBYSTEP proc     
MOV BX,  1000H
MOV DX,0
DIV BX 
cmp al,0ah
jae loop1
ADD AL,30H 
jmp cont1
loop1: ADD AL,57H
cont1:
MOV BYTE PTR [VAR+2],AL

MOV BX,100H
MOV AX,DX
MOV DX,0
DIV BX
;AL =OPERAND 
;AH = REMAINDER
MOV BL,AL
MOV AX,DX
cmp bl,0ah
jae loop2
ADD BL,30H
jmp cont2
loop2: add bl,57h
cont2: MOV BYTE PTR [VAR+3],BL

MOV AH,00

MOV BL,10H
DIV BL

cmp al,0ah
jae loop3
ADD AL,30H
jmp cont3
loop3: 
add al,57h
cont3: 
MOV BYTE PTR [VAR+4],AL

cmp ah,0ah
jae loop4
ADD AH,30H
jmp cont4
loop4: 
add ah,57h
cont4:
MOV BYTE PTR [VAR+5],AH  
;ret
;DIVSTEPBYSTEP endp

ENDM DIVSTEPBYSTEP





CONVERT MACRO
LOCAL LOOP1
LOCAL LOOP2
LOCAL LOOP3
LOCAL LOOP4 
LOCAL LOOP5

CMP BYTE PTR [BX],41H
JB LOOP1
CMP BYTE PTR [BX],5AH
JA LOOP1
MOV AL, BYTE PTR [BX]
ADD AL,20H
MOV [SI],AL
JMP LOOP4
;TO PUT THE CHARS



LOOP1:
CMP BYTE PTR [BX],20H
JE LOOP2
MOV AL,BYTE PTR [BX]
MOV BYTE PTR [SI],AL
JMP LOOP4

LOOP2:
CMP CL,0
JNE LOOP3
INC CL
MOV AL,BYTE PTR [BX]
MOV BYTE PTR [SI],AL
JMP LOOP4

LOOP3:
INC BX
DEC CH
JMP LOOP5

LOOP4:
INC SI
INC BX

LOOP5:

ENDM CONVERT  






INPUT MACRO VAR
LOCAL LOOP1
LOCAL LOOP2
LOCAL LOOP3
MOV BL,VAR
CMP BYTE PTR [VAR], 61H
JB LOOP1

SUB BL,57H
ADD AL,BL

JMP LOOP3

LOOP1:
SUB BL,30H
ADD AL,BL

Jmp LOOP3
LOOP3:
ENDM INPUT
;-----------------The end of macros------------------------;
;---------------------------------collection-----------------------
;----------------------------------------------------------------
.MODEL SMALL   
.STACK 64 
.386
.DATA  

WINNERA db 'PLAYER 1 IS THE WINNER','$'
WINNERB db 'PLAYER 2 IS IS THE WINNER','$'

player1_firingposrow dw 150d       ;where he pressed the spacebar  
player2_firingposrow dw 150d

player1_firingposcol dw 80d
player2_firingposcol dw 240d

player1_firingstatus db 0d
player2_firingstatus db 0d   ;1 is ready to go otherwise no

player1_gunposcol   dw 70d   ;kant 80     ;where the gun is located rn ;middle point
player1_gunposrow   dw 125d    ;kant 150
player2_gunposcol  dw 230d 
player2_gunposrow  dw 125d 

                               
player1_gundirection db 0d     ;either up, down, right or left 
player2_gundirection db 0d

;
;player1_score    db  0d
;player2_score    db  0d
; 


player1_redhits dw 0d
player1_bluehits dw 0d
player1_yellowhits dw 0d        ;when collision occur those hits increase
player1_magentahits dw 0d  
player2_redhits dw 0d
player2_bluehits dw 0d
player2_yellowhits dw 0d 
player2_magentahits dw 0d



randnum db 0  ;to save our random number  


randrow db 0  
randcol db 0 
randcol2 db 0
count db 1  


;time for the random numbers (i want them to generate every 2 min and stay for 600 sec then hide 5 times only)
starttime dw 00 
looptime dw 00   
timecounter db 6  ;3shan yzhr elrandom numbers 5 marat felgame kolo   ;5altha 6 badl 5

randtimedec dw 0  ;for 600 sec wait 
appeartime db 0 
erasetime dw 0 ;to wait 300 sec  


;-------------------------------------------------------------------------------------------------------------
NAME1 DB 'PLAYER1:ENTER YOUR NAME','$'
NAME2 DB 'PLAYER2:ENTER YOUR NAME','$'
PLAYER1 DB 30,?,15 DUP('$') 
PLAYER2 DB 30,?,15 DUP('$')   


INTIALPOINTS1 DB 'INTIALPOINTS1:','$' 
INTIALPOINTS2 DB 'INTIALPOINTS2:','$'  
                                      
                                      

PTS1 DB ?
PTS2 DB ? 

POINTS1 DB 20,?,20 DUP('$') 
POINTS2 DB 20 ,?,20 DUP('$') 


DS1_SEG  DB 8 DUP(01H)

DS2_SEG  DB 8 DUP(00H)   


mes1 db 'press enter key to continue','$'  
mes2 db 'to start chatting press F1','$'    ;TO BE IN THE MAIN MENUE
mes3 db 'to start the game press F2','$'
mes4 db 'to end the program press ESC','$'
invite db 'An invitation has been sent press 1 to continue','$'
mes5 db 'enter the level : press 1 for level 1 and 2 for level 2:','$'
mes6 db 'choose forbidden chars','$'
mes7 db 'your score is: ','$'

level db 3,?,3 dup ('$') 


;----------------------------------




FORBIDDEN1_CHAR DB 4,?,4 DUP('$')
FORBIDDEN2_CHAR DB 4,?,4 DUP('$') 

;-----------------------------------

MESAX1 DB 10,13,'PLEASE INTIALIZE AX1',10,13,'$'
MESBX1 DB 10,13,'PLEASE INTIALIZE BX1',10,13,'$'
MESCX1 DB 10,13,'PLEASE INTIALIZE CX1',10,13,'$'
MESDX1 DB 10,13,'PLEASE INTIALIZE DX1',10,13,'$'
MESSI1 DB 10,13,'PLEASE INTIALIZE SI1',10,13,'$'
MESDI1 DB 10,13,'PLEASE INTIALIZE DI1',10,13,'$'
MESBP1 DB 10,13,'PLEASE INTIALIZE BP1',10,13,'$'


MESAX2 DB 10,13,'PLEASE INTIALIZE AX2',10,13,'$'
MESBX2 DB 10,13,'PLEASE INTIALIZE BX2',10,13,'$'
MESCX2 DB 10,13,'PLEASE INTIALIZE CX2',10,13,'$'
MESDX2 DB 10,13,'PLEASE INTIALIZE DX2',10,13,'$'
MESSI2 DB 10,13,'PLEASE INTIALIZE SI2',10,13,'$'
MESDI2 DB 10,13,'PLEASE INTIALIZE DI2',10,13,'$'
MESBP2 DB 10,13,'PLEASE INTIALIZE BP2',10,13,'$' 

AX1_REG DB 10,?,4 DUP(31H),'$' 
BX1_REG DB 10,?,4 DUP(31H),'$' 
CX1_REG DB 10,?,4 DUP(30H),'$' 
DX1_REG DB 10,?,4 DUP(30H),'$' 
SP1_REG DB 10,?,4 DUP(30H),'$' 
BP1_REG DB 10,?,4 DUP(30H),'$' 
SI1_REG DB 10,?,4 DUP(30H),'$' 
DI1_REG DB 10,?,4 DUP(30H),'$' 

AX2_REG DB 10,?,4 DUP(31H),'$' 
BX2_REG DB 10,?,4 DUP(31H),'$' 
CX2_REG DB 10,?,4 DUP(30H),'$' 
DX2_REG DB 10,?,4 DUP(30H),'$' 
SP2_REG DB 10,?,4 DUP(30H),'$' 
BP2_REG DB 10,?,4 DUP(30H),'$' 
SI2_REG DB 10,?,4 DUP(30H),'$' 
DI2_REG DB 10,?,4 DUP(30H),'$' 


INDATA DB 30,?,30 DUP('$') 

WINNER_FLAG DB 0

WINNER DB 0

PLAYER DB 1


POWER_UP DB 0

A_player DB 1


CF1_FLAG DB 0
 

CF2_FLAG DB 0

FLAG_CHANGED1 DB 0
FLAG_CHANGED2 DB 0

AX1 DB 'ax'
BX1 DB 'bx' 
CX1 DB 'cx'
DX1 DB 'dx' 
AL1 DB 'al'
AH1 DB 'ah'
BL1 DB 'bl'
BH1 DB 'bh'
DL1 DB 'dl'
DH1 DB 'dh' 
SI1 DB 'si'
DI1 DB 'di'
BP1 DB 'bp' 
CL1 DB 'cl'
CH1 DB 'ch'
OFFSI DB '[si]'
OFFDI DB '[di]'
OFFBX DB '[bx]'
OUTDATA DB 30 DUP(?)

TEMP DB 0
TEMP2 DB 0
TEMP3 DW 0

;OPERATIONS
ADD_OP DB 'add ' 
SUB_OP DB 'sub ' 
MUL_OP DB 'mul '
SHR_OP DB 'shr '
SHL_OP DB 'shl ' 
INC_OP DB 'inc ' 
DEC_OP DB 'dec '
DIV_OP DB 'div '
NOP_OP DB 'nop '
MOV_OP DB 'mov '
AND_OP DB 'and '
ADC_OP DB 'adc '
XOR_OP DB 'xor '
CLC_OP DB 'clc ' 
SBB_OP DB 'sbb '
SAR_OP DB 'sar '
ROR_OP DB 'ror '
                   
 VAR DB 4 DUP(0)

FLAG_CHANGED11 db 0
FLAG_CHANGED22 db 0   

make db 1
turn db 0
                                     
;phase2
value1 db 0
;-------------------------------------------CODE----------------------------------------------------------------------------------- 
 
.CODE

MAIN                PROC FAR
    
MOV AX,@DATA    
MOV DS,AX 
MOV ES,AX


;mov ax, 0B800h
;mov es,ax        ;for memory
 
mov ah,00 
mov al,13h         ;graphics mode
int 10h

call init
mov si,offset make
CALL Transmit_BL
call uncondrec
cmp bl,1
jne first
mov turn,1h

first:
call first_page ;that displays entering players names and their initial pts
call secound_page ;that displays (f1 chatting, f2 game, esc exit) ;appears in both level one and 2        
;----------------------------------------------Main menu------------------------------------------------------------------------ 

call level_screen ;to choose either level 1 or 2



mov cx,0         ;see he is in which level
mov di,0
mov di ,offset level+2
mov cl, byte ptr [di]
sub cl,30h ;hexa
cmp cl,02h
je level2
      
JMP levels 



level2:

call level2fn
;CALL player_play_where  ;see he will write in which reg 

mov ah,00 
mov al,13h         ;graphics mode      ;msh 3rfa lao sa7 kdah
int 10h
        

levels:
call forbd_char_screen ;to choose the forbidden char





cmp ah,3Bh     ;if equal zero flag=1
jz chatting 

cmp ah,3Ch
jz gaming  

cmp ah,1h      ;kant 1b
jnz D
jmp gameover
D:

mov cx,4
chatting:
loop chatting         


;mov cx,4 
gaming:

call gui2 
call printingreg



;-------------------------------------Shooting gamee (should start after call gui)--------------------------
;----------------------------------------------time loop------------------------------------------------------------------------ 

call drawgun1
call drawgun2 



randtime:
call rand 
dec timecounter

mov ah,2ch
int 21h   ;ch hours, cl minutes, dh secs, dl hundredth of seconds (in hexa)
mov randtimedec,dx   


ourloop: 


mov ah,2ch
int 21h   ;ch hours, cl minutes, dh secs, dl hundredth of seconds (in hexa)
mov starttime,dx
  
  
;-------------always checks if an esc key was pressed if pressed score screen appears------------
mov ah,1h
int 16h      ;zf=0 if a key was pressed means its not zero
jz play

checkingesc:   ;(ah scan code, al ascii)
mov ah,0
int 16h  

cmp ah,1h 
jne nn
jmp gameover
nn:


;-----------------------logic of the game----------------
play:  

 ;call getcommand  ;gets whats in input and displays it on the screen
; 
; 
;mov ah,2          ;Move Cursor 
;mov dh, 17     ;X,Y Position   
;mov dl,1
;int 10h  
;
;mov ah,0AH        ;Read from keyboard
;mov dx,offset INDATA                  
;int 21h         
         



;------------------------------------------------ 
;logic:
;call logicfn

;------------------------shooting gun game---------------

call movegun1   ; our flag is firingstatus 

;3yza hena ashof hoa door meen      ;---------------------------what i edited----------------------
 cmp A_player,1
 je pl1
 jmp pl2  ;if not player1
 
 
pl1: ;---------------------------------------------------what i edited--------------------

cmp  player1_firingstatus,1
jne notspace

call firebullet1 ;draws once 

       

;--------------------------if collision occured hide--------------------
;bx should be our flag where want to see if a collision occured 1 red 2 blue 3 yellow 4 magenta
cmp bx,1
je hidetime
cmp bx,2
je hidetime                         ;collision will not occur if a spacebar was not pressed
cmp bx,3
je hidetime
cmp bx,4
je hidetime

      ;jmp notspace 
      
      mov cx,50000
      delay1:
      dec cx 
      jnz delay1
      
      mov cx,50000
      delay2:
      dec cx
      jnz delay2
      
      
      mov cx,50000
      delay3:
      dec cx
      jnz delay3
       
      call movebullet1
      sub player1_firingposrow,8h 
   
      cmp player1_firingposrow,0 
      ;call gui2
      
      ;jz p
;      ;jmp firebullet1 
;      call firebullet1
;      p: 
    

;call movebullet1 

 pl2: ;---------------------------------------------------what i edited--------------------
cmp  player2_firingstatus,1
jne notspace

call firebullet2 ;draws once 

       

;--------------------------if collision occured hide--------------------
;bx should be our flag where want to see if a collision occured 1 red 2 blue 3 yellow 4 magenta
cmp bx,1
je hidetime
cmp bx,2
je hidetime                         ;collision will not occur if a spacebar was not pressed
cmp bx,3
je hidetime
cmp bx,4
je hidetime

      ;jmp notspace 
      
      mov cx,50000
      delayyy1:
      dec cx 
      jnz delayyy1
      
      mov cx,50000
      delayyy2:
      dec cx
      jnz delayyy2
      
      
      mov cx,50000
      delayyy3:
      dec cx
      jnz delayyy3
       
      call movebullet2
      sub player2_firingposrow,8h 
   
      cmp player2_firingposrow,0 


;------------------------------------------------------------------------------

;------------------------------------------------------------------------------

notspace:

mov bp, starttime
mov si, randtimedec

sub bp, si

cmp bp, 4000
jae hidetime


Checktime:   ;delays the drawing if numbers fir the motion to appear
mov ah,2ch ;reading time
int 21h
cmp dx,starttime
je Checktime
mov starttime, dx ;updating time  
jmp ourloop 

hidetime:
call hiderand
;call gui2
;cmp timecounter , 0 

mov ah,2ch
int 21h   ;ch hours, cl minutes, dh secs, dl hundredth of seconds (in hexa)
mov appeartime, cl 


now:
mov ah,2ch
int 21h   ;ch hours, cl minutes, dh secs, dl hundredth of seconds (in hexa)
 

;HERE THE GAME SHOULD PROCEED 
; 
mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  

mov ah,0AH        ;Read from keyboard
mov dx,offset INDATA                  
int 21h  


call logicfn 
call printingreg
call WINNERfn
cmp WINNER_FLAG,1
je gameover
mov ch, indata
mov si, offset indata
mov di, offset outdata
add si,2
cleardata1:
mov al,24h
mov byte ptr[si],24h
mov byte ptr[di],0h
dec ch
inc si
inc di
cmp ch,0
jne cleardata1 


;TO CLEAR COMMAND
mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  
 
MOV AH,09
MOV BH,00
MOV AL,'8'
MOV CX,0BH
MOV BL,00H
INT 10H

sub cl, appeartime  
cmp cl,3  ; appear every 3 mins
jb now   

cmp timecounter , 0
je nomorerand

jmp randtime 


nomorerand:
call Hidegun1
call Hidegun2
;call gui2  
;HERE THE GAME SHOULD PROCEED
;----------------------------------------------------------------WHAT I EDITED BEG----------------------
againnn:
mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  

mov ah,0AH        ;Read from keyboard
mov dx,offset INDATA                  
int 21h  
call logicfn 
call printingreg
call WINNERfn
cmp WINNER_FLAG,1
je gameover
mov ch, indata
mov si, offset indata
mov di, offset outdata
add si,2
cleardata2:
;mov al,24h
;mov indata+1,0
mov byte ptr[si],24h
mov byte ptr[di],0h
dec ch
inc si
inc di
cmp ch,0
jne cleardata2  

;TO CLEAR COMMAND
mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  
 
MOV AH,09
MOV BH,00
MOV AL,'8'
MOV CX,0BH
MOV BL,00H
INT 10H

;-------------always checks if an esc key was pressed if pressed score screen appears------------
mov ah,1h
int 16h      ;zf=0 if a key was pressed means its not zero
jz againnn

;checkingesc:   ;(ah scan code, al ascii)
mov ah,0
int 16h  

cmp ah,1h 
jne n
jmp gameover
n: 
;--------------------------------------------------------WHAT I EDITED END--------------------------------------- 


gameover:
;call score_screen  ;that displays the scores when the game is done
mov ah,00
mov al,03h
int 10

CMP  WINNER,1
JE ANNOUNCE1
CMP  WINNER,2
JE ANNOUNCE2
ANNOUNCE1:
mov ah,09
mov dx, offset WINNERA 
int 21h

ANNOUNCE2:
mov ah,09
mov dx, offset WINNERB 
int 21h
;-----------------------(end of timeloop)--------------terminating the program-------------------------------------------------------------     
mov ah,4ch
int 21h
hlt


;ret
MAIN ENDP 
ret 

;----------------------------------------FUNCTIONSSSSSSSS----------------------------------------------

init proc near                              
       
       mov dx,3fbh 			; Line Control Register
        mov al,10000000b		; Set Divisor Latch Access Bit
        out dx,al				; Out it

        ;Set LSB byte of the Baud Rate Divisor Latch register.
        mov dx,3f8h			
        mov al,0ch			
        out dx,al

        ; Set MSB byte of the Baud Rate Divisor Latch register.
        mov dx,3f9h
        mov al,00h
        out dx,al

        ; Set port configuration
        mov dx,3fbh
        mov al,00011011b
                                ; 0: Access to Receiver buffer, Transmitter buffer
                                ; 0: Set Break disabled
                                ; 011: Even Parity
                                ; 0: One Stop Bit
                                ; 11: 8bits
        out dx,al

    ret
init endp

Transmit_BL proc near
    mov dx , 3FDH		        ; Line Status Register
        AGAIN:
  	        In al, dx 			    ; Read Line Status
  		    test al, 00100000b
        JZ AGAIN                    ; Not empty

        ;If empty put the VALUE in Transmit data register
  		mov dx, 3F8H		        ; Transmit data register
  		mov al, [si]
  		out dx, al
     ret
Transmit_BL endp

;-------------------------moving the gun function player1 "getting key pressed"------------------

movegun1 proc
ourloop1:
mov ah,1h
int 16h  ;checks if a key is pressed                                   ;lsa msh 3rfa ezay y3rf player 1 eldas wala player2

jnz bla
jmp  exit  
bla:  


;this sees which key player1 pressed     (ah scan code, al ascii)
keypressed1:
              
mov ah,0
int 16h  

cmp ah,4dh ;right arrow
jne lef
cmp A_player,1
je Rightarrow1
jmp Rightarrow2  
                                                   ;Iedited in key pressed2 "copy paste"---------------
lef:
cmp ah,4bh    ;left arrow  
jne uppp
cmp A_player,1
je Leftarrow1  
jmp Leftarrow2     

uppp:
cmp ah,48h  ;up arrow  
jne Downnn
cmp A_player,1
je Uparrow1
jmp Uparrow2

Downnn:
cmp ah,50h  ;down arrow  
jne Spaceee
cmp A_player,1
je Downarrow1
jmp Downarrow2

Spaceee:
cmp ah,39h   ;spacebar
jne exit
cmp A_player,1
je spacebar1
jmp spacebar2   


jmp exit      ;if none of those keys were pressed continue to check    


;to change the direction of the gun or shoot fire  

;player1:
;playerr1:
spacebar1:     ;shooting
mov player1_firingstatus,1
mov player1_gundirection,0
jmp checkkey1

Rightarrow1: 
mov player1_firingstatus,0
mov player1_gundirection,6d ;setting direction of gun right
jmp checkkey1

Leftarrow1: 
mov player1_firingstatus,0
mov player1_gundirection,4d ;setting direction of gun left
jmp checkkey1

Uparrow1: 
mov player1_firingstatus,0 
mov player1_gundirection,8d ;setting direction of gun up
jmp checkkey1 


Downarrow1: 
mov player1_firingstatus,0
mov player1_gundirection,2d ;setting direction of gun down
jmp checkkey1 

;checking the key pressed and moving the gun or bullet
;if the keypressed was to the right the direction will be 6d 
checkkey1:
cmp player1_gundirection,6d
je gunright1 

;if the keypressed was to the left the direction will be 4d
cmp player1_gundirection,4d
je gunleft1 

;if the keypressed was up the direction will be 8d
cmp player1_gundirection,8d
je gunup1          

;if the keypressed was down the direction will be 2d 
cmp player1_gundirection,2d 
je gundown1 

;if the keypressed was space bar (39h) and firing status 1
cmp player1_firingstatus,1d 
je exit 
 
 
;player2:

spacebar2:     ;shooting
mov player2_firingstatus,1
mov player2_gundirection,0
jmp checkkey2

Rightarrow2: 
mov player2_firingstatus,0
mov player2_gundirection,6d ;setting direction of gun right
jmp checkkey2

Leftarrow2: 
mov player2_firingstatus,0
mov player2_gundirection,4d ;setting direction of gun left
jmp checkkey2

Uparrow2: 
mov player2_firingstatus,0 
mov player2_gundirection,8d ;setting direction of gun up
jmp checkkey2 


Downarrow2: 
mov player2_firingstatus,0
mov player2_gundirection,2d ;setting direction of gun down
jmp checkkey2


;checking the key pressed and moving the gun or bullet
;if the keypressed was to the right the direction will be 6d 
checkkey2:
cmp player2_gundirection,6d
je gunright2 

;if the keypressed was to the left the direction will be 4d
cmp player2_gundirection,4d
je gunleft2 

;if the keypressed was up the direction will be 8d
cmp player2_gundirection,8d
je gunup2          

;if the keypressed was down the direction will be 2d 
cmp player2_gundirection,2d 
je gundown2 

;if the keypressed was space bar (39h) and firing status 1
cmp player2_firingstatus,1d 
je exit 
 


;jne ourloop1   ;i guess it will jump above to see the key pressed again "AT THE END SHOFHEAAAAA TANYYYY"
;jne exit
je blaa
jmp exit 
blaa: 
 
;--------------------------3AYZA A CHECK ENO MAY3DESH EL LIMITTTTTTTTTTT
gunright1:
cmp player1_gunposcol, 120 ;for limit  
jae exit 
call Hidegun1
add player1_gunposcol,6h 
mov bp,player1_gunposcol 
mov player1_firingposcol,bp
;jmp drawgun1
call drawgun1
jmp exit        

gunleft1:
cmp player1_gunposcol,3 ;for limit  
jbe exit 
call Hidegun1
sub player1_gunposcol,6h 
mov bp,player1_gunposcol 
mov player1_firingposcol,bp 
;jmp drawgun1
call drawgun1  
jmp exit


gunup1: 
cmp player1_gunposrow,6 ;for limit  
jbe exit
call Hidegun1
sub player1_gunposrow,6h
mov bp,player1_gunposrow 
mov player1_firingposrow,bp
;jmp drawgun1 
call drawgun1
jmp exit 

gundown1: 
;intially row is 150d

cmp player1_gunposrow,150d    ;for limit  
jae exit 
call Hidegun1
add player1_gunposrow,6h
mov bp,player1_gunposrow 
mov player1_firingposrow,bp
;jmp drawgun1
call drawgun1 
jmp exit 


 
;player2

gunright2:
cmp player2_gunposcol, 247 ;for limit       ;3yza a check limit   ;mokmkn 230
jae exit 
call Hidegun2
add player2_gunposcol,6h 
mov bp,player2_gunposcol 
mov player2_firingposcol,bp

call drawgun2
jmp exit        

gunleft2:
cmp player2_gunposcol,150 ;for limit           ;3yza acheck limit
jbe exit 
call Hidegun2
sub player2_gunposcol,6h 
mov bp,player2_gunposcol 
mov player2_firingposcol,bp 

call drawgun2  
jmp exit                                                                 ;Copy paste movegun 1 all


gunup2: 
cmp player2_gunposrow,6 ;for limit           
jbe exit
call Hidegun2
sub player2_gunposrow,6h
mov bp,player2_gunposrow 
mov player2_firingposrow,bp

call drawgun2
jmp exit 

gundown2: 
;intially row is 150d
                                               
cmp player2_gunposrow,150d    ;for limit  
jae exit 
call Hidegun2
add player2_gunposrow,6h
mov bp,player2_gunposrow 
mov player2_firingposrow,bp

call drawgun2 
jmp exit 



 
 exit:
 ret
 movegun1 endp 
 
 
 
; ;------------------------drawing and moving the bullet for player 1&2---------------------------------
;
;;vertical line up
firebullet1 proc
    
      cmp player1_gunposrow,0 
      jg y1
      jmp enddd
      y1:

      mov al,0fh  ;pixel color
      mov bh,00
      mov ah,0ch 
      
      
    
      mov cx,player1_firingposcol 
      mov dx, player1_firingposrow
   
     
      
      mov bx, player1_firingposrow
      
      sub bx,4h                           ;4 pixeles up (starts from down)
      mov bp,bx
      cmp bx,0 
      
      ;jle ourloop1 
      jg y2
      jmp enddd
      y2: 
      
      fb: int 10h
            dec dx 
            cmp dx,bp
            jnz fb
            
            
       ;if the bullet after been drawn is collided with randrow and randcol
       call CheckCollision1 
       
       ;if bx is 1 then red hits then we want to hide red, 2 blue,3 yellow 4 magenta. if none move bullet
       cmp bx,1 
       
       jne m1  
       jmp enddd ;to stop drawing the bullet   (bx) is still our flag
       m1:
       
       cmp bx,2
       jne m2
       jmp enddd
       m2: 
       
       cmp bx,3 
       jne m3
       jmp enddd 
       m3:
       
       cmp bx,4 
       jne m4
       jmp enddd
       m4:
       
        mov bx,0
        
 enddd:
                  
    
ret
firebullet1 endp 

movebullet1 proc
    
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch 
      
      mov cx,player1_firingposcol
      mov dx, player1_firingposrow
  
      
      mov bx, player1_firingposrow
    
      sub bx,4h
      mov bp,bx
  
      cmp bx,0 
      ;jle ourloop1   
      
      
      jg y3
      jmp endd
      y3:
      hb: int 10h
            dec dx 
            cmp dx,bp
            jnz hb 
      
     ; sub player1_firingposrow,8h 
;   
;      cmp player1_firingposrow,0 
;      
;      jz p
;      jmp firebullet1
;      p: 
;        
 endd:
ret
movebullet1 endp  

;;vertical line up
firebullet2 proc
    
      cmp player2_gunposrow,0 
      jg y11
      jmp enddd2
      y11:

      mov al,0fh  ;pixel color
      mov bh,00
      mov ah,0ch                                                                  ;Add firebullet2
      
      
    
      mov cx,player2_firingposcol 
      mov dx, player2_firingposrow
   
     
      
      mov bx, player2_firingposrow
      
      sub bx,4h                           ;4 pixeles up (starts from down)
      mov bp,bx
      cmp bx,0 
      
      ;jle ourloop1 
      jg y22
      jmp enddd
      y22: 
      
      fbb: int 10h
            dec dx 
            cmp dx,bp
            jnz fbb
            
            
       ;if the bullet after been drawn is collided with randrow and randcol
       call CheckCollision2 
       
       ;if bx is 1 then red hits then we want to hide red, 2 blue,3 yellow 4 magenta. if none move bullet
       cmp bx,1 
       
       jne m11  
       jmp enddd2 ;to stop drawing the bullet   (bx) is still our flag
       m11:
       
       cmp bx,2
       jne m22
       jmp enddd2
       m22: 
       
       cmp bx,3 
       jne m33
       jmp enddd2 
       m33:
       
       cmp bx,4 
       jne m44
       jmp enddd2
       m44:
       
        mov bx,0
        
 enddd2:
                  
    
ret
firebullet2 endp 

movebullet2 proc
    
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch 
      
      mov cx,player2_firingposcol
      mov dx, player2_firingposrow
  
      
      mov bx, player2_firingposrow
    
      sub bx,4h                                                                         ;Add movebullet2
      mov bp,bx
  
      cmp bx,0 
      ;jle ourloop1   
      
      
      jg y33
      jmp endd2
      y33:
      hbb: int 10h
            dec dx 
            cmp dx,bp
            jnz hbb 
      
     ; sub player1_firingposrow,8h 
;   
;      cmp player1_firingposrow,0 
;      
;      jz p
;      jmp firebullet1
;      p: 
;        
 endd2:
ret
movebullet2 endp  

        
;--------------------------drawing and moving the gun player1&2---------------------------------
;arrow that represents player's 1 gun  ;having gun position as the middle point  ...
 drawgun1 proc  
      mov al,03h  ;pixel color
      mov bh,00
      mov ah,0ch
      mov cx,player1_gunposcol
      mov dx,player1_gunposrow
      mov bx, player1_gunposcol            ;right
      add bx,6
      mov bp,bx
      back: int 10h
            inc cx 
            cmp cx,bp
            jnz back        
      mov bx, player1_gunposcol 
      sub bx,6
      mov bp,bx            
      mov al,03h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,bp                                ;left
      mov dx,player1_gunposrow 
      back1: int 10h
            inc cx 
            cmp cx,player1_gunposcol
            jnz back1     


      mov bx, player1_gunposrow 
      sub bx,8
      mov bp,bx           
      mov al,03h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,player1_gunposcol             ;up
      mov dx,bp 
      back2: int 10h
            inc dx 
            cmp dx,player1_gunposrow
            jnz back2  
            
     mov si, player1_gunposrow
     mov player1_firingposrow, si
     mov si, player1_gunposcol
     mov player1_firingposcol, si
  ret
  drawgun1 endp                                                             
   

;arrow that represents player 2 gun  ;having gun position as the middle point 
 drawgun2 proc   
      mov al,03h  ;pixel color
      mov bh,00
      mov ah,0ch
      mov cx,player2_gunposcol
      mov dx,player2_gunposrow
      mov bx, player2_gunposcol
      add bx,6
      mov bp,bx
      backk: int 10h
            inc cx 
            cmp cx,bp
            jnz backk        
      mov bx, player2_gunposcol 
      sub bx,6
      mov bp,bx            
      mov al,03h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,bp
      mov dx,player2_gunposrow 
      back11: int 10h
            inc cx 
            cmp cx,player2_gunposcol
            jnz back11     


      mov bx, player2_gunposrow 
      sub bx,8
      mov bp,bx           
      mov al,03h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,player2_gunposcol
      mov dx,bp 
      back22: int 10h
            inc dx 
            cmp dx,player2_gunposrow
            jnz back22 
            
            
     mov si, player2_gunposrow
     mov player2_firingposrow, si
     mov si, player2_gunposcol
     mov player2_firingposcol, si
     
 ret
 drawgun2 endp   
 
 
 ;;-----------------------functions that generates random numbers,col,row---------------------- 
genrand proc    ;T2REBAN DE FAR??????? 
   
mov ah,00h   ;int to get system time 
int 1ah     ; the time will be stored in CX:DX "clock ticks since midnight"


mov ax,dx   ;moving number of clock ticks in ax 
mov dx, 0   ;clearing dx 
mov bx,10   ;our divisor to generate number between 0-9 as reminder
div bx      ;divide ax by bx    

;call genrandrow
;;add dl,randnum
;mov randrow,dl 
;
;call genrandcol
;mov randcol,dl  

;limiting the range (1-4) only 
cmp dl,4
je range 
cmp dl,3
je range
cmp dl,2
je range
cmp dl,1
je range

norange:
;this will show 3
mov dl,3
;mov randnum,dl
;jmp cont

range:  
mov randnum, dl ;get divisor from dl and store in our random number 
call genrandrow
;add dl,randnum
mov randrow,dl 

call genrandcol
mov randcol,dl
add dl,21d
mov randcol2,dl 
                                                     
 
ret
genrand endp 

;to generate random numbers for col

genrandcol proc 
   
mov ah,00h   ;int to get system time 
int 1ah     ; the time will be stored in CX:DX "clock ticks since midnight"


mov ax,dx   ;moving number of clock ticks in ax 
mov dx, 0   ;clearing dx 
mov bx,10   ;our divisor to generate number between 0-9 as reminder
div bx      ;divide ax by bx

mov randcol, dl
;add dl,50h 
;mov randcol2,dl
 

;limiting the range to half the screen     ;till column 160

cmp randcol,160d
jb colrange
;cmp randcol2,d
;jb colrange
   
call genrandcol
colrange:

ret
genrandcol endp 

;to generate random numbers for row

genrandrow proc 
   
mov ah,00h   ;int to get system time 
int 1ah     ; the time will be stored in CX:DX "clock ticks since midnight"


mov ax,dx   ;moving number of clock ticks in ax 
mov dx, 0   ;clearing dx 
mov bx,10   ;our divisor to generate number between 0-9 as reminder
div bx      ;divide ax by bx

;mov randrow, dl


ret
genrandrow endp 



;-----------------------function to hide the generated randomnumber after 600 secs------------------------
hiderand proc  
;mov cx,bp
;hide:
;loop hide

;code to hide rand

mov ah,2h   
mov dh,randrow ;row 
mov dl,randcol  ;column
mov bh,00
int 10h 

mov al,randnum
add al,'0'
mov bh,00
mov bl,00h  ;color
mov ah,09h 
mov cx,1
int 10h  

mov ah,2h   
mov dh,randrow ;row 
mov dl,randcol2  ;column
mov bh,00
int 10h 

mov al,randnum
add al,'0'
mov bh,00
mov bl,00h  ;color
mov ah,09h 
mov cx,1
int 10h 
 
    
ret
hiderand endp 


;-------------------function for generating random objects on random places--------------------------

;we want to keep showing random numbers till game stops idk how 
;mov cx,2
rand proc  
mov count,2
call genrand  
;screen 1
mov ah,2h   
mov dh,randrow ;row 
mov dl,randcol  ;column    ;we want the row and column to be random
mov bh,00
int 10h  


;MOV AX,09h   ;Tells INT 33 to set mouse cursor
;MOV BX,0Ah   ;horizontal hot spot (-16 to 16)
;MOV CX,00h   ;vertical hot spot (-16 to 16)
;;MOV ES,SEG Curlook
;;MOV DX,OFFSET Curlook
;
;;ES:DX = pointer to screen and cursor masks (16 byte bitmap)
;
;INT 33h ;SET MOUSE CURSOR!!!

displayy:
cmp randnum,1
je red
cmp randnum,2
je blue 
cmp randnum,3
je yellow 
cmp randnum,4
je magenta 

mov si,cx
red: 
mov al,randnum
add al,'0'
mov bh,00
mov bl,04h  ;color
mov ah,09h 
mov cx,1
int 10h  

jmp continue

blue: 
mov al,randnum
add al,'0'
mov bh,00
mov bl,01h  ;color
mov ah,09h 
mov cx,1
int 10h 
jmp continue


yellow: 
mov al,randnum
add al,'0'
mov bh,00
mov bl,0eh  ;color
mov ah,09h 
mov cx,1
int 10h 
jmp continue 

magenta:
mov al,randnum
add al,'0'
mov bh,00
mov bl,05h  ;color
mov ah,09h 
mov cx,1
int 10h 
jmp continue 

screen2:
mov ah,2h   
mov dh,randrow ;row 
mov dl,randcol2  ;column    ;we want the row and column to be random
mov bh,00
int 10h 
;mov cx,1
jmp displayy


 
;;to hide at once if its zero and wait 600 sec if in range
;cmp randnum,0
;jne hideslow
;
;
;hideimm:
;mov bp,1
;call hiderand 
;
continue: 
;mov si,count
;dec si  
dec count
jnz screen2

;hideslow: 
;mov bp,600
;call hiderand 

;mov cx,600  ;lesa msh 3rfa mfrod tb2a kam bzbt
      
;loop rand         ;JUMP OUT OF RANGE WHY??????????????????????????????  
;cmp time, 600
ret
rand endp  

;;----------------function that hides gun for player1:----------------------

 
Hidegun1 proc
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch
      mov cx,player1_gunposcol
      mov dx,player1_gunposrow
      mov bx, player1_gunposcol
      add bx,6
      mov bp,bx
      bk: int 10h
            inc cx 
            cmp cx,bp
            jnz bk        
      mov bx, player1_gunposcol 
      sub bx,6
      mov bp,bx            
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,bp
      mov dx,player1_gunposrow 
      bk1: int 10h
            inc cx 
            cmp cx,player1_gunposcol
            jnz bk1     


      mov bx, player1_gunposrow 
      sub bx,8
      mov bp,bx           
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,player1_gunposcol
      mov dx,bp 
      bk2: int 10h
            inc dx 
            cmp dx,player1_gunposrow
            jnz bk2  
      ;jmp drawgun1
ret
Hidegun1 endp 
                
 ;----------------------------function to hide gun for player2---------------------------
 
 Hidegun2 proc
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch
      mov cx,player2_gunposcol
      mov dx,player2_gunposrow
      mov bx, player2_gunposcol
      add bx,6
      mov bp,bx
      bkk: int 10h
            inc cx 
            cmp cx,bp
            jnz bkk        
      mov bx, player2_gunposcol 
      sub bx,6
      mov bp,bx            
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,bp
      mov dx,player2_gunposrow 
      bkk1: int 10h
            inc cx 
            cmp cx,player2_gunposcol
            jnz bkk1     


      mov bx, player2_gunposrow 
      sub bx,8
      mov bp,bx           
      mov al,00h  ;pixel color
      mov bh,00
      mov ah,0ch 
      mov cx,player2_gunposcol
      mov dx,bp 
      bkk2: int 10h
            inc dx 
            cmp dx,player2_gunposrow
            jnz bkk2  
 ret
 Hidegun2 endp 
 
;--------------------------------checking collisions between random numbers and firingposition at the moment-----------------
CheckCollision1 proc 
   
;we need to check if the firingposcol and row are equal to randcol and randrow
;then we need to check if randnum was 1 2 3 or 4 to see color 

;notice that we need to multiply randrow by 8 then check this number and (+8) numbers 
;same with randcol

 
;mov bx, WORD PTR randrow

mov al,8
mov bl, randrow
mul bl ;AX= randrow*8      ;mul bl  (AX=AL*BL)

;AX has randrow*8
mov bx, player1_firingposrow 

mov cx,8

xx:
cmp ax,bx
je comp
inc ax 
dec cx
jnz xx 

jmp exitt 
;jne exitt

                     
comp: 

mov al,8
mov bl, randcol
mul bl ;AX=randcol*8

;AX has randcol*8
mov bx,player1_firingposcol

mov cx, 8

xy: 
cmp ax,bx 
je color1
inc ax
dec cx
jnz xy 

;mov bx, WORD PTR randcol


;jne exitt
jmp exitt


color1:  
     cmp randnum,1
     je redhit1
     cmp randnum,2
     je bluehit1
     cmp randnum,3
     je yellowhit1
     cmp randnum,4
     je magentahit1 
     
jmp exitt        ;msh 3rfa lsa ye jump feen




;if collision occured a sound will occur as well as updated the score
;then we want to return a flag to hide the randnum   ;our flag is( BX )

;---------------------------------------------------WHAT I EDITED BEG---------------------------
redhit1:

mov ah,2
mov dl,7d
int 21h       ;displaying beep

inc player1_redhits   ;updating score of player 1
add PTS1,1

                                                                
mov ah,2
mov dh,19     ;row
mov dl,1     ;col
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player1_redhits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h
mov bx,1
jmp exitt

bluehit1:

mov ah,2
mov dl,7d
int 21h       ;displaying beep

inc player1_bluehits   ;updating score of player 1
add PTS1,2 

mov ah,2
mov dh,19    ;row
mov dl,6    ;col
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player1_bluehits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h

mov bx,2
jmp exitt


yellowhit1:

mov ah,2
mov dl,7d
int 21h       ;displaying beep
                                               
inc player1_yellowhits   ;updating score of player 1 
add PTS1,3 

mov ah,2
mov dh,19    ;row
mov dl,3    ;col
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player1_yellowhits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h

mov bx,3
jmp exitt

magentahit1:

mov ah,2
mov dl,7d
int 21h       ;displaying beep

inc player1_magentahits   ;updating score of player 1
add PTS1,6 

mov ah,2
mov dh,19     ;row
mov dl,9     ;col
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player1_magentahits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h

mov bx,4
jmp exitt
 
exitt: 
;mov bx,0 

;---------------------------------------------WHAT I EDITED END----------------------------
ret
CheckCollision1 endp 

CheckCollision2 proc 
   
;we need to check if the firingposcol and row are equal to randcol and randrow
;then we need to check if randnum was 1 2 3 or 4 to see color 

;notice that we need to multiply randrow by 8 then check this number and (+8) numbers 
;same with randcol

 
;mov bx, WORD PTR randrow

mov al,8
mov bl, randrow
mul bl ;AX= randrow*8      ;mul bl  (AX=AL*BL)

;AX has randrow*8
mov bx, player2_firingposrow 

mov cx,8

xxx:
cmp ax,bx
je comp2                                                                  ;Add Checkcollision2
inc ax 
dec cx
jnz xxx 

jmp exitt2 
;jne exitt

                     
comp2: 

mov al,8
mov bl, randcol2
mul bl ;AX=randcol*8

;AX has randcol*8
mov bx,player2_firingposcol

mov cx, 8

xy2: 
cmp ax,bx 
je color2
inc ax
dec cx
jnz xy2 

;mov bx, WORD PTR randcol


;jne exitt
jmp exitt2


color2:  
     cmp randnum,1
     je redhit2
     cmp randnum,2
     je bluehit2
     cmp randnum,3
     je yellowhit2
     cmp randnum,4
     je magentahit2 
     
jmp exitt2        ;msh 3rfa lsa ye jump feen



;------------------------------------------------collision function-----------------------
;if collision occured a sound will occur as well as updated the score
;then we want to return a flag to hide the randnum   ;our flag is( BX )

;---------------------------------------------------WHAT I EDITED BEG---------------------------
redhit2:

mov ah,2
mov dl,7d
int 21h       ;displaying beep

inc player2_redhits   ;updating score of player 1
add PTS2,1

                                                                
mov ah,2
mov dh,19     ;row        ;nafs row bs nzwd col msh 3rfa lsa kam
mov dl,20d     ;col                                                   ;+21d 
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player2_redhits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h
mov bx,1
jmp exitt2

bluehit2:

mov ah,2
mov dl,7d
int 21h       ;displaying beep

inc player2_bluehits   ;updating score of player 1
add PTS2,2 

mov ah,2                                                                     ;yellow+3
mov dh,19    ;row              ;nafs row bs nzwd col msh 3rfa lsa kam
mov dl,25d    ;col
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player2_bluehits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h

mov bx,2
jmp exitt2


yellowhit2:

mov ah,2
mov dl,7d
int 21h       ;displaying beep
                                               
inc player2_yellowhits   ;updating score of player 1 
add PTS2,3 

mov ah,2                              ;nafs row bs nzwd col msh 3rfa lsa kam    red+2
mov dh,19    ;row
mov dl,22d    ;col
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player2_yellowhits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h

mov bx,3
jmp exitt2

magentahit2:

mov ah,2
mov dl,7d
int 21h       ;displaying beep

inc player2_magentahits   ;updating score of player 1       
add PTS2,4 

mov ah,2
mov dh,19     ;row
mov dl,28d     ;col             ;nafs row bs nzwd col msh 3rfa lsa kam   ;blue+3
;mov bh 00
int 10h                     ;moving the cursor

mov cl,byte PTR player2_magentahits
mov ah,02
add cl,30h 
mov dl,cl      ;displaying the number
int 21h

mov bx,4
jmp exitt2
 
exitt2: 
;mov bx,0 

;---------------------------------------------WHAT I EDITED END----------------------------
ret
CheckCollision2 endp 
recieving PROC
mov dx , 3FDH		; Line Status Register
        CHK2:
            in al , dx 
            test al , 1
        JZ CHK2              ; Not Ready

        ; If Ready read the VALUE in Receive data register
        mov dx , 03F8H
        in al , dx 
        mov bl , al
 ret
 recieving ENDP      
 uncondrec proc
 mov dx , 3FDH		; Line Status Register
       
            in al , dx 
            test al , 1
            JZ yasmine              ; Not Ready

        ; If Ready read the VALUE in Receive data register
        mov dx , 03F8H
        in al , dx 
        mov bl , al

        yasmine:
   ret
  uncondrec ENDP      
;----------------------first page code-----------------

first_page proc 
;clear screen
mov ax,03h
int 10h    
          
        

mov ah,2          ;Move Cursor
mov dx,0000h      ;X,Y Position
int 10h    
                 
cmp turn,0
jne second
mov ah, 9
mov dx, offset NAME1;Display string 
int 21h      

mov ah,2          ;Move Cursor
mov dx,0100h      ;X,Y Position
int 10h    
         

mov ah,0AH        ;Read name 1from keyboard
mov dx,offset PLAYER1                 
int 21h
;-------------------;


mov ah,2          ;Move Cursor
mov dx,0200h      ;X,Y Position
int 10h 



mov ah, 9
mov dx, offset INTIALPOINTS1;Display string 
int 21h   

            
            
mov ah,2          ;Move Cursor
mov dx,0300h      ;X,Y Position
int 10h    
         

mov ah,0AH        ;Read from keyboard
mov dx,offset POINTS1                
int 21h  

mov si, offset PLAYER1
mov cl,[si+1]
add cl,2
add si,1h
sendingloop:
mov bl,[si]
call Transmit_BL
inc si
dec cl
cmp cl,0
jnz sendingloop

MOV SI,OFFSET PLAYER2+1
RecieveMsg:
       call recieving
        mov [si], bl
        inc si
        cmp bl, 0dh
        jnz RecieveMsg

mov si, offset POINTS1
mov cl,[si+1]
add cl,2
add si,1h
sendingloop2:
mov bl,[si]
call Transmit_BL
inc si
dec cl
cmp cl,0
jnz sendingloop2

mov si,offset points2+1
RecieveMsg2:
       call recieving
        mov [si], bl
        inc si
        cmp bl, 0dh
        jnz RecieveMsg2

  
jmp continue234

;-------------------;
second: 
mov ah, 9
mov dx, offset NAME2;Display string 
int 21h      

mov ah,2          ;Move Cursor
mov dx,0100h      ;X,Y Position
int 10h    
         

mov ah,0AH        ;Read name 1from keyboard
mov dx,offset PLAYER2                 
int 21h

mov ah,2          ;Move Cursor
mov dx,0200h      ;X,Y Position
int 10h 



mov ah, 9
mov dx, offset INTIALPOINTS2;Display string 
int 21h   

            
            
mov ah,2          ;Move Cursor
mov dx,0300h      ;X,Y Position
int 10h    
         

mov ah,0AH        ;Read from keyboard
mov dx,offset POINTS2                
int 21h  


mov si,offset player1+1
RecieveMsg3:
       call recieving
        mov [si], bl
        inc si
        cmp bl, 0dh
        jnz RecieveMsg3

mov si, offset player2
mov cl,[si+1]
add cl,2
add si,1h
sendingloop3:
mov bl,[si]
call Transmit_BL
inc si
dec cl
cmp cl,0
jnz sendingloop3

mov si,offset POINTS1+1
RecieveMsg4:
       call recieving
        mov [si], bl
        inc si
        cmp bl, 0dh
        jnz RecieveMsg4

mov si, offset points2
mov cl,[si+1]
add cl,2h
add si,1h
sendingloop4:
mov bl,[si]
call Transmit_BL
inc si
dec cl
cmp cl,0
jnz sendingloop4

continue234:
mov ah, 9
mov dx, offset mes1;Display string 
int 21h  

mov ah,2          ;Move Cursor
mov dx,0500h      ;X,Y Position
int 10h    


mov ah,0                                                              
int 16h   ;Get key pressed (Wait for a key-AH:scancode,AL:ASCII)    

mov ah,2          ;Move Cursor
mov dx,0A00h      ;X,Y Position
int 10h    

mov ah,9          ;Display
mov bh,0          ;Page 0
mov al,'.'        ;Letter D
mov cx,50h         ;50 times
mov bl,0ffh        ;Green (A) on white(F) background
int 10h

;................................................

;--------------------------SAVE VALUE IN PTS1 ZAY ELNAS--------------------------;  

 
MOV di,offset points2+2
MOV si,offset Points1+2
MOV BX,[SI] ;---------------------------lessa mt3dl
cmp  BX,[di]
JbE LOOP67          
JMP LOOP68
LOOP67:

mov Bl,Points1+2
mov bh,points1+3

mov Points2+2,bl
mov points2+3,bh

jmp clear

LOOP68:
mov Bl,points2+2
mov bh,Points2+3

MOV Points1+2,Bl
mov points1+3,bh


CLEAR:mov ah,00
      mov al,03
      int 10h


MOV SI,OFFSET POINTS1+2
MOV AX,[SI]
SUB AL,30H
ROL AL,4  
SUB AH,30H
ADD AL,AH
MOV AH,0
MOV PTS1,AL 


MOV SI,OFFSET POINTS2+2
MOV AX,[SI]
SUB AL,30H
ROL AL,4  
SUB AH,30H
ADD AL,AH
MOV AH,0
MOV PTS2,AL 

 ret 
first_page endp    


;--------------------------------------secound page code---------------------------
secound_page proc
;SECOND PAGE


mov ah,2          ;Move Cursor
mov dx,081Dh      ;X,Y Position
int 10h   

mov ah, 9
mov dx, offset mes2 ;Display string 
int 21h 

mov ah,2          ;Move Cursor
mov dx,0A1Dh      ;X,Y Position
int 10h   

mov ah, 9
mov dx, offset mes3;Display string 
int 21h 

mov ah,2          ;Move Cursor
mov dx,0D1Dh      ;X,Y Position
int 10h   

mov ah, 9
mov dx, offset mes4;Display string 
int 21h          



mov ah,0
int 16h   ;Get key pressed (Wait for a key-AH:scancode,AL:ASCII)  


;ESC scan code 1B , F1 scancode 6E "wrong bayeb"
;F1 3B , F2  3C 

mov ax,03h
int 10h
  ret
secound_page endp


;------------------------------------level screen third page ----------------------
level_screen proc

mov ah,2          ;Move Cursor
mov dx,0a00h      ;X,Y Position
int 10h    
                 

mov ah, 9
mov dx, offset mes5;Display string 
int 21h 


mov ah,2          ;Move Cursor
mov dx,0c03h      ;X,Y Position
int 10h    
         

mov ah,0AH        ;Read name 1 from keyboard
mov dx,offset level                
int 21h

mov ax,03h
int 10h
ret  
 level_screen endp  


;----------------------page four choose dorbiden chars code-----------------


forbd_char_screen proc
  
       
mov ah,2          ;Move Cursor
mov dx,0000h      ;X,Y Position   ;dh row   dl col
int 10h    
                 

mov ah, 9
mov dx, offset mes6;Display string 
int 21h  

mov ah,2          ;Move Cursor
mov dx,0200h      ;X,Y Position   ;kant 1
int 10h    
         
mov ah,0AH        ;Read from keyboard
mov dx,offset FORBIDDEN1_CHAR               
int 21h

 ;--------------------------------------------- 

mov ah,2          ;Move Cursor
mov dx,0800h      ;X,Y Position
int 10h 

mov ah,9          ;Display
mov bh,0          ;Page 0
mov al,'.'        ;Letter D
mov cx,50h         ;50 times
mov bl,0ffh        ;Green (A) on white(F) background
int 10h

;----------------------------------------------

mov ah,2          ;Move Cursor
mov dx,0900h      ;X,Y Position
int 10h 


mov ah, 9
mov dx, offset mes6;Display string 
int 21h  

mov ah,2          ;Move Cursor
mov dx,0A00h      ;X,Y Position
int 10h 

mov ah,0AH        ;Read from keyboard
mov dx,offset FORBIDDEN2_CHAR               
int 21h

mov ax,03h
int 10h  
    ret
forbd_char_screen endp   


;-----------------------score screen code--------------------------------
score_screen proc

mov ah,2          ;Move Cursor
mov dx,0200h      ;X,Y Position
int 10h    
                 

mov ah, 9
mov dx, offset mes7;Display string 
int 21h 

mov ah, 9
mov dx, offset PTS1;Display string 
int 21h  

mov ah,2          ;Move Cursor
mov dx,0500h      ;X,Y Position
int 10h 

mov ah,9          ;Display
mov bh,0          ;Page 0
mov al,'.'        ;Letter D
mov cx,50h         ;50 times
mov bl,0ffh        ;Green (A) on white(F) background
int 10h

mov ah,2          ;Move Cursor
mov dx,0700h      ;X,Y Position
int 10h    
                 

mov ah, 9
mov dx, offset mes7;Display string 
int 21h 

mov ah, 9
mov dx, offset PTS2;Display string 
int 21h

call delay
  
mov ax,03h
int 10h   
      ret
score_screen endp

;---------------------------------level2 function----------------------------------

level2fn proc           
mov ah,00 ;GET INTO TEXT MODE
mov al,03
int 10h
mov ah, 9
mov dx, offset MESAX1;Display string 
int 21h
MOV CX,4
MOV BX,3
LOO1:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset AX1_REG+2
MOV BYTE PTR [SI+BX],AL 
DEC BX
LOOP LOO1
mov ah, 9
mov dx, offset MESBX1;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP2:
mov ah,1       ;Read FROM keyboard                
int 21H
mov si, offset BX1_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP2
mov ah, 9
mov dx, offset MESCX1;Display string 
int 21h
MOV CX,4
MOV BX,0
LOOP3:
mov ah,1       ;Read from keyboard                
int 21H
mov si, offset CX1_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP3
mov ah, 9
mov dx, offset MESDX1;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP4:
mov ah,1       ;Read from keyboard                
int 21H
mov si, offset DX1_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP4
mov ah, 9
mov dx, offset MESSI1;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOO5:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset SI1_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOO5
mov ah, 9
mov dx, offset MESDI1;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP6:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset DI1_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP6
mov ah, 9
mov dx, offset MESBP1;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP7:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset BP1_REG+2
MOV BYTE PTR [SI+BX],AL  
INC BX
LOOP LOOP7  
mov ah, 9
mov dx, offset MESAX2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP8:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset AX2_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP8 
mov ah, 9
mov dx, offset MESBX2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP9:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset BX2_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP9
mov ah, 9
mov dx, offset MESCX2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP10:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset CX2_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP10
mov ah, 9
mov dx, offset MESDX2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP11:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset DX2_REG+2
MOV BYTE PTR [SI+BX],AL 
INC BX
LOOP LOOP11   
mov ah, 9
mov dx, offset MESSI2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP12:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset SI2_REG+2
MOV BYTE PTR [SI+BX],AL
INC BX
LOOP LOOP12
mov ah, 9
mov dx, offset MESDI2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP13:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset DI2_REG+2
MOV BYTE PTR [SI+BX],AL
INC BX
LOOP LOOP13         
mov ah, 9
mov dx, offset MESBP2;Display string 
int 21h    
MOV CX,4
MOV BX,0
LOOP14:
mov ah,1       ;Read name 1from keyboard                
int 21H
mov si, offset BP2_REG+2
MOV BYTE PTR [SI+BX],AL
INC BX
LOOP LOOP14 

ret

level2fn endp


;----------------------------------GUI FUNCTION------------------------------------------
gui2 proc 

 ;---------------------------------graphics mode-------------------------------------  
 
 mov ah,0 
 mov al,13h
 int 10h
 
;----------------------------red line for commands-----------------------


mov cx,0
mov dx,132
mov al,04h
mov ah,0ch
label_draw_horizantonal_lineCR:int 10h
                         inc cx
                         cmp cx,320
                         jnz label_draw_horizantonal_lineCR
                          


 ; --------------------------------red line for scores and circles-------------
mov cx,0
mov dx,148
mov al,04h
mov ah,0ch
label_draw_horizantonal_lineS:int 10h
                         inc cx
                         cmp cx,320
                         jnz label_draw_horizantonal_lineS
                          


;----------------------------grey line for chatting-------------------------------

mov cx,0
mov dx,164
mov al,08h
mov ah,0ch
label_draw_horizantonal_lineC:int 10h
                         inc cx
                         cmp cx,320
                         jnz label_draw_horizantonal_lineC 
                          
mov cx,0
mov dx,165
mov al,08h
mov ah,0ch
labell_draw_horizontal_lineC:int 10h
                         inc cx
                         cmp cx,320
                         jnz labell_draw_horizontal_lineC  
 
;...................display the names and the scores on the left.................................

mov ah,2    ;move cursor
mov dl,0   ;column
mov dh,15   ;row  
int 10h
     
mov ah,09h
mov dx,offset PLAYER1+2    ;display name 
int 21h 



MOV Cl,1   
mov dl,1
MOV SI,offset PLAYER1+1
loop56:
mov ah,2     ;move cursor to display the score
inc dl
inc cx
mov dh,15   ;row  
int 10h
cmp cl,[si]
jne loop56

mov al,pts1
mov ah,00
mov bl,10h
div bl
add ah,30h
add al,30h
mov POINTS1+2,AL
mov points1+3,AH

mov ah,09h
mov dx,offset points1+2   ;display score
int 21h 

mov ah,2  ;move cursor
mov dl,10 ;column      
mov dh,15 ;row
int 10h


mov ah,09h ;display
mov dx,offset PLAYER2+2
int 21h 



MOV Cl,1 
MOV SI,offset PLAYER2+1
mov dl,11
loop57:
mov ah,2    ;move cursor
inc dl
inc cx
mov dh,15   ;row  
int 10h
cmp cl,[si]
jne loop57


mov al,pts2
mov ah,00
mov bl,10h
div bl
add ah,30h
add al,30h
mov POINTS2+2,AL
mov points2+3,AH

mov ah,09h
mov dx,offset points2+2   ;display score
int 21h 


;......................display the names and the scores on the right....................

mov ah,2     ;move cursor
mov dl,20    ;column
mov dh,15    ;row
int 10h  


mov ah,09h
mov dx,offset PLAYER1+2    ;display the name
int 21h  



MOV Cl,1 
mov dl,21
MOV SI,offset PLAYER1+1
loop58:
mov ah,2    ;move cursor to display the score
inc dl
inc cx
mov dh,15   ;row  
int 10h

cmp cl,[si]
jne loop58





mov ah,9
mov dx,offset Points1+2    ;display score
int 21h 



mov ah,2  ;move cursor 
mov dl,31 ;column
mov dh,15 ;row
int 10h

  
mov ah,09h        ;display the name
mov dx,offset PLAYER2+2
int 21h 


MOV Cl,1      
MOV SI,offset PLAYER2+1
mov dl,32
loop59:
mov ah,2    ;move cursor to display the score
inc dl
inc cx
mov dh,15   ;row  
int 10h
cmp cl,[si]
jne loop59





mov ah,9
mov dx,offset Points2+2    ;display score
int 21h 




;-----------------------------white vertical line for half the screen---------------------
;draw vertical line 
mov cx,151
mov dx,0
mov al,0fh
mov ah,0ch
label_draw_vetical_line: int 10h
                         inc dx
                         cmp dx,199
                         jnz label_draw_vetical_line 
                          
mov cx,152
mov dx,0
mov al,0fh
mov ah,0ch
labell_draw_vetical_line: int 10h
                         inc dx
                         cmp dx,199
                         jnz labell_draw_vetical_line
 

 
;-----------------------rectangle for score of fire bullets on left side-----------------

;1.red 

       mov dx,155
label5:mov cx,5
       mov al,04h
       mov ah,0ch
label6:int 10h
        inc cx
        cmp cx,15 ;+10
        jnz label6   
        inc dx 
        cmp dx,163   ;+8
        jnz label5  

;2.yellow        
       mov dx,155
label7:mov cx,25
       mov al,0Eh
       mov ah,0ch
label8:int 10h
        inc cx
        cmp cx,35 ;+10
        jnz label8   
        inc dx 
        cmp dx,163  ;+8
        jnz label7 

;3.blue        
       mov dx,155
label9:mov cx,45
       mov al,01h
       mov ah,0ch
label10:int 10h
        inc cx
        cmp cx,55 ;+10
        jnz label10   
        inc dx 
 
   
        cmp dx,163   ;+8
        jnz label9
        
  
;4.green  

       mov dx,155
label11:mov cx,65
       mov al,05h
       mov ah,0ch
label12:int 10h
        inc cx
        cmp cx,75 ;+10
        jnz label12   
        inc dx 
        cmp dx,163   ;+8
        jnz label11 
  
                     
   
 ;----------------rectangle for score of fire bullets on right side--------------
;1.red 

        mov dx,155
label13:mov cx,155
        mov al,04h
        mov ah,0ch
label14:int 10h
        inc cx
        cmp cx,165 ;+10
        jnz label14   
        inc dx 
        cmp dx,163   ;+8
        jnz label13  
;2.yellow        
       mov dx,155
label15:mov cx,175
       mov al,0Eh
       mov ah,0ch
label16:int 10h
        inc cx
        cmp cx,185 ;+10
        jnz label16   
        inc dx 
        cmp dx,163   ;+8
        jnz label15 
;3.blue        
       mov dx,155
label17:mov cx,195
       mov al,01h
       mov ah,0ch
label18:int 10h
        inc cx
        cmp cx,205 ;+10
        jnz label18   
        inc dx 
        cmp dx,163  ;+8
        jnz label17 
;4.green  

        mov dx,155
label19:mov cx,215
        mov al,05h
        mov ah,0ch
label20:int 10h
        inc cx
        cmp cx,225 ;+10
        jnz label20   
        inc dx 
        cmp dx,163   ;+8
        jnz label19  

;------------------------------Drawing 16 red rectangles--------------------------------------------------------
;draw column1 horizontal sides.                 
                 mov bx,10d   ;begin height
labell1:         mov cx,20d
                 mov dx,bx
                 mov al,4h
                 mov ah,0ch
draw_horiz_side1:int 10h
                 inc cx
                 cmp cx,60d    ;el horizontal line hy2of lma ymshy 
                 jnz draw_horiz_side1
                 add bx,15d    ;height el rect.
                 cmp dx,115d   ;dh akher side khalas horizontal lw 3ozna nghyer hight el rect nghyer hena
                 jnz labell1  
            

;draw column2 horizontal sides.                 
                 mov bx,10d 
labell2:          mov cx,100d
                 mov dx,bx
                 mov al,4h
                 mov ah,0ch
draw_horiz_side2:int 10h

                 inc cx
                 cmp cx,140d
                 jnz draw_horiz_side2
                 add bx,15d    ;height el rect.
                 cmp dx,115d   ;dh akher side khalas horizontal lw 3ozna nghyer hight el rect nghyer hena
                 jnz labell2  
                 
                 
;draw column3 horizontal sides.                 
                 mov bx,10d 
labell3:          mov cx,180d
                 mov dx,bx
                 mov al,4h
                 mov ah,0ch
draw_horiz_side3:int 10h
                 inc cx
                 cmp cx,220d
                 jnz draw_horiz_side3
                 add bx,15d    ;height el rect.
                 cmp dx,115d   ;dh akher side khalas horizontal lw 3ozna nghyer hight el rect nghyer hena
                 jnz labell3 
               
;draw column4 horizontal sides.                 
                 mov bx,10d 
labell4:         mov cx,260d
                 mov dx,bx
                 mov al,4h
                 mov ah,0ch
draw_horiz_side4:int 10h
                 inc cx
                 cmp cx,300d
                 jnz draw_horiz_side4
                 add bx,15d    ;height el rect.
                 cmp dx,115d   ;dh akher side khalas horizontal lw 3ozna nghyer hight el rect nghyer hena
                 jnz labell4 
               
                  
;draw row1 rect vertical sides.  

                 mov bx,20d       ;beg of the row
labell5:         mov cx,bx
                 mov dx,10        ;beg of the column
                 mov al,4h
                 mov ah,0ch
draw_vert1_sides:int 10h
                 inc dx
                 cmp dx,26d         ;countinue drawing heghit equals 15
                 jnz draw_vert1_sides
                 add bx,40d
                 cmp cx,300d        ;drawing 8 vertival sides horizontlly
                 jnz labell5 
                
;draw row2 rect vertical sides.  

                 mov bx,20d
labell6:         mov cx,bx
                 mov dx,40
                 mov al,4h
                 mov ah,0ch
draw_vert2_sides:int 10h
                 inc dx
                 cmp dx,56d
                 jnz draw_vert2_sides
                 add bx,40d
                 cmp cx,300d 
                 jnz labell6    
         
;draw row3 rect vertical sides.  
      
 
                 mov bx,20d
labell7:         mov cx,bx
                 mov dx,70
                 mov al,4h
                 mov ah,0ch
draw_vert3_sides:int 10h
                 inc dx
                 cmp dx,86d
                 jnz draw_vert3_sides
                 add bx,40d
                 cmp cx,300d 
                 jnz labell7
         
                 
;draw row4 rect vertical sides.  

                 mov bx,20d
labell8:         mov cx,bx
                 mov dx,100
                 mov al,4h
                 mov ah,0ch
draw_vert4_sides:int 10h
                 inc dx
                 cmp dx,116d
                 jnz draw_vert4_sides
                 add bx,40d
                 cmp cx,300d 
                 jnz labell8   
 


;---------------------------------writing registers names and initilizing thier variables-------------------------------
 ;First column
 
 ;---------------------AX-------------------
          
mov  dl, 0   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'A'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground    ;kant 0f3
mov ah,0eh 
;mov cx,1
int 10h 


;---------------------BX--------------------
   
mov  dl, 0   ;Column
mov  dh, 5  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'B'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1   ;Column
mov  dh, 5   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h     

;--------------------CX-----------------------

mov  dl, 0   ;Column
mov  dh, 9  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'C'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h  
  

;-------------------DX---------------------- 

mov  dl, 0   ;Column
mov  dh, 0dh  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'D'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 



mov  dl, 1   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h 


 ;Sec column
 
 ;--------------------SI-----------------

mov  dl, 0ah   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'S'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 0bh   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'I'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h 

 

;-----------------DI---------------------
  
mov  dl, 0ah   ;Column
mov  dh, 5  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'D'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 0bh   ;Column
mov  dh, 5  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'I'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h     


;-------------SP------------------ 
  
mov  dl, 0ah   ;Column
mov  dh, 9  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'S'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 0bh   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'P'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h  


 

;-----------BP-------------- 

mov  dl, 0ah   ;Column
mov  dh, 0dh  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'B'
mov bh,00
mov bl,07h  ;color                                                          f
mov ah,0eh 
;mov cx,1
int 10h 
   
mov  dl, 0bh   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'P'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h    


;------------------------third column-----------------------

;--------------AX--------------------

mov  dl, 14h   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'A'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 
 
mov  dl, 15h   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h 

  

;-------------------BX----------------

mov  dl, 14h   ;Column
mov  dh, 5  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'B'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 15h   ;Column
mov  dh, 5   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h     


;----------------CX--------------------- 

mov  dl, 14h   ;Column
mov  dh, 9  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'C'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 15h   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h  


;---------------DX---------------------

mov  dl, 14h   ;Column
mov  dh, 0dh  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'D'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 


mov  dl, 15h   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'X'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h 
  

 ;----------------------forth column---------------------
 
 ;--------------SI---------------

mov  dl, 1eh   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'S'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1fh   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'I'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h 


;------------------------DI-----------------------
mov  dl, 1eh   ;Column
mov  dh, 5  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'D'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1fh   ;Column
mov  dh, 5   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'I'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h     


;------------------------SP---------------

mov  dl, 1eh   ;Column
mov  dh, 9  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'S'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1fh   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'P'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h 


;--------------BP------------------- 

mov  dl, 1eh   ;Column
mov  dh, 0dh  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h 
;AL = Character, BH = Page Number, BL = Color, cx number of times
mov al,'B'
mov bh,00
mov bl,07h  ;color
mov ah,0eh 
;mov cx,1
int 10h 

mov  dl, 1fh   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h
mov al,'P'
mov bh,00
mov bl,07h  ;color high 4 bits are background, low 4 bits are foreground
mov ah,0eh 
;mov cx,1
int 10h                     



            
  
;-----------------making a vertical line for power up number on left------------------------------
mov cx,83
mov dx,149
mov al,0fh
mov ah,0ch
label_draw_vetical_line_powerupL:int 10h
                                 inc dx
                                 cmp dx,164
                                 jnz label_draw_vetical_line_powerupL   
                                 
                                 
;-------------------------------making a vertical line for power up number on right
mov cx,242
mov dx,149
mov al,0fh
mov ah,0ch
labelR_draw_vetical_line_powerupR:int 10h
                                 inc dx
                                 cmp dx,164
                                 jnz labelR_draw_vetical_line_powerupR

;-----------------making a verical line for hidden char on left and putting the hidden char val----------------------------
mov cx,0
mov di,0
mov di ,offset level+2
mov cx,[di]
sub cx,0030h
cmp cx,0D02h
jZ loop91
mov cx,120
mov dx,149
mov al,0fh
mov ah,0ch
label_draw_vetical_line_hidden_charL:int 10h
                                     inc dx
                                     cmp dx,164
                                     jnz label_draw_vetical_line_hidden_charL 

mov  dl, 16   ;Column
mov  dh, 19    ;Row
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset FORBIDDEN2_CHAR+2
int 21h 


;-----------------making a verical line for hidden char on right and putting the hidden char val------------------- 
mov cx,280
mov dx,149
mov al,0fh
mov ah,0ch
labelR_draw_vetical_line_hidden_charR:int 10h
                                      inc dx
                                      cmp dx,164                                 
                                      jnz labelR_draw_vetical_line_hidden_charR  
mov  dl, 25h   ;Column
mov  dh, 19   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h

mov  dl, 25h   ;Column
mov  dh, 19   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset FORBIDDEN1_CHAR+2
int 21h


call printingreg

                                     
loop91:
                                                                          
 ret                                    
                                      
gui2 endp  

delay proc   
       mov cx,0
delrep:inc cx 
       cmp cx ,20
       jnz delrep      
   ret
delay  endp 

 
  ;---------------------------getinputcommand function-------------------
;TO GET THE INPUT
;MOV AH,0AH
;MOV DX, OFFSET INDATA
;INT 21H
getcommand proc 
      

mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  

mov ah,0AH        ;Read from keyboard
mov dx,offset INDATA                  
int 21h         
         
mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h    

mov dx, offset INDATA+2  ;Display the input data in a new location
mov ah, 9
int 21h 



done: 
ret
getcommand endp 


;---------------------printing out registers values:-------------------------
printingreg proc
    
;first column
;AX
mov  dl, 3   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset AX1_REG+2
int 21h  

;BX
mov  dl, 3   ;Column
mov  dh, 6  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset BX1_REG+2
int 21h 

;CX
mov  dl, 3   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset CX1_REG+2
int 21h 


;DX 
 mov  dl, 3   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset DX1_REG+2
int 21h 

;SEC COLUMN
;SI

mov  dl, 0dh   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset SI1_REG+2
int 21h 

;DI
mov  dl, 0dh   ;Column
mov  dh, 6   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset DI1_REG+2
int 21h 

;SP
mov  dl, 0dh   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset SP1_REG+2
int 21h 

;BP 
mov  dl, 0dh   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset BP1_REG+2
int 21h 

;THIRD COL
;AX

mov  dl, 17h   ;Column
mov  dh, 2   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset AX2_REG+2
int 21h


;BX

mov  dl, 17h   ;Column
mov  dh, 6   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset BX2_REG+2
int 21h 


;CX

mov  dl, 17h   ;Column
mov  dh, 9   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset CX2_REG+2
int 21h 


;DX

mov  dl, 17h   ;Column
mov  dh, 0dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset DX2_REG+2
int 21h 


;FORTH COL
;SI
mov  dl, 21h   ;Column
mov  dh, 2h   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset SI2_REG+2
int 21h 

;DI
mov  dl, 21h   ;Column
mov  dh, 6h   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset DI2_REG+2
int 21h 

;SP
mov  dl, 21h   ;Column
mov  dh,  9  ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset SP2_REG+2
int 21h 


;BP  
mov  dl, 21h   ;Column
mov  dh, 0Dh   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset BP2_REG+2
int 21h 



ret
printingreg endp

;-----------------------------------------------------playerplaywhere function-------------------------

player_play_where proc
    
    
mov cx,0         ;see he is in which level
mov di,0
mov di ,offset level+2
mov cl,[di]
sub cl,30h
cmp cl,02h
je loop300      
JMP LOOP86

loop300: 
cmp indata+2,31H
je loop80
jmp loop83
loop80:
        mov player,2
        jmp loop86



loop83: mov player,1
        jmp loop86
        

   loop86: 
ret 
player_play_where endp

logicfn proc 

;;TO GET THE INPUT
;MOV AH,0AH
;MOV DX, OFFSET INDATA
;INT 21H
mov cl,level+2
cmp cl,32h
jne lvl1
call player_play_where
mov ch, indata+1
mov si, offset indata+2
cleardata3:
mov byte ptr[si],'$'
dec ch
inc si
cmp ch,0
jne cleardata3

mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  

mov ah,0AH        ;Read from keyboard
mov dx,offset INDATA                  
int 21h

lvl1:
MOV AH,INDATA+1
MOV DH,0

;--------------------powerups-------------------------------------;
cmp ah,1
jne cont
call powerups

mov ch, indata+1
mov si, offset indata+2
cleardata4:
mov byte ptr[si],'$'
dec ch
inc si
cmp ch,0
jne cleardata4

mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  

mov ah,0AH        ;Read from keyboard
mov dx,offset INDATA                  
int 21h

jmp cont
;-----------------------------------------------------------------;

cont:
mov ax,0
cmp player,2
jne cf1
mov al,CF2_FLAG
shl ax,15  ;cl equals 15
rcl ax,1
jmp conttt
cf1: 
mov al,CF1_FLAG
shl ax,15  ;cl equals 15
rcl ax,1

conttt:
MOV AH,INDATA+1
MOV DH,0
MOV BX, OFFSET INDATA+2
MOV SI,OFFSET OUTDATA 
MOV CL,0
mov ch,0
CONVERLOOP:  
CONVERT 
INC DH
inc ch
CMP DH,AH
JNE CONVERLOOP
mov temp,ch

;---------------FORBIDDEN CHAR CHECK---------------------------------------------;    
 CMP PLAYER,2
JNE BXB
 MOV SI,OFFSET OUTDATA
 MOV DI, OFFSET FORBIDDEN1_CHAR+2
 MOV BH, [DI] 
 JMP BXBB
 BXB:
 MOV SI,OFFSET OUTDATA
 MOV DI, OFFSET FORBIDDEN2_CHAR+2
 MOV BH, [DI] 
 BXBB:
 MOV CX,11
 FORLOOP:  
 MOV BL,[SI] 
 CMP BL,BH  
 JE  ERROR_LOOP 
 INC SI
 LOOP FORLOOP
 

;---------------FORBIDDEN CHAR CHECK---------------------------------------------;

;CH CONTAINS THE SIZE AFTER THE ADJUSTMENT LW EST5DMTY 7AGA FIHA CH 7OTIHA ELAWL FIH TEMP VAR 3ASHAN ELVALUE MATRO7SH 
;push cx
;MOV TEMP,CH 
mov si,offset outdata  ;si gowaha a  
MOV DI,OFFSET NOP_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JE ENDLOOP 



mov si,offset outdata  ;si gowaha a  
MOV DI,OFFSET CLC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JE CLCLOOP



mov si,offset outdata
add si,3 ;si gowaha el space 
cmp byte ptr [si],20h 
jne  loop1
;jne "loop operation =4" 
inc si ;si = bedayet el source    
jmp startloop
 
loop1:
inc si 
cmp byte ptr [si],20h
jne ERROR_LOOP
inc si ;si = bedayet el source 

startloop:
CLD

MOV DI,OFFSET AX1  ;destenation check
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AXLOOP 

MOV SI, OFFSET OUTDATA+4 
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BXLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CXLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DXLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SILOOP  

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DILOOP


MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BPLOOP  


MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET AL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE ALLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET AH1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AHLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET BL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BLLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET BH1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BHLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CLLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET CH1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CHLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET DL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DLLOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET DH1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DHLOOP

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET OFFSI 
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSILOOP  


MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDILOOP 

MOV SI, OFFSET OUTDATA+4
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBXLOOP 


MOV AL, OUTDATA+4
CMP AL,'['
JE OFFNUMLOOP
JMP ERROR_LOOP

 



AXLOOP:

CMP PLAYER,2
JNE P1
MOV AX,0H
INPUT AX1_REG+2
ROL AX,4
INPUT AX1_REG+3
ROL AX,4
INPUT AX1_REG+4
ROL AX,4
INPUT AX1_REG+5
JMP P11
P1:
MOV AX,0H
INPUT AX2_REG+2
ROL AX,4
INPUT AX2_REG+3
ROL AX,4
INPUT AX2_REG+4
ROL AX,4
INPUT AX2_REG+5 

P11:
cmp cl,1
je op1_loop
;MOV CH,0
;push cx
MOV TEMP2,0
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1   

CMP byte ptr [SI],0H
JE  MUL1_LOOP   ;THAT'S WHERE THE CONFUSION LIES

;ADD SI,1


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX1LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX1LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX1LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX1LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI1LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI1LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP1LOOP 


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL1LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI1LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI1LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX1LOOP

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM1LOOP


value11_loop:
MOV SI, OFFSET OUTDATA+7
mov di,7h
;pop bx
;pop cx
MOV CH,TEMP
;push bx
cmp ch,11d
ja ERROR_LOOP
sub ch,7
MOV AX,0H
;MOV SI,OFFSET OUTDATA+2


value:
cmp byte ptr [si],30H
jb ERROR_LOOP
cmp byte ptr [si],39h
jb done1
cmp byte ptr [si],61h
jb ERROR_LOOP
cmp byte ptr [si],66h
ja ERROR_LOOP
JMP DONE2
done1: 
SUB BYTE PTR[SI],30H
MOV CL,[SI]
inc si
;inc di
dec ch
cmp ch,0
je finish1
ADD AL,CL
ROL AX,4
jmp value
finish1:
ADD AL,CL
JMP OP1_LOOP         
DONE2:        
SUB BYTE PTR[SI],57H
MOV CL,[SI]
inc si
;inc di
dec ch
cmp ch,0
je finish1
ADD AL,CL
ROL AX,4
jmp value

AX1LOOP:
mov cl,1 
jmp AXLOOP

BX1LOOP: 
mov cl,1
jmp BXLOOP


CX1LOOP:
mov cl,1
jmp CXLOOP

DX1LOOP:
mov cl,1
jmp DXLOOP


SI1LOOP: 
mov cl,1 
jmp SI1LOOP
  

DI1LOOP:
mov cl,1  
jmp DI1LOOP


BP1LOOP:
mov cl,1
jmp BPLOOP


CL1LOOP: 
MOV CL,1
JMP CXLOOP

OFFSI1LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI1LOOP: 
MOV CL,1
JMP OFFDILOOP

OFFBX1LOOP:
MOV CL,1
JMP OFFBXLOOP

OFFNUM1LOOP: 
MOV CL,1
JMP OFFNUMLOOP 
        
              
;-----------------------------------------------------------------------------------------------
BXLOOP: 
CMP PLAYER,2
JNE P2
MOV AX,0H 
INPUT BX1_REG+2
ROL AX,4
INPUT BX1_REG+3
ROL AX,4
INPUT BX1_REG+4
ROL AX,4
INPUT BX1_REG+5 
JMP P22
P2: 
MOV AX,0H
INPUT BX2_REG+2
ROL AX,4
INPUT BX2_REG+3
ROL AX,4
INPUT BX2_REG+4
ROL AX,4
INPUT BX2_REG+5 
P22:
CMP CL,1
JE op1_loop
;MOV CH,1
;push cx
MOV TEMP2,1
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  MUL1_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX2LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX2LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL2LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI2LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI2LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX2LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM2LOOP

JMP value11_loop

;------------------------HEREEEEEEE------------------------------------

AX2LOOP:
mov cl,1
jmp AXLOOP


BX2LOOP:
mov cl,1
jmp BXLOOP


CX2LOOP:
mov cl,1
jmp CXLOOP


DX2LOOP:
mov cl,1 
jmp DXLOOP
  
SI2LOOP:
mov cl,1 
jmp SILOOP

DI2LOOP: 
mov cl,1
jmp DILOOP


BP2LOOP:
mov cl,1
jmp AXLOOP


CL2LOOP: 
MOV CL,1
JMP CXLOOP   

OFFBX2LOOP: 
MOV CL,1
JMP OFFBXLOOP   

OFFSI2LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI2LOOP: 
MOV CL,1
JMP OFFDILOOP  

OFFNUM2LOOP: 
MOV CL,1
JMP OFFNUMLOOP      
;-----------------------------------------------------------------------------------------------
CXLOOP: 
CMP PLAYER,2
JNE P3
MOV AX,0H 
INPUT CX1_REG+2
ROL AX,4
INPUT CX1_REG+3
ROL AX,4
INPUT CX1_REG+4
ROL AX,4
INPUT CX1_REG+5
JMP P33
P3: 
MOV AX,0H
INPUT CX2_REG+2
ROL AX,4
INPUT CX2_REG+3
ROL AX,4
INPUT CX2_REG+4
ROL AX,4
INPUT CX2_REG+5
P33:
CMP CL,1
JE op1_loop
;MOV CH,2
;push cx
MOV TEMP2,2
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1   

CMP BYTE PTR [SI],0H
JE  MUL1_LOOP

;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX3LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX3LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL3LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI3LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI3LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX3LOOP 
 
MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM3LOOP

JMP value11_loop


AX3LOOP: 
mov cl,1
jmp AXLOOP


BX3LOOP:
mov cl,1
jmp BXLOOP


CX3LOOP:
mov cl,1
jmp CXLOOP


DX3LOOP:
mov cl,1
jmp DXLOOP


SI3LOOP:
mov cl,1
jmp SILOOP


DI3LOOP:
mov cl,1
jmp DILOOP


BP3LOOP:
mov cl,1
jmp BPLOOP


CL3LOOP:
MOV CL,1
JMP CXLOOP 

OFFBX3LOOP: 
MOV CL,1
JMP OFFBXLOOP   

OFFSI3LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI3LOOP: 
MOV CL,1
JMP OFFDILOOP           

OFFNUM3LOOP: 
MOV CL,1
JMP OFFNUMLOOP    


;-----------------------------------------------------------------------------------------------

DXLOOP:
CMP PLAYER,2
JNE P4   
MOV AX,0H 
INPUT DX1_REG+2
ROL AX,4
INPUT DX1_REG+3
ROL AX,4
INPUT DX1_REG+4
ROL AX,4
INPUT DX1_REG+5
JMP P44
P4:
MOV AX,0H 
INPUT DX2_REG+2
ROL AX,4
INPUT DX2_REG+3
ROL AX,4
INPUT DX2_REG+4
ROL AX,4
INPUT DX2_REG+5
P44:
CMP CL,1
JE op1_loop
;MOV CH,3
;push cx
MOV TEMP2,3
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
ADD SI,1  

CMP BYTE PTR [SI],0H
JE  MUL1_LOOP
ADD SI,1


MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX4LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX4LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP4LOOP 
 
MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL4LOOP   

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI4LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI4LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX4LOOP

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM4LOOP

JMP value11_loop

AX4LOOP: 
mov cl,1
jmp AXLOOP


BX4LOOP: 
mov cl,1
jmp BXLOOP


CX4LOOP:
mov cl,1
jmp CXLOOP


DX4LOOP: 
mov cl,1
jmp DXLOOP


SI4LOOP:
mov cl,1
jmp SILOOP

DI4LOOP:
mov cl,1
jmp DILOOP


BP4LOOP:
mov cl,1
jmp BPLOOP


CL4LOOP:
MOV CL,1
JMP CXLOOP    

OFFBX4LOOP: 
MOV CL,1
JMP OFFBXLOOP   

OFFSI4LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI4LOOP: 
MOV CL,1
JMP OFFDILOOP           

OFFNUM4LOOP: 
MOV CL,1
JMP OFFNUMLOOP 

;----------------------------------------------------------------------------------------------------
SILOOP: 
CMP PLAYER,2
JNE P5
MOV AX,0H
INPUT SI1_REG+2
ROL AX,4
INPUT SI1_REG+3
ROL AX,4
INPUT SI1_REG+4
ROL AX,4
INPUT SI1_REG+5
JMP P55
P5: 
MOV AX,0H
INPUT SI2_REG+2
ROL AX,4
INPUT SI2_REG+3
ROL AX,4
INPUT SI2_REG+4
ROL AX,4
INPUT SI2_REG+5
P55:
CMP CL,1 ;HNA DH M3NAH EN DH EL2ND OPERAND  FAH HYROO7 Y3ML ELOPS 3ALA TOOL
JE op1_loop
;MOV CH,4
;push cx
MOV TEMP2,4
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1   

CMP byte ptr [SI],0H
JE  MUL1_LOOP   ;THAT'S WHERE THE CONFUSION LIES

;ADD SI,1


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX5LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX5LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX5LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX5LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI5LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI5LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP5LOOP 


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL5LOOP 


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI5LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI5LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX5LOOP
 
MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM5LOOP


JMP value11_loop

AX5LOOP:
mov cl,1 
jmp AXLOOP


BX5LOOP:
mov cl,1 
jmp BXLOOP


CX5LOOP:
mov cl,1
jmp CXLOOP


DX5LOOP: 
mov cl,1
jmp DXLOOP


SI5LOOP: 
mov cl,1 
jmp SILOOP
 

DI5LOOP: 
mov cl,1
jmp DILOOP


BP5LOOP: 
mov cl,1
jmp BPLOOP
 

CL5LOOP: 
MOV CL,1
JMP CXLOOP
 
MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM3LOOP

OFFBX5LOOP: 
MOV CL,1
JMP OFFBXLOOP   

OFFSI5LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI5LOOP: 
MOV CL,1
JMP OFFDILOOP           

OFFNUM5LOOP: 
MOV CL,1
JMP OFFNUMLOOP 
        
;-----------------------------------------------------------------------------------------------   
DILOOP:
CMP PLAYER,2
JNE P6 
MOV AX,0H 
INPUT DI1_REG+2
ROL AX,4
INPUT DI1_REG+3
ROL AX,4
INPUT DI1_REG+4
ROL AX,4
INPUT DI1_REG+5
JMP P66
P6: 
MOV AX,0H 
INPUT DI2_REG+2
ROL AX,4
INPUT DI2_REG+3
ROL AX,4
INPUT DI2_REG+4
ROL AX,4
INPUT DI2_REG+5
P66:
CMP CL,1
JE op1_loop
;MOV CH,5
;push cx
MOV TEMP2,5
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  MUL1_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX6LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX6LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX6LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX6LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI6LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI6LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP6LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 2H
REPE CMPSB
CMP CX,0 
JE CL6LOOP 


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI6LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI6LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX6LOOP

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM6LOOP

JMP value11_loop

OFFBX6LOOP: 
MOV CL,1
JMP OFFBXLOOP   

OFFSI6LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI6LOOP: 
MOV CL,1
JMP OFFDILOOP           

OFFNUM6LOOP: 
MOV CL,1
JMP OFFNUMLOOP 

AX6LOOP:
mov cl,1
jmp AXLOOP

BX6LOOP: 
mov cl,1
jmp BXLOOP

CX6LOOP:
mov cl,1
jmp CXLOOP

DX6LOOP:
mov cl,1
jmp DXLOOP

SI6LOOP:
mov cl,1   
jmp SILOOP

DI6LOOP:
mov cl,1
jmp DILOOP

BP6LOOP:
mov cl,1
jmp BPLOOP

CL6LOOP:
MOV CL,1
JMP CXLOOP                      
;----------------------------------------------------------------------------------------------- 
BPLOOP:
CMP PLAYER,2
JNE P7 
MOV AX,0H 
INPUT BP1_REG+2
ROL AX,4
INPUT BP1_REG+3
ROL AX,4
INPUT BP1_REG+4
ROL AX,4
INPUT BP1_REG+5
JMP P77
P7:   
MOV AX,0H 
INPUT BP2_REG+2
ROL AX,4
INPUT BP2_REG+3
ROL AX,4
INPUT BP2_REG+4
ROL AX,4
INPUT BP2_REG+5
P77:
CMP CL,1
JE op1_loop
;MOV CH,6
;push cx
MOV TEMP2,6
MOV DX,AX 

;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  MUL1_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AX7LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BX7LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CX7LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DX7LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SI7LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DI7LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BP7LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL7LOOP 


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI7LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI7LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX7LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM7LOOP

JMP value11_loop

OFFBX7LOOP: 
MOV CL,1
JMP OFFBXLOOP   

OFFSI7LOOP: 
MOV CL,1
JMP OFFSILOOP    

OFFDI7LOOP: 
MOV CL,1
JMP OFFDILOOP           

OFFNUM7LOOP: 
MOV CL,1
JMP OFFNUMLOOP 


AX7LOOP: 
mov cl,1
jmp AXLOOP


BX7LOOP: 
mov cl,1   
jmp BXLOOP

CX7LOOP: 
mov cl,1
jmp CXLOOP

DX7LOOP: 
mov cl,1 
jmp DXLOOP

SI7LOOP: 
mov cl,1
jmp SILOOP

DI7LOOP: 
mov cl,1
jmp DILOOP
                    
BP7LOOP: 
mov cl,1
jmp BPLOOP

CL7LOOP:
MOV CL,1
JMP CXLOOP
;------------------------------------------------------------------------------------------------------;
 
OFFSILOOP: 
CMP PLAYER,2
JNE P91
MOV AX,0H 
INPUT SI1_REG+2
ROL AX,4
INPUT SI1_REG+3
ROL AX,4
INPUT SI1_REG+4
ROL AX,4
INPUT SI1_REG+5
JMP P991
P91:
MOV AX,0H 
INPUT SI2_REG+2
ROL AX,4
INPUT SI2_REG+3
ROL AX,4
INPUT SI2_REG+4
ROL AX,4
INPUT SI2_REG+5
P991:
MOV BX,AX
CMP AX,8
JA ERROR_LOOP
CMP CL,1
JE PUTVALUE
CMP CL,2
JE PUTVALUE2
CMP CL,4
JE PUTVALUE3
MOV TEMP2,15D
MOV SI, OFFSET OUTDATA+9
CMP BYTE PTR [SI],0H
JE  OP6_LOOP
;ADD SI,1                                                                          
CMP OUTDATA+10D,'X'
JNE LOOPL
CMP AL, 8
JE  ERROR_LOOP
CMP PLAYER,2
JNE TFT
MOV SI,OFFSET DS1_SEG 
JMP TFTT
TFT: 
MOV SI,OFFSET DS2_SEG 
TFTT:
MOV AL,byte ptr[SI+BX] 
INC BX
MOV AH,byte ptr[SI+BX]
MOV Dx,Ax
JMP AXOF1LOOPA
                                       
LOOPL:
CMP PLAYER,2
JNE MMM  
MOV SI,OFFSET DS1_SEG
JMP MMMM
MMM: 
MOV SI,OFFSET DS2_SEG
MMMM:
MOV AL, byte ptr[SI+BX]
MOV Dx,Ax
JMP ALOF1LOOPA

PUTVALUE3:  
CMP PLAYER,2
JNE GOG
MOV SI,OFFSET DS1_SEG
JMP GOGG
GOG: 
MOV SI,OFFSET DS2_SEG
GOGG:
MOV AL,byte ptr[SI+BX]
JMP OP4_LOOP

PUTVALUE2:  
CMP PLAYER,2
JNE DDU
MOV SI,OFFSET DS1_SEG
JMP DDUU
DDU: 
MOV SI,OFFSET DS2_SEG
DDUU:
MOV AL,byte ptr[SI+BX]
JMP OP2_LOOP

PUTVALUE:
CMP PLAYER,2
JNE HHG 
MOV SI,OFFSET DS1_SEG 
JMP HHGG
HHG:     
MOV SI,OFFSET DS2_SEG
HHGG:
MOV AL,byte ptr[SI+BX]
INC BX
CMP AX,8
JA ERROR_LOOP
MOV AH,byte ptr[SI+BX]

JMP OP1_LOOP
 
;CONT1LOOP:
;MOV CH,15D
;push cx

;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 



AXOF1LOOPA:
MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AXOF1LOOP 

MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BXOF1LOOP  

MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CXOF1LOOP  

MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DXOF1LOOP 

MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SIOF1LOOP 

MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DIOF1LOOP 

MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BPOF1LOOP 

ALOF1LOOPA:
MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE ALOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AHOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BLOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BHOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CLOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CHOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DLOF1LOOP 


MOV SI,OFFSET OUTDATA+9
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DHOF1LOOP  
jmp ERROR_LOOP

;JMP value11_loop HOW CAN I GET THE VALUES 

AXOF1LOOP: 
mov cl,1
jmp AXLOOP

BXOF1LOOP: 
mov cl,1   
jmp BXLOOP

CXOF1LOOP: 
mov cl,1
jmp CXLOOP

DXOF1LOOP: 
mov cl,1 
jmp DXLOOP

SIOF1LOOP: 
mov cl,1
jmp SILOOP

DIOF1LOOP: 
mov cl,1
jmp DILOOP
                    
BPOF1LOOP: 
mov cl,1
jmp BPLOOP

ALOF1LOOP: 
MOV CL,2
JMP ALLOOP 

AHOF1LOOP: 
MOV CL,3
JMP AHLOOP  

BLOF1LOOP: 
MOV CL,2
JMP BLLOOP

BHOF1LOOP: 
MOV CL,3
JMP BHLOOP

CLOF1LOOP: 
MOV CL,2
JMP CLLOOP

CHOF1LOOP: 
MOV CL,3
JMP CHLOOP

DLOF1LOOP: 
MOV CL,2
JMP DLLOOP

DHOF1LOOP: 
MOV CL,3
JMP DHLOOP
;-------------------------------------------------------------------------------------------------
OFFDILOOP: 
CMP PLAYER,2
JNE P65
MOV AX,0H 
INPUT DI1_REG+2
ROL AX,4
INPUT DI1_REG+3
ROL AX,4
INPUT DI1_REG+4
ROL AX,4
INPUT DI1_REG+5
JMP P665
P65:
MOV AX,0H 
INPUT DI2_REG+2
ROL AX,4
INPUT DI2_REG+3
ROL AX,4
INPUT DI2_REG+4
ROL AX,4
INPUT DI2_REG+5
P665:
MOV BX,AX
CMP AX,8
JA ERROR_LOOP
CMP CL,1
JE PUTVALUE
CMP CL,2
JE PUTVALUE2
CMP CL,4
JE PUTVALUE3
MOV TEMP2,15D

MOV SI, OFFSET OUTDATA+9
CMP BYTE PTR [SI],0H
JE  OP6_LOOP
;ADD SI,1                                                                          
CMP OUTDATA+10D,'X'
JNE LOOPL1
CMP AL, 8
JE  ERROR_LOOP
CMP PLAYER,2
JNE TET
MOV SI,OFFSET DS1_SEG 
JMP TETT
TET:
MOV SI,OFFSET DS2_SEG
TETT:
MOV AL,[SI+BX] 
INC BX
MOV AH,[SI+BX]
MOV Dx,Ax
JMP AXOF2LOOPA
                                       
LOOPL1:
CMP PLAYER,2
JNE TOT  
MOV SI,OFFSET DS1_SEG
JMP TOTT
TOT: 
MOV SI,OFFSET DS2_SEG
TOTT:
MOV AL,[SI+BX]
MOV Dx,Ax
JMP ALOF2LOOPA





AXOF2LOOPA:
MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AXOF2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BXOF2LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CXOF2LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DXOF2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SIOF2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DIOF2LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BPOF2LOOP 

ALOF2LOOPA:
MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE ALOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AHOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BLOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BHOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CLOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CHOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DLOF1LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DHOF1LOOP  

jmp ERROR_LOOP
;TO HANDLE THE CASE OF VALUE

AXOF2LOOP: 
mov cl,1
jmp AXLOOP


BXOF2LOOP: 
mov cl,1   
jmp BXLOOP

CXOF2LOOP: 
mov cl,1
jmp CXLOOP

DXOF2LOOP: 
mov cl,1 
jmp DXLOOP

SIOF2LOOP: 
mov cl,1
jmp SILOOP

DIOF2LOOP: 
mov cl,1
jmp DILOOP
                    
BPOF2LOOP: 
mov cl,1
jmp BPLOOP

ALOF2LOOP: 
MOV CL,2
JMP ALLOOP 

AHOF2LOOP: 
MOV CL,3
JMP AHLOOP  

BLOF2LOOP: 
MOV CL,2
JMP BLLOOP

BHOF2LOOP: 
MOV CL,3
JMP BHLOOP

CLOF2LOOP: 
MOV CL,2
JMP CLLOOP

CHOF2LOOP: 
MOV CL,3
JMP CHLOOP

DLOF2LOOP: 
MOV CL,2
JMP DLLOOP

DHOF2LOOP: 
MOV CL,3
JMP DHLOOP
;------------------------------------------------------------------------
OFFBXLOOP:
CMP PLAYER,2
JNE RR
MOV AX,0H 
INPUT BX1_REG+2
ROL AX,4
INPUT BX1_REG+3 
ROL AX,4
INPUT BX1_REG+4
ROL AX,4
INPUT BX1_REG+5 
JMP KK
RR:
INPUT BX2_REG+2
ROL AX,4
INPUT BX2_REG+3 
ROL AX,4
INPUT BX2_REG+4
ROL AX,4
INPUT BX2_REG+5

KK:
MOV BX,AX
CMP AX,8
JA ERROR_LOOP
CMP CL,1
JE PUTVALUE
CMP CL,2
JE PUTVALUE2
CMP CL,4
JE PUTVALUE3
MOV TEMP2,15D

MOV SI, OFFSET OUTDATA+9
CMP BYTE PTR [SI],0H
JE  OP6_LOOP
;ADD SI,1

CMP OUTDATA+10D,'X'
JNE LOOPL2
CMP AL, 8
JE  ERROR_LOOP
CMP PLAYER,2
JNE BBF
MOV SI,OFFSET DS1_SEG 
JMP BBFF
BBF:   
MOV SI,OFFSET DS2_SEG 
BBFF:
MOV AL,[SI+BX] 
INC BX
MOV AH,[SI+BX]
MOV Dx,Ax
JMP AXOF3LOOPA
                                       
LOOPL2:
CMP PLAYER,2
JNE CVC  
MOV SI,OFFSET DS1_SEG
JMP CVCC
CVC: 
MOV SI,OFFSET DS2_SEG
CVCC:
MOV AL,[SI+BX]
MOV Dx,Ax
JMP ALOF3LOOPA




AXOF3LOOPA:
MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AXOF3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BXOF3LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CXOF3LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DXOF3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SIOF3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DIOF3LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BPOF3LOOP 


ALOF3LOOPA:

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE ALOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AHOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BLOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BHOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CLOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CHOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DLOF3LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DHOF3LOOP  

jmp ERROR_LOOP
;TO HANDLE THE CASE OF VALUE

AXOF3LOOP: 
mov cl,1
jmp AXLOOP


BXOF3LOOP: 
mov cl,1   
jmp BXLOOP

CXOF3LOOP: 
mov cl,1
jmp CXLOOP

DXOF3LOOP: 
mov cl,1 
jmp DXLOOP

SIOF3LOOP: 
mov cl,1
jmp SILOOP

DIOF3LOOP: 
mov cl,1
jmp DILOOP
                    
BPOF3LOOP: 
mov cl,1
jmp BPLOOP

ALOF3LOOP: 
MOV CL,2
JMP ALLOOP 

AHOF3LOOP: 
MOV CL,3
JMP AHLOOP  

BLOF3LOOP: 
MOV CL,2
JMP BLLOOP

BHOF3LOOP: 
MOV CL,3
JMP BHLOOP

CLOF3LOOP: 
MOV CL,2
JMP CLLOOP

CHOF3LOOP: 
MOV CL,3
JMP CHLOOP

DLOF3LOOP: 
MOV CL,2
JMP DLLOOP

DHOF3LOOP: 
MOV CL,3
JMP DHLOOP
;---------------------------------------------------------------------------
OFFNUMLOOP:
MOV AL, OUTDATA+8
CMP AX,8
JA ERROR_LOOP
MOV AL, OUTDATA+10D
CMP AL,']'
JNE ERROR_LOOP   
MOV BH,AL ;BH CONTAINS THE LOCATION  
CMP PLAYER,2
JNE ZR
MOV BL,0
MOV SI,OFFSET DS1_SEG
MOV AL,[SI+BX] 
JMP ZD
ZR: MOV BL,0
MOV SI,OFFSET DS1_SEG
MOV AL,[SI+BX] 
ZD:
CMP OUTDATA+5,'x'
JNE  GETAH
ADD BH,1
CMP BH,8
JA  ERROR_LOOP   
GETAH: 
CMP PLAYER,2
JNE MH
MOV BL,0
MOV SI,OFFSET DS1_SEG
MOV AL,[SI+BX] 
JMP OL
MH: MOV BL,0
MOV SI,OFFSET DS1_SEG
MOV AL,[SI+BX] 
OL:
CMP CL,1
JnE cont5loop
CMP OUTDATA+5,'x' 
JE OP1_LOOP 
CMP OUTDATA+5,'l'
JE  OP2_LOOP
JMP OP4_LOOP
 
CONT5LOOP:
;MOV CH,18D
;push cx
MOV TEMP2,18D
MOV DX,AX
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
ADD SI,1 

MOV SI, OFFSET OUTDATA+7
CMP BYTE PTR [SI],0H
JE  MUL1_LOOP
ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AX1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AXOF4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BXOF4LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CXOF4LOOP  

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DX1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DXOF4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET SI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE SIOF4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DI1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DIOF4LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BP1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BPOF4LOOP 



MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE ALOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AHOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BLOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BHOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CLOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CHOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DLOF4LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DHOF4LOOP  


;TO HANDLE THE CASE OF VALUE

AXOF4LOOP: 
mov cl,1
jmp AXLOOP


BXOF4LOOP: 
mov cl,1   
jmp BXLOOP

CXOF4LOOP: 
mov cl,1
jmp CXLOOP

DXOF4LOOP: 
mov cl,1 
jmp DXLOOP

SIOF4LOOP: 
mov cl,1
jmp SILOOP

DIOF4LOOP: 
mov cl,1
jmp DILOOP
                    
BPOF4LOOP: 
mov cl,1
jmp BPLOOP

ALOF4LOOP: 
MOV CL,2
JMP ALLOOP 

AHOF4LOOP: 
MOV CL,3
JMP AHLOOP  

BLOF4LOOP: 
MOV CL,2
JMP BLLOOP

BHOF4LOOP: 
MOV CL,3
JMP BHLOOP

CLOF4LOOP: 
MOV CL,2
JMP CLLOOP

CHOF4LOOP: 
MOV CL,3
JMP CHLOOP

DLOF4LOOP: 
MOV CL,2
JMP DLLOOP

DHOF4LOOP: 
MOV CL,3
JMP DHLOOP

JMP ERROR_LOOP
;--------------------------------BEGINNING OPERATIONS-----------------------------------;
op1_loop: 

SAR12_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SAR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHL12_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL55
JMP SAR55
VAL55:
CMP AL,1
JNE ERROR_LOOP 
SAR55:
MOV CL,AL
SAR DX,CL
MOV AX,DX
JMP ENDLOOP
    

SHL12_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ROR12_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL33
JMP SHL33
VAL33:
CMP AL,1
JNE ERROR_LOOP 
SHL33:
MOV CL,AL
SHL DX,CL
MOV AX,DX
JMP ENDLOOP

ROR12_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ROR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHR12_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL56
JMP ROR56
VAL56:
CMP AL,1
JNE ERROR_LOOP 
ROR56:
MOV CL,AL
ROR DX,CL
MOV AX,DX
JMP ENDLOOP







SHR12_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE CHECK


MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL77
JMP SHR77
VAL77:
CMP AL,1
JNE ERROR_LOOP 
SHR77:
MOV CL,AL
SHR DX,CL
MOV AX,DX
JMP ENDLOOP

CHECK:
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE ADD12_LOOP
JMP ERROR_LOOP





ADD12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADD_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE MOV12_LOOP  
add ax,dx 
JMP ENDLOOP   

MOV12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MOV_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ADC12_LOOP  
JMP ENDLOOP  

ADC12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SUB12_LOOP  
ADC AX,DX 
JMP ENDLOOP   

SUB12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SUB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE AND12_LOOP  
SUB DX,AX
MOV AX,DX
JMP ENDLOOP    

AND12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET AND_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE XOR12_LOOP 
AND DX,AX
MOV AX,DX  
JMP ENDLOOP  



XOR12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET XOR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SBB12_LOOP
XOR DX,AX
MOV AX,DX  
JMP ENDLOOP 

SBB12_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SBB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP
SBB DX,AX
MOV AX,DX  
JMP ENDLOOP





   

MUL1_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MUL_OP
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE INC1_LOOP  
MOV AX,DX
MUL AX   
;PUSH DX
MOV TEMP3,DX 
CMP PLAYER,2
JNE VBV
PUSHF
DIVSTEPBYSTEP AX1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
JMP VBVV
VBV: 
PUSHF
DIVSTEPBYSTEP AX2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
VBVV:
MOV DX,TEMP3
MOV AX,DX  
CMP PLAYER,2
JNE HVE
PUSHF
DIVSTEPBYSTEP DX1_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
JMP HVEE
HVE: 
PUSHF
DIVSTEPBYSTEP DX2_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
HVEE:
JMP ENDLOOP1 
;AL CASE IS NOT DONE YET AND IT IS NOT THE SAME IN MUL AND DIV

INC1_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET INC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE DEC1_LOOP 
MOV AX,DX
INC AX
JMP ENDLOOP 


DEC1_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET DEC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP 
MOV AX,DX
DEC AX
JMP ENDLOOP    




;----------------------------------END OPERATIONSS----------------------------------------;
            
;----------------------------------------BDAYET EL 1 BYTE OPERATIONS----------------------------------; 

;----------------------------------BEG OF AL-AL OP2 OPERATIONSS----------------------------------------;
OP2_LOOP:   ;CL=2
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADD_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE MOV83_LOOP  
ADD DL,AL
MOV AX,DX 
JMP ENDLOOP 

MOV83_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MOV_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ADC83_LOOP     
MOV DL,AL
MOV AX,DX
JMP ENDLOOP 

ADC83_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SUB83_LOOP   
ADC DL,AL
MOV AX,DX
JMP ENDLOOP 

SUB83_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SUB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE AND83_LOOP 
SUB DL,AL
MOV AX,DX 
JMP ENDLOOP  

AND83_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET AND_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE XOR83_LOOP 
AND DL,AL
MOV AX,DX 
JMP ENDLOOP  

XOR83_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET XOR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SBB83_LOOP
XOR DL,AL
MOV AX,DX  
JMP ENDLOOP   

SBB83_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SBB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SAR83_LOOP
SBB DL,AL
MOV AX,DX  
JMP ENDLOOP

SAR83_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SAR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHL83_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL0
JMP SAR1
VAL0:
CMP AL,1
JNE ERROR_LOOP 
SAR1:
MOV CL,AL
SAR DL,CL
MOV AX,DX
JMP ENDLOOP
    

SHL83_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ROR83_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL
JMP SHL1
VAL:
CMP AL,1
JNE ERROR_LOOP 
SHL1:
MOV CL, AL
SHL DL,CL
MOV AX,DX
JMP ENDLOOP

ROR83_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ROR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHR83_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VALY
JMP ROR1
VALY:
CMP AL,1
JNE ERROR_LOOP 
ROR1:
MOV CL, AL
ROR DL,CL
MOV AX,DX
JMP ENDLOOP

SHR83_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL1
JMP SHR1
VAL1:
CMP AL,1
JNE ERROR_LOOP 
SHR1:
MOV CL,AL
SHR DL,CL
MOV AX,DX
JMP ENDLOOP







;----------------------------------END OF AL-AL OPERATIONSS----------------------------------------;  

;----------------------------------BEG OF AL-AH OPERATIONSS----------------------------------------;
OP3_LOOP:  ;CL=3

MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADD_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE MOV102_LOOP  
ADD DL,AH
MOV AX,DX 
JMP ENDLOOP 

MOV102_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MOV_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ADC102_LOOP     
MOV DL,AH
MOV AX,DX 
JMP ENDLOOP 

ADC102_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SUB102_LOOP   
ADC DL,AH   
MOV AX,DX
JMP ENDLOOP 

SUB102_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SUB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE AND102_LOOP 
SUB DL,AH
MOV AX,DX 
JMP ENDLOOP  

AND102_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET AND_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE XOR102_LOOP 
AND DL,AH
MOV AX,DX 
JMP ENDLOOP  

XOR102_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET XOR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SBB102_LOOP
XOR DL,AH
MOV AX,DX
JMP ENDLOOP   

SBB102_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SBB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SAR102_LOOP
SBB DL,AH
MOV AX,DX 
JMP ENDLOOP


SAR102_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SAR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHL102_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL2
JMP SAR2
VAL2:
CMP AL,1
JNE ERROR_LOOP 
SAR2:
MOV CL,AH
SAR DL,CL
MOV AX,DX
JMP ENDLOOP
    

SHL102_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ROR102_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL3
JMP SHL3
VAL3:
CMP AL,1
JNE ERROR_LOOP 
SHL3:
MOV CL,AH
SHL DL,CL
MOV AX,DX
JMP ENDLOOP

ROR102_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ROR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHR102_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL34
JMP ROR3
VAL34:
CMP AL,1
JNE ERROR_LOOP 
ROR3:
MOV CL,AH
ROR DL,CL
MOV AX,DX
JMP ENDLOOP


SHR102_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL4
JMP SHR4
VAL4:
CMP AL,1
JNE ERROR_LOOP 
SHR4:
MOV CL,AH
SHR DL,CL
MOV AX,DX
JMP ENDLOOP



                   
;----------------------------------END OF AL-AH OPERATIONSS----------------------------------------;     
;----------------------------------BEG OF AH-AL OPERATIONSS----------------------------------------; 
OP4_LOOP: ;CL=4
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADD_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE MOV93_LOOP  
ADD DH,AL
MOV AX,DX 
JMP ENDLOOP 

MOV93_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MOV_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ADC93_LOOP     
MOV DH,AL
MOV AX,DX
JMP ENDLOOP 

ADC93_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SUB93_LOOP   
ADC DH,AL
MOV AX,DX
JMP ENDLOOP 

SUB93_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SUB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE AND93_LOOP 
SUB DH,AL
MOV AX,DX
JMP ENDLOOP  

AND93_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET AND_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE XOR93_LOOP 
AND DH,AL
MOV AX,DX 
JMP ENDLOOP  

XOR93_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET XOR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SBB93_LOOP
XOR DH,AL
MOV AX,DX 
JMP ENDLOOP   

SBB93_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SBB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SAR93_LOOP
SBB DH,AL
MOV AX,DX 
JMP ENDLOOP


SAR93_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SAR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHL93_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL5
JMP SAR5
VAL5:
CMP AL,1
JNE ERROR_LOOP 
SAR5:
MOV CL,AL 
SAR DH,CL
MOV AX,DX
JMP ENDLOOP
    

SHL93_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ROR93_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL6
JMP SHL6
VAL6:
CMP AL,1
JNE ERROR_LOOP 
SHL6:
MOV CL,AL
SHL DH,CL
MOV AX,DX
JMP ENDLOOP

ROR93_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ROR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHR93_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL65
JMP ROR6
VAL65:
CMP AL,1
JNE ERROR_LOOP 
ROR6:
MOV CL,AL
ROR DH,CL
MOV AX,DX
JMP ENDLOOP


SHR93_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL7
JMP SHR7
VAL7:
CMP AL,1
JNE ERROR_LOOP 
SHR7:
MOV CL,AL
SHR DH,CL
MOV AX,DX
JMP ENDLOOP

;----------------------------------END OF AH-AL OPERATIONSS----------------------------------------;   
;----------------------------------BEG OF AH-AH OPERATIONSS----------------------------------------;
OP5_LOOP: ;CL=5  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADD_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE MOV94_LOOP  
ADD DH,AH
MOV AX,DX 
JMP ENDLOOP 

MOV94_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MOV_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ADC94_LOOP     
MOV DH,AH
MOV AX,DX
JMP ENDLOOP 

ADC94_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ADC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SUB94_LOOP   
ADC DH,AH
MOV AX,DX
JMP ENDLOOP 

SUB94_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SUB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE AND94_LOOP 
SUB DH,AH
MOV AX,DX
JMP ENDLOOP  

AND94_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET AND_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE XOR94_LOOP 
AND DH,AH
MOV AX,DX
JMP ENDLOOP  

XOR94_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET XOR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SBB94_LOOP
XOR DH,AH
MOV AX,DX 
JMP ENDLOOP   

SBB94_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SBB_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SAR94_LOOP
SBB DH,AH
MOV AX,DX 
JMP ENDLOOP


SAR94_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SAR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHL94_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL9
JMP SAR9
VAL9:
CMP AL,1
JNE ERROR_LOOP 
SAR9:
MOV CL,AH
SAR DH,CL
MOV AX,DX
JMP ENDLOOP
    

SHL94_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ROR94_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL10
JMP SHL10
VAL10:
CMP AL,1
JNE ERROR_LOOP 
SHL10:
MOV CL,AH
SHL DH,CL
MOV AX,DX
JMP ENDLOOP





ROR94_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET ROR_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE SHR94_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL76
JMP ROR10
VAL76:
CMP AL,1
JNE ERROR_LOOP 
ROR10:
MOV CL,AH
ROR DH,CL
MOV AX,DX
JMP ENDLOOP

SHR94_LOOP:  
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET SHL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP
MOV SI,OFFSET OUTDATA+7 
MOV DI,OFFSET CL1
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JNE VAL11
JMP SHR11
VAL11:
CMP AL,1
JNE ERROR_LOOP 
SHR11:
MOV CL,AH
SHR DH,CL
MOV AX,DX
JMP ENDLOOP
;----------------------------------END OF AH-AH OPERATIONSS----------------------------------------;   
;----------------------------------BEGIN OF ONE OPERAND 1BYTE OPERATIONSS----------------------------------------;
OP6_LOOP: 
MUL8_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MUL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE INC8_LOOP
MUL AL
CMP PLAYER,2
JNE RTY
PUSHF
DIVSTEPBYSTEP AX1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
JMP RTYY
RTY:
PUSHF
DIVSTEPBYSTEP AX2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
RTYY:
JMP ENDLOOP1

INC8_LOOP: 
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET INC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE DEC8_LOOP 
INC AL
JMP ENDLOOP

DEC8_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET DEC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP 
DEC AL
JMP ENDLOOP 



;----------------------------------END OF ONE OPERAND 1BYTE OPERATIONSS----------------------------------------;
;----------------------------------BEGIN OF ONE OPERAND 1BYTE OPERATIONSS----------------------------------------;
OP7_LOOP: 
MUL999_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET MUL_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE INC999_LOOP
MUL AH
CMP PLAYER,2
JNE RTB
PUSHF
DIVSTEPBYSTEP AX1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
JMP RTBB
RTB:
PUSHF
DIVSTEPBYSTEP AX2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
RTBB:
JMP ENDLOOP1

INC999_LOOP: 
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET INC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE DEC999_LOOP 
INC AH
JMP ENDLOOP

DEC999_LOOP:
MOV SI,OFFSET OUTDATA
MOV DI,OFFSET DEC_OP
MOV CX, 4H
REPE CMPSB
CMP CX,0 
JNE ERROR_LOOP 
DEC AH
JMP ENDLOOP 



;----------------------------------END OF ONE OPERAND 1BYTE OPERATIONSS----------------------------------------;
   


ALLOOP:
CMP PLAYER,2
JNE P8                                                                                                 
MOV AX,0H 
INPUT AX1_REG+2
ROL AX,4
INPUT AX1_REG+3
ROL AX,4
INPUT AX1_REG+4
ROL AX,4
INPUT AX1_REG+5
JMP P88
P8:
MOV AX,0H 
INPUT AX2_REG+2
ROL AX,4
INPUT AX2_REG+3
ROL AX,4
INPUT AX2_REG+4
ROL AX,4
INPUT AX2_REG+5
P88:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,7 
;push cx
MOV TEMP2,7
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP6_LOOP
ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL8LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH8LOOP  

value12_loop:
MOV SI, OFFSET OUTDATA+7
;mov di,7h
;pop bx
;pop cx
MOV CH,TEMP
;push bx
cmp ch,9d
ja ERROR_LOOP
sub ch,7
MOV AX,0H


value2:
cmp byte ptr [si],30H
jb ERROR_LOOP
cmp byte ptr [si],39h
jb done11
cmp byte ptr [si],61h
jb ERROR_LOOP
cmp byte ptr [si],66h
ja ERROR_LOOP
JMP DONE22
done11: 
SUB BYTE PTR[SI],30H
MOV CL,[SI]
inc si
;inc di
dec ch
cmp ch,0
je finish2
ADD AL,CL
ROL AX,4
jmp value2
finish2:
ADD AL,CL
JMP OP2_LOOP         
DONE22:        
SUB BYTE PTR[SI],57H
MOV CL,[SI]
inc si
;inc di
dec ch
cmp ch,0
je finish2
ADD AL,CL
ROL AX,4
jmp value2


AL8LOOP:
MOV CL,2
JMP ALLOOP

AH8LOOP: 
MOV CL,3
JMP AHLOOP

BL8LOOP: 
MOV CL,2
JMP BLLOOP


BH8LOOP: 
MOV CL,3
JMP BHLOOP

CL8LOOP: 
MOV CL,2
JMP CLLOOP


CH8LOOP: 
MOV CL,3
JMP CHLOOP


DL8LOOP: 
MOV CL,2
JMP DLLOOP

DH8LOOP: 
MOV CL,3
JMP DHLOOP




;-----------------------------------------------------------------------------------------------
AHLOOP:  
CMP PLAYER,2
JNE P9
MOV AX,0H 
INPUT AX1_REG+2
ROL AX,4
INPUT AX1_REG+3
ROL AX,4
INPUT AX1_REG+4
ROL AX,4
INPUT AX1_REG+5
JMP P99
P9: 
 MOV AX,0H 
INPUT AX2_REG+2
ROL AX,4
INPUT AX2_REG+3
ROL AX,4
INPUT AX2_REG+4
ROL AX,4
INPUT AX2_REG+5
P99:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,8 
;push cx
MOV TEMP2,8
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP7_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL9LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH9LOOP   

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI8LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI8LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX8LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM8LOOP

 

value13_loop:
MOV SI, OFFSET OUTDATA+7
;mov di,7h
;pop bx
;pop cx
MOV CH,TEMP
;push bx
cmp ch,9d
ja ERROR_LOOP
sub ch,7
MOV AX,0H


value3:
cmp byte ptr [si],30H
jb ERROR_LOOP
cmp byte ptr [si],39h
jb done3
cmp byte ptr [si],61h
jb ERROR_LOOP
cmp byte ptr [si],66h
ja ERROR_LOOP
JMP DONE23
done3: 
SUB BYTE PTR[SI],30H
MOV CL,[SI]
inc si
;inc di
dec ch
cmp ch,0
je finish3
ADD AL,CL
ROL AX,4
jmp value
finish3:
ADD AL,CL
JMP OP4_LOOP         
DONE23:        
SUB BYTE PTR[SI],57H
MOV CL,[SI]
inc si
;inc di
dec ch
cmp ch,0
je finish3
ADD AL,CL
ROL AX,4
jmp value3  

OFFBX8LOOP: 
MOV CL,4
JMP OFFBXLOOP   

OFFSI8LOOP: 
MOV CL,4
JMP OFFSILOOP    

OFFDI8LOOP: 
MOV CL,4
JMP OFFDILOOP           

OFFNUM8LOOP: 
MOV CL,4
JMP OFFNUMLOOP


AL9LOOP:
MOV CL,4     ;AH,AL
JMP ALLOOP

AH9LOOP: 
MOV CL,5    ;AH,AH
JMP AHLOOP


BL9LOOP: 
MOV CL,4  ;AH,AL
JMP BLLOOP

BH9LOOP: 
MOV CL,5
JMP BHLOOP

CL9LOOP: 
MOV CL,4
JMP CLLOOP


CH9LOOP: 
MOV CL,5
JMP CHLOOP

DL9LOOP: 
MOV CL,4
JMP DLLOOP


DH9LOOP: 
MOV CL,5
JMP DHLOOP
  

;-----------------------------------------------------------------------------------------------------
BLLOOP:
CMP PLAYER,2
JNE P10 
MOV AX,0H 
INPUT BX1_REG+2
ROL AX,4
INPUT BX1_REG+3
ROL AX,4
INPUT BX1_REG+4
ROL AX,4
INPUT BX1_REG+5
JMP P100
P10: 
MOV AX,0H 
INPUT BX2_REG+2
ROL AX,4
INPUT BX2_REG+3
ROL AX,4
INPUT BX2_REG+4
ROL AX,4
INPUT BX2_REG+5
P100:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,9
;push cx
MOV TEMP2,9
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP6_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL10LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH10LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI10LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI10LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX10LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM10LOOP

JMP value12_loop

OFFBX10LOOP: 
MOV CL,2
JMP OFFBXLOOP   

OFFSI10LOOP: 
MOV CL,2
JMP OFFSILOOP    

OFFDI10LOOP: 
MOV CL,2
JMP OFFDILOOP           

OFFNUM10LOOP: 
MOV CL,2
JMP OFFNUMLOOP 

AL10LOOP: 
MOV CL,2
JMP ALLOOP


AH10LOOP: 
MOV CL,3
JMP AHLOOP



BL10LOOP: 
MOV CL,2
JMP BLLOOP


BH10LOOP: 
MOV CL,3
JMP BHLOOP

CL10LOOP: 
MOV CL,2
JMP CLLOOP


CH10LOOP: 
MOV CL,3
JMP CHLOOP

DL10LOOP: 
MOV CL,2
JMP DLLOOP


DH10LOOP: 
MOV CL,3
JMP DHLOOP



;-----------------------------------------------------------------------------------------------
BHLOOP:
CMP PLAYER,2
JNE P16 
MOV AX,0H 
INPUT BX1_REG+2
ROL AX,4
INPUT BX1_REG+3
ROL AX,4
INPUT BX1_REG+4
ROL AX,4
INPUT BX1_REG+5
JMP P166
P16: 
MOV AX,0H 
INPUT BX2_REG+2
ROL AX,4
INPUT BX2_REG+3
ROL AX,4
INPUT BX2_REG+4
ROL AX,4
INPUT BX2_REG+5
P166:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
MOV CH,10d
;push cx
MOV TEMP2,10D
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP7_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL11LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH11LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL11LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH11LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL11LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH11LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL11LOOP 

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH11LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI11LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI11LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX11LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM11LOOP

JMP value13_loop

OFFBX11LOOP: 
MOV CL,4
JMP OFFBXLOOP   

OFFSI11LOOP: 
MOV CL,4
JMP OFFSILOOP    

OFFDI11LOOP: 
MOV CL,4
JMP OFFDILOOP           

OFFNUM11LOOP: 
MOV CL,4
JMP OFFNUMLOOP 

AL11LOOP:
MOV CL,4
JMP ALLOOP 


AH11LOOP: 
MOV CL,5
JMP AHLOOP  



BL11LOOP: 
MOV CL,4
JMP BLLOOP

BH11LOOP: 
MOV CL,5
JMP BHLOOP

CL11LOOP: 
MOV CL,4
JMP CLLOOP


CH11LOOP: 
MOV CL,5
JMP CHLOOP   


DL11LOOP: 
MOV CL,4
JMP DLLOOP


DH11LOOP: 
MOV CL,5
JMP DHLOOP

;-----------------------------------------------------------------------------------------------
CLLOOP:
CMP PLAYER,2
JNE P17 
MOV AX,0H 
INPUT CX1_REG+2
ROL AX,4
INPUT CX1_REG+3
ROL AX,4
INPUT CX1_REG+4
ROL AX,4
INPUT CX1_REG+5 
JMP P177
P17:  
MOV AX,0H 
INPUT CX2_REG+2
ROL AX,4
INPUT CX2_REG+3
ROL AX,4
INPUT CX2_REG+4
ROL AX,4
INPUT CX2_REG+5 
P177:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,11d
;push cx
MOV TEMP2,11D
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP6_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL12LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH12LOOP 


MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI12LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI12LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX12LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM12LOOP


JMP value12_loop

OFFBX12LOOP: 
MOV CL,2
JMP OFFBXLOOP   

OFFSI12LOOP: 
MOV CL,2
JMP OFFSILOOP    

OFFDI12LOOP: 
MOV CL,2
JMP OFFDILOOP           

OFFNUM12LOOP: 
MOV CL,2
JMP OFFNUMLOOP 


AL12LOOP: 
MOV CL,2
JMP ALLOOP 


AH12LOOP: 
MOV CL,3
JMP AHLOOP  



BL12LOOP: 
MOV CL,2
JMP BLLOOP


BH12LOOP: 
MOV CL,3
JMP BHLOOP

CL12LOOP: 
MOV CL,2
JMP CLLOOP


CH12LOOP: 
MOV CL,3
JMP CHLOOP


DL12LOOP: 
MOV CL,2
JMP DLLOOP


DH12LOOP: 
MOV CL,3
JMP DHLOOP

;-----------------------------------------------------------------------------------------------
CHLOOP:
CMP PLAYER,2
JNE P18 
MOV AX,0H 
INPUT CX1_REG+2
ROL AX,4
INPUT CX1_REG+3
ROL AX,4
INPUT CX1_REG+4
ROL AX,4
INPUT CX1_REG+5
JMP P188
P18:
MOV AX,0H 
INPUT CX2_REG+2
ROL AX,4
INPUT CX2_REG+3
ROL AX,4
INPUT CX2_REG+4
ROL AX,4
INPUT CX2_REG+5
P188:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP  
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,12d
;push cx
MOV TEMP2,12D
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP7_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL13LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH13LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI13LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI13LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX13LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM13LOOP
JMP value13_loop

OFFBX13LOOP: 
MOV CL,4
JMP OFFBXLOOP   

OFFSI13LOOP: 
MOV CL,4
JMP OFFSILOOP    

OFFDI13LOOP: 
MOV CL,4
JMP OFFDILOOP           

OFFNUM13LOOP: 
MOV CL,4
JMP OFFNUMLOOP 

AL13LOOP:  
MOV CL,4
JMP ALLOOP

AH13LOOP: 
MOV CL,5
JMP AHLOOP



BL13LOOP: 
MOV CL,4
JMP BLLOOP


BH13LOOP: 
MOV CL,5
JMP BHLOOP 

CL13LOOP: 
MOV CL,4
JMP CLLOOP


CH13LOOP: 
MOV CL,5
JMP CHLOOP 


DL13LOOP: 
MOV CL,4
JMP DLLOOP


DH13LOOP: 
MOV CL,5
JMP DHLOOP


;-----------------------------------------------------------------------------------------------
DLLOOP:
CMP PLAYER,2
JNE P19 
MOV AX,0H 
INPUT DX1_REG+2
ROL AX,4
INPUT DX1_REG+3
ROL AX,4
INPUT DX1_REG+4
ROL AX,4
INPUT DX1_REG+5
JMP P199
P19: 
MOV AX,0H 
INPUT DX2_REG+2
ROL AX,4
INPUT DX2_REG+3
ROL AX,4
INPUT DX2_REG+4
ROL AX,4
INPUT DX2_REG+5
P199:
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,13d
;push cx
MOV TEMP2,13D 
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP6_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL14LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH14LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI14LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI14LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX14LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM14LOOP

JMP value12_loop

OFFBX14LOOP: 
MOV CL,2
JMP OFFBXLOOP   

OFFSI14LOOP: 
MOV CL,2
JMP OFFSILOOP    

OFFDI14LOOP: 
MOV CL,2
JMP OFFDILOOP           

OFFNUM14LOOP: 
MOV CL,2
JMP OFFNUMLOOP 

AL14LOOP: 
MOV CL,2
JMP ALLOOP 


AH14LOOP:  
MOV CL,3
JMP AHLOOP



BL14LOOP: 
MOV CL,2
JMP BLLOOP


BH14LOOP: 
MOV CL,3
JMP BHLOOP

CL14LOOP: 
MOV CL,2
JMP CLLOOP


CH14LOOP: 
MOV CL,3
JMP CHLOOP


DL14LOOP: 
MOV CL,2
JMP DLLOOP


DH14LOOP: 
MOV CL,3
JMP DHLOOP

;-----------------------------------------------------------------------------------------------
DHLOOP:
CMP PLAYER,2
JNE P20 
MOV AX,0H 
INPUT DX1_REG+2
ROL AX,4
INPUT DX1_REG+3
ROL AX,4
INPUT DX1_REG+4
ROL AX,4
INPUT DX1_REG+5
JMP P200
P20:   
MOV AX,0H 
INPUT DX2_REG+2
ROL AX,4
INPUT DX2_REG+3
ROL AX,4
INPUT DX2_REG+4
ROL AX,4
INPUT DX2_REG+5
P200: 
CMP CL,2
JE OP2_LOOP
CMP CL,3
JE OP3_LOOP
CMP CL,4
JE OP4_LOOP
CMP CL,5
JE OP5_LOOP
;MOV CH,14d
;push cx
MOV TEMP2,14D
MOV DX,AX 
;HNA 27NA ALREADY 3ARFEEN EN DH AX FAH NA5OD MENO ELVARIABLE FIH ELAWL WE N7OTO FIH TEM REG
;ADD SI,1 

CMP BYTE PTR [SI],0H
JE  OP7_LOOP
;ADD SI,1

MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AL15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET AH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE AH15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BL15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET BH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE BH15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CL15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET CH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE CH15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DL1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DL15LOOP 


MOV SI,OFFSET OUTDATA+7
MOV DI,OFFSET DH1 ;mov di,offset ax1 isntead in all 
MOV CX, 3H
REPE CMPSB
CMP CX,0 
JE DH15LOOP 

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFSI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFSI15LOOP  

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFDI
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFDI15LOOP

MOV SI, OFFSET OUTDATA+7
MOV DI,OFFSET OFFBX
MOV CX, 5H
REPE CMPSB
CMP CX,0 
JE OFFBX15LOOP 

MOV AL, OUTDATA+7
CMP AL,'['
JE OFFNUM15LOOP

JMP value13_loop

OFFBX15LOOP: 
MOV CL,4
JMP OFFBXLOOP   

OFFSI15LOOP: 
MOV CL,4
JMP OFFSILOOP    

OFFDI15LOOP: 
MOV CL,4
JMP OFFDILOOP           

OFFNUM15LOOP: 
MOV CL,4
JMP OFFNUMLOOP 

AL15LOOP: 
MOV CL,4
JMP ALLOOP  


AH15LOOP: 
MOV CL,5
JMP AHLOOP



BL15LOOP: 
MOV CL,4
JMP BLLOOP


BH15LOOP: 
MOV CL,5
JMP BHLOOP 

CL15LOOP: 
MOV CL,4
JMP CLLOOP


CH15LOOP: 
MOV CL,5
JMP CHLOOP


DL15LOOP: 
MOV CL,4
JMP DLLOOP


DH15LOOP: 
MOV CL,5
JMP DHLOOP     



;-----------------------------------------------------------------------------------------------

CLCLOOP: 
MOV CF1_FLAG,0H
CLC
JMP ENDLOOP


ENDLOOP:
cmp ax,105eh
jne continuee
mov WINNER_FLAG,1
jmp ldone
continuee:
CMP TEMP2,0
JE AXX 
CMP TEMP2,1
JE BXX 
CMP TEMP2,2
JE CXX 
CMP TEMP2,3
JE DXX  
CMP TEMP2,4
JE SII
CMP TEMP2,5
JE DII   
CMP TEMP2,6
JE BPP 
CMP TEMP2,7
JE AXX
CMP TEMP2,8
JE AXX
CMP TEMP2,9
JE BXX
CMP TEMP2,10d
JE BXX
CMP TEMP2,11d
JE CXX 
CMP TEMP2,12d
JE CXX
CMP TEMP2,13d
JE DXX
CMP TEMP2,14d
JE DXX 
CMP TEMP2,15D
JE DSS


AXX:
CMP PLAYER,2
JNE AXX1
PUSHF
DIVSTEPBYSTEP AX1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
jmp ENDLOOP1
AXX1:
PUSHF
DIVSTEPBYSTEP AX2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
jmp ENDLOOP1
BXX:
CMP PLAYER,2
JNE BXX1
PUSHF
DIVSTEPBYSTEP BX1_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
jmp ENDLOOP1
BXX1:
PUSHF
DIVSTEPBYSTEP BX2_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
jmp ENDLOOP1
CXX:
CMP PLAYER,2
JNE CXX1
PUSHF 
DIVSTEPBYSTEP CX1_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
JMP ENDLOOP1
CXX1:   
PUSHF
DIVSTEPBYSTEP CX2_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
jmp ENDLOOP1
DXX:
CMP PLAYER,2
JNE DXX1     
PUSHF
DIVSTEPBYSTEP DX1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
JMP ENDLOOP1
DXX1:
PUSHF
DIVSTEPBYSTEP DX2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
jmp ENDLOOP1
SII:
CMP PLAYER,2
JNE SII1   
PUSHF
DIVSTEPBYSTEP SI1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
jmp ENDLOOP1 
SII1:
PUSHF
DIVSTEPBYSTEP SI2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
jmp ENDLOOP1 
DII:
CMP PLAYER,2
JNE DII1     
PUSHF
DIVSTEPBYSTEP DI1_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al
jmp ENDLOOP1
DII1: 
PUSHF
DIVSTEPBYSTEP DI2_REG
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
jmp ENDLOOP1
BPP:
CMP PLAYER,2
JNE BPP1     
PUSHF
DIVSTEPBYSTEP BP1_REG
 POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF1_FLAG,al  
jmp ENDLOOP1
BPP1:
PUSHF
DIVSTEPBYSTEP BP2_REG 
POPF ;FOR FLAGS
rcr ax,1
shr ax,15d
mov CF2_FLAG,al
DSS:
cmp player,2
jne dss2
MOV SI,OFFSET DS1_SEG
dec bl
MOV byte ptr[SI+BX],Dl 
inc bl
;inc si
CMP OUTDATA+10D,'X'
jne ENDLOOP1
MOV byte ptr[SI+BX],Dh 
JMP ENDLOOP1

DSS2:
MOV SI,OFFSET DS2_SEG
dec bl
MOV byte ptr[SI+BX],Dl 
inc bl
;inc si
CMP OUTDATA+10D,'X'
jne ENDLOOP1
MOV byte ptr[SI+BX],Dh 
JMP ENDLOOP1

ERROR_LOOP:
CMP A_PLAYER,1
JNE DECPLAY2
DEC PTS1
JMP ENDLOOP1
DECPLAY2: DEC PTS2 

ENDLOOP1: 
cmp POWER_UP,2
jne cont2
mov POWER_UP,0
cmp player,2
jne makeplay22
mov player,1
jmp cont
makeplay22:
mov player,2
jmp cont
cont2:
cmp A_player,2
jne makeplay2
mov player,1
mov A_player,1
jmp ldone
makeplay2: 
mov A_player,2
mov player,2

ldone:

ret
logicfn endp

forbd_char_print proc


mov  dl, 16   ;Column
mov  dh, 19    ;Row
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset FORBIDDEN2_CHAR+2
int 21h 

mov  dl, 25h   ;Column
mov  dh, 19   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h

mov  dl, 25h   ;Column
mov  dh, 19   ;Row
mov  bh, 0    ;Display page
mov  ah, 02h  ;SetCursorPosition
int  10h

mov ah,09h
mov dx,offset FORBIDDEN1_CHAR+2
int 21h

ret
forbd_char_print endp

powerups proc

;-----------------------------------------POWER_UP1-----------------------------;
cmp POWER_UP,2
je EXITLOOP
cmp INDATA+2,31H  ;power up 1 user changes values of his own register
jne p_up2
cmp A_player,2
jne p2loop
CMP PTS2,5
JBE FINLOOP
SUB PTS2, 5               ; stiLl need to check ther power up at the end
jmp cont1
p2loop: 
CMP PTS1,5
JBE FINLOOP
sub PTS1,5
cont1: 
MOV POWER_UP,1
cmp a_player,1
jne p_up1_player2
mov player,2
jmp EXITLOOP
p_up1_player2: 
mov player,1
JMP EXITLOOP
;------------------------------------POWER_UP1-------------------------;
;-----------------------------------POWER_UP2---------------------------;
p_up2: 
CMP INDATA+2,32H  ; POWER UP 2 EXECUTING THE SAME COMMAND ON BOTH REGS
JNE P_UP3 
cmp A_player,2 
jne p22loop
CMP PTS2,3
JBE FINLOOP
sub PTS2,3
JMP P_UP_3
p22loop:
CMP PTS1,3
JBE FINLOOP 
sub PTS1,3
P_UP_3: 
MOV POWER_UP,2
JMP EXITLOOP
;--------------------------------POWER_UP3--------------------------------;
P_UP3:
cleardata11:
mov byte ptr[si],'$'
dec ch
inc si
cmp ch,0
jne cleardata11  

;TO CLEAR COMMAND
mov ah,2          ;Move Cursor 
mov dh, 17     ;X,Y Position   
mov dl,1
int 10h  
 
MOV AH,09
MOV BH,00
MOV AL,'8'
MOV CX,0BH
MOV BL,00H
INT 10H

CMP INDATA+2,33H  ;POWER UP 3 CHANGING FORBIDDEN CHAR ONLY ONCE
JNE P_UP4
cmp A_player,2 
jne p23loop
CMP FLAG_CHANGED2,0
JNE EXITLOOP
CMP PTS2,8
JBE FINLOOP
sub PTS2,8
MOV POWER_UP,3
;SET CURSOR POSITION
 
 mov ah,02
 mov dx,1B02H
 INT 10h

MOV AH,0AH
MOV DX,OFFSET FORBIDDEN1_CHAR
INT 21H
MOV BX,OFFSET FORBIDDEN1_CHAR+2
CONVERT
mov FORBIDDEN1_CHAR+2,AL
mov flag_changed2,1  
call forbd_char_print                                                                                                                                                                                                                      
JMP EXITLOOP


p23loop:
CMP FLAG_CHANGED1,0
jne EXITLOOP
CMP PTS1,8
JBE FINLOOP
sub PTS1,8
;SET CURSOR POSITION

MOV AH,0AH
MOV DX,OFFSET FORBIDDEN2_CHAR
INT 21H
MOV BX,OFFSET FORBIDDEN2_CHAR+2
CONVERT
mov FORBIDDEN2_CHAR+2,al
MOV FLAG_CHANGED1,1
mov cl,level+2
cmp cl,31h
jne EXITLOOP
call forbd_char_print
JMP EXITLOOP

;--------------------------------POWER_UP4---------------------------------;
P_UP4:
cmp A_player,2
jne p2loop1
cmp FLAG_CHANGED22,1
je EXITLOOP
CMP PTS2,30
JB FINLOOP
SUB PTS2, 30 
mov FLAG_CHANGED22,1              ; stiLl need to check ther power up at the end
jmp CLEARREG
p2loop1:
cmp FLAG_CHANGED11,1
je EXITLOOP
CMP PTS1,30H
JB EXITLOOP
sub PTS1, 30H
mov FLAG_CHANGED11,1 


CLEARREG:
mov ax,0000
DIVSTEPBYSTEP AX1_REG
mov ax,0000
DIVSTEPBYSTEP BX1_REG
mov ax,0000
DIVSTEPBYSTEP CX1_REG
mov ax,0000
DIVSTEPBYSTEP DX1_REG
mov ax,0000
DIVSTEPBYSTEP SI1_REG
mov ax,0000
DIVSTEPBYSTEP DI1_REG
mov ax,0000
DIVSTEPBYSTEP BP1_REG
mov ax,0000
DIVSTEPBYSTEP AX2_REG
mov ax,0000
DIVSTEPBYSTEP BX2_REG
mov ax,0000
DIVSTEPBYSTEP CX2_REG
mov ax,0000
DIVSTEPBYSTEP DX2_REG
mov ax,0000
DIVSTEPBYSTEP SI2_REG
mov ax,0000
DIVSTEPBYSTEP DI2_REG
mov ax,0000
DIVSTEPBYSTEP BP2_REG
call printingreg
jmp EXITLOOP
FINLOOP:
CMP A_player,1
JE DELLOOP
mov PTS2,0
JMP EXITLOOP
DELLOOP:
mov PTS1,0
EXITLOOP:
ret
powerups endp

WINNERfn PROC
CMP WINNER_FLAG, 1
JNE CHECKPOINT
mov cl,A_player
MOV WINNER, CL
JMP EXITTT
CHECKPOINT:
CMP PTS1, 0
JE LOSE1
CMP PTS2, 0
JE LOSE2
JMP EXITTT
LOSE1: 
MOV WINNER_FLAG, 1
MOV WINNER, 2
JMP EXITTT
LOSE2: 
MOV WINNER_FLAG, 1
MOV WINNER, 1
EXITTT:
ret
WINNERfn endp
END MAIN


