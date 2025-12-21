#import "/lib/snippets.typ": analysis-header, definition, ex
#import "lib/math-utils.typ"



#set page(
  margin: 1in,
  header: analysis-header(3),
)
asdfas
#definition(title: "Konvergenz", number: "4.4")[
  Die Folge $(a_n)_(n in NN)$ konvergiert gegen $a$ für $n -> infinity$ falls
  $
    forall epsilon > 0:
    exists N_epsilon in NN:
    forall n >= N_epsilon: |a_n - a| < epsilon
  $<slow>
  also falls für jede beliebig kleine (positive) Fehlerschranke ε ab einem bestimmten
  Folgenglied mit ausreichend großem Index Nε alle Folgenglieder um weniger als ε von
  a abweichen.

]

== Example Plot

$
  g(x) := cases(
    x^2 "    if  " x < 0,
    -x^2 "  if  " x >= 0
  )
$

#let g(x) = if x < 0 { x * x } else { -(x * x) }
#let f(x) = 1 - 2 * x
#let fg(x) = f(g(x))

#let inputs = range(-4, 5).map(x => x / 2)

#align(center)[
  #math-utils.funs-table(
    inputs,
    ($f(x)$, f),
    ($g(x)$, g),
    ($f compose g)(x)$, fg),
  )

  #math-utils.funs-plot(
    domain: (-2, 2),
    ($f(x)$, f),
    ($g(x)$, g),
    ($(f compose g)(x)$, fg),
  )

]

#let f1(x) = calc.sin(x)
#set text(size: 10pt)

@slow
