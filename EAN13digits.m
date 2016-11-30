function out = EAN13digits( vector7)


    switch (vector7)
        case [0 0 0 1 1 0 1]
            out = 0; return;
        case [0 0 1 1 0 0 1]
            out = 0;return;
        case [1 1 1 0 0 1 0]
            out = 0;return;
            
        case [0 0 1 1 0 0 1]
            out = 1;return;
        case [0 1 1 0 0 1 1]
            out = 1;return;
        case [1 1 0 0 1 1 0]
            out = 1;return;
            
        case [0 0 1 0 0 1 1]
            out = 2;return;
        case [0 0 1 1 0 1 1]
            out = 2;return;
        case [1 1 0 1 1 0 0]
            out = 2;return;
        
        case [0 1 1 1 1 0 1]
            out= 3; return;
        case [0 1 0 0 0 0 1]
            out = 3; return;
        case [1 0 0 0 0 1 0]
            out = 3; return;
        
        case [0 1 0 0 0 1 1]
            out = 4; return;
        case [0 0 1 1 1 0 1]
            out = 4; return;
        case [1 0 1 1 1 0 0]
            out = 4; return;
            
        case [0 1 1 0 0 0 1]
            out = 5; return;
        case [0 1 1 1 0 0 1]
            out = 5; return;
        case [1 0 0 1 1 1 0]
            out = 5; return;
            
        case [0 1 0 1 1 1 1]
            out = 6; return;
        case [0 0 0 0 1 0 1]
            out = 6; return;
        case [1 0 1 0 0 0 0]
            out = 6; return;
            
        case [0 1 1 1 0 1 1]
            out = 7; return;
        case [0 0 1 0 0 0 1]
            out = 7; return;
        case [1 0 0 0 1 0 0]
            out = 7; return;
            
        case [0 1 1 0 1 1 1]
            out = 8; return;
        case [0 0 0 1 0 0 1]
            out = 8; return;
        case [1 0 0 1 0 0 0]
            out = 8; return;
            
        case [0 0 0 1 0 1 1]
            out = 9; return;
        case [0 0 1 0 1 1 1]
            out = 9; return;
        case [1 1 1 0 1 0 0]
            out = 9; return;
        
        otherwise out = -2; return; 
            
    end;

end

