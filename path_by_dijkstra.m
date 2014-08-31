function Path = path_by_dijkstra(riddle,figureData)
%path_by_dijkstra calculates the path for mainObject from start to target
%border of the complete riddle
%object contains ALL objects except mainobject
%start mainobject which needs to pass trough the puzzle
%target target configuration for mainobject
%figureData set of information for replotting the riddle on-the-fly

next_collision_set = cell(1, length(riddle.o));
%create initial collision borders for each object
for i=1:length(riddle.o)
    temp = riddle.o; %generate set of other objects to collide with
    temp(i) = [];
    next_collision_set{i} = getRims(riddle.o{i}.data,temp,length(riddle.o{i}.data),riddle.o{i}.mid);
end

%collision_set{length(collision_set)+1} = riddle.b;
%get size of direction vector ( 3 parameters per object) 
directions = zeros(1,(length(riddle.o)*3)*2);
for i=1:(length(riddle.o)*3)*2
    directions(i) = floor((i+1)/2);
    if ~mod(i,2)
        directions(i) = directions(i)*(-1);
    end
end

%directions = [ 1 -1 2 -2 3 -3 6 -6];

%initial configuration vector for start and target
start = riddle.m.mid;
target = riddle.t.mid;
for i=2:length(riddle.o)
    start = [start,riddle.o{i}.mid];
    target = [target,riddle.o{i}.mid];
end
[nextVec] = isValid(start,riddle.b,next_collision_set);

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
%collision set
collision_set=cell(1,1000);
collision_set{1} = next_collision_set;

while(~sum(ismember(R(:,1:3),target(1:3),'rows')))
    %Wähleo nächsten noch unbesuchten knoten nach Heuristik/Weglänge
    unvisited_D= D+H;
    unvisited_D(V==1)=inf;
    [~ ,next_position]= min(unvisited_D);
    next=R(next_position,:);
    V(next_position)=1;
    
    

    
    %Rand von next berechnen
    for i=1:length(directions) % für jede Richtung auf x,y
        %get all nodes in front of next obstacle line
        [possible_next,next_collision_set] = oneStep(next,directions(i),collision_set{next_position},riddle,-1*sign(directions(i))); % berechne nächsten knoten
        if isValid(possible_next,riddle.b,next_collision_set) % when der knoten erlaubt ist
            if ~sum(sum(abs(R - ones(size(R,1),1)*possible_next)<0.001,2)==size(R,2)) % und nicht im Rand ist
                R=[R;possible_next]; %füge ihn hinzu
                collision_set{length(D)+1} = next_collision_set; %set his collision information
                D=[D;D(next_position)+0.1]; %und trage seine distanz zum start ein
                P=[P;next]; %und trage als vorgänger betrachteten knoten ein
                H=[H;heuristic(possible_next,target)]; %berechne abstand zum ziel
                V=[V;0]; %und er wurde noch nicht besucht
            else                    %wenn er schon im Rand ist, dann
                pn_position=find(sum(abs(R - ones(size(R,1),1)*possible_next)<0.001,2)==size(R,2)); %suche position des knotens im Rand
                if(D(pn_position)>D(next_position)+0.1) % wenn Randknoten weiter weg ist als momentaner weg
                    D(pn_position)=D(next_position)+0.1; % update für entfernung
                    P(pn_position(1),:)=next; %und trage als vorgänger betrachteten knoten ein
                end %wenn Randknoten näher ist ist alles ok, knoten muss nicht hinzugefügt werden
            end
   
        %get all nodes behind next obtacle line
        [possible_next,next_collision_set] = oneStep(next,directions(i),collision_set{next_position},riddle, sign(directions(i))); % berechne nächsten knoten
        if isValid(possible_next,riddle.b,next_collision_set) % when der knoten erlaubt ist
            if ~sum(sum(abs(R - ones(size(R,1),1)*possible_next)<0.001,2)==size(R,2)) % und nicht im Rand ist
                R=[R;possible_next]; %füge ihn hinzu
                collision_set{length(D)+1} = next_collision_set; %set his collision information
                D=[D;D(next_position)+0.1]; %und trage seine distanz zum start ein
                P=[P;next]; %und trage als vorgänger betrachteten knoten ein
                H=[H;heuristic(possible_next,target)]; %berechne abstand zum ziel
                V=[V;0]; %und er wurde noch nicht besucht
            else                    %wenn er schon im Rand ist, dann
                pn_position=find(sum(abs(R - ones(size(R,1),1)*possible_next)<0.001,2)==size(R,2)); %suche position des knotens im Rand
                if(D(pn_position)>D(next_position)+0.1) % wenn Randknoten weiter weg ist als momentaner weg
                    D(pn_position)=D(next_position)+0.1; % update für entfernung
                    P(pn_position(1),:)=next; %und trage als vorgänger betrachteten knoten ein
                end %wenn Randknoten näher ist ist alles ok, knoten muss nicht hinzugefügt werden
            end
          end %wenn knoten nicht erlaubt ist nicht betrachten
        end %wenn knoten nicht erlaubt ist nicht betrachten        
    end
    
    %figureData.collision = next_collision_set;
    %figureData.current = next;
    %figureData.start = start;
    %drawMainObject(figureData);
    
    %fprintf('.');
    
end

%get node on target
[~,temp]=ismember(R(:,1:3),target(1:3),'rows');
current = R(temp==1,:);
finish=1
pause();
while(sum(current~=start)~=0) %solange bis zurück am anfang
    figureData.current = current;
    figureData.start = start;
    drawMainObject(figureData);
    [~,temp]=ismember(current,R,'rows'); %suche position des knotens im Rand
    Path=[current;Path]; % füge zum pfad hinzu
    current = P(temp,:); % mache bei pre weiter

end
Path = [start;Path];