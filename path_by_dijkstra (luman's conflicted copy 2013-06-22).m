function Path = path_by_dijkstra(K_o,KKR_oh,start,target)
%suche auf einem grid. keine direkte erstellung von knoten und
%distanzmatrix, alles wird lokal erstellt

%suchrichtungen
xp=[1,0,0];
xm=[-1,0,0];
yp=[0,1,0];
ym=[0,-1,0];
zp=[0,0,5];
zm=[0,0,-5];
directions=[xp;xm;yp;ym;zp;zm];


%initialwerte
%Rand
R=[start];
%Entfernungen f�r Randknoten
D=[0];
%Pre von Randknoten
P=[start];
%Besuchte Knoten
V=[0];
%leerer pfad
Path=[];

while(~sum(ismember(R,target,'rows')))
    %W�hle n�chsten noch unbesuchten knoten
    unvisited_D=D;
    unvisited_D(V==1)=inf;
    [~ ,next_position]= min(unvisited_D);
    next=R(next_position,:)
    V(next_position)=1;
    
    %Rand von next berechnen
    for i=1:length(directions) % f�r jede Richtung auf x,y
        possible_next = next+directions(i,:); % berechne n�chsten knoten
        if isValid(possible_next,K_o,KKR_oh) % when der knoten erlaubt ist
            if ~sum(ismember(R,possible_next,'rows')) % und nicht im Rand ist
                R=[R;next+directions(i,:)]; %f�ge ihn hinzu
                D=[D;D(next_position)+0.1]; %und trage seine distanz zum start ein
                P=[P;possible_next]; %und trage als vorg�nger betrachteten knoten ein
                V=[V;0];
            else                    %wenn er schon im Rand ist, dann
                pn_position=find(ismember(R,possible_next,'rows')); %suche position des knotens im Rand
                if(D(pn_position)>D(next_position)+0.1) % wenn Randknoten weiter weg ist als momentaner weg
                    D(pn_position)=D(next_position)+0.1; % update f�r entfernung
                    P(pn_position)=possible_next; %und trage als vorg�nger betrachteten knoten ein
                end %wenn Randknoten n�her ist ist alles ok, knoten muss nicht hinzugef�gt werden
            end
        end %wenn knoten nicht erlaubt ist nicht betrachten
    end
end

%weg berechnen ausgehend vom target im Rand
current = target;
while(current~=start) %solange bis zur�ck am anfang
    [~,temp]=ismember(R,current,'rows') %suche position des knotens im Rand
    Path=[current;Path] % f�ge zum pfad hinzu
    current = P(temp) % mache bei pre weiter
end
Path = [start;Path];