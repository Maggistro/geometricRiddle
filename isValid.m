function valid = isValid(start,K_o,KKR_oh)
%checks for collision

%check if inside K_o regarding x and y
valid = start(1) >= K_o(1,1) && start(1) <=K_o(2,1) &&...
        start(2) >= K_o(1,2) && start(2) <=K_o(3,2);

%check if inside KKR_oh
%get rectangle for current rotation
K_oh_part = [KKR_oh(KKR_oh(:,3)==start(3),1),KKR_oh(KKR_oh(:,3)==start(3),2)];
if ~isempty(K_oh_part)
valid = valid && ~(...
        start(1) >= min(K_oh_part(:,1)) && start(1) <= max(K_oh_part(:,1)) &&...
        start(2) >= min(K_oh_part(:,2)) && start(2) <= max(K_oh_part(:,2))); 
else valid = 0;
end
    


end

