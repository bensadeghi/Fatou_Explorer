function J = jet2(m)
if nargin < 1
   m = size(get(gcf,'colormap'),1);
end
n = ceil(m/4);
u = [(1:1:n)/n ones(1,n-1) (n:-1:1)/n]';
g = ceil(n/2) - (mod(m,4)==1) + (1:length(u))';
r = g + n;
b = g - n;
g(g>m) = [];
r(r>m) = [];
b(b<1) = [];
J = zeros(m,3);
J(r,1) = u(1:length(r));
J(g,2) = u(1:length(g));
J(b,3) = u(end-length(b)+1:end);
J(1,:)=0;
J(end,:)=0;