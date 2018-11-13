# Test file
#
# To run the test, call 
#
#     Read("unipoly.g");
#     Test("unipoly.tst");
#
# in GAP (use full paths, if necessary)
#
# First, a single example
#
gap> INFO_UUU:=InfoLevel(InfoUnipoly);;
gap> SetInfoLevel(InfoUnipoly,0);
gap> G:=SO(3,17^2); S:=GeneratorsOfGroup(G);; exp:=Order(G);
SO(0,3,289)
24137280
gap> u:=unipoly(S,exp);;
gap> Order(u[2]);Order(u[3]);Order(u[4]);
2
2
17
gap> u[2]*u[3]=u[4];
true

# helper function 
gap> unipolytest:=function(p,n)
> local G, u;
> G := SO(3,p^n);
> u:=unipoly( GeneratorsOfGroup( G ), Size(G) );
> if u[1]<>true then
>   Error("u[1] <> true \n");
> elif Order(u[2]) <> 2 then
>   Error("Order(u[2]) <> 2 \n");
> elif Order(u[3]) <> 2 then
>   Error("Order(u[3]) <> 2 \n");
> elif Order(u[4]) <> p then
>   Error("Order(u[4]) <> p \n");
> elif u[2]*u[3] <> u[4] then
>   Error("u[2]*u[3] <> u[4] \n");
> else
>   return true;
> fi;
> end;
function( p, n ) ... end

# tests
#
# we use one line per test instead of writing a loop
# in order to make it easy to display the progress of
# the test and to see where it fails
#
gap> unipolytest(3,2);
true
gap> unipolytest(3,3);
true
gap> unipolytest(3,4);
true
gap> unipolytest(3,5);
true
gap> unipolytest(3,6);
true
gap> unipolytest(3,7);
true
gap> unipolytest(3,8);
true
gap> unipolytest(5,1);
true
gap> unipolytest(5,2);
true
gap> unipolytest(5,3);
true
gap> unipolytest(7,1);
true
gap> unipolytest(7,2);
true
gap> unipolytest(11,1);
true
gap> unipolytest(11,2);
true
gap> unipolytest(13,1);
true
gap> unipolytest(13,2);
true
gap> unipolytest(17,1);
true
gap> unipolytest(17,2);
true
gap> SetInfoLevel(InfoUnipoly,INFO_UUU);

# that's all!