function [x, U] = gauss_elim(A,b)

n = size(A, 1);  
permVec = zeros(n, 1); 
tol = 1e-15;
for i = 1 : 1 : n    
   permVec(i) = i;
end

for perVecIndex = 1 : 1 : n
    max = abs(A(permVec(perVecIndex), permVec(perVecIndex)));    
    maxPos = perVecIndex;    
    for colIndex = perVecIndex : 1 : n        
        if abs(A(permVec(colIndex), permVec(perVecIndex))) > max            
            max = abs(A(permVec(colIndex), permVec(perVecIndex)));            
            maxPos = colIndex;            
        end
    end
    
    tmpV = permVec;
    permVec(perVecIndex) = tmpV(maxPos);
    permVec(maxPos) = tmpV(perVecIndex);
       
    for i = 1 : 1 : n
        if i ~= perVecIndex
            foo = A(permVec(i), perVecIndex) / A(permVec(perVecIndex), perVecIndex);
            for j = perVecIndex : 1 : n
                A(permVec(i), j) = A(permVec(i), j) - A(permVec(perVecIndex), j) * foo;                       
            end
            b(permVec(i)) = b(permVec(i)) - b(permVec(perVecIndex)) * foo;
        else 
            if abs(A(i,i)) < tol && abs(A(i,i)) > 0
                error('singular')
            end
        end
    end
end

x = zeros(n, 1);
for i = 1 : 1 : n
    x(i) = b(permVec(i)) / A(permVec(i), i);
end
U = A
end 