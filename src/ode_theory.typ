#import "../config.typ":*
// align block equations
#show math.equation.where(block: true): pad.with(left: 1cm)
#show math.equation.where(block: true): set align(left)

// do not line break inline math
#show math.equation.where(block: false): box

// definitions, theorems, ...
#show: setup-frames

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

#theorem[Picard-Lindelöf][
Suppose the initial value problem
$
y^' = f(y) + g(x),\
y(a) = eta.
$
And suppose that $f$ is continuous, $(dif f)/(dif x)$ is continuous and $g$ is continuous.
Then there exists $delta > 0$ such that there is a unique solution to the initial value problem
on the interval $chevron.l -delta, delta chevron.r .$]

For the proof of this theorem we need some knowledge base. Let us state some definitions, lemmas and theorems.

#theorem[][
The metric space of continuous functions equipped with the usual metric $(cal(C)(chevron.l a,b chevron.r), varrho)$ is Cauchy complete.
]

#proof[][...]

#definition[Contracting map][
Suppose $(X, varrho)$ to be a metric space. A map $T: X mapsto X$ is called contracting if there 
exists $c < 1$ such that $varrho(T(x), T(y)) lt.eq c varrho(x,y)$ for all $x, y in X.$
]

#definition[Fix point][
Suppose $T: X mapsto X.$ A fix point is a point $x in X$ such that $T(x) = x.$
]

#lemma[][If $T: X mapsto X$ is a contracting map, then $T$ can have at most one fix point.] 

#proof[][

Proof by contradiction

Suppose $y_1, y_2 in X, med y_1 eq.not y_2$ and
$
T(y_1) = y_1, quad T(y_2) = y_2.
$
Then from definition
$
varrho(T(y_1), T(y_2)) lt.eq c varrho(y_1, y_2)
$
but because $y_1$ and $y_2$ are fix points 
$
varrho(y_1, y_2) lt.eq c varrho(y_1, y_2)
$
using the information that $c < 0$ we can see that
$
varrho(y_1, y_2) = 0 imply y_1 eq y_2 quad arrow.zigzag
$
from the definition of a metric.
]

#definition[Cauchy sequence][
Given a metric space $(X, varrho)$, a sequence ${x_n}$ of elements of $X$ is Cauchy if
$
forall epsilon > 0 med exists N "such that" forall n,m > N quad varrho(x_n, x_m) < epsilon
$
]

#theorem[][
If $(X, varrho)$ is a Cauchy complete space and $T: X mapsto X$ is a contracting map, then $T$ has a unique fix point.
]

#proof[][
Let $x_0 in X$ be a fix point of $T.$ We claim that ${T^n (x)}$ converges to a fix point $T^n (x) arrow.r x_infinity " for " n arrow.r infinity.$

+ First lets show that the sequence ${x_n}$ is Cauchy and thus convergent in $X.$

  To do that we have to show that we can make $varrho(T^n (x), T^m (x))$ as small as we want.
  Define $m := n + k.$
  $
  varrho(T^n (x), T^m (x)) = varrho(T^n (x), T^(n+k) (x)) = varrho(T(T^(n-1)(x)), T(T^(n-1+k) (x))) lt.eq\
  lt.eq c varrho(T^(n-1)(x), T^(n-1+k) (x)) lt.eq dots lt.eq c^n varrho(x, T^k (x))
  $
  Now we would like to limit $varrho(x, T^k (x))$ because $c^n$ already goes to zero with $n.$ Via triangual inequality
  $
  varrho(x, T^k (x)) lt.eq varrho(x, T (x)) + varrho(T (x), T^2 (x)) + dots + varrho(T^(k-1) (x), T^k (x)) lt.eq\
  lt.eq varrho(x, T(x)) + c varrho(x, T(x)) + dots + c^(k-1) varrho(x, T(x)) = varrho(x, T(x)) ( 1 + c + c^2 + dots + c^(k-1))
  $
  but the ... in parentheses is just the sum of a geometric series thus
  $
  varrho(x, T^k (x)) lt.eq 1/(1-c) varrho(x, T(x)).
  $
  So we can finally write
  $
  varrho(T^n (x), T^m (x)) lt.eq c^n 1/(1-c) varrho (x, T(x)),
  $
  for any $x$ we pick $varrho(x , T(x))$ is just a constant, thus we have showed that the sequence $T^n (x)$ is Cauchy for all $x in X.$

+ Secondly, we need to show that the series converges to a fix point.

  We already know that the sequence is convergent so denote the limit
  $
  lim_(n arrow.r infinity) T^n (x) = x_infinity.\
  T(T^n (x)) = T^(n+1) (x) arrow.r x_infinity
  $
  We can easily see that
  $
  varrho(T(x_infinity), T^(n+1) (x)) = varrho(T(x_infinity), T(T^n (x))) lt.eq c varrho(x_infinity, T^n (x))
  $
  And since $T^n (x) arrow.r x_infinity$ as $n arrow.r infinity$
  $
  varrho(x_infinity, T^n (x)) arrow.r 0 imply varrho(T(x_infinity), T^(n+1) (x)) arrow.r 0 " and thus " T^(n+1) (x) arrow.r T(x_infinity).
  $
  But also $T^(n+1) (x) arrow.r x_infinity$, thus
  $
  T^n (x_infinity) = x_infinity
  $
]

#lemma[][
  Suppose that $f$ is continuous, $f'$ is continuous and $g$ is continuous on $RR$. For $delta_0 > 0$ on the space $cal(C)(chevron.l - delta_0, delta_0 chevron.r)$ we define a map $T$ on functions $y$ as follows
  $
  T(y)(x) = a + integral_0^x f(y(s)) + g(x) dif s
  $
  Let $a$ be a constant and set $r := abs(a) + 2.$ There exists a $delta > 0$ such that:
+ The map $T$ maps the ball in the metric space $(cal(C)(chevron.l - delta, delta chevron.r), varrho)$ of radius $r$ and with center the constant function zero into itself. We write $B_r (0) = {y in C(chevron.l - delta, delta chevron.r) med : med varrho(y, 0) lt.eq r)}$ for this ball and so have that
  $
  T: B_r (0) mapsto B_r (0)
  $
+ The map is contracting on $B_r (0).$
]

#proof[][
Let
$
L_1 = 
$
]

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

