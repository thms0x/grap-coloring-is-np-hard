#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot


#let custom-custom-plot = plot.plot.with(
  x-grid: true,
  y-grid: true,
  axis-style: "school-book",
  size: (12, 10),
)

#let funs-plot_old(domain: auto, ..funcs) = canvas({
  plot.plot(
    size: (12, 10),
    //x-tick-step: 0.5,
    //y-tick-step: 1,
    axis-style: "school-book",
    x-grid: true,
    y-grid: true,
    legend: "inner-north",
    {
      for f in funcs.pos() {
        let (label, fn) = f
        plot.add(domain: domain, label: label, fn)
      }
    },
  )
})


#let custom-custom-plot = plot.plot.with(
  x-grid: true,
  y-grid: true,
  axis-style: "school-book",
  size: (12, 10),
)

#let funs-plot(domain: auto, ..funcs) = canvas({
  plot.plot(
    size: (12, 10),
    //x-tick-step: 0.5,
    //y-tick-step: 1,
    axis-style: "school-book",
    x-grid: true,
    y-grid: true,
    legend: "inner-north",
    {
      for f in funcs.pos() {
        let (label, fn) = f
        plot.add(domain: domain, label: label, fn)
      }
    },
  )
})

#let funs-table(
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



