    .data
      .text
main:    
    
    .macro E
    li    $v0, 33
    la    $a0 ,64
    la    $a1, 1000
    la    $a2, 0
    la    $a3, 100
    syscall
    .end_macro
    
    .macro pause
    li    $v0, 32
    la    $a0 ,1000
    syscall
    .end_macro
    
    .macro G
    li    $v0, 33
    la    $a0 ,67
    la    $a1, 1000
    la    $a2, 0
    la    $a3, 100
    syscall
    .end_macro
    
    .macro C
    li    $v0, 33
    la    $a0 ,60
    la    $a1, 1000
    la    $a2, 0
    la    $a3, 100
    syscall
    .end_macro
    
    .macro D
    li    $v0, 33
    la    $a0 ,62
    la    $a1, 1000
    la    $a2, 0
    la    $a3, 100
    syscall
    .end_macro
    E
    E
    E
    pause
    E
    E
    E
    pause
    E
    G
    C
    D
    E