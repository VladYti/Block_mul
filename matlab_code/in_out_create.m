%% input files creating v1.0
clear;
% let n (martix size) be power of two
% so number of blocks must be power of two 
M = 5;
n = power(2, M); %matrix size


mb = tril(randn(n,n, "double"));
ma = triu(randn(n,n, "double"));


%% input files creating v2.0
lma=0;
lmb=0;

m = 3;
k = power(2, m); %number  of blocks


%elements per block (at shape[0])
epb = power(2, M-m);

%create two matrices
%mb = tril(randn(n,n, "double"));
%ma = triu(randn(n,n, "double"));

%writing  blocks of matrices as a list
serv = 0;
for j=0:k-1
    for i=0:k-1
        tmp1 = ma(1+(j*epb):epb+(j*epb), 1+(i*epb):epb+(i*epb));
        if  (tmp1(1,1) ~= 0)
            lma(1:epb, 1+(serv*epb):epb+(serv*epb)) = tmp1;
        else
            continue
        end
        
        tmp2 =  mb(1+(i*epb):epb+(i*epb), 1+(j*epb):epb+(j*epb));
        if (tmp2(1,1) ~= 0)
            lmb(1:epb, 1+(serv*epb):epb+(serv*epb)) = tmp2;
        else
            continue
        end
        
        serv = serv + 1;
    end
    
end

%number of writes blocks
count  = (k*k+k)/2;

%length of blocks list
lc = count * epb;

%%
mc = ma*mb;

%%
f = fopen('in0.bin','wb');
fwrite(f, n,'integer*8');

for i=1:n
    fwrite(f, ma(i, 1:n), 'real*8');
    fwrite(f, mb(i, 1:n), 'real*8');
end

fclose(f);
%% writing list of blocks at file
filename = 'in1.bin';
f = fopen(filename, 'wb');
fwrite(f, n,'integer*8');
fwrite(f, k,'integer*8');
fwrite(f, epb,'integer*8');
fwrite(f, lc,'integer*8');

for i=1:epb
    fwrite(f, lma(i, :), 'real*8');
    fwrite(f, lmb(i, :), 'real*8');
end
fclose(f);



%%

mc = ma*mb;
%% test output reading 
n = 32;
outp = fopen('output_file.bin', 'r');


for j=1:n
    matrix_C(j, :) =  fread(outp,[1,n], 'real*8');
    if feof(outp) break; end
end

fclose(outp);
%%
f = fopen('f0.bin','r');
n = fread(f, 1, 'integer*8');

for i=1:n
    MA(i, :) = fread(f, [1,n], 'real*8');
    MB(i, :) = fread(f, [1,n], 'real*8');
     if feof(f) break; end
end
fclose(f);
%%
     
a = round(mc, 5);
b = round(matrix_C, 5);
tf = isequal(a, b);
    






















