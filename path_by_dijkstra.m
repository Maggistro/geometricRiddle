function Path = path_by_dijkstra(CS_Main,CS_Obstacle,start,target,figureData)
%suche auf einem grid. keine direkte erstellung von knoten und
%distanzmatrix, alles wird lokal erstellt

%Speedup:
%erstellen der verbotenen zone als markierte punkte auf dem grid
%Zusammenführen von schritten für weniger speicher
%adaptive schrittgröße ( wie? )
%verbesserung der heuristik


%suchrichtungen
stepsize=1/2;
xp=[stepsize,0,0];
xm=[-stepsize,0,0];
yp=[0,stepsize,0];
ym=[0,-stepsize,0];
zp=[0,0,5];
zm=[0,0,-5];
directions=[xp;xm;yp;ym;zp;zm];


%initialwerte
%Rand
R=[start];
%Entfernungen für Randknoten
D=[0];
%Pre von Randknoten
P=[start];
%Besuchte Knoten
V=[0];
%Heuristik
H=[heuristic(start,target)];
%leerer pfad
Path=[];

while(~sum(ismember(R,target,'rows')))
    %Wähle nächsten noch unbesuchten knoten nach Heuristik/Weglänge
    unvisited_D= H;
    unvisited_D(V==1)=inf;
    [~ ,next_position]= min(unvisited_D);
    next=R(next_position,:);
    V(next_position)=1;
    
    
    
    %Rand von next berechnen
    for i=1:length(directions) % für jede Richtung auf x,y
        possible_next = next+directions(i,:); % berechne nächsten knoten
        if isValid(possible_next,CS_Main,CS_Obstacle) % when der knoten erlaubt ist
            if ~sum(ismember(R,possible_next,'rows')) % und nicht im Rand ist
                R=[R;next+directions(i,:)]; %füge ihn hinzu
                D=[D;D(next_position)+0.1]; %und trage seine distanz zum start ein
                P=[P;next]; %und trage als vorgänger betrachteten knoten ein
                H=[H;heuristic(possible_next,target)]; %berechne abstand zum ziel
                V=[V;0]; %und er wurde noch nicht besucht
            else                    %wenn er schon im Rand ist, dann
                pn_position=find(ismember(R,possible_next,'rows')); %suche position des knotens im Rand
                if(D(pn_position)>D(next_position)+0.1) % wenn Randknoten weiter weg ist als momentaner weg
                    D(pn_position)=D(next_position)+0.1; % update für entfernung
                    P(pn_position,:)=next; %und trage als vorgänger betrachteten knoten ein
                end %wenn Randknoten näher ist ist alles ok, knoten muss nicht hinzugefügt werden
            end
        end %wenn knoten nicht erlaubt ist nicht betrachten        
    end
    
    
    figureData.current = next;
    figureData.start = start;
    drawMainObject(figureData);
end

%weg berechnen ausgehend vom target im Rand
current = target;
while(sum(current~=start)~=0) %solange bis zurück am anfang
    [~,temp]=ismember(current,R,'rows'); %suche position des knotens im Rand
    Path=[current;Path]; % füge zum pfad hinzu
    current = P(temp,:); % mache bei pre weiter
end
Path = [start;Path];