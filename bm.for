      subroutine indices(ind)
      implicit real*8 (a-h,l-z)
      integer*8 n, k, epb
      integer*8 ra_shift, la_shift, rb_shift, lb_shift, g, tm3, tm2, tm1
      
      dimension
     >  ind(0:k-1, 0:k-1, 0:5, 1:k)
      
      common
     >/par/ n, k, epb
      
      
      ra_shift=0
      ra_shift = epb!*k
      la_shift = 1
      rb_shift = epb!*k
      lb_shift = 1
      
      do j=0,k-1
          rb_shift = epb!*k
          lb_shift = 1
          do i=0,k-1
              tm1 = ra_shift-la_shift
              tm2 = rb_shift-lb_shift
              tm3 = min(tm1, tm2)
              !print*, (tm3+1)/epb
              !print*,'i = ', i
              !print*, lb_shift, rb_shift
              g = (tm3+1)/epb
              ind(j, i, 0, 1) = g
              !print*,  1+epb*i, epb+epb*i
              !print*, g
              tm1 = la_shift
              tm2 = lb_shift
              do t = 1,g
                  
                  ind(j, i, 1, t) = tm1
                  ind(j, i, 2, t) = tm1+epb-1
                  ind(j, i, 3, t) = tm2
                  ind(j, i, 4, t) = tm2+epb-1
                  
                  tm1 = tm1+epb
                  tm2 = tm2+epb
              end do
          
              
              lb_shift = lb_shift + epb*(i+1)
              rb_shift = rb_shift + epb*(i+2)
            
              
              
          end do
          
         ! print*, '**********'
          la_shift = la_shift + epb*(j+1)
          ra_shift = ra_shift + epb*(j+2)
          
      end do
      
      end
      
      
      
      
      
      
      
      
      
