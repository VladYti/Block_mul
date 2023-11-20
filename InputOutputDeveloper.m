%%Input
clear;
n = 10;
Amat = triu(randi(5,n,n));
Bmat = tril(randi(6,n,n));
Cmat = Amat * Bmat;
inputer = fopen('f1.bin','wb');
fwrite(inputer, n,'int8');

for i=1:n
    fwrite(inputer, Amat(i, 1:n), 'real*8');
    fwrite(inputer, Bmat(i, 1:n), 'real*8');
end

fclose(inputer);

%%
n = 10;
outp = fopen('output_file.dat', 'r');

for i=1:n
    matrix_C(i, :) =  fread(outp, [1,n], 'real*8');
end

fclose(outp);
