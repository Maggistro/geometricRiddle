function Path = path_by_dijkstraFunc(riddle,figureData)
%path_by_dijkstra calculates the path for mainObject from start to target
%border of the complete riddle
%object contains ALL objects except mainobject
%start mainobject which needs to pass trough the puzzle
%target target configuration for mainobject
%figureData set of information for replotting the riddle on-the-fly

next_collision_set = riddle.o;
next_collision_set = [next_collision_set riddle.r];
%collision_set{length(collision_set)+1} = riddle.b;
%get size of direction vector ( 3 parameters per object) 
directions = zeros(1,(length(riddle.o)*3)*2);
for i=1:(length(riddle.o)*3)*2
    directions(i) = floor((i+1)/2);
    if ~mod(i,2)
        directions(i) = directions(i)*(-1);
    end
end

%directions = [1 -1 2 -2 3 -3 6 -6];

%initial configuration vector for start and target
start = riddle.m.mid;
target = riddle.t.mid;
for i=2:length(riddle.o)
    start = [start,riddle.o{i}.mid];
    target = [target,riddle.o{i}.mid];
end
[nextVec] = isValidFunc(riddle.b,next_collision_set,1);

%initialwerte
%Rand
R=[start];
%Entfernungen f�r Randknoten
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



    %figureData.o = next_collision_set;
    %drawMainObjectFunc(figureData);
    
while(~sum(ismember(R(:,1:3),target(1:3),'rows')))
    %W�hleo n�chsten noch unbesuchten knoten nach Heuristik/Wegl�nge
    unvisited_D= D+H;
    unvisited_D(V==1)=inf;
    [~ ,next_position]= min(unvisited_D);
    next=R(next_position,:);
    V(next_position)=1;
    
    
    %figureData.o = collision_set{next_position};
    %drawMainObjectFunc(figureData);
    %Rand von next berechnen
    for i=1:length(directions) % f�r jede Richtung auf x,y
        %get all nodes in front of next obstacle line
        [possible_next,next_collision_set] = oneStepFunc(next,directions(i),collision_set{next_position},riddle); % berechne n�chsten knoten
        if isValidFunc(riddle.b,next_collision_set,directions(i)) % when der knoten erlaubt ist
            if ~sum(sum(abs(R - ones(size(R,1),1)*possible_next)<0.001,2)==size(R,2)) % und nicht im Rand ist
                R=[R;possible_next]; %f�ge ihn hinzu
                collision_set{length(D)+1} = next_collision_set; %set his collision information
                D=[D;D(next_position)+0.1]; %und trage seine distanz zum start ein
                P=[P;next]; %und trage als vorg�nger betrachteten knoten ein
                H=[H;heuristic(possible_next,target)]; %berechne abstand zum ziel
                V=[V;0]; %und er wurde noch nicht besucht
            else                    %wenn er schon im Rand ist, dann
                pn_position=find(sum(abs(R - ones(size(R,1),1)*possible_next)<0.001,2)==size(R,2)); %suche position des knotens im Rand
                if(D(pn_position)>D(next_position)+0.1) % wenn Randknoten weiter weg ist als momentaner weg
                    D(pn_position)=D(next_position)+0.1; % update f�r entfernung
                    P(pn_position(1),:)=next; %und trage als vorg�nger betrachteten knoten ein
                end %wenn Randknoten n�her ist ist alles ok, knoten muss nicht hinzugef�gt werden
            end
        end %wenn knoten nicht erlaubt ist nicht betrachten        
    end
    
    
    %fprintf('.');
    
end

%get node on target
[~,temp]=ismember(R(:,1:3),target(1:3),'rows');
current = R(temp==1,:);
figureData.pause=1;

while(sum(current~=start)~=0) %solange bis zur�ck am anfang
     [~,temp]=ismember(current,R,'rows'); %suche position des knotens im Rand
     %figureData.o = collision_set{find(sum(abs(R - ones(size(R,1),1)*current)<0.001,2)==size(R,2))};
     %drawMainObjectFunc(figureData);
     Path=[current;Path]; % f�ge zum pfad hinzu
    current = P(temp,:); % mache bei pre weiter

end
Path = [start;Path];
drawPathFunc(Path,figureData,collision_set,R);