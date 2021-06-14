.data 
menu:       .asciiz "\n1. Malloc CharPtr.\n2. Malloc BytePtr.\n3. Malloc WordPtr.\n4. Malloc2 .\n5. Copy 2 con tro xau ki tu.\n6. Tinh toan luong bo nho da cap phat cho cac bien dong (malloc).\n7. Set Array[i][j].\n8. Get Array[i][j].\nThoat neu khac 1-8"
message: .asciiz "\nnhap vao ki tu: "
message1: .asciiz "\nDia chi cua bien la:\n"
message2: .asciiz "\nTong bo nho da cap phat: \n"
message3: .asciiz "\ngia tri cua cac bien con tro:\n"
char_message: .asciiz "\nNhap ki tu"
int_message: .asciiz "\nNhap so nguyen:"
int_message1: .asciiz "\nNhap so luong phan tu"
input_val:  .asciiz "\nNhap gia tri gan cho phan tu cua mang: "
enter:	.asciiz "\n"
bound_error:    .asciiz "\nError: Ngoai vung bo nho cho phep cua mang"
null_error: .asciiz "\nError: Chua khoi tao mang"
output_val: .asciiz "\nGia tri tra ve: "
nb_row:     .asciiz "\nNhap so hang cua mang: "
nb_col:     .asciiz "\nNhap so cot cua mang: "
input_row:  .asciiz "\nNhap i (so thu tu cua dong): "
input_col:  .asciiz "\nNhap j (so thu tu cua cot): "
row:        .word 1 
col:        .word 1
CharPtr: .word 0 # bien con tro, tro toi kieu asciiz
BytePtr: .word 0 # bien con tro, tro toi kieu Byte
WordPtr: .word 0 # bien con tro, tro toi mang kieu word
Arr_wordPtr: .word 0 # bien con tro, tro toi mang 2 chieu kieu word
CharPtr1:   .word 0     # Bien con tro, dung trong yeu cau copy xau
CharPtr2:   .word 0     # Bien con tro, dung trong yeu cau copy xau
input_str:  .asciiz "\nNhap vao mot xau ky tu: "
copy_str:   .asciiz "\nXau da duoc copy: "
string_copy:    .space  100             # Xau copy
input: .asciiz "\nnhap so luong phan tu muon cap phat"
.kdata
# Bien chua dia chi dau tien cua vung nho con trong
Sys_TheTopOfFree: .word 1
# Vung khong gian tu do, dung de cap bo nho cho cac bien con tro
Sys_MyFreeSpace: 

.text
	li $s5,0	#bien dem bo nho da cap phat
	jal SysInitMem
	nop

		
main:
    	switch:
    	la  $a0, menu
    	jal integer_input   # get integer input value from user
    	nop
	move    $s6, $a0    # switch option
	nop
	case1:
	bne $s6, 1, case2
	nop
	jal ex_CharPtr
    	nop
    	j switch
    	nop
    	case2:
    	bne $s6, 2, case3
    	nop
    	jal ex_BytePtr
    	nop
    	j switch
    	nop
    	case3:
    	bne $s6, 3, case4
    	nop
    	jal ex_WordPtr
    	nop
    	j switch
    	nop
    	case4:
    	bne $s6, 4, case5
    	nop
    	jal ex_WordArr
    	nop
    	j switch
    	nop
    	case5:
    	bne $s6, 5, case6
    	nop
    	jal copy_String
    	nop
    	j switch
    	case6:
    	bne $s6, 6, case7
	nop
	jal totalMemory
    	nop
    	j switch
    	nop
	case7:
	bne $s6, 7,case8
	nop
	jal ex_setArr
	nop
	j switch
	nop
	case8:
	bne $s6, 8, end
	nop
	jal ex_getArr 
	nop
	j switch
	nop
end:	li $v0, 10		# Call exit command
	syscall			# Exec 	
	
		
	#-----------------------
	#  Cap phat cho bien con tro, gom 10 phan tu,moi phan tu 1 byte
	#----------------------
ex_CharPtr:
	addi $t5,$ra,0 #luu dia chi cua $ra
	
	li $s7,0		#luu so luong phan tu muon cap phat
	la $a0,int_message1
	jal integer_input
	nop
	add $s7,$zero,$a0		#luu so phan tu cua mang vao $s7
	la $a0, CharPtr
	add $a1, $zero,$s7
	addi $a2, $zero,1
	mul $s0,$a1,$a2
	add $s5,$s5,$s0
	jal malloc
	nop
	la $a0,CharPtr
	jal input_char
	nop
	la $a0, CharPtr
	jal getaddressOfPtr
	nop
	la $a0, CharPtr
	jal getValueofPointerChar
	nop
	
	la $ra,($t5) #lay lai dia chi cua $ra
	jr $ra
	nop
	#-----------------------
	  #Cap phat cho bien con tro, gom 6 phan tu, moi phan tu 1 byte
	#-----------------------
ex_BytePtr:
	addi $t5,$ra,0 #luu dia chi cua $ra
	
	li $s7,0		#luu so luong phan tu muon cap phat
	la $a0,int_message1
	jal integer_input
	nop
	add $s7,$zero,$a0		#luu so phan tu cua mang vao $s7
	la   $a0, BytePtr
	add $a1, $zero,$s7		#$a1=$s7
	addi $a2, $zero,1		#$a2=1
	mul $s0,$a1,$a2			#s0=so bo nho da cap cho mang
	add $s5,$s5,$s0			#$s1 la tong bo nho da duoc cap phat
	jal  malloc
	nop
	la $a0, BytePtr
	jal getaddressOfPtr		#lay dia chi cua con tro
	nop
	la  $a0, BytePtr 
	jal input_byte			#nhap gia tri 
	nop
	la $a0,BytePtr
	jal getValueofPointerByte	#in ra cac gia tri 
	nop
	
	la $ra,($t5) #lay lai dia chi cua $ra
	jr $ra
	nop
	#-----------------------
	#  Cap phat cho bien con tro, gom 5 phan tu, moi phan tu 4 byte
	#-----------------------
ex_WordPtr:
	addi $t5,$ra,0 #luu dia chi cua $ra
	
	li $s7,0			#luu so luong phan tu muon cap phat
	la $a0,int_message1
	jal integer_input
	nop
	add $s7,$s7,$a0			#$s7 = $a0	
	la $a0,WordPtr				
	add $a1, $zero, $s7			
	addi $a2, $zero, 4
	mul $s0,$a1,$a2			#s0 = so bo nho da cap cho mang	
	add $s5,$s5,$s0			#s1 = tong bo nho da duoc cap phat
	jal  malloc
	nop
	la $a0, WordPtr
	jal  getaddressOfPtr		#lay dia chi cua con tro
	nop
	la $a0, WordPtr			
	jal input_word			#nhap gia tri cho mang
	nop
	la $a0,WordPtr
	jal getValueofPointerWord	#in ra gia tri cua mang
	nop
	
	la $ra,($t5) #lay lai dia chi cua $ra
	jr $ra
	nop
	#-----------------------
	#  Cap phat bo nho cho mang 2 chieu Malloc2
	#-----------------------
ex_WordArr:
	addi $t5,$ra,0 #luu dia chi cua $ra

	addiu   $sp, $sp, -4            # them 1 phan tu vao stack
   	la  $a0, nb_row     
   	jal     integer_input           # Nhap vao so hang
    	nop
    	move    $s0, $a0
    	la  $a0, nb_col
    	jal     integer_input          	 # Nhap vao so cot
    	nop
    	move    $a1, $s0           	 # malloc2 input_row parameter
    	move    $a2, $a0           	 # malloc2 input_col parameter
    	mul 	$s0,$a1,$a2
    	mul	$s0,$s0,4
    	add 	$s5,$s5,$s0
    	la  $a0, Arr_wordPtr
    	jal     malloc2             	# Cap phat bo nho
	nop
	jal getaddressOfPtr	#in ra gia tri cua mang
	nop
	
	la $ra,($t5) #lay lai dia chi cua $ra
	jr $ra
	nop
#----------------
#--------------------------------
#copy string 
#--------------------------------
copy_String:
	addi $t5,$ra,0 #luu dia chi cua $ra
	
	input_string:
    		li      $v0, 54                	 # InputDialogString
    		la      $a0, input_str          
    		la      $a1, string_copy        	# Dia chi luu string dung de copy
    		li  $a2, 100            	# So ki tu toi da co the doc duoc = 100
    		syscall
    		la      $a1, string_copy        	# Load lai 1 lan
    		la  $s2, CharPtr1           	# Load dia chi cua CharPtr1     
    		sw  $a1, 0($s2)             	# Luu string vua nhap vao CharPtr1
    		nop
	copy:
    		la  $a0, CharPtr2          	 # Load dia chi cua CharPtr2
    		la      $t9, Sys_TheTopOfFree 
    		lw      $t8, 0($t9)             	# Lay dia chi dau tien con trong
    		sw      $t8, 0($a0)                 # Cat dia chi do vao bien con tro CharPtr2
    		lw  $t4, 0($t9)                	 # Dem so luong ki tu trong string
    		lw  $t1, 0($s2)         	# Load gia tri con tro CharPtr1
    		lw  $t2, 0($a0)        	 # Load gia tri con tro CharPtr2
	copy_loop:
    		lb  $t3, ($t1)          	# Load 1 ki tu (tren cung) tai $t1 vao $t3
    		sb  $t3, ($t2)          	# Luu 1 ki tu cua $t3 vao o nho tai dia chi $t2
    		addi    $t4, $t4, 1         	# $t4 : dem so luong ki tu string
    		addi    $t1, $t1, 1         	# Chuyen sang dia chi ki tu tiep theo cua CharPtr1
    		addi    $t2, $t2, 1         	# Chuyen sang dia chi ki tu tiep theo cua CharPtr2
    		beq     $t3, '\n', exit_copy  	# Check null => end string
    		nop
    		j   copy_loop
    		nop
	exit_copy:
    		la  $a0, copy_str       
    		li  $v0, 4             	 # print string service
    		syscall
    		la  $a2, CharPtr2           	# Load dia chi CharPtr2 vao $a2
    		lw  $a0, ($a2)          	# Luu xau da copy tu $a0 vao CharPtr2
    		li  $v0, 4              	# In ra gia tri CharPtr2
    		syscall
    		la  $a0, enter
    		syscall
    		
    		la $ra,($t5) #lay lai dia chi cua $ra
		jr $ra
		nop
   	
#-----------------------------------------
# Set[i][j]
#------------------------------------------
ex_setArr:          
    		addi $t5,$ra,0 #luu dia chi cua $ra          
    
    		la  $a0, Arr_wordPtr
    		lw  $s7, 0($a0)
    		beqz    $s7, nullptr            # if *ArrayPtr==0 error null pointer
    		nop
  		la  $a0, input_row
    		jal     integer_input           # get row
    		nop
    		move    $s0, $a0
    		la  $a0, input_col
    		jal     integer_input           # get col
    		nop
    		move    $s1, $a0
    		la  $a0, input_val
    		jal     integer_input           # get val
    		nop
    		move    $a3, $a0
    		move    $a1, $s0
    		move    $a2, $s1
    		move    $a0, $s7
    		jal     SetArray
    		nop
    		
    		la $ra,($t5) #lay lai dia chi cua $ra
		jr $ra
		nop
#-----------------------------------------
ex_getArr:                   # Get[i][j]
		addi $t5,$ra,0 #luu dia chi cua $ra
		
   		la  $a0, Arr_wordPtr
    		lw  $s1, 0($a0)
    		beqz    $s1, nullptr            # if *ArrayPtr == 0 return error null pointer
    		nop
    		la  $a0, input_row
    		jal     integer_input           # get row
    		nop
    		move    $s0, $a0            # $s0 = so hang
    		la  $a0, input_col
    		jal     integer_input           # get col
    		nop
    		move    $a2, $a0            # $a2 = so cot
    		move    $a1, $s0            # $a1 = so hang
    		move    $a0, $s1            # $a0 = gia tri thanh ghi
    		jal     GetArray
    		nop
    		move    $s0, $v0            # save return value of GetArray
    		la  $a0, output_val
		li  $v0, 4
    		syscall
    		move    $a0, $s0
    		li  $v0, 1
    		syscall
    		
    		la $ra,($t5) #lay lai dia chi cua $ra
		jr $ra
		nop
    
    
#--------------------------
#in ra tong bo nho da cap phat la gia tri cua bien $s1
#--------------------------		
totalMemory: 
		addi $t5,$ra,0 #luu dia chi cua $ra
		
		li $v0,4			#service 4 : in ra 1 string
		la $a0,message2			#gan dia chi cua message 2 vao $a0
		syscall				#exec
		li $v0,1			#service 1 : in ra 1 gia tri kieu int
	     	la $a0,($s5)			#gán ??a chi $s1 vào $a0
	     	syscall				#exec
	     	li $v0,4			#service 4 : in ra 1 string
		la $a0,enter			#gan dia chi cua message 2 vao $a0
		syscall	
	     	
	     	la $ra,($t5) #lay lai dia chi cua $ra
		jr $ra
		nop    
	
#------------------------------------------
#  Ham khoi tao cho viec cap phat dong
#  @param    khong co
#  @detail   Danh dau vi tri bat dau cua vung nho co the cap phat duoc
#------------------------------------------
SysInitMem: la	$t9,Sys_TheTopOfFree	#Lay con tro chua dau tien con trong khoi tao
 	    la	$t7,Sys_MyFreeSpace	#Lay dia chi dau tien con trong, khoi tao
 	    sw	$t7,0($t9)		#Luu lai
 	    jr	$ra
 	    nop
#------------------------------------------
#  Ham cap phat bo nho dong cho cac bien con tro
#  @param  [in/out]   $a0   Chua dia chi cua bien con tro can cap phat
#                           Khi ham ket thuc, dia chi vung nho duoc cap phat se luu tru vao bien con tro
#  @param  [in]       $a1   So phan tu can cap phat
#  @param  [in]       $a2   Kich thuoc 1 phan tu, tinh theo byte
#  @return            $v0   Dia chi vung nho duoc cap phat
#-----------------------------------------
malloc:	la	$t9,Sys_TheTopOfFree
	lw	$t8, 0($t9)	#Lay dia chi dau tien con trong
	bne     $a2, 4, skip            # Neu khong phai kieu Word thi nhay sang skip
    	nop
    	addi    $t8, $t8, 3         
    	andi    $t8, $t8, 0xfffffffc        # gia tri luu tai $t8 luon la 1 so chia het cho 4
skip:    
	sw	$t8, 0($a0)	#Cat dia chi do vao bien con tro
	addi 	$v0, $t8, 0	#Dong thoi la ket qua tra ve cua ham
	mul	$t7, $a1, $a2	#Tinh kich thuoc cua mang can cap phat
	add	$t6, $t8, $t7	#Tinh dia chi dau tien con trong
	sw	$t6, 0($t9)	#Luu tro lai dia chi dau tien do vao bien Sys_TheTopOfFree
	jr	$ra
	nop 
#-----------------------------------------
malloc2: 
    	sw  $ra, 4($sp)             # push $ra
    	la  $s0, row
    	sw  $a1, 0($s0)         # luu so hang vao row
    	sw  $a2, 4($s0)         # luu so cot vao col
    	mul     $a1, $a1, $a2           # tra ve so phan tu cua Array
    	li  $a2, 4              # kich thuoc kieu Word = 4 bytes
    	jal     malloc
    	nop
    	lw  $ra, 4($sp)
    	addiu   $sp, $sp, 4           # pop $ra
    	jr  $ra
    nop
	   	   
#----------------------------------------- 
# Cac ham nhap gia tri cua bien con tro
#  @param  [in]   $a0   Chua dia chi cua bien con tro vua cap phat
#---------------------------------------
input_char: 		la $t1,($a0)
			la $a0,message
			lw $a1,($t1)
			li $a2,10
			li $v0, 54		# 54 = InputDialogString
			syscall			# Exec	
			jr $ra
#-------------------------------------------------------	
input_byte: 	
		la $t1,($a0)
		lw $t3,($t1)
		inputByte_loop:
			beqz $s7,exit		#if t2=0 thi nhay den exit2
			nop
			li $v0, 51			#service 51: InputDialogInt	
			la $a0, int_message		#gan dia chi cua int_message
			syscall				#exec
			blt $a0,-128,inputByte_loop	#if $a0<-128 thì nhap lai
			nop
			bgt $a0,127,inputByte_loop	#if $a0>127 thi nhap lai
			nop
			blt $a1,0,inputByte_loop
			nop
			sb $a0,($t3)
			addi $t3,$t3,1
			subi $s7,$s7,1
			j inputByte_loop
			nop
#-------------------------------------
input_word: 	
		la $t1,($a0)
		lw $t3,($t1)
		inputWord_loop:
			beqz $s7,exit		#if t2=0 thi nhay den exit2
			nop
			li $v0, 51			#service 51: InputDialogInt	
			la $a0, int_message		#gan dia chi cua int_message
			syscall				#exec
			blt $a0,-10000,inputWord_loop	#if $a0<-2147483648 thì nhap lai
			nop
			bgt $a0,10000,inputWord_loop	#if $a0>2147483647 thi nhap lai
			nop
			blt $a1,0,inputWord_loop
			nop
			sw $a0,($t3)
			addi $t3,$t3,4
			subi $s7,$s7,1
			j inputWord_loop
			nop
#-------------------------------------	
#--------------------------------------

#-------------------------------------
#Ham nhap so luong phan tu 
#--------------------------------------	
integer_input:
    	move    $t9, $a0
    	li  $v0, 51
    	syscall
    	beq     $a1, 0, exit
    	nop
    	beq 	$a1,-2,end
    	nop
    	move    $a0, $t9
    	j   integer_input
    	nop
#Lay gia tri cua con tro Char 	
#$a0 la chua dia chi cua bien con tro
#-----------------------------------	
getValueofPointerChar:
		addi $t3,$s0,0 			#lay gia tri bo nho da cap phat 
		la $t1,($a0)			#lay dia chi cua $a0 gan vao $t1
		lw $t2,($t1)			#$t2=$t1
		li $v0,4	
		la $a0,message3			#in ra message3: "gia tri cua cac bien con tro:\n"
		syscall
		loop:
			beqz $t3,exit 		#$t3=0 thi nhay toi exit1
			nop
			lb $a0,0($t2)		#nap cac gia tri vao bo nho da cap phat
			blt $a0,32,exit 	#loai bo cac phan tu rong 
			li $v0,11		#service 11: in ra 1 ki tu
			syscall			#exec
			addi $t2,$t2,1		#$t2=$t2+1
			subi $t3,$t3,1		#$t3=$t3-1
			li $v0,4		#service 4: in ra 1 string 
			la $a0,enter		#gan dia chi enter vao $a0
			syscall			#exec
			j loop
			nop
#-------------------------------------------------------------
#lay gia tri cua con tro word voi tham so truyen vao  
#Param [in]	$a0 chua dia chi bat dau mang
#-------------------------------------------------------------
getValueofPointerByte:
		addi $t3,$s0,0 			#lay gia tri bo nho da cap phat 
		la $t1,($a0)			#$a1 = address of input buffer
		lw $t2,($t1)			#luu gia tri thanh ghi t1 vao t2
		li $v0,4			#service 4: in ra 1 string 
		la $a0,message3			#gan dia chi message3 vao $a0
		syscall
		loop1:
			beqz $t3,exit		# $t3=0 thi nhay toi exit1
			lb $a0,0($t2) 		# nap $a0 vao thanh ghi $t2
			nop
			li $v0,1		#service 1: in ra ra 1 so kieu int
			syscall			#exec
			addi $t2,$t2,1		#$t2=$t2+1
			subi $t3,$t3,1		#$t3=$t3-1
			li $v0,4		#service 4: in ra 1 string 
			la $a0,enter		#gan dia chi enter vao $a0
			syscall			#exec
			j loop1			#nhay den nhan loop
			nop
	
#--------------------------
#-------------------------------------------------------------
#lay gia tri cua con tro byte voi tham so truyen vao  
#Param[in] 	$a0 chua dia chi bat dau mang
#-------------------------------------------------------------
getValueofPointerWord:
		div $s0,$s0,4
		addi $t3,$s0,0 			#lay gia tri bo nho da cap phat 
		la $t1,($a0)			#$a1 = address of input buffer
		lw $t2,($t1)			#luu gia tri thanh ghi t1 vao t2
		li $v0,4			#service 4: in ra 1 string 
		la $a0,message3			#gan dia chi message3 vao $a0
		syscall
		loop2:
			beqz $t3,exit 		# $t3=0 thi nhay toi exit1
			lw $a0,0($t2) 		# nap $a0 vao thanh ghi $t2
			nop
			li $v0,1		#service 1: in ra ra 1 so kieu int
			syscall			#exec
			addi $t2,$t2,4		#$t2=$t2+4
			subi $t3,$t3,1		#$t3=$t3-1
			li $v0,4		#service 4: in ra 1 string 
			la $a0,enter		#gan dia chi enter vao $a0
			syscall			#exec
			j loop2			#nhay den nhan loop
			nop
#------------------------
		

#-----------------------------
#in ra dia chi cua bien con tro	  
# param[in] $a0 chua dia chi cua bat dau mang
#-----------------------------   	
getaddressOfPtr: 	
		la $t1,($a0)	 		#lay vi tri cua con tro hien tai
		lw $t1,0($t1)	 		#gia tri cua $t1 la dia chi cua con tro can in	 	
		j showMessage
		printAddress:
			li $v0,34		#service 1 : in ra 1 gia tri kieu int
			la $a0,($t1)		#$a0=$t1
			syscall	 		#exec
			li $v0,4		# service 4 : in ra 1 string
			la $a0,enter		#gan dia chi enter vao $a0
			syscall			#exec
			jr $ra
			nop
		showMessage:	
			li $v0,4		# service 4 : in ra 1 string
			la $a0,message1 	# gan dia chi message1 vao $a0
			syscall
			j printAddress
			nop
#--------------------------------------------------------
# gan gia tri cua phan tu trong mang hai chieu
# @param [in] $a0 Chua dia chi bat dau mang
# @param [in] $a1 hang (i)  
# @param [in] $a2 cot (j)
# @param [in] $a3 gia tri gan
#--------------------------------------------------------
SetArray:
    la  $s0, row            # $s0 = dia chi so hang
    lw  $s1, 0($s0)             # $s1 so hang
    lw  $s2, 4($s0)             # $s2 so cot
    bge     $a1, $s1, bound_err         # Neu so cot vuot qua gioi han => error
    nop
    bge     $a2, $s2, bound_err         # Neu so hang vuot qua gioi han => error
    nop
    mul     $s0, $s2, $a1
    addu    $s0, $s0, $a2           # $s0 = i*col +j
    sll     $s0, $s0, 2			# $s0 = (i*col+j)*4
    addu    $s0, $s0, $a0           # $s0 = *array + (i*col +j)*4
    sw  $a3, 0($s0)
    jr  $ra
    nop

#------------------------------------------
# lay gia tri cua trong mang
# @param [in] $a0 Chua dia chi bat dau mang
# @param [in] $a1 hang (i)
# @param [in] $a2 cot (j)
# @return $v0 gia tri tai hang a1 cot a2 trong mang
#------------------------------------------
GetArray:
    la  $s0, row            # $s0 = dia chi so hang
    lw  $s1, 0($s0)             # $s1 so hang
    lw  $s2, 4($s0)             # $s2 so cot
    bge     $a1, $s1, bound_err         # Neu so cot vuot qua gioi han => error
    nop
    bge     $a2, $s2, bound_err         # Neu so hang vuot qua gioi han => error
    nop
    mul     $s0, $s2, $a1
    addu    $s0, $s0, $a2           # $s0= i*col +j
    sll     $s0, $s0, 2
    addu    $s0, $s0, $a0           # $s0 = *array + (i*col +j)*4
    lw  $v0, 0($s0)
    jr  $ra
    nop
bound_err:          # In ra thong bao loi chi so vuot ngoai pham vi
    la  $a0, bound_error
    j   error
    nop
nullptr:            # In ra thong bao loi con tro rong ( null)
    la  $a0, null_error
    j   error
    nop
error:  
    li  $v0, 4      # In ra thong bao loi
    syscall
    j   main
    nop
exit: jr $ra
	nop


		
