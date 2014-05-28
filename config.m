%%Calculate configuration spaces CS in 3 dimensions ( x,y,phi )
%%with start configurations C and object dimenstions A
function CS = config(C,A)
R=A.R; %rims
M=A.M; %main object
CS_m=[]; %configuration space for main object 
for i=1:length(M)-1
    for j=1:length(R)-1
        CS_m=[CS_m;R(j,:)-M(i,:)];
    end
end
[CS_m,~,~]=unique(CS_m,'rows','stable');
CS.M=CS_m+ones(length(CS_m),1)*([C.M(1,1),C.M(1,2)] - M(1,:));