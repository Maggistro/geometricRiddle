function Path = path_by_dijkstra(riddle,figureData)
%path_by_dijkstra calculates the path for mainObject from start to target
%border of the complete riddle
%object contains ALL objects except mainobject
%start mainobject which needs to pass trough the puzzle
%target target configuration for mainobject
%figureData set of information for replotting the riddle on-the-fly

%create initial collision borders for mainObject to others
initial_Collision_set = getRims(riddle.m.data,riddle.o,length(riddle.m.data),riddle.m.mid);

%get size of direction vector ( 3 parameters per object and mainobject ) 
directions = zeros(1,(length(riddle.o)*3 + 3)*2);
for i=1:(length(riddle.o)*3 + 3)*2
    directions(i) = floor((i+1)/2);
    if ~mod(i,2)
        directions(i) = directions(i)*(-1);
    end
end


%initial configuration vector for start and target
start = riddle.m.mid;
target = riddle.t.mid;
for i=length(riddle.o)
    start = [start,riddle.o{i}.mid];
    target = [target,riddle.o{i}.mid];
end
[nextVec] = isValid(start,riddle.b,riddle.o);

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
        possible_next = oneStep(next,directions(i),initial_Collision_set); % berechne nächsten knoten
        if isValid(possible_next,border,objects) % when der knoten erlaubt ist
            if ~sum(ismember(R,possible_next,'rows')) % und nicht im Rand ist
                R=[R;possible_next]; %füge ihn hinzu
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