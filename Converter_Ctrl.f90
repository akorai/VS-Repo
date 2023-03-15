! This program calculates the converter currents

program Conv_Ctrl 
implicit none
    real :: pref, qref,xconv,ugrid,ThetaGrid_Degree,ThetaGrid,uameas,ubmeas,udmeas,uqmeas,umeasMag,ipref,iqref,udconv,uqconv,ucon_abs,iconvMag
    real :: thetaconv,thetaconSynch,pcalc,qcalc
    real,parameter:: PI = 3.14159
    complex :: uabmeas,udqmeas,ucon,iconv,spower
    integer :: Synch,Grid_Form
    
        
    !write(*,*) 'Enter the values of Synch and Grid_Form:'
    !read(*,*) Synch,Grid_Form

    Synch     = 0
    Grid_Form = 1

    pref      = 0.2
    qref      = -0.1
    ugrid     = 1.0
    xconv     = 0.1
    ThetaGrid_Degree = 50.0
    
    ThetaGrid = ThetaGrid_Degree * PI/180.0
    uameas    = ugrid*cos(ThetaGrid)
    ubmeas    = ugrid*sin(ThetaGrid)
    uabmeas   = cmplx(uameas, ubmeas)
    udmeas    =  cos(ThetaGrid)*uameas + sin(ThetaGrid)*ubmeas 
    uqmeas    = -sin(ThetaGrid)*uameas + cos(ThetaGrid)*ubmeas
    udqmeas   = cmplx(udmeas, uqmeas)
    umeasMag  = cabs(udqmeas)  
   
    ipref     = pref/umeasMag   
    iqref     = qref/umeasMag   
   
    udconv    = - iqref*xconv + udmeas   
    uqconv    =   ipref*xconv + uqmeas
  
    ucon      = cmplx(udconv, uqconv)
    ucon_abs  = cabs(ucon)
    iconv     = (ucon-udqmeas)/cmplx(0,xconv)
    iconvMag  = cabs(iconv) 
  
    spower    = udqmeas *conjg(iconv)  
    thetaconv = atan2(uqconv,udconv)   
  
    if (Synch .eq. 1 .and. Grid_form .eq. 0) then 
       thetaconSynch = ThetaGrid + thetaconv
    elseif (Synch .eq. 0 .and. Grid_form .eq. 1) then
       thetaconSynch  = 0.0
       ThetaGrid = - thetaconv 
       umeasMag = cabs(cmplx(ucon_abs,0) - iconv*xconv) 
       ucon  =cmplx(1, 0)
    elseif (Synch .eq. 1 .and. Grid_form .eq. 999) then
       thetaconSynch  = 0
    endif
 
    pcalc     = (cabs(ucon)*umeasMag*sin(thetaconSynch-ThetaGrid))/xconv    
    qcalc     = umeasMag**2/xconv - cabs(ucon)*umeasMag*cos(thetaconSynch-ThetaGrid)/xconv    
    
    print*,pcalc,qcalc
end program  Conv_Ctrl 
     
    