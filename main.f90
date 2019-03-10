program Temp_Sep

    implicit none

    integer :: Line_count=0         ! No of lines counting Variable
    integer :: Reason               ! Error Code Identifier
    integer :: incre                ! Loop incrementor 1
    integer :: incre2               ! Loop incrementor 2
    integer :: x                    ! 'i' Coordinate reading Variable
    integer :: y                    ! 'j' Coordinate reading Variable
    integer :: z                    ! 'spin A(i,j)'  reading Variable
    real :: First_Value             ! First Temperature Value reading Variable
    real :: w                       ! Temperature Reading Variable
    CHARACTER(LEN=25) :: File_Name  ! Temperature real value to string value conversion Variable



    open(unit=11,file='temperature.dat',status='old', action='read')

    !----This Segment of code is intended to find out the number of lines of input file in the range of 900,000-----!

    do incre=0,900000
        READ(11,*,IOSTAT=Reason)
        IF (Reason > 0)  THEN
            exit
        ELSE IF (Reason < 0) THEN
            exit
        ELSE
            Line_count = Line_count + 1
        END IF
    end do

    write(*,*) Line_count               !----Write No of lines to screen----!
    close(unit=11)

    !----End of Segment----!

    !----This segment of code is intended to find the first temperature value of input file for the sake of creating new files based on temperature names for the sake of plotting-----!

    open(unit=12,file='temperature.dat',status='old', action='read')
    read(12,*);
    read(12,*) First_Value
    close(unit=12)

    write(File_Name , *) First_Value    !----Typeset Real value to String----!

    !----End of Segment----!

    !----This Segment seperates the file into many files----!

    open(unit=14,file=File_Name,status='new', action='write')    !----Creating the initial file based on initial temperature----!
    write(14,*)"  temperature","      i" ,"                j","                spin A(i,j)"
    open(unit=13,file='temperature.dat',status='old', action='read')
    read(13,*);

    do incre2=1,Line_count-1
    read(13,*) w,x,y,z
    if(w==First_Value)then
        write(14,*)w,x,y,z
    elseif(w.ne.First_Value)then
        First_Value=w
        write(File_Name , *) First_Value
        open(unit=14,file=File_Name,status='new', action='write')
        write(14,*)"  temperature","      i" ,"                j","                spin A(i,j)"
        write(14,*)w,x,y,z
    else
        exit

    end if

    enddo



end program Temp_Sep