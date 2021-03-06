function object_list_update = object_localization(object_list, object_num,...
	innerLine_coordinate, innerLine_Vertex_index, ...
	middleLine_coordinate, middleLine_Vertex_index,...
	outerLine_coordinate, outerLine_Vertex_index,lane_offset,...
	 option)

object_list_update	= object_list;
% distance 			= zeros(size(object_list,1),3);
side_direction 		= zeros(size(object_list,1),3);
% nearestIndex 		= zeros(size(object_list,1),3);

for  i = 1:object_num
    if(object_list(i,1)~=0)
        p = [object_list(i,2),object_list(i,4)];%2nd and 4th colomn are range x and range y
        side_direction(i,1) = point_inside_lane(p,innerLine_coordinate, innerLine_Vertex_index);
        side_direction(i,2) = point_inside_lane(p,middleLine_coordinate,middleLine_Vertex_index);
%         side_direction(i,3) = point_inside_lane(p,outerLine_coordinate, outerLine_Vertex_index);
        side_direction(i,3) = point_inside_lane_offset(p,outerLine_coordinate, outerLine_Vertex_index,lane_offset);       
    end
end

for i = 1:object_num
    if(object_list(i,1)~=0)
        if(option.clockWise == 0)%counter-clockwise
            switch(sum(side_direction(i,:)))
                case  3  %( 1  1  1) outside outer ring
                	object_list_update(i,9) = 3; 
                case  1  %( 1  1 -1)
                	object_list_update(i,9) = 2; %outer lane 
                case -1  %( 1 -1 -1)
                	object_list_update(i,9) = 1; %inner lane
                case -3  %(-1 -1 -1)
                	object_list_update(i,9) = 0; %inside inner ring
                otherwise
                    object_list_update(i,9) = 5;%warning('Unexpected location!')
            end
        else%clockwise
            switch(sum(side_direction(i,:)))%couterclockwise
                case -3 %( -1  -1  -1)
                	object_list_update(i,9) = 3; 
                case -1 %( -1  -1   1)
                	object_list_update(i,9) = 2; %outer lane 
                case  1   %( -1   1   1)
                 	object_list_update(i,9) = 1; %inner lane
                case  3   %(  1   1   1)
                	object_list_update(i,9) = 0; %inside inner ring
                otherwise
                    object_list_update(i,9) = 5;%warning('Unexpected location!')
            end
        end
    end
end


