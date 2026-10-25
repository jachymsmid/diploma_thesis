#set text(font: "New Computer Modern", lang: "en")
#show link: set text(fill: blue)
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
#set heading(numbering: "I.1")
//#set heading(level: 1, numbering: none)
#set document(
  title: [Discontinuous Galerkin method in time],
  author: "Jachym Smid",
  date: auto
)

#align(center,title())

// add some interesting picture

#pagebreak()

#outline()

#pagebreak()

= Discontinuous Galerkin Method for ODE 


= Discontinuous Galerkin Method for parabollic PDE 




