%Randobjekt:  
R= [ 	0,0 ;
	5,0 ;
	5,1 ;
	4,1 ;
    3,0 ;
	3,1 ;
	1,1 ;
	1,3 ;
	5,3 ;
	5,4 ;
	0,4 ];


%Haupobjekt :
H= [0,0;
	0.8,0;
	0.8,1.8;
	0,1.8];

%Rotationsobjekt:
Ro = [	3.1, 1.1;
	3.1, 1.9;
	%Viertelkreis;
	2.1, 1.1];	

%Konfigurationen K = [K_h, K_r] ; K_h = [x,y] K_r = theta
%SK=[ 1.1, 1.1 ;
%    0 ]

%Konfigurationshindernisse für H und R
K_H=[];
for i=1:length(R)
	for j=1:length(H)
		K_H=[K_H ; [R(i,1) + H(j,1),R(i,2) + H(j,2)]];	
	end
end

%doppelte löschen
for i=1:length(K_H)
	temp = K_H(i,:);
	for j=i+1:length(K_H)
		if (temp==K_H(j,:))
			K(j,:)=[];
		end
	end
end

figure;
plot([K_H(:,1);K_H(1,1)],[K_H(:,2);K_H(1,2)],'.');
