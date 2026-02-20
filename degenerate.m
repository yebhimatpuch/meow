clc
clear all
clear figure
%phase 1 for input
c=[3 -5 0 0];
A=[1 1 1 0; 2 -1 0 -1];
b=[6;9];
z=@(X) c*X;
m=size(A,1);
n=size(A,2);

%phase 2
basicsol=[];
bfsol=[];
degenerate = [];
nondegenerate = [];

ncm=nchoosek(n,m);
pair=nchoosek(1:n,m);
for i=1:ncm
    basicvar_index=pair(i,:);
    X=A(:,basicvar_index)\b;
    y=zeros(n,1);
    y(basicvar_index)=X;
    basicsol=[basicsol y];
    if(X>=0)
        bfsol=[bfsol y];
        if(X==0)
            degenerate=[degenerate y];
        else
            nondegenerate=[nondegenerate y];
        end
    end
end
disp('BS:')
disp(basicsol)
disp('BFS:')
disp(bfsol)
disp('Degenerate BFS:')
disp(degenerate)
disp('Non-Degenerate BFS:')
disp(nondegenerate)

%phase 3 optimal solution and value
cost=z(bfsol);
[optval index]=min(cost);
optsol=bfsol(:,index);
disp(optsol);
