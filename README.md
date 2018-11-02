[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/sukru-yalcinkaya/unipoly/master)

Introduction: This GAP code is prepared to construct a unipotent element in the groups SO(3,q)=PGL(2,q), q odd, as explained in the paper “Adjoint representations of black box groups PSL(2,q), q odd”. The GAP code is only slightly varies from the justification presented in the paper which results in a slightly faster algorithm.

It is important to note that our code treats the input groups as black box groups, that is, it does not use any specific features of the representation of the input group. Also, our code uses GAP as a black box, that is, our code does not use any specific group theoretic features of GAP, the only group theoretic functionality of GAP used is to do group multiplication, taking inverses and checking whether group elements are same. 

Input: Our codes takes a list of generators and an exponent of the groups SO(3,q), q>3 odd as an input. As PGL(2,q) is isomorphic to SO(3,q), one can use the generators of PGL(2,q), q odd, as well. It should be taken into consideration that one can input much bigger fields in GAP when the matrix groups SO(3,q) is used. 

We use the order of the group for the exponent of the input group.  As the groups in consideration are in GAP Library, their orders are known. 

If one uses very small prime fields like q=5,7,11 etc. unipotent elements appear frequently during random computations and therefore our code can return an answer before it does everything it designed to do so to construct a unipotent element.

Output: The output has the following format:
	•	It is a list consisting of 4 entries.
	•	The first entry of the output is a confirmation that a unipotent element is constructed. 
	•	The second and the third entry of the list are involutions (elements of order 2). 
	•	The fourth entry of the list is the unipotent element which is a product of the involutions in the second and third entry.

Demonstration: We demonstrate how our algorithm should be run with the following example.
```
gap> G:=SO(3,101^2);; S:=GeneratorsOfGroup(G);; exp:=Order(G);;
gap> u:=unipoly(S,exp);
[ true, [ [ Z(101^2)^5944, Z(101^2)^5558, Z(101^2)^8301 ], [ Z(101^2)^8668, Z(101^2)^5944, Z(101^2)^4756 ], 
      [ Z(101^2)^4858, Z(101^2)^8403, Z(101^2)^885 ] ], 
  [ [ Z(101^2)^4628, Z(101^2)^2578, Z(101^2)^6153 ], [ Z(101^2)^6490, Z(101^2)^4628, Z(101^2)^8109 ], 
      [ Z(101^2)^8211, Z(101^2)^6255, Z(101^2)^4352 ] ], 
  [ [ Z(101^2)^9692, Z(101^2)^9480, Z(101^2)^1936 ], [ Z(101^2)^5848, Z(101^2)^8720, Z(101^2)^4734 ], 
      [ Z(101^2)^5322, Z(101^2)^1552, Z(101^2)^4089 ] ] ]
gap> Order(u[2]);
2
gap> Order(u[3]);
2
gap> Order(u[4]);
101
gap> u[2]*u[3]=u[4];
true
```
