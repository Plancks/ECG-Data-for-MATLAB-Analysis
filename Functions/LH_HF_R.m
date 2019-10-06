

function [ratio, estplf1, estphf1]= pds_intg(fv,px,lowfreq1,lowfreq2,hifreq1,hifreq2)

    [r_row1, r_col1]=find(fv>=lowfreq1 & fv<lowfreq2);  %Find the low frequency of Freq. Vector
    [rh_row1, rh_col1]=find(fv>=hifreq1 & fv<hifreq2); %Find the high frequency of Freq. Vector
    
    estplf1=trapz(px(r_col1:r_row1)); %integrate power spectral density
    estphf1=trapz(px(rh_col1:rh_row1)); %accross these frequencies.
    
    ratio=estplf1/estphf1;
end
   