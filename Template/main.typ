#import "@preview/cetz:0.4.2": canvas, draw
#import "lib/snippets.typ": definition, proof
#import "lib/lib.typ"

#set page(
  header: lib.header(
    lva_name: "Introduction to Computational Complexity",
    matr_nr: "k1241678",
    student_name: "Thomas Rafetseder",
    student_name1: "Simon Feiler",
    student_name2: "Florian Burghuber",
    title: "",
  ),
)

= 3-Coloring problem is NP-complete

== Introduction

== What is the coloring problem?
Given a graph $G(V,E)$, the graph coloring problem assigns a color-mapping for each vertex to its corresponding color $c: V(G) -> {1,2,...,k}$
for which $forall(u, v) in E(G): c(u) != c(v)$ for any two vertices $u,v in G$ and a number $k in NN$.
If this statement holds, we can call the graph *proper*.

The k-coloring problem asks if a given graph $G$ can be properly colored using at most $k$ distinct colors. 
If such a satisfying mapping exists, we may call the mapping proper k-coloring.

== 3-Coloring problem
For our following proof we explicitly decided to do the proof for the *3-coloring-problem*. 
That is because the 3-coloring problem is the smallest coloring problem which is contained in *NP*. \
The 2-coloring problem is contained in *P*. 
We can easily solve this in $O(n)$ using something like Breadth-first search for example. 

If we can prove that 3-Coloring is *NP-complete*, then 4-Coloring, 5-Coloring, ..., k-Coloring are NP-complete as well, since 3-Coloring is 
just a restriction of them.

== Justification of problem choice
The graph coloring problem caught our attention due to us being already introduced to this problem in the lecture _Logic_ before.

The fact that the nature of this problem is easily recognisable, and may be even understood by a child, 
but requires deeper knowledge and understanding when trying to get a hold of efficient solving and ultimately proving its 
membership in *NP-completeness*, was appealing to us.

We believe, that the choice of this problem will lead us to a deeper understanding of the concept of _Karp reduction_
and the wide-ranging impact it has on theoretical computer science.

== Theorem: 3-Coloring is in NP
#definition()[
 A language $𝐴 in {0, 1}^*$ is in NP if there
exist polynomials $𝑝, 𝑞 : NN → NN$ and a TM $M$ (verifier) with the following two properties: \
\
- Completeness: if $x in A$, then there exists a short certificate $y in {0, 1}^*$ with $"|"y"|"= p"(|"x"|")$ such that $M(x, y)$ = accept after (at most) $q"(|"x"|)"$ steps. \
- Soundness: else if $𝑥 in.not 𝐴$, then  $M(x,y)$ = reject for all possible certificates $y in {0, 1}^*$
]
#proof[
To show that the problem is in NP, our verifier $M$ takes the Graph $G(V,E)$ and our color mapping $c$ as input and checks in $O(n^2)$ if $c$ is a satisfying mapping. \ 
$M$ does this by accepting if the two connected vertices $u,v in V$ of every edge $e in E$ have 2 distinct colors.
It is easy to show that the verifier only takes max. $n^2$ steps for verifing that $c$ is a satisfying mapping. In a graph G with n vertices, each vertex can be connected to max n-1 other vertices.
The result is a complete graph. Please note, that in graph coloring, we ignore edges $e = (v,v) in E$ where $v in V$ (loops).
Now the verifier iterates over n vertices and for each vertex checks n-1 adjacent vertices for distinct coloring. In other words, the verifier checks $n dot (n-1)$ edges $e in E$.
If an edge (v,u) was checked for distinct coloring, the two vertices do not have to be checked again in the reverse direction in another iteration. In other words, we can half the number of edges that need to be checked.
In total, the verifier executes in $(n dot (n-1))/2 in O(n^2)$ steps.
This proofs that 3-coloring is in NP.
]
== Theorem: 3-Coloring is NP-hard
#proof[
We want to show that 3-Coloring is NP-hard by reducing from 3-SAT which is known to be NP-complete. \
We have an arbitary 3-SAT formula F. We have a language L = {x $in {0,1}^*$: F(x) = 1} $in {0,1}^*$ and a language L' = {c $in {0,1}^*$: c is valid 3-coloring of graph G} $in {0,1}^*$.
In words, L contains all valid assignments for F and L' contains all valid 3-colorings for a graph G.
We now create a polynomial-time algorithm f(x) that maps elements from L to L' and elements of $overline(L)$ to elements of $overline(L')$.
Further, we create an algorithm that returns 1 iff f(x) $in L'$ iff x $in L$.
What we can already guess is, that the 3-SAT formula somehow needs to be mapped to a 3-colored graph. This mapping f(x) has to happen in polynomial time in order for 3-coloring to be NP-complete. \ \
In the following proof we will show that the polynomial time function f(x) exists $forall(x) in L$. \

=== 3-SAT formula
A 3-SAT formula is in Conjunctive-Normal-Form (CNF). It has $m$ clauses, where each clause consists of 3 literals. \
A literal is either a variable $v in {"x1,x2,x3"}$ or the negation of a variable $v in {overline("x1"), overline("x2"), overline("x3")}$. \
Clauses are connected by a logical AND ($and$), whereas literals are connected by a logical OR ($or$).
Examples of CNFs: \
(x1 $or$ x2 $or$ x3), \
(x1 $or$ $overline("x2")$ $or$ x3) $and$ ($overline("x1")$ $or$ x2 $or$ $overline("x3")$) \

=== Mapping variables to vertices
A boolean variable can have two values True or False. To represent two distinct values in our graph, we can introduce two colors $c_1$, $c_2$ where $c_1 eq.not c_2$.
We use the color green for True and red for False. \
Furthermore we assume that our CNF formula has 3 new variables for every clause m. This is the worst case scenario for our CNF formula, resulting in $3 dot m$ variables $x_i in {x_1, ..., x_"3m"}$.
For each of these variables $x_i$ we introduce 2 vertices in our graph: \

#figure(
  canvas({
    import draw: *

    let node-radius = 0.7
	let stroke-thickness = 2pt
    let node-fill = white
    let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red

    circle((0.0, 3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "v1")
    content("v1", [$x_i$]) 

    circle((4.0, 3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "v2")
    content("v2", [$overline(x_i)$])


    line("v1", "v2")
    line("v2", "v1")
  }),
  caption: [Variable coloring]
)

We already see, that the vertices have two distinct colors. The vertices are connected by an edge to force $x_i eq.not overline(x_i)$, which is always the case. 
As we are doing a 3-coloring, one color is still missing. How can we make sure that the vertices $x_i$ and $overline(x_i)$ are always colored with exactly 2 colors, when there are 3 colors to choose from?
We somehow need to force $x_i$ and $overline(x_i)$ to only be of colors green and red. Let's introduce the color blue as our third color to the graph.

#figure(
  canvas({
    import draw: *

    let node-radius = 0.7
	let stroke-thickness = 2pt
    let node-fill = white
    let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue

    circle((0.0, 3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "v1")
    content("v1", [$x_i$]) 

    circle((4.0, 3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "v2")
    content("v2", [$overline(x_i)$])

    circle((2.0, 0.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "v3")
    content("v3", [B])

    line("v1", "v2")
    line("v2", "v3")
	line("v3", "v1")
  }),
  caption: [Color triangle]
)

We have connected $x_i$ and $overline(x_i)$ to the vertex $B$. This forces $x_i$ and $overline(x_i)$ to be of colors green and red, because otherwise we would no longer have a valid 3-coloring.
We call this process trapping. A vertex or multiple vertices are trapped to have a subset of colors. 
With the concept of trapping, we can make sure that the variables form a valid boolean assignment. We can now build a logical or ($or$) clause.

=== 2-literal clauses: Introducing the gadget
Let's assume we have a clause with only 2 literals: $x_1 or x_2$. This clause is false iff $x_1=0 "and" x_2=0$ and true in all other cases. To achive this logic, we introduce a new graph and call it gadget: \

#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, name: "x1")
    content("x1", $x_1$)
    circle((0, 2), ..white-node-style, name: "x2")
    content("x2", $x_2$)

    circle((2.5, 4), ..gray-node-style, name: "g1")
    circle((2.5, 2), ..gray-node-style, name: "g2")

    circle((5, 3), ..gray-node-style, name: "g3")
    content((5, 3 + label-offset), $x_1 or x_2$)

    line("x1", "g1")
    line("x2", "g2")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")
  }),
  caption: [Gadget graph for 2 literals]
)

Our vertices $x_1$ and $x_2$ represent the input assignment. Let the vertex $x_1 or x_2$ represent the output. So for the given clause $x_1 or x_2$, the vertex to the very right should be green, when either or both vertices $x_1$, $x_2$ are green.
In total we have $2^2$ input assignments. Let's see if we can achive a valid 3-coloring of the gadget graph for every assignment: \

#columns(2)[
#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "x1")
    content("x1", $x_1$)
    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "x2")
    content("x2", $x_2$)

    circle((2.5, 4), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g1")
    circle((2.5, 2), ..gray-node-style, name: "g2")

    circle((5, 3), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g3")
    content((5, 3 + label-offset), $x_1 or x_2$)

    line("x1", "g1")
    line("x2", "g2")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")
  }),
  caption: [$overline(x_1) or overline(x_2)$]
) <fig_notx1_notx2>

\

#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "x1")
    content("x1", $x_1$)
    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "x2")
    content("x2", $x_2$)

    circle((2.5, 4), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g1")
    circle((2.5, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g2")

    circle((5, 3), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g3")
    content((5, 3 + label-offset), $x_1 or x_2$)

    line("x1", "g1")
    line("x2", "g2")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")
  }),
  caption: [$overline(x_1) or x_2$]
)

#colbreak()

#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "x1")
    content("x1", $x_1$)
    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "x2")
    content("x2", $x_2$)

    circle((2.5, 4), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g1")
    circle((2.5, 2), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g2")

    circle((5, 3), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g3")
    content((5, 3 + label-offset), $x_1 or x_2$)

    line("x1", "g1")
    line("x2", "g2")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")
  }),
  caption: [$x_1 or overline(x_2)$]
)

\

#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "x1")
    content("x1", $x_1$)
    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "x2")
    content("x2", $x_2$)

    circle((2.5, 4), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g1")
    circle((2.5, 2), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g2")

    circle((5, 3), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g3")
    content((5, 3 + label-offset), $x_1 or x_2$)

    line("x1", "g1")
    line("x2", "g2")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")
  }),
  caption: [$x_1 or x_2$]
)]

We can see in figure @fig_notx1_notx2 that there is no valid 3-coloring for $overline(x_1) or overline(x_2)$. This is exactly the behaviour we want: 
The graph should not be colorable iff the input assignment is not valid, which is the case for $overline(x_1) or overline(x_2)$.

=== 3-literal clauses
How can we extend the 2-Literal gadget in order to support 3 literals? \
We want something like this: If our 2-literal gadget has a valid 3-coloring, the 3-literal gadget should also have a valid 3-coloring.
If the 2-literal gadget is invalid, there is still a chance, that our third literal, that we are introducing now, is valid and therefor the entire graph should be valid again. \
This is tricky. We cannot proceed with the same coloring that we used in the 2-literal graph because of the case in @fig_notx1_notx2. \
Here is why: Assume we have a 3-literal assignement: ($overline(x_1) or overline(x_2) or x_3$). Until now, our 2-literal gadget only processed $overline(x_1) or overline(x_2)$ and fails with a valid 3-coloring.
But what aboud $x_3$? This single literal can still make the entire clause true. We need to do two things while constructing the 3-literal gadget: Add the new literal $x_3$ to the 2-literal gadget and adapt the coloring strategy that we used for the 2-literal gadget. \
We follow the same approach as before: All input literals are to the very left of the graph and a single green vertex is on the very right. \

#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, name: "x1")
    content("x1", $x_1$)
    circle((0, 2), ..white-node-style, name: "x2")
    content("x2", $x_2$)
    circle((0, 0), ..white-node-style, name: "x3")
    content("x3", $x_3$)

    circle((2.5, 4), ..gray-node-style, name: "g1")
    circle((2.5, 2), ..gray-node-style, name: "g2")

    circle((5, 3), ..gray-node-style, name: "g3")
    content((5, 3 + label-offset), $x_1 or x_2$)

    circle((7.5, 3), ..gray-node-style, name: "g4")
    circle((7.5, 0), ..gray-node-style, name: "g5")

	circle((10, 1.5), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((10, 1.5 + label-offset), $x_1 or x_2 or x_3$)

    line("x1", "g1")
    line("x2", "g2")
    line("x3", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [Gadget graph for 3-literals]
)

In total we have 2^3 input assignments. Let’s see if we can achive a valid 3-coloring of the gadget graph for every assignment:

#pagebreak()

#columns(2)[
#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..gray-node-style, name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$overline(x_1) or overline(x_2) or overline(x_3)$]
)

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$overline(x_1) or overline(x_2) or x_3$]
)

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$overline(x_1) or x_2 or overline(x_3)$]
)

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$overline(x_1) or x_2 or x_3$]
)

#colbreak()

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$x_1 or overline(x_2) or overline(x_3)$]
)

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$x_1 or overline(x_2) or x_3$]
)

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$x_1 or x_2 or overline(x_3)$]
)

#figure(
    canvas({
    import draw: *

    let node-radius = 0.3
	let node-stroke-black = black
    let node-stroke-green = green
    let node-stroke-red = red
	let node-stroke-blue = blue
	let stroke-thickness = 2pt
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 2), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "a")
    content("a", $a$)
    circle((0, 1), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "c")
    content("c", $c$)

    circle((1.25, 2), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g1")
    circle((1.25, 1), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g2")

    circle((2.5, 1.5), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g3")
    content((2.5, 1.5 + label-offset), $a or b$)

    circle((3.75, 1.5), ..white-node-style, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "g4")
    circle((3.75, 0), ..white-node-style, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "g5")

	circle((5, 0.75), ..white-node-style, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "g6")
    content((5, 0.75 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  }),
  caption: [$x_1 or x_2 or x_3$]
)
]

With the 3-literal gadget, we have proven soundness. If the assignment $x$ is not valid (all variable vertices are red), there is no valid coloring.
In every other case, there is a valid coloring. Formally , we have shown: $x in.not L <-> f(x) in.not L'$. 

We create Graph G and inside a Triangle with 3 colors T, F and B and connect every variable like this. \
#figure(
  canvas({
    import draw: *

    let node-radius = 0.7
	let stroke-thickness = 2pt
    let node-fill = white
    let node-stroke-black = black
    let node-stroke-blue = blue
    let node-stroke-red = red
    let node-stroke-green = green

    circle((0.0, 3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-green, thickness: stroke-thickness), name: "v1")
    content("v1", [T]) 

    circle((4.0, 3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-red, thickness: stroke-thickness), name: "v2")
    content("v2", [F])

    circle((2.0, 0.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-blue, thickness: stroke-thickness), name: "v3")
    content("v3", [B])

    circle((6.0, 1.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-black, thickness: stroke-thickness), name: "v4")
    content("v4", [$x_i$])

    circle((5.0, -1.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-black, thickness: stroke-thickness), name: "v5")
    content("v5", [$overline(x_i) $])

    circle((0.0, -3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-black, thickness: stroke-thickness), name: "v6")
    content("v6", [$x_2$])

    circle((3.0, -3.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-black, thickness: stroke-thickness), name: "v7")
    content("v7", [$overline(x_2) $])

    circle((-3.0, -0.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-black, thickness: stroke-thickness), name: "v8")
    content("v8", [$x_1$])

    circle((-2.0, -2.0), radius: node-radius, fill: node-fill, stroke: (paint: node-stroke-black, thickness: stroke-thickness), name: "v9")
    content("v9", [$overline(x_1) $])


    line("v1", "v2")
    line("v2", "v3")
    line("v3", "v1")
    line("v3", "v4")
    line("v3", "v5")
    line("v3", "v6")
    line("v3", "v7")
    line("v3", "v8")
    line("v3", "v9")
    line("v8", "v9")
    line("v7", "v6")
    line("v4", "v5")
  }),
)

Then we need to create for every clause a gadget like this and connect the literals to the corresponding variable nodes. \

#figure(
  canvas({
    import draw: *

    let node-radius = 0.5
    let white-node-style = (fill: white, stroke: black, radius: node-radius)
    let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
    let label-offset = 0.7


    circle((0, 4), ..white-node-style, name: "a")
    content("a", $a$)
    circle((0, 2), ..white-node-style, name: "b")
    content("b", $b$)
    circle((0, 0), ..white-node-style, name: "c")
    content("c", $c$)

    circle((2.5, 4), ..gray-node-style, name: "g1")
    circle((2.5, 2), ..gray-node-style, name: "g2")

    circle((5, 3), ..gray-node-style, name: "g3")
    content((5, 3 + label-offset), $a or b$)

    circle((7.5, 3), ..gray-node-style, name: "g4")
    circle((7.5, 0), ..gray-node-style, name: "g5")

    circle((10, 1.5), ..gray-node-style, name: "g6")
    content((10, 1.5 + label-offset), $a or b or c$)

    line("a", "g1")
    line("b", "g2")
    line("c", "g5")

    line("g1", "g2")
    line("g1", "g3")
    line("g2", "g3")

    line("g3", "g4")
    line("g4", "g5")

    line("g4", "g6")
    line("g5", "g6")
  })
)

Connect the output node to the base triangle node B and the node F. \

#figure(
canvas({
  import draw: *

  let node-radius = 0.5
  let white-node-style = (fill: white, stroke: black, radius: node-radius)
  let gray-node-style = (fill: luma(150), stroke: black, radius: node-radius)
  let label-offset = 0.7


  circle((0, 4), ..white-node-style, name: "a")
  content("a", $a$)
  circle((0, 2), ..white-node-style, name: "b")
  content("b", $b$)
  circle((0, 0), ..white-node-style, name: "c")
  content("c", $c$)

  circle((2.5, 4), ..gray-node-style, name: "g1")
  circle((2.5, 2), ..gray-node-style, name: "g2")

  circle((5, 3), ..gray-node-style, name: "g3")
  content((5, 3 + label-offset), $a or b$)

  circle((7.5, 3), ..gray-node-style, name: "g4")
  circle((7.5, 0), ..gray-node-style, name: "g5")

  circle((10, 1.5), ..gray-node-style, name: "g6")
  content((10, 1.5 + label-offset), $a or b or c$)

  line("a", "g1")
  line("b", "g2")
  line("c", "g5")

  line("g1", "g2")
  line("g1", "g3")
  line("g2", "g3")

  line("g3", "g4")
  line("g4", "g5")

  line("g4", "g6")
  line("g5", "g6")

    let node-fill = white
    let node-stroke-black = black
    let node-stroke-blue = blue
    let node-stroke-red = red
    let node-stroke-green = green

    circle((12.0, 3.0), radius: node-radius, fill: node-fill, stroke: node-stroke-green, name: "v1")
    content("v1", [T]) 

    circle((14.0, 3.0), radius: node-radius, fill: node-fill, stroke: node-stroke-red, name: "v2")
    content("v2", [F])

    circle((13.0, 0.0), radius: node-radius, fill: node-fill, stroke: node-stroke-blue, name: "v3")
    content("v3", [B])

    line("v1", "v2")
    line("v2", "v3")
    line("v1", "v3")
    line("g6", "v3")

})
)

Now we also prove that the mapping is done in polynomial time. \

#figure(
  image("f_diagram.png", width: 80%),
  caption: "Source: Berechenbarkeit und Komplexität JKU Vorlesungsfolien WS 2025",
  supplement: none

)

Now we are done.  
Lets gooooo Simon!!! :)

]

