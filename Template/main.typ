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
A k-coloring of vertices of a given graph $G(V,E)$ is a mapping $c: V(G) -> {1,2,...,k}$
for which $(u, v) in E(G) -> c(u) != c(v)$ for any two vertices $u,v in G$ and a number $k in NN$.
If the implication holds, we can call the graph proper.\
\
The k-coloring problem asks if a given grap $G$ can be properly colored using at most $k$ colors. If there is a satisfying mapping, we can call the mapping a proper k-coloring.

== 3-Coloring problem
But for our following proof we explicitly decided to do the proof for the 3-Coloring problem. 
That's because the 3-coloring problem is the smallest coloring problem which is contained in NP. \
The 2-coloring problem is contained in P. We can easily solve this in $O(n)$ using something like Breadth First Search for example. \
The 3-coloring problem is contained in NP-complete (proof follows) and if we can show that 3-Coloring is NP-complete, then 4-Coloring, 5-Coloring,..., k-Coloring are automatically NP-complete, since 3-Coloring is 
just a restriction of them.

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
]

== Theorem: 3-Coloring is NP-hard

#figure(
  canvas({
    import draw: *

    let node-radius = 0.7
    let node-fill = white
    let node-stroke-black = black
    let node-stroke-blue = blue
    let node-stroke-red = red
    let node-stroke-green = green

    circle((0.0, 3.0), radius: node-radius, fill: node-fill, stroke: node-stroke-green, name: "v1")
    content("v1", [T]) 

    circle((4.0, 3.0), radius: node-radius, fill: node-fill, stroke: node-stroke-red, name: "v2")
    content("v2", [F])

    circle((2.0, 0.0), radius: node-radius, fill: node-fill, stroke: node-stroke-blue, name: "v3")
    content("v3", [B])

    circle((6.0, 1.0), radius: node-radius, fill: node-fill, stroke: node-stroke-black, name: "v4")
    content("v4", [$x_i$])

    circle((5.0, -1.0), radius: node-radius, fill: node-fill, stroke: node-stroke-black, name: "v5")
    content("v5", [$overline(x_i) $])

    circle((0.0, -3.0), radius: node-radius, fill: node-fill, stroke: node-stroke-black, name: "v6")
    content("v6", [$x_2$])

    circle((3.0, -3.0), radius: node-radius, fill: node-fill, stroke: node-stroke-black, name: "v7")
    content("v7", [$overline(x_2) $])

    circle((-3.0, -0.0), radius: node-radius, fill: node-fill, stroke: node-stroke-black, name: "v8")
    content("v8", [$x_1$])

    circle((-2.0, -2.0), radius: node-radius, fill: node-fill, stroke: node-stroke-black, name: "v9")
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
