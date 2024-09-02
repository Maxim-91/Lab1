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
String_CAPTION                DB    "��������� 1 ������� ��������� ������ - �������� �.�.",0
String_SHABLON                DB     "���������� ������ �� �� �  = %d,  ������= %d. ���������: ���� ������� = %d, ������� ������� = %d. �������� �� � �������, ������ ������� ���� ������� �� ������ ���������� �� � �������. ���������: ���� ������� = %d �� ������� ������� = %d",0
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
             MOV   X   ,   ESI   ;���������� ������ �� �� �
             MOV      Y ,  7     ;����� �����
             MOV      Z ,  0     ;���� �������
             MOV      W ,  0     ;�������
             MOV      Q ,  12    ;� �������
             MOV      A ,  9     ;������� ���� �������
             MOV      E ,  0     ;���� ������� ���� �������� ��������� � ������ �����
             MOV      R ,  0     ;������� ������� ���� �������� ��������� � ������ �����             
             ;-------------- DIV 
             MOV EDX,0  ;��������� ���
             MOV EAX, X ;�������� ���
             MOV EBX, Y ;�������� ���
             DIV EBX ; ������� ��������� EAX � EBX ��������� ���������� EAX
             MOV ESI, EAX 
             MOV Z ,  ESI     ;���� ������� 
             MOV W ,  EDX     ;������� 
             ;------------- MUL
             MOV EDX, 0 ;��������� ���
             MOV EAX, Z ;�������� ���
             MOV EBX, Q ;�������� ���
             MUL EBX ; ��������� ��������� EAX � EBX ��������� ���������� EAX
             MOV EDI, EAX ; �������� ���������� �� EAX � EDI
             MOV E, EDI 
             ;------------- ADD
             MOV EAX, A
             ADD EDI, EAX
             MOV E, EDI
             ;-------------- DIV 
             MOV EDX,0  ;��������� ���
             MOV EAX, E ;�������� ���
             MOV EBX, Q ;�������� ���
             DIV EBX ; ������� ��������� EAX � EBX ��������� ���������� EAX
             MOV ESI, EAX 
             MOV E ,  ESI     ;���� ������� 
             MOV R ,  EDX     ;�������	
       ;------------------------------------------------------------------
      invoke   wsprintf    ,\
      		   addr      String_CONTENER  ,\    ; �����
      		   addr      String_SHABLON    , \   ; ������
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