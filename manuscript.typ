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

// heading numbering
#set heading(numbering: clean_numbering("I.","1."))

// align block equations
#show math.equation.where(block: true): pad.with(left: 1cm)
#show math.equation.where(block: true): set align(left)

// definitions, theorems, ...
#show: setup-frames

#align(center,title())

// add some interesting picture

#pagebreak()

#outline()

#pagebreak()

= Discontinuous Galerkin Method for ODE 

Suppose the following initial value problem
$
u^' (t) + A u(t) = f(t),\
u(0) = u_0.
$
Here $A = lambda > 0$ is a real constant, $u$ is a function $u: chevron.l 0,T chevron.r mapsto RR$.

== Weak formulation

=== Weak derivative

#definition[Weak derivative][
Let $u$ be a function in $L^1(Omega)$. We say that $g in L^1(Omega)$ satisfying
$
integral_Omega g phi dif x = integral_Omega u phi^' dif t quad forall phi in cal(C)^infinity_0 (Omega),
$
is the weak derivative of $u$.
]

#remark[There exists only one weak derivative.]

#proof[][
  For the sake of proof by contradiction let $g_1 eq.not g_2$ be the weak derivatives for the function $u in L^1(Omega)$. Using the identity
  $
  integral_Omega g_1 phi dif x = integral_Omega g_2 phi dif x
  $
  we arrive at
  $
  integral_Omega g_1 phi dif x - integral_Omega g_2 phi dif x = 0\
  integral_Omega phi (g_1 - g_2) dif x = 0.
  $
  But if this were to hold for all $phi$ the term in parentheses must be equal to zero
  $
  g_1 - g_2 = 0\
  g_1 = g_2 quad arrow.zigzag
  $
  
]

=== hmmm

To obtain the weak formulation of our problem we test with an infinitely differentiable funciton $v in C^infinity$
$
u^' (t) + A u(t) = f(t) quad \\dot.op v\
u^' dot.op v + A u dot.op v = f dot.op v
$
we integrate both sides
$
integral_Omega u^' dot.op v dif t + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t\
$
and apply the integration by parts on the first integral
$
- integral_Omega u dot.op v^' dif t + [u dot.op v]bar.v_Omega + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t\
- integral_Omega u dot.op v^' dif t + integral_(partial Omega) hat(n) dot.op u dot.op v dif t + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t
$
This equation can also be viewed as
$
- chevron.l u, v^' chevron.r_(L^2(Omega)) + chevron.l hat(n) dot.op u,v chevron.r_(L^2(partial Omega)) + chevron.l A u, v chevron.r_(L^2(Omega)) = chevron.l f, v chevron.r_(L^2(Omega)) 
$
using the scalar product in the Lebesque space for $p = 2$.


== Domain discretization

To discretize the domain $Omega = chevron.l 0, T chevron.r$ we define a sectioning
$
I_n = (t_n, t_(n+1)), quad n = 0,1,dots,N,
$
where $t_0 = 0$ and $t_N = T$, $tau_n = t_(n+1) - t_n$ is a local time step. Thus the approximate domain can be defined as
$
Omega approx Omega_tau = union.big_(n=0)^(N-1) I_n
$



