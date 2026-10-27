// theorems,...
#import "@preview/frame-it:2.0.0":*
#let (definition,) = frames(
  definition: ("Definition", gray),
  kind: "definition",
)
#let (theorem,) = frames(
  theorem: ("Theorem",gray),
  kind: "theorem",
)

// proof setup to add qed at the end of every proof
#let (proof: _raw-proof,) = frames(
  proof: ("Proof", gray),
  kind: "proof",
)
#let proof(..args) = {
  let pos = args.pos()
  let body = pos.pop() // The content block is always the last positional argument

  _raw-proof(..args.named(), ..pos)[
    #body
    #box(width: 0pt)
    #h(1fr)
    #sym.wj
    $square$
  ]
}

#let (example,) = frames(
  example: ("Example",gray),
  kind: "example",
)
#let (remark,) = frames(
  remark: ("Remark", gray),
  kind: "remark",
)
#let (lemma,) = frames(
  lemma: ("Lemma",gray),
  kind: "lemma",
)

// theorems show rules
#let setup-frames(doc) = {
  show: frame-style(styles.hint, kind: "definition")
  show: frame-style(styles.hint, kind: "theorem")
  show: frame-style(styles.hint, kind: "proof")
  show: frame-style(styles.hint, kind: "example")
  show: frame-style(styles.hint, kind: "remark")
  show: frame-style(styles.hint, kind: "lemma")

  doc
}

// numbered equations environment
#let numbered_eq(content) = math.equation(block: true, numbering: "(1)", content)

// implication sign
#let imply = $quad arrow.r.double quad$

// clean numbering for headings
#let clean_numbering(..schemes) = {
  (..nums) => {
    let (section, ..subsections) = nums.pos()
    let (section_scheme, ..subschemes) = schemes.pos()

    if subsections.len() == 0 {
      numbering(section_scheme, section)
    } else if subschemes.len() == 0 {
      numbering(section_scheme, ..nums.pos())
    }
    else {
      clean_numbering(..subschemes)(..subsections)
    }
  }
}
