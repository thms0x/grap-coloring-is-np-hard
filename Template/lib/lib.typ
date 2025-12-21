#let header(
  title: "My Title",
  lva_name: "Introduction to Typst",
  student_name: "John Doe",
  student_name1: "John Doe",
  student_name2: "John Doe",
  matr_nr: "k12345678",
) = {
  grid(
    columns: (4fr, 1fr),
    [
      #text(weight: "bold", size: 14pt)[#lva_name]\
      #text(size: 10pt)[#student_name, #student_name1, #student_name2]
    ],
    align(right)[#image("../img/JKU_Logo.svg")],
  )
  line(length: 100%)
}


#let math(title: "", number: "", statement) = block(
  inset: 10pt,
  fill: lightAqua,
  stroke: (left: 3pt + teal),
)[
  *Definition* *#number #title*: #statement
]

#let mathbox(
  kind: "Theorem",
  title: "",
  number: "",
  statement,
  _color: blue,
) = {
  block(
    above: 1em,
    below: 0.5em,
    inset: 8pt,
    fill: color.mix((_color, 20%), (white, 90%)),
    stroke: (left: 2pt + _color),
  )[
    *#kind* *#number* #statement
  ]
}
