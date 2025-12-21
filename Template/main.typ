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

== What is the coloring problem?
A k-coloring of vertices of a given graph $G(V,E)$ is a mapping $c: V(G) -> {1,2,...,k}$
for which ${u, v} in E(G) -> c(u) != c(v)$ for any two vertices $u,v in G$ and a number $k in NN$.
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
