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
#set enum(numbering: "(i.)")

// align block equations
#show math.equation.where(block: true): pad.with(left: 1cm)
#show math.equation.where(block: true): set align(left)

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
= Methods for solving ODEs (initial value problems)

Befor anything we have to state what problems we are going to be trying to solve. We will focus on solving ordinary differential equations with initial condition. As an initial value problem for a system of first order ODEs
#numbered_eq($
y_1^' = f_1 (x, y_1, ..., y_m),\
y_2^' = f_2 (x, y_1, ..., y_m),\
dots.v\
y_m^' = f_m (x, y_1, ..., y_m), quad x in chevron.l a, b chevron.r,
$)
we will understand finding the $m$ functions $y_1, y_2, ..., y_m$ of the variable $x$, defined, continuous and continuously differentiable on the interval $chevron.l a, b chevron.r$, that solve the equations and for which it holds that
#numbered_eq(
$
y_1(xi) = eta_1, med y_2(xi) = eta_2, med ..., med y_m(xi) = eta_m,
$)<initial_condition>
where $(eta_1, eta_2, ..., eta_m)$ is an $m$-dimensional vector of values and $xi$ is a defined point in $chevron.l a, b chevron.r$, usually the left boundary point. The additional condition #ref(<initial_condition>) is often named the initial condition.


#lemma[][Every ordinary differential equation of order $m$ can be restated as a system of equations of order 1.]

#proof[][
Suppose the ODE
$
y^(\(m\)) = f(x, y, y^', y^'', ..., y^(\(m-1\))).
$
Define new variables
$
y_1 := y,\
y_2 := y_1^' quad (eq.triple y^''),\
dots.v\
y_m := y_(m-1)^' quad (eq.triple y^(\(m-1\))).
$
Now we have got the system
$
y_1^' = y_2,\
y_2^' = y_3,\
dots.v\
y_m^' = f(x, y_1, y_2, ..., y_m) 
$
that is equal to the original equation.
]

Because of this lemma we are stating the initial value problem without any loss of generality.

For simplicity we will usually use only one equation
#numbered_eq(
$
y^' = f(x, y), quad y(a) = eta,
$)<first_order_ode>
but the generalization to a system is usally simple.

The methods we are focusing on are discrete one step methods. Meaning we are solving the equations on a finite set of points $x_n, n = 0,1,...,N$ inside the interval $chevron.l a,b chevron.r$ spaced with the integration step $h_n$, that need not be constant.
The discretization then looks like
$
x_n = x_(n-1) + h_n , quad  n = 0,1,...,N " such that " x_0 = a " and " x_N = b.
$
But again, for simplicity we will usually use constant integration step $forall i (h_i = h)$, then the discretization gets simplified to
$
x_n = a + n h, quad n = 0,1,...,N " such that " x_0 = a " and " x_N = b.
$

== Solution existence and uniqueness

To prove existence and uniqueness of a solution for the initial value problem we have to first define some terms.

#definition[Lipschitz continuous function][]

#lemma[][If $f$ has bounded partial derivation with respect to $y$ on the band $x in chevron.l a, b chevron.r$, $y in (-infinity, infinity)$, then it is Lipschitz continuous.]<lipschitz>

...

#theorem[Picard-Lindelöf][
Suppose $f in cal(C)(U,RR^n)$, where $U$ is an open subset of $RR^(n+1),$ and $(a, eta) in U.$ If $f$ is locally Lipschitz continuous in the second argument, uniformly with respect to the first, then there exists a unique local solution of the #ref(<first_order_ode>).
]

#proof[][...]

#theorem[Peano][existence of solution, is it any useful?]

#remark[][From the #ref(<lipschitz>) we can see that any linear first order ODE is Lipschitz continuous.]

== General one-step method

General one-step method are characteristic that every approximate solution $y_n$ in $x_n$ can be computed only from knwing the values $x_n, y_n$ and $h.$ This relation put in formula could look like 
#numbered_eq($
y_(n+1) = y_n + h phi(x_n, y_n, h).
$)<general_method>

#definition[Total approximation error][
Let $y$ be the exact solution and $y_n$ be the approximate numerical solution in the node $x_n$. Total approximation error is defined as
$
e_n = y_n - y(x_n).
$]

The only free parameter in a one-step method is the integration step $h$, we would like to express the error as a function of $h.$

#definition[Error estimate][
Let $e_n$ be the total approximation error at node $x_n$ and $psi$ a positive real valued function. We say that $psi$ is an error estimate if it holds that
$
abs(e_n) lt.eq psi(h) " and " lim_(h arrow.r 0) psi = 0.
$
]

#definition[Convergence][
Let $e_n$ be the total approximation error on a mesh with $N$ nodes. A general one step method is convergent if and only if:
$
lim_(h arrow.r 0) norm(e_n) = 0, quad forall n lt.eq N.
$
]

#remark[][If we can find an error estimate of the total approximation error then the method converges.]
#proof[][
Let $psi$ be an error estimate. From definition
$
abs(e_n) lt.eq psi(h) " and " lim_(h arrow.r 0) psi = 0
$
thus
$
lim_(h arrow.r 0) abs(e_n) lt.eq lim _(h arrow.r 0) psi = 0.
$
]

#definition[Big O notation][
Let $f$ be a real valued function on domain $D$ and let $g$, the comparison function, be a real valued non-negative defined on the same set $D.$ We write
$
f(x) = O(g(x)),
$
if there exists a real positive constant $M$, such that
$
abs(f(x)) lt.eq M g(x) quad forall x in D.
$
]

#definition[Speed of convergence][
Let $e_n$ be the total approximation error at the node $x_n$. If there exists a function $phi(dot.op)$ such that 
+ $lim_(h arrow.r 0) phi(h) = 0$
+ $lim_(h arrow.r 0) abs(e_n) = O(phi(h))$
]

Usually for these methods the function $phi$ is a polynomial.

#definition[Asymptotic error estimate][
Let $e_n$ be the total approximation error at node $x_n$ and let $eta$ be a real valued function. We say that $eta$ is a asymptotic error estimate if it holds that
$
lim_(h arrow.r 0) e_n/eta(h) = 1.
$
]

#definition[Local approximation error][
The local approximation error $L(y,h)$ is an error we would make if we plugged into the #ref(<general_method>, supplement: "formula") exact values and computed one step. We write
$
L(y,h) := y(x+h) - y(x) - h Phi (x, y(x), h).
$
]

#definition[Order of a one-step method][
Let $L(y,h)$ be the local approximation error of a one-step method with the intergration step $h$. The largest $p$ for which it holds that
$
L(y,h) = O(h^(p+1)),
$
is called the order of the method.
]

#theorem[][Let us have a general one-step method of order $p gt.eq 1$, thus for the local approximation error we can write 
$
abs(L(y,h)) lt.eq K h^(p+1).
$
Next let $Phi$ be the corresponding function, for which it holds
+ Function $Phi$ is defined and continuous on
  $
  cal(D) = \{(x,y,h): x in chevron.l a, b chevron.r, y in (-infinity, infinity), h in chevron.l 0, h_0 chevron.r\}
  $
+ Function $Phi$ is Lipschitz continuous in $cal(D)$:
  $
  abs(Phi(x,y,h) - Phi(x,y^*,h)) lt.eq L abs(y-y^*).
  $
Then for the total approximation error it can be said that
$
abs(e_n) lt.eq (h^p K)/L (e^(L(x_n -a))-1)
$
for all $h$ small enough.
]

#proof[][]


#definition[Stability][]

#definition[Consistence][]

#theorem[Lax convergence theorem][]

#proof[][]

== Runge-Kutta

=== Explicit Runge-Kutta

=== Embedded Runge-Kutta

== Symplectic methods

== Special Second order methods

=== Newmark methods

= Discontinuous Galerkin Method for ODE

== Weak formulation

=== Integration by parts (per-partes)

#lemma[Integration by parts][
  todo: assumptions. An integral of two functions $f$ and $g$ can be written as
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

=== Distributions

=== Distributional (generalized) derivative

=== Weak formulation

todo: some definition?

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

todo: definitions

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

== Function spaces

todo: finish this whole thing

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

=== Degrees of freedom

=== Polynomial spaces

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



== Numerical quadrature

todo: finish this whole thing

=== Radau quadrature

=== Gauss quadrature

== DGM derivation

=== Linear homegenous 1. order ODE
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

Now we approximate the functions by defining the trial and test spaces to be the broken polynomial spaces of order $p.$
The local (on the interval $I_n = (t_(n-1), t_n)$) weak formulation is
$
- integral_I_n u_h v^'_h dif t + [u_h v_h]bar.v_I_n+ integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t,\
- integral_I_n u_h v^'_h dif t + u_h (t_n^-) v_h (t_n^-) - u_h (t_(n-1)^+) v_h (t_(n-1)^+) + integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t.
$
Using the upwind numerical trace
$
hat(U)_n = u_h (t_n^-)
$
we obtain the local #underline[weak] discrete DGM formulation
$
-integral_I_n u_h v^'_h dif t + hat(U)_n v_h (t_n^-) - hat(U)_(n-1) v_h (t_(n-1)^+) + integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t
$

Equivalent formulation can be obtained by usign integration by parts again on the first integral and by equivalent operations obtaining
$
integral_I_n u^'_h v_h dif t - u_h (t_n^-) v_h (t_n^-) + u_h (t_(n-1)^+) v_h (t_(n-1)^+) + hat(U)_n v_h (t_n^-) - hat(U)_(n-1) v_h (t_(n-1)^+) + \ quad +integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t\
integral_I_n u^'_h v_h dif t - u_h (t_n^-) v_h (t_n^-) + u_h (t_(n-1)^+) v_h (t_(n-1)^+) + u_h (t_n^-) v_h (t_n^-) - u_h (t_(n-1)) v_h (t_(n-1)^+) + \ quad +integral_I_n A u_h v_h dif t = integral_I_n f v_h dif t\
integral_I_n (u^'_h + A u_h)v_h dif t + [u_h (t_(n-1)^+) - u_h (t_(n-1)^-)] v_h (t_(n-1)^+) = integral_I_n f v_h dif t\
integral_I_n (u^'_h + A u_h)v_h dif t + [u_h]_(n-1) v_h (t_(n-1)^+) = integral_I_n f v_h dif t
$
Or formulated globaly
$
sum_n^N integral_I_n (u^'_h + A u_h)v_h dif t + sum_n^(N-1) [u_h]_n v_h (t_(n)^+) + (u_h (0^+) - u_0) v_h (0^+) = sum_n^N integral_I_n f v_h dif t
$
This equation contains a jump of $u_h$ on the left interface, we will denote it with $bracket.l.stroked u_h bracket.r.stroked_(n-1)$
$
bracket.l.stroked u bracket.r.stroked_n:= u(t_n^+) - u(t_n^-).
$
Substituting the jump we get the final #underline[strong] form
$
integral_I_n (u^'_h + A u_h)v_h dif t +  bracket.l.stroked u bracket.r.stroked_(n-1) v_h (t_(n-1)^+) = integral_I_n f v_h dif t.
$

To obtain the global discrete formulation we sum the local equations over all the intervals
$
sum_n^N integral_I_n -u_h v^'_h dif t + sum_n^(N-1) (hat(U)_(n+1) v_h (t_(n+1)^-) - hat(U)_(n) v_h (t_(n)^+)) + (u_h (t_(2)^-)v_h (t_(2)^-)-u_0 v_h (0^+)) +\ quad + sum_n^N integral_I_n A u_h v_h dif t = sum_n^N integral_I_n f v_h dif t,\
sum_n^N integral_I_n (u^'_h + A u_h)v_h dif t + sum_n^(N-1) bracket.l.stroked u bracket.r.stroked_(n) v_h (t_(n)^+) + (u_h (0^+) - u_0)v_h (0^+) = sum_n^N integral_I_n f v_h dif t.
$

=== Convergence for $p = 0$

#definition[Convergence][
  Let $u$ be an exact solution and $U$ be the numerical solution. We say that a numerical scheme with numerical step $h$ converges if
  $
  lim_(h arrow.r 0) norm(u - U) = 0.
  $
]

#definition[Local approximation error][
Let $u$ be the exact solution and $U_n = cal(H)_h U_(n-1)$ the numerical scheme in operator formulation. Local approximation error is then defined as
$
d_n = u(t_n) - cal(H)_h u
$
]

#lemma[][The local approximation error of the DG method of order $p=0$ for the IVP
$
u^'+a u = f, quad a gt.eq 0, u(0) = u_0,
$
is bounded by
$
abs(d_n) lt.eq (M a k_n^2)/2.
$]

#proof[][
...
]

#definition[Global error][
...
]

#lemma[][The global error is bounded by ...]

#theorem[][Let the exact solution $u in cal(C^1)$, then the DG method with order $p = 0$ converges for the equation
$
u^'+a u = f, quad a gt.eq 0, u(0) = u_0.
$
]

#proof[][
From the assumption that $u in cal(C^1)$ we can say that $|u^'| lt.eq M$ on a finite interval. Integrating $|u^'| lt.eq M$ from $t$ to $t_n$
$
integral_t^(t_n) |u^'| dif t lt.eq integral_t^(t_n) M dif t\
abs(integral_t^(t_n) u^' dif t ) lt.eq integral_t^(t_n) |u^'| dif t lt.eq M(t_n - t)\
abs(integral_t^(t_n) u^' dif t )  lt.eq M(t_n - t)\
| [u]_t^(t_n) |  lt.eq M(t_n - t)\
|u(t_n) - u(t)|  lt.eq M(t_n - t)\
|u(t) - u(t_n)| lt.eq M h " on " I_n
$
This bound applies to the whole interval, and all intervals.

Next integrate the original equation on the interval $I_n$
$
integral_I_n u^'+a u dif t = integral_I_n f dif t\
u(t_n) - u(t_(n-1)) + integral_I_n a u dif t = integral_I_n f dif t
$
Define $d_n := u(t_n) - U_n = (1+a k_n) u(t_n) - u(t_(n-1)) - integral_I_n f dif t$. Subtracting the two equations we get
$
d_n = a k_n u(t_n) - a integral_I_n u dif t,
$
but because $u(t_n)$ is a constant we can write
$
d_n = a integral_I_n u(t_n) - u dif t
$

Now utilizing the inequality $|u(t_n) - u(t)|  lt.eq M(t_n - t)$ we obtained earlier. We integrate it over interval $I_n$
$
abs(integral_I_n u(t_n) - u(t) dif t) lt.eq integral_I_n |u(t_n) - u(t)| dif t  lt.eq  integral_I_n M(t_n - t) dif t quad \/ dot.op a\
abs(a integral_I_n u(t_n) - u(t) dif t) lt.eq a integral_I_n M(t_n - t) dif t
$
but now the first integral is the $d_n$, substituting we get
$
abs(d_n) lt.eq a integral_I_n M(t_n - t) dif t = [M a ( t_n t - t^2/2)]_(t_(n-1))^t_n = M a ( t_n^2 - t_n^2/2 - t_n t_(n-1) + t_(n-1)^2/2) =\
= M a 1/2 (t_n^2 - t_n t_(n-1) + t_(n-1)^2) = (M a k_n^2)/2
$]

#proof[continuation of the proof][Next define $e_n = u(t_n) - U_n$. We know that
$
u_n (1 + a k_n) - u_(n-1) = integral_I_n f dif t + d_n,\
U_n (1 + a k_n) - U_(n-1) = integral_I_n f dif t.
$
Subtracting these two equations we get
$
u_n - U_n = (u_(n-1) - U_(n-1) + d_n)/(1+a k_n)\
e_n = (e_(n-1) + d_n)/(1+a k_n)
$
Thus
$
abs(e_n) lt.eq abs((e_(n-1) + d_n)) lt.eq abs(e_(n-1)) + abs(d_n)
$
Now assume $e_0 = 0$, then
$
abs(e_1) lt.eq abs(d_1), quad abs(e_2) lt.eq abs(e_1) + abs(d_2) lt.eq abs(d_1) + abs(d_2) quad arrow.r.double quad abs(e_n) lt.eq sum_n abs(d_n)
$
And now because we have already bounded $d_n$
$
abs(e_n) lt.eq sum_n abs(d_n) lt.eq (M a)/2 sum_n k_n^2 lt.eq (M a h)/2 sum_n k_n lt.eq (M a h T)/2
$
And then
$
abs(u-U_n) = abs(u - u_n + u_n - U_n) lt.eq abs(u - u_n) + abs(u_n - U_n) lt.eq M h + (M a h T)/2 = M h (1 + (a T)/2)
$
and thus
$
lim_(h arrow.r 0) abs(u - U_n) = 0
$
]

=== Energy equivalence
Taking $v_h = u_h$ and assuming $f =0$ in the discrete weak formulation we get
$
-integral_I_n u_h u_h^' dif t + hat(U)_n u_h (t_n^-) - hat(U)_(n-1) u_h (t_(n-1)^+) + A integral_I_n u_h^2 dif t = 0\
-integral_I_n (u_h^2 /2)^' dif t + hat(U)_n u_h (t_n^-) - hat(U)_(n-1) u_h (t_(n-1)^+) + A integral_I_n u_h^2 dif t = 0\
$
Now we can simply evaluate the integral
$
-[u_h^2 /2]_(t_(n-1)^+)^(t_n^-)+ u_h (t_n^-) u_h (t_n^-) - u_h (t_(n-1)^-) u_h (t_(n-1)^+) + A integral_I_n u_h^2 dif t = 0\
-(u_h^2 (t_n^-))/2 + (u_h^2 (t_(n-1)^+))/2 + u_h (t_n^-) u_h (t_n^-) - u_h (t_(n-1)^-) u_h (t_(n-1)^+) + A integral_I_n u_h^2 dif t = 0\
(u_h^2 (t_n^-))/2 + (u_h^2 (t_(n-1)^+))/2  - u_h (t_(n-1)^-) u_h (t_(n-1)^+) + A integral_I_n u_h^2 dif t = 0\
(u_h^2 (t_n^-))/2 - (u_h^2 (t_(n-1)^+))/2  +1/2( u_h (t_(n-1)^-) - u_h (t_(n-1)^+))^2 + A integral_I_n u_h^2 dif t = 0\
$
summing over all intervals gives
$
(u_h^2 (T^-))/2 - (u_h^2 (0^+))/2  +1/2 sum_n^N ( u_h (t_(n-1)^-) - u_h (t_(n-1)^+))^2 + A sum_n^N integral_I_n u_h^2 dif t = 0.
$
Consequently
$
(u_h^2 (T^-))/2 + A sum_n^N integral_I_n u_h^2 dif t lt.eq (u_h^2 (0^+))/2.
$
Which gives
$
u_h^2 (T^-) lt.eq u_h^2 (0^+), quad "assuming" A gt.eq 0
$

=== Connection to Runge-Kutta methods


