      subroutine block_mul1(l_ma, l_mb, mc)
      
      implicit real*8 (a-h,l-z)
      integer*8 n, k, epb, lc
      integer*8 ra_shift, la_shift, rb_shift, lb_shift, g
      !print*, n, k, epb, lc
      
!          real*8 tmp1(1:epb*k, 1:epb), tmp2(1:epb*k, 1:epb), 
!     >        tmp3(1:epb, 1:epb)
      

      
      dimension
     > l_ma(1:lc, 1:epb), l_mb(1:lc, 1:epb),
     > mc(1:n, 1:n), tmp1(1:epb*k, 1:epb), tmp2(1:epb*k, 1:epb),
     > tmp3(1:epb, 1:epb)
      
      common
     >/par/ n, k, epb, lc 
      
      
      ra_shift=0
      ra_shift = epb*k
      la_shift = 1
      print*, ra_shift
      
      rb_shift = epb*k
      lb_shift = 1
      do j=0,k-1
         ! print*, 'j = ', j
          tmp1 = 0
          tmp2 = 0
          do i=0,k-1
              
              !print*,'i = ', i
              !print*, la_shift, ra_shift
              !print*, list_ma(la_shift:ra_shift, 1:4)
              g = ra_shift - la_shift + 1
      tmp1(1:g, 1:epb) = l_ma(la_shift:ra_shift, 1:epb) 
      tmp2(1:g, 1:epb) = l_mb(lb_shift:rb_shift, 1:epb)
              
              print*, 'La = ', la_shift
              print*, 'Ra = ', ra_shift
              print*, 'max p = ', (g)/epb
              
              do p=0,(g)/epb-1
                  !print*, 'p = ', p
                  
                  call matrix_mul(tmp1(1+epb*p:epb+epb*p, 1:epb),
     >                        tmp2(1+epb*p:epb+epb*p, 1:epb), tmp3, epb)
                  !print*, tmp3(1:,:) 
                  mc(1+epb*i:epb+epb*i, 1+epb*j:epb+epb*j) = 
     >        mc(1+epb*i:epb+epb*i, 1+epb*j:epb+epb*j) + 
     >                tmp3(1:epb, 1:epb)
                  !print*, tmp3
              end do
              
              la_shift = la_shift + epb 
              
              lb_shift = lb_shift + epb*(k-i)
              if (serv > 0) Then
                  lb_shift = lb_shift - epb
                  la_shift = la_shift - epb
                  serv = serv - 1
              end if 
              rb_shift =rb_shift +epb*(k-i-1) 
              
              
              
              
              !tmp11 = list_ma(1+epb*(j) + i*(k-j)*epb:epb*k, 1:epb) * list_mb(1:epb*k, 1:epb)
              !tmp12 = list_ma(1+epb*(j):epb*k, 1:epb) * list_mb(1 + epb*k:epb*k+ epb*(k-1),  1:epb)
              !tmp13 = list_ma(1+epb*(j):epb*k, 1:epb) * list_mb(1 + epb*k + epb*(k-1):epb*(k*k), 1:epb)
              
          end do
          
          !la_shift = la_shift + epb
          ra_shift = ra_shift + epb*(k-j-1)
          lb_shift = 1 + epb*(j+1)
          serv = j+1
          
          
          rb_shift = epb*k
      end do
      
         end
         
         !      ra_shift=0
!      ra_shift = epb*k
!      la_shift = 1
!      rb_shift = epb*k
!      lb_shift = 1
!      
!      do j=0,k-1
!
!          do i=0,k-1
!              
!              !print*,'i = ', i
!
!              g = (ra_shift-la_shift+1)/epb
!              ind(j, i, 0, 1) = g
!              !print*,  1+epb*i, epb+epb*i
!              
!              do t = 1,g
!                  ind(j, i, 1, t) = la_shift+epb*(t-1)
!                  ind(j, i, 2, t) = ra_shift-epb*(g-t)
!                  ind(j, i, 3, t) = lb_shift+epb*(t-1)
!                  ind(j, i, 4, t) = rb_shift-epb*(g-t)
!              end do
!          
!              la_shift = la_shift + epb 
!              lb_shift = lb_shift + epb*(k-i)
!              
!              if (serv > 0) Then
!                  lb_shift = lb_shift - epb
!                  la_shift = la_shift - epb
!                  serv = serv - 1
!              end if 
!              
!              rb_shift =rb_shift +epb*(k-i-1) 
!              
!          end do
!          
!          ra_shift = ra_shift + epb*(k-j-1)
!          lb_shift = 1 + epb*(j+1)
!          serv = j+1
!          rb_shift = epb*k
!          
!      end do