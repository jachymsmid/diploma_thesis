#import "config.typ":*

// font & language
#set text(font: "New Computer Modern", lang: "en")

// page & page numbering
#set page(
  paper: "a4",
  number-align: center,
  numbering: "1",
  footer: context {
  let num = page.numbering
  if num != none {
    set align(page.number-align.x)
    "— " + numbering(num, ..counter(page).get()) + " —"
  }}

)

// title & document metadata
#set document(
  title: [Discontinuous Galerkin method in time],
  author: "Jachym Smid",
  date: auto
)

// heading numbering style
#set heading(numbering: clean_numbering("I.","1."))

// numbered list numbering style
#set enum(numbering: "(i.),a)")

// align block equations
#show math.equation.where(block: true): pad.with(left: 1cm)
#show math.equation.where(block: true): set align(left)

// do not line break inline math
#show math.equation.where(block: false): box

// definitions, theorems, ...
#show: setup-frames

#align(center, title())

// todo: add some interesting picture

#pagebreak()

// outline
#outline()

#pagebreak()

// frequently used symbols
#heading(level: 1, numbering: none, outlined: false, [Frequently used symbols:])

$U$ - numerical solution\
$u_n = u(t_n)$ - exact solution evaluated at node $t_n$\
...

#pagebreak()

// todo: divide manuscript into multiple files

#include("src/1_ode_theory.typ")
#include("src/2_ode_dgm.typ")


