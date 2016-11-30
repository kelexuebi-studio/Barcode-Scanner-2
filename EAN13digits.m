function out = EAN13digits( vector7)


    
        if isequal(vector7, [0 0 0 1 1 0 1])
            out = 0; return;
        elseif isequal(vector7, [0 1 1 0 0 1 1])
            out = 0;return;
        elseif isequal(vector7, [1 1 1 0 0 1 0])
            out = 0;return;
            
        elseif isequal(vector7, [0 0 1 1 0 0 1])
            out = 1;return;
        elseif isequal(vector7, [0 1 1 0 0 1 1])
            out = 1;return;
        elseif isequal(vector7, [1 1 0 0 1 1 0])
            out = 1;return;
            
        elseif isequal(vector7, [0 0 1 0 0 1 1])
            out = 2;return;
        elseif isequal(vector7, [0 0 1 1 0 1 1])
            out = 2;return;
        elseif isequal(vector7, [1 1 0 1 1 0 0])
            out = 2;return;
        
        elseif isequal(vector7, [0 1 1 1 1 0 1])
            out= 3; return;
        elseif isequal(vector7, [0 1 0 0 0 0 1])
            out = 3; return;
        elseif isequal(vector7, [1 0 0 0 0 1 0])
            out = 3; return;
        
        elseif isequal(vector7, [0 1 0 0 0 1 1])
            out = 4; return;
        elseif isequal(vector7, [0 0 1 1 1 0 1])
            out = 4; return;
        elseif isequal(vector7, [1 0 1 1 1 0 0])
            out = 4; return;
            
        elseif isequal(vector7, [0 1 1 0 0 0 1])
            out = 5; return;
        elseif isequal(vector7, [0 1 1 1 0 0 1])
            out = 5; return;
        elseif isequal(vector7, [1 0 0 1 1 1 0])
            out = 5; return;
            
        elseif isequal(vector7, [0 1 0 1 1 1 1])
            out = 6; return;
        elseif isequal(vector7, [0 0 0 0 1 0 1])
            out = 6; return;
        elseif isequal(vector7, [1 0 1 0 0 0 0])
            out = 6; return;
            
        elseif isequal(vector7, [0 1 1 1 0 1 1])
            out = 7; return;
        elseif isequal(vector7, [0 0 1 0 0 0 1])
            out = 7; return;
        elseif isequal(vector7, [1 0 0 0 1 0 0])
            out = 7; return;
            
        elseif isequal(vector7, [0 1 1 0 1 1 1])
            out = 8; return;
        elseif isequal(vector7, [0 0 0 1 0 0 1])
            out = 8; return;
        elseif isequal(vector7, [1 0 0 1 0 0 0])
            out = 8; return;
            
        elseif isequal(vector7, [0 0 0 1 0 1 1])
            out = 9; return;
        elseif isequal(vector7, [0 0 1 0 1 1 1])
            out = 9; return;
        elseif isequal(vector7, [1 1 1 0 1 0 0])
            out = 9; return;
        
        else out = -2; return; 
            
    end;

end

