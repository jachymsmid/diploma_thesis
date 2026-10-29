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

== Polynomial spaces

=== Degrees of freedom

=== Broken polynomial spaces

#definition[Broken polynomial space][Given a mesh $cal(T)$ we define a broken polynomial space of order $p$ as a set
$
PP_p (cal(T)) = {v in L^2 (Omega) med : med v bar.v_K in PP_p (K), med forall K in cal(T)}
$]

#definition[Jump][Let $PP_p (cal(T))$ be a broken polynomial space on mesh $cal(T)$. A jump is defnied as
$
[u] = ...
$]

#definition[Trace][]

#definition[Numerical trace][]

#lemma[][
$
dim (PP_p (cal(T)) inter H^1 (cal(T))) = |cal(T)| dot.op p - 1
$]


== Weak formulation

=== Integration by parts (per-partes)

#lemma[Integration by parts][
  An integral of two functions $f$ and $g$ can be written as
  $
  integral_Omega f g^' dif x = - integral_Omega f^' g dif x + [f g]bar.v_Omega.
  $
]

#proof[][
  Take the derivative of the product of the two functions
  $
  (f g)^' = f^' g + f g^'
  $
  integrate it
  $
  integral_Omega (f g)^' dif x = integral_Omega f^' g dif x + integral_Omega f g^' dif x\
  [f g]bar.v_Omega  = integral_Omega f^' g dif x + integral_Omega f g^' dif x
  $
  and rearrange
  $
  integral_Omega f g^' dif x = -integral_Omega f^' g dif x + [f g]bar.v_Omega  
  $


]

=== Weak derivative

#definition[Weak derivative][
Let $u$ be a function in $L^1(Omega)$. We say that $g in L^1(Omega)$ satisfying
$
integral_Omega g phi dif x = integral_Omega u phi^' dif t quad forall phi in cal(C)^infinity_0 (Omega),
$
is a weak derivative of $u$.
]


=== Weak formulation

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
- integral_Omega u dot.op v^' dif t + [u dot.op v]limits(bar.v)_0^T + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t\
- integral_Omega u dot.op v^' dif t + u(T)v(T) - u(0)v(0) + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t\
$
Requiring that $v in V = {f in cal(C)^infinity (0,T) med : med f(T) = 0}$ and using the information that $u(0) = u_0$ gives
$
- integral_Omega u dot.op v^' dif t - u_0 dot.op v(0) + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t quad forall v in V\
$
Which is the final weak formulation of the equation.

Note that requiring that $v$ vanishes at both endpoints would mean that we loose the information about the initial condition.


==== Local weak formulation

Having a domain partitioned into intervals $I_n = (t_(n-1), t_n)$, we can formulate the local weak form of the problem
$
- integral_I_n u dot.op v^' dif t + u(t_n)v(t_n) - u(t_(n-1))v(t_(n-1)) + integral_I_n A u dot.op v dif t = integral_I_n f dot.op v dif t forall v in V
$


== Domain discretization

To discretize the domain $Omega = chevron.l 0, T chevron.r$ we divide it into intervals
$
I_n = (t_n, t_(n+1)), quad n = 0,1,dots,N,
$
where $t_0 = 0$ and $t_N = T$, $tau_n = t_(n+1) - t_n$ is a local time step.
Now we define a mesh as
$
cal(T) = {I_i med : med i lt.eq n} = { I_1, I_2, dots, I_N}
$
Thus the approximate domain can be defined as
$
Omega approx Omega_tau = union.big cal(T) = union.big_(n=0)^(N-1) I_n
$

=== Regular
$tau$ stays constant.

=== Irregular
$tau_n$ is different for each $I_n$.

=== Reference element

== Polynomials

== Spaces

=== Lebesque space

#definition[Lebesque space][
  A Lebesque space is a space of square integrable functions
  $
  L^2 (Omega) = {f med : med integral_Omega |f|^2 dif x < infinity}
  $
  
]

=== Sobolev space

#definition[Sobolev space][
We define Sobolev space as
$
H^1(Omega) = {f in L^2 (Omega) med : med D f in L^2 (Omega)}
$
]

#lemma[][
  Let $f in PP_p (cal(T))$. If $f in H^1 (Omega)$ then for every jump $[f]_n = 0$.


]


== Numerical quadrature

== DGM derivation

First lets derive the simplest case possible and generelize it later. Suppose the following initial value problem
$
u^' (t) + A u(t) = f(t),\
u(0) = u_0.
$
Here $A = lambda > 0$ is a real constant, $u$ is a function $u: chevron.l 0,T chevron.r mapsto RR$.

The weak formulation of this problem is
$
- integral_Omega u dot.op v^' dif t - u_0 dot.op v(0) + integral_Omega A u dot.op v dif t = integral_Omega f dot.op v dif t quad forall v in {f in cal(C)^infinity (0,T) med : med f(T) = 0}\
$
First approximate the domain $Omega$ by $Omega_tau$. For simplicity suppose regular intervals.

Now we approximate the functions by defining the trial and test spaces to be the broken polynomial space of order $p.$

$
- integral_Omega_tau u_h v^'_h dif t + [u_h v_h]bar.v_Omega_tau + integral_Omega_tau A u_h v_h dif t = integral_Omega_tau f v_h dif t quad forall v_h in PP_p (cal(T))\
$

Now the local (on the interval $I_n$) weak formulation becomes
$
- integral_I_n u_h v^'_h dif t + [u_h v_h]bar.v_I_n+ integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t\
- integral_I_n u_h v^'_h dif t + u_h (t_n^-) v_h (t_n^-) - u_h (t_(n-1)^+) v_h (t_(n-1)^+) + integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t
$

Using the upwind numerical trace
$
hat(U)_n = u_h (t_n^-)
$
we obtain the final integral DGM formulation
$
- integral_I_n u_h v^'_h dif t + hat(U)_n v_h (t_n^-) - hat(U)_(n-1) v_h (t_(n-1)^+) + integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t
$
Equivalent formulation can be obtained by usign integration by parts again on the first integral
$
integral_I_n u^'_h v_h dif t - u_h (t_n^-) v_h (t_n^-) + u_h (t_(n-1)^+) v_h (t_(n-1)^+) + hat(U)_n v_h (t_n^-) - hat(U)_(n-1) v_h (t_(n-1)^+) + \ quad +integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t\
integral_I_n u^'_h v_h dif t - u_h (t_n^-) v_h (t_n^-) + u_h (t_(n-1)^+) v_h (t_(n-1)^+) + u_h (t_n^-) v_h (t_n^-) - u_h (t_(n-1)) v_h (t_(n-1)^+) + \ quad +integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t\
integral_I_n u^'_h v_h dif t + [u_h (t_(n-1)^+) - u_h (t_(n-1)^-)] v_h (t_(n-1)^+) + integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t\
integral_I_n (u^'_h + A u_h)v_h dif t + [u_h (t_(n-1)^+) - u_h (t_(n-1)^-)] v_h (t_(n-1)^+) = integral_I_n f v_h dif t
$

=== Energy equivalence
$
E = 1/2 u^2
$

=== Algorithm

==== Results

=== Connection to Runge-Kutta methods

=== Superconvergrence

=== A priori error estimation




= Discontinuous Galerkin method for parabolic PDE
