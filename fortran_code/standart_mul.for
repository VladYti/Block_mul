      subroutine matrix_mul(ma, mb, mc, n)
      
      implicit real*8 (a-h,l-z)
      integer*8 n

      
      dimension
     > ma(1:n, 1:n), mb(1:n, 1:n), mc(1:n, 1:n)

      mc = 0
      !print*, 'std mul in process'
      do i=1,n
          do j=1,n
              do k=1,n
                  mc(j, i) = mc(j, i) + ma(k, i)*mb(j, k)
              end do
          end do
      end do
          
      end
