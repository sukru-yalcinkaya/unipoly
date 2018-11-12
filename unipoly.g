invo:=function(G,Eo)
# returns an involution produced from a random element in the group G.
# We assume that the distribution of the elements of even order in the group G
# is pretty high, which is the case for Lie type groups of odd characteristic.

local id,seek,g,finished;

id:=Identity(G);
seek:=false;
    while not seek do
        g:=PseudoRandom(G);
            if g^Eo=id then
                seek:=false;
            else
                g:=g^Eo;
                finished:=false;
                    while not finished do
                        if g^2=id then
                            return g;
                        else
                            g:=g^2;
                        fi;
                    od;
            fi;
    od;
end;
################################################################################
################################################################################
################################################################################
invoeven:=function(g,id)
# returns an involution produced from an element "g" of even order.
# It is known that "g" has even order for this function.

local finished;

finished:=false;
	while not finished do
			if g^2=id then
				return g;
			else
				g:=g^2;
			fi;
	od;
end;
################################################################################
################################################################################
################################################################################
is4div:=function(g,id,Eo)
# Here, "g" belongs to a group with an exponent "E" and "Eo" is the odd part
# of the exponent "E", and "id" is the identity of the group.
# This function returns the truth value whether the order of "g" is divisible by 4.

g:=g^Eo;
	if g=id or g^2 = id then
		return false;
	else
		return true;
	fi;
end;
################################################################################
################################################################################
################################################################################
eltor4:=function(g,id,Eo)
# This function is used precisely when the order of "g" is divisible by 4 and
# it returns an element of order 4 in the cyclic group generated by "g".
# Here, "id" is the group identity.

local finished;

g:=g^Eo;
finished:=false;
	while not finished do
		if (g <> id) and (g^2 <> id) and (g^4 = id) then
			return g;
		else
			g:=g^2;
		fi;
	od;
end;
################################################################################
################################################################################
################################################################################
ds:=function(G)

# returns some generators for the derived subgroup of the group "G".

local i,j,z,g,h,l;

l:=[];
i:=1;
   while i <= 20 do
    z:=Identity(G);
       for j in [1..10] do
        g:=PseudoRandom(G);
        h:=PseudoRandom(G);
        z:=g^(-1)*h^(-1)*g*h*z;
       od;
    l[i]:=z;
    i:=i+1;
   od;
return l;
end;
################################################################################
################################################################################
################################################################################
cent:=function(t,G,Eo)
# Here, "G" is a group and "t" is an involution in "G".
# This function returns some generators of the centralizer
# of "t" in "G", "C_G(t)", by using only the map "zeta_1".

local id,l,seek,i,j,x,y,o;

id:=Identity(G);
l:=[];
	for i in [1..40] do
		seek:=false;
			while not seek do
				x:=PseudoRandom(G);
				y:=t*t^x;
					if y^Eo=id then
						l[i]:=(y^((Eo+1)/2))*x^(-1);
						seek:=true;
					else
						seek:=false;
					fi;
			od;
	od;
return l;
end;
################################################################################
################################################################################
################################################################################
permij:=function(s,i,j,Eo)
# Here, "s" is a list of generators of a group "PSL(2,q)" or "PGL(2,q)", "q" odd.
# "i" and "j" are commuting conjugate involutions.
# This function returns an element of order 3 in the normaliser of i,j,i*j.
# The output conjugates in the following way: i--> j --> i*j --> i.

local x,id,g1,g2,g3,finished,g,h1,h2,h3,t1,y1,f1,z1,u1;

x:=Group(s);
id:=Identity(x);
g1:=i;
g2:=j;
g3:=i*j;
finished:=false;
	while not finished do
		g:=PseudoRandom(x);
		h1:=g1^g;
		h2:=g2^g;
		h3:=g3^g;
			if (g1*h2)^Eo = id then
				t1:=g1*h2;
				y1:=t1^((Eo+1)/2);
				f1:=g3^(g*(y1^-1));
					if (g2*f1)^Eo = id then
						finished:=true;
						z1:=g2*f1;
						u1:=z1^((Eo+1)/2);
					else
						finished:=false;
					fi;
			else
				finished:=false;
			fi;
	od;
return (g*(y1^-1)*(u1^-1))^2;
end;
################################################################################
################################################################################
################################################################################
unipotency:=function(s,i,j,Eo)
# Here, "s" is a list of generators of the group PGL(2,q)=SO(3,q) or PSL(2,q)
# "q" odd, and "i" and "j" are involutions.
# This function returns the truth value whether the product "i*j" is a
# unipotent element or not.

local x,id,u,ci,found,ti;

x:=Group(s);
id:=Identity(x);
u:=i*j;
ci:=Group(cent(i,x,Eo));
found:=false;
	while not found do
		ti:=PseudoRandom(ci);
			if (ti<>id) and (ti^2<>id) and (ti^3<>id) then
				found:=true;
			fi;
	od;
	if (u<>u^ti) and ((u*(u^ti)*(u^-1))*((u^ti)^-1)=id) and (u<>id) and (u^2<>id) then
		return true;
	else
		return false;
	fi;
end;
################################################################################
################################################################################
################################################################################
reif:=function(s,i,j,Eo)
# Here, "s" is a list of generators for PGL(2,q)=SO(3,q), q odd.
# "i" and "j" are commuting involutions.
# If there exists an involution commuting with "i" and "j", it returns [false,g], where
# "g" is the desired involution commuting with both "i" and "j".
# Otherwise, the product "i*j" is unipotent and it returns the list [true, i,j,i*j].

local x,id,r,rr,vi,ci,l,count,g,R,T,ll,r1,r2,r3,t1,t2,t3,g2,h2,hh2,z2,dill,found,gg,k;

#########
# We first check for unipotency. If fails, then we start the procedure to
# construct desired involution.
#########
	if unipotency(s,i,j,Eo) then
		return [true,i,j,i*j];
	else
		x:=Group(s);
		id:=Identity(x);
		r:=i*j;
		rr:=r^Eo;
			if r^Eo <> id then
				return [false, invoeven(rr,id)];
			else
				vi:=cent(i,x,Eo);
				ci:=Group(vi);
				l:=[];
				count:=1;
					while count <= 20 do
						g:=PseudoRandom(ci);
							if (g <> id) and (g^2 <> id) and (g^3 <> id) then
								l[count]:=g;
								count:=count+1;
							fi;
					od;
				R:=Group(r);
				T:=Group(l);
				ll:=[];
########
# For the construction of the centralizer of the desired involution, we use
# the word ”w1*z1*w2*z2*w3*z3” where z1, z2, z3 are elements from the group
# R and w1, w2, w3 are elements from the group T.
########
					for k in [1..50] do
						r1:=PseudoRandom(R);
						r2:=PseudoRandom(R);
						r3:=PseudoRandom(R);
						t1:=PseudoRandom(T);
						t2:=PseudoRandom(T);
						t3:=PseudoRandom(T);
						g2:=r1*t1*r2*t2*r3*t3;
						h2:=(r1*(t1^-1)*r2*(t2^-1)*r3*(t3^-1))*((t3^-1)*(r3^-1)*(t2^-1)*(r2^-1)*(t1^-1)*(r1^-1));
						hh2:=h2^Eo;
							if hh2 = id then
								z2:=(h2^((Eo+1)/2))*g2;
							else
								z2:=invoeven(hh2,id);
							fi;
						ll[k]:=z2;
					od;
				dill:=Group(ll);
#######
# Now, we try to locate the central involution in the centre of the centralizer
# of the desired involution.
#######
				found:=false;
					while not found do
						g:=PseudoRandom(dill);
						gg:=g^Eo;
							if (gg <> id) and (g <> id) and (g^2 <> id) and (g^3 <> id) then
								g:=invoeven(gg,id);
									if (g*i=i*g) and (g*j=j*g) then
										return [false,g];
									fi;
							fi;
					od;
			fi;
	fi;
end;
################################################################################
################################################################################
################################################################################
inter:=function(s,i1,i2,j1,j2,Eo)
# Here, "s" is a list of generators for PGL(2,q), q odd.
# The function constructs the intersection of the lines passing thru "i1,i2" and "j1,j2".
# It returns either
# [false, P] where "P" is an involution corresponding to the intersection; or
# [true, P1,P2,P3] where "P1,P2" are involutions and "P3=P1*P2" is a unipotent element.

local z1,z2;

z1:=reif(s,i1,i2,Eo);
if z1[1]=true then
   return z1;
fi;
z2:=reif(s,j1,j2,Eo);
if z2[1]=true then
   return z2;
fi;
return reif(s,z1[2],z2[2],Eo);
end;
################################################################################
################################################################################
################################################################################
unity:=function(s,i1,j1,k1,ti1,sc)
# Here, "s" is a list of generators for PGL(2,q), q odd.
# "i1,j1,k1" are involutions determining a basis triangle for the projective geometry.
# "ti1" is an element of order 4 in C_G(i) whose square is "i1"
# "sc" is an element of order 3 permuting "i1,j1,k1".
# This function returns either
# [false, P1,P2,P3] where "P1,P2,P3" are unit elements on the lines "j1vk1",
# "i1vk1" and "i1vj1" respectively; or
# [true, P1,P2,P3] where "P1,P2" are involutions with "P3=P1*P2" is a unipotent element.

local x,id,N,lli,llj,llk,i,j,k,g,found,gi,gj,gk;

x:=Group(s);
id:=Identity(x);
N:=[id, ti1, ti1^2, ti1^3, j1, ti1*j1, (ti1^2)*j1, (ti1^3)*j1, sc, ti1*sc, (ti1^2)*sc, (ti1^3)*sc, j1*sc, ti1*j1*sc, (ti1^2)*j1*sc, (ti1^3)*j1*sc,   sc^2,  ti1*sc^2, (ti1^2)*sc^2, (ti1^3)*sc^2, j1*sc^2, ti1*j1*sc^2, (ti1^2)*j1*sc^2,(ti1^3)*j1*sc^2 ];
lli:=[];
llj:=[];
llk:=[];
i:=1;
j:=1;
k:=1;
	for g in N do
		if (g <> id) and (g^2 = id) and (j1^g=k1) then
			lli[i]:=g;
			i:=i+1;
		fi;
	od;
	for g in N do
		if (g <> id) and (g^2 = id) and (i1^g=k1) then
			llj[j]:=g;
			j:=j+1;
		fi;
	od;
	for g in N do
		if (g <> id) and (g^2 = id) and (i1^g=j1) then
			llk[k]:=g;
			k:=k+1;
		fi;
	od;
found:=false;
	for gi in lli do
		for gj in llj do
			for gk in llk do
				if gk^gj=gi and gi^sc=gj and gi^(sc^2)=gk then
					return [gi,gj,gk];
				fi;
			od;
		od;
	od;
end;
################################################################################
################################################################################
################################################################################
add:=function(s,mid,i1,j1,k1,a,b,Eo)
# Here, "s" is a list of generators for PGL(2,q), q odd.
# "i1,j1,k1" are involutions determining a basis triangle for the projective geometry.
# "mid" is the point corresponding to [1,1,1] in the triangle "i1,j1,k1".
# "a" and "b" are two points on the axis "j1 v k1". Here, "j1=0", "k1=\infty".
# This function computes "a+b" on the axis "j1 v k1".
# It returns either
# [false, P] where "P" is an involution corresponding to "a+b"; or
# [true, P1,P2,P3] where "P1,P2" are involutions with "P3=P1*P2" is a unipotent element.

local aprime,bprime,ab,se;

aprime:=inter(s,i1,a,mid,k1,Eo);
	if aprime[1]=true then
		return aprime;
	fi;
se:=inter(s,mid,k1,i1,j1,Eo);
	if se[1]=true then
		return se;
	fi;
bprime:=inter(s,i1,k1,b,se[2],Eo);
	if bprime[1]=true then
		return bprime;
	fi;
ab:=inter(s,j1,k1,aprime[2],bprime[2],Eo);
	if ab[1]=true then
		return ab;
	else
		return ab;
	fi;
end;
################################################################################
################################################################################
################################################################################
mult:=function(s,mid,i1,j1,k1,a,b,Eo)
# Here, "s" is a list of generators for PGL(2,q), q odd.
# "i1,j1,k1" are involutions determining a basis triangle for the projective geometry.
# "mid" is the point corresponding to [1,1,1] in the triangle "i1,j1,k1".
# "a" and "b" are two points on the axis "j1 v k1". Here, "j1=0", "k1=\infty".
# This function computes "a \times b" on the axis "j1 v k1".
# It returns either
# [false, P] where "P" is an involution corresponding to "a\times b"; or
# [true, P1,P2,P3] where "P1,P2" are involutions with "P3=P1*P2" is a unipotent element.

local aprime,bprime,ab;

aprime:=inter(s,i1,a,j1,mid,Eo);
	if aprime[1]=true then
		return aprime;
	fi;
bprime:=inter(s,b,mid,i1,k1,Eo);
	if bprime[1]=true then
		return bprime;
	fi;
ab:=inter(s,aprime[2],bprime[2],j1,k1,Eo);
return ab;
end;
################################################################################
################################################################################
################################################################################
log2:=function(n)
# returns a list consisting of natural numbers with which 2-powers add up to "n".

local l,stop,finished,i,j,k,a;

l:=[];
stop:=false;
finished:=false;
i:=0;
	while not stop do
		if 2^i=n then
			stop:=true;
			finished:=true;
		elif  2^i > n then
			stop:=true;
			i:=i-1;
		else
			i:=i+1;
		fi;
	od;
l[1]:=i;
n:=n-2^i;
k:=2;
	while not finished do
		stop:=false;
		j:=1;
			while not stop do
				a:=2^(i-j);
					if a = n then
						stop:=true;
						finished:=true;
						l[k]:=i-j;
					elif a > n then
						stop:=false;
						j:=j+1;
					else
						stop:=true;
						l[k]:=i-j;
						i:=i-j;
						k:=k+1;
						n:=n-a;
					fi;
			od;
	od;
return l;
end;
################################################################################
################################################################################
################################################################################
multo:=function(s,mid,i1,j1,k1,di1,a,l,Eo)

# Here, "s" is a list of generators for PGL(2,q), q odd.
# "i1,j1,k1" are involutions determining a basis triangle for the projective geometry.
# "mid" is the point corresponding to [1,1,1] in the triangle "i1,j1,k1".
# "di1" is the unity element on the "j1 v k1" axis.
# "l" is a list of natural numbers with which the 2-powers add up to a
# natural number "n".
# "a" is an element in the black box field associated to the axis "j1 v k1".
# This function returns the value "a^n" on the axis "j1 v k1".

local M,0in,x,k,i,y,f,ll;

M:=Maximum(l);
	if 0 in l then
		0in:=true;
	else
		0in:=false;
	fi;
ll:=[];
x:=a;
k:=1;
	for i in [1..M] do
			if i in l then
				x:=mult(s,mid,i1,j1,k1,x,x,Eo);
					if x[1]=true then
						return x;
					else
						x:=x[2];
					fi;
				ll[k]:=x;
				k:=k+1;
			else
				x:=mult(s,mid,i1,j1,k1,x,x,Eo);
					if x[1]=true then
						return x;
					else
						x:=x[2];
					fi;
			fi;
	od;
	if Length(ll)=0 then
		return di1;
	else
		y:=ll[1];
			for f in [2..(k-1)] do
				y:=mult(s,mid,i1,j1,k1,y,ll[f],Eo);
					if y[1]=true then
						return y;
					else
						y:=y[2];
					fi;
			od;
	fi;
	if 0in=true then
		return mult(s,mid,i1,j1,k1,y,a,Eo);
	else
		return [false,y];
	fi;
end;
################################################################################
################################################################################
################################################################################
unipoly:=function(s,E)
# "s" is a list of generators of G=PGL(2,q), "q" odd, and "E" is an exponent for "G".
# This function returns a list “l” where
# l[1] is a truth value whether it succeeds to produce unipotent element.
# l[2] and l[3] are two involutions whose product is a unipotent element.
# l[4] is a unipotent element which is the product of l[2] and l[3].


local L,i,finished1,Ee,Eo,x,id,i1,ci1,found,count,ti1,j1,cj1,tj1,k1,sc,m,di1,dj1,mid,a2,l,nn,finished,t1,t2,tt1,tt2,tt3,ss,sqrttt3,x1,x2,candi;
###############
# Finding the odd and even part of the exponent "E".
###############
L:=E;
i:=0;
finished1:=false;
	while not finished1 do
		if L mod 2 = 0 then
			L:=L/2;
			i:=i+1;
		else
			finished1:=true;
		fi;
	od;
Ee:=i;
Eo:=E/(2^Ee);
##############
# Exponent is decomposed into odd and even part.
##############
##############
# Constructing a basis of the projective geometry
##############
x:=Group(s);
id:=Identity(x);
finished1:=false;
	while not finished1 do
		i1:=invo(x,Eo);
		ci1:=Group(cent(i1,x,Eo));
		found:=false;
		count:=1;
			while (not found) and (count<=20) do
				ti1:=PseudoRandom(ci1);
					if is4div(ti1,id,Eo) then
						found:=true;
						finished1:=true;
					else
						count:=count+1;
					fi;
			od;
	od;
finished1:=false;
	while not finished1 do
		j1:=invo(ci1,Eo);
			if j1<>i1 then
				cj1:=Group(cent(j1,x,Eo));
				found:=false;
				count:=1;
					while (not found) and (count <=20) do
						tj1:=PseudoRandom(cj1);
							if is4div(tj1,id,Eo) then
								found:=true;
								finished1:=true;
							else
								count:=count+1;
							fi;
					od;
			else
				finished1:=false;
			fi;
	od;
k1:=i1*j1;
sc:=permij(s,i1,j1,Eo);;
ti1:=eltor4(ti1,id,Eo);
m:=unity(s,i1,j1,k1,ti1,sc);
di1:=m[1];
dj1:=m[2];
mid:=inter(s,i1,di1,j1,dj1,Eo);
	if mid[1]=true then
		return mid;
	else
		mid:=mid[2];
	fi;
a2:=add(s,mid,i1,j1,k1,di1,di1,Eo);
	if a2[1]=true then
		return a2;
	else
		a2:=a2[2];
	fi;
l:=log2(Eo);;
nn:=log2((Eo+1)/2);
finished:=false;
	while not finished do
		found:=false;
			while not found do
				t1:=PseudoRandom(ci1);
					if ((t1^2=id) and (t1<>i1) and (t1<>j1) and (t1<>k1)) then
						found:=true;
					fi;
			od;
		found:=false;
			while not found do
				t2:=PseudoRandom(ci1);
					if (t2<>t1) and (t2^2=id) and (t2<>i1) and (t2<>j1) and (t2<>k1) then
						found:=true;
					fi;
			od;
		tt1:=mult(s,mid,i1,j1,k1,t1,t1,Eo);
			if tt1[1]=true then
				return tt1;
			fi;
		tt2:=mult(s,mid,i1,j1,k1,t2,t2,Eo);
			if tt2[1]=true then
				return tt2;
			fi;
		tt3:=add(s,mid,i1,j1,k1,tt1[2]^j1,tt2[2]^j1,Eo);
			if tt3[1]=true then
				return tt3;
			fi;
		ss:=multo(s,mid,i1,j1,k1,di1,tt3[2],l,Eo);
			if ss[1]=true then
				return ss;
			elif ss[2]=di1 then
				finished:=true;
				sqrttt3:=multo(s,mid,i1,j1,k1,di1,tt3[2],nn,Eo);
					if sqrttt3[1]=true then
						return sqrttt3;
					fi;
				x1:=mult(s,mid,i1,j1,k1,t1,sqrttt3[2]^di1,Eo);
					if x1[1]=true then
						return x1;
					fi;
				x1:=x1[2];
				x2:=mult(s,mid,i1,j1,k1,t2,sqrttt3[2]^di1,Eo);
					if x2[1]=true then
						return x2;
					fi;
				x2:=x2[2]^dj1;
				candi:=inter(s,i1,x1,k1,x2,Eo);
					if candi[1]=true then
						return candi;
					fi;
			elif mult(s,mid,i1,j1,k1,ss[2],ss[2],Eo)[2] <> di1 then
				i:=1;
					while i<=Ee do
						ss:=mult(s,mid,i1,j1,k1,ss[2],ss[2],Eo);
							if ss[1]=true then
								return ss;
							else
								i:=i+1;
							fi;
					od;
			else
			fi;
	od;
end;