        .386
        .model flat,stdcall
  option   casemap:none
                        include D:\masm32\INCLUDE\WINDOWS.INC
                        include D:\masm32\INCLUDE\KERNEL32.INC 
                        include D:\masm32\INCLUDE\USER32.INC
                        include D:\masm32\INCLUDE\ADVAPI32.INC                                                  
                                                                     
                        includelib D:\masm32\lib\comctl32.lib
                        includelib D:\masm32\lib\user32.lib
                        includelib D:\masm32\lib\gdi32.lib
                        includelib D:\masm32\lib\kernel32.lib                
                        includelib D:\masm32\lib\user32.lib
                        includelib D:\masm32\lib\advapi32.lib                 
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;------------------------------------------------------------
.DATA
FOR_MUL                        DD                        100
FOR_DIV                          DWORD            6
HINST            DWORD       0
X       DD             ?
Y       DWORD          ?
Z       DWORD          ?
W       DWORD          ?
Q       DWORD          ?
A       DWORD          ?
E       DWORD          ?
R       DWORD          ?
String_CAPTION                DB    "Виконання 1 частини самостійної роботи - Котлубаєв М.Є.",0
String_SHABLON                DB     "Розширення екрану по осі у  = %d,  дільник= %d. Результат: ціла частина = %d, дробова частина = %d. Множенмо на № варіанту, додаємо кількості букв прізвища та діленмо результату на № варіанту. Результат: ціла частина = %d та дробова частина = %d",0
String_CONTENER               DB      256  dup (0)
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;---------------------------------------------------------------------------------------------------
.CODE
START:  
            invoke    GetSystemMetrics ,  SM_CXSCREEN
	    MOV    Edi  ,  EAX
	    invoke    GetSystemMetrics ,  SM_CYSCREEN
	    MOV   Esi  ,   EAX
             MOV   X   ,   ESI   ;розширення екрану по осі у
             MOV      Y ,  7     ;ПРИСВ ПЕРЕМ
             MOV      Z ,  0     ;ціла частина
             MOV      W ,  0     ;остаток
             MOV      Q ,  12    ;№ варіанту
             MOV      A ,  9     ;кількість букв прізвища
             MOV      E ,  0     ;ціла частина після множення додовання і ділення числа
             MOV      R ,  0     ;дробова частина після множення додовання і ділення числа             
             ;-------------- DIV 
             MOV EDX,0  ;ОБНУЛЕНИЕ РЕГ
             MOV EAX, X ;ЗНАЧЕНИЕ РЕГ
             MOV EBX, Y ;ЗНАЧЕНИЕ РЕГ
             DIV EBX ; ДЕЛЕНИЕ РЕГИСТРОВ EAX И EBX РУЗУЛЬТАТ ПЕРЕДАЕТСЯ EAX
             MOV ESI, EAX 
             MOV Z ,  ESI     ;ціла частина 
             MOV W ,  EDX     ;остаток 
             ;------------- MUL
             MOV EDX, 0 ;ОБНУЛЕНИЕ РЕГ
             MOV EAX, Z ;ЗНАЧЕНИЕ РЕГ
             MOV EBX, Q ;ЗНАЧЕНИЕ РЕГ
             MUL EBX ; УМНОЖЕНИЕ РЕГИСТРОВ EAX И EBX РУЗУЛЬТАТ ПЕРЕДАЕТСЯ EAX
             MOV EDI, EAX ; ПЕРЕДАЧА РЕЗУЛЬТАТА ИЗ EAX В EDI
             MOV E, EDI 
             ;------------- ADD
             MOV EAX, A
             ADD EDI, EAX
             MOV E, EDI
             ;-------------- DIV 
             MOV EDX,0  ;ОБНУЛЕНИЕ РЕГ
             MOV EAX, E ;ЗНАЧЕНИЕ РЕГ
             MOV EBX, Q ;ЗНАЧЕНИЕ РЕГ
             DIV EBX ; ДЕЛЕНИЕ РЕГИСТРОВ EAX И EBX РУЗУЛЬТАТ ПЕРЕДАЕТСЯ EAX
             MOV ESI, EAX 
             MOV E ,  ESI     ;ціла частина 
             MOV R ,  EDX     ;остаток	
       ;------------------------------------------------------------------
      invoke   wsprintf    ,\
      		   addr      String_CONTENER  ,\    ; БУФЕР
      		   addr      String_SHABLON    , \   ; ФОРМАТ
                   X   ,\     		   
                   Y   ,\
      		   Z   ,\
      		   W   ,\  
                   E   ,\
                   R	
        ;----------------------------------------------------------------- 
mov   EDI    ,  offset   String_CONTENER
  	mov  ESI     ,   offset   String_CAPTION
        
invoke   MessageBox   ,  0 , EDI  ,\
         				     			 ESI   ,\ 
         				    		      0    
          ;------------------------------------------------------
EXIT:     
             invoke               ExitProcess        ,       0
;++++++++++++++++++++++++++++++++++++++++++++
END  START