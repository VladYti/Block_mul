      subroutine block_mul2(l_ma, l_mb, mc, ind)
      
      implicit real*8 (a-h,l-z)
      integer*8 n, k, epb, lc
      integer*8 g
      
       dimension
     > l_ma(1:lc, 1:epb), l_mb(1:lc, 1:epb),
     > mc(1:n, 1:n), tmp1(1:epb, 1:epb),
     > tmp3(1:epb, 1:epb), ind(0:k-1, 0:k-1, 0:5, 1:k)
       
       
        common
     >/par/ n, k, epb, lc 
        
        do j=0,k-1
            do i=0,k-1
                  g = ind(j, i, 0, 1)
                  do t=1,g
                      la = ind(j, i, 1, t)
                      ra = ind(j, i, 2, t)
                      lb = ind(j, i, 3, t)
                      rb = ind(j, i, 4, t)
                      call matrix_mul(
     >                              l_ma(la:ra, 1:epb), 
     >                              l_mb(lb:rb, 1:epb), 
     >                              tmp3, 
     >                              epb
     >                             )
                      tmp1 = tmp1 + tmp3
                  end do
                  mc(1+epb*i:epb+epb*i, 1+epb*j:epb+epb*j) = tmp1
                  tmp1 = 0
              
            end do
        end do
        
      end
