#import "lib.typ"

#let ex(number, code: false, statement) = block(
  above: 1em,
  below: 0.5em,
  inset: 8pt,
  fill: luma(93%),
  stroke: blue,
)[
  = *Aufgabe #number*
  #statement
]

#let proof(title: "", body) = [
  *Proof.* #title \
  #body \
  #align(right)[$square$] \
  #v(0.5em)
]

#let table_gen(
  label: "x",
  inputs,
  ..funcs,
) = {
  let headers = (label,) + funcs.pos().map(f => f.at(0))

  table(
    columns: 1 + funcs.pos().len(),
    align: right,
    inset: 8pt,
    ..headers,
    ..for x in inputs {
      (str(x),) + funcs.pos().map(f => str(f.at(1)(x)))
    }
  )
}

#let lemma(title: "", number: "", statement) = block(
  inset: 8pt,
  fill: luma(98%),
  stroke: (left: 2pt + luma(70%)),
)[
  *Lemma* #title *#number:* #statement
]
#let lightAqua = color.mix((aqua, 20%), (white, 90%))

#let definition(title: "", number: "", statement) = lib.mathbox(
  kind: "Definition",
  title: title,
  number: number,
  _color: aqua,
  statement,
)

#let lemma(title: "", number: "", statement) = block(
  inset: 8pt,
  fill: luma(98%),
  stroke: (left: 2pt + luma(70%)),
)[
  *Satz* #title *#number:* #statement
]
#let lightAqua = color.mix((aqua, 20%), (white, 90%))

#let definition(title: "", number: "", statement) = lib.mathbox(
  kind: "Definition",
  number: number,
  _color: aqua,
  statement,
)

