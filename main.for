      implicit real*8 (a-h,l-z)
      character*30 input_file, output_file
      integer*8 n, k, epb, lc, op_switcher, g
      

    
      allocatable
     > l_ma(:, :), l_mb(:, :),
     > ma(:, :), mb(:, :),
     > mc(:, :), ind(:, :, :, :)
      
      common 
     >/par/ n, k, epb, lc 
      
      
      print*, '1 for std'
      print*, '2 for block'


      READ(*,*) op_switcher
      READ(*,*) input_file
      !READ(*,*) output_file
      
     
      
      

      
      IF (op_switcher .EQ. 1) THEN
          GO TO 10
      END if
      
      IF (op_switcher .EQ. 2) THEN
          GO TO 11
      END IF
      
      
      go to 13
          
          
      
      
 11   open(9,file=input_file,form='BINARY',status='old')
      rewind(9)
      read(9) n, k, epb, lc
      print*, '|n = ', n, ' | k = ', k, ' | epb = ', epb, ' | lc = ', lc
      

      allocate(
     >         l_ma(1:lc, 1:epb),
     >         l_mb(1:lc, 1:epb),
     >         mc(1:n, 1:n) 
     >        ) 
      
      
      do i=1,epb
          read(9) (l_ma(j, i), j=1,lc)
          read(9) (l_mb(j, i), j=1,lc)
      end do
      
      close(9)
      print*, 'read done'
      
      
      
      if (op_switcher .EQ. 2) THEN
          go to 22
      end if
      

      

      
      
22    allocate(ind(0:k-1, 0:k-1, 0:5, 1:k))
      call indices(ind)
      
      do j=0,k-1
          do i=0,k-1
              g =  ind(j, i, 0, 1)
              
                  print*, ind(j, i, 1, 1:g)
                  print*, ind(j, i, 2, 1:g)
              
          end do
      end do
      !print*, '****************'
      do i=0,k-1
          do j=0,k-1
              g =  ind(i, j, 0, 1)
              
                  !print*, ind(i, j, 3, 1:g)
                 ! print*, ind(i, j, 4, 1:g)
              
          end do
      end do
      
      
      
      
          
      
      call CPU_TIME(start_time)
      call block_mul2(l_ma, l_mb, mc, ind)
      call CPU_TIME(finish_time)
      
      GO TO 12
!     ____________________________
      
      
      
10    open(99,file=input_file,form='BINARY',status='old')
      rewind(99)
      read(99) n
      
      allocate(
     >         ma(1:n, 1:n), 
     >         mb(1:n, 1:n), 
     >         mc(1:n, 1:n)
     >        )
      
      do j=1,n
           read(99) (ma(i, j), i=1,n)
           read(99) (mb(i, j), i=1,n)
      end do
      
      close(99)
      
      call CPU_TIME(start_time)
      
      call matrix_mul(ma, mb, mc, n)
      
      call CPU_TIME(finish_time)
      
      
      GO TO 12
      

      
      
      
      
      
      
12    open(109, file='output_file.bin',  ACCESS='APPEND', form='BINARY')
      do j=1,n
          write(109) (mc(i, j), i=1,n)
      end do
      close(109)
      
      open(209, file='time.txt', ACCESS='APPEND')
      
      write(209,2), finish_time - start_time
 2    format(f12.8)
      close(209)
      
!      do i=1,n
!          print*, (mc(i, j), j=1,n)
!          print*, '______'
!      end do
    ! Variables

    ! Body of Console1
      print *, 'calculation time = ', finish_time - start_time
 13   print *, 'DONE'
      
      READ(*,*) op_switcher
      
      
      
      end