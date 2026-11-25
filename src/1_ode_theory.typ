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

== Solution existence and uniqueness

To prove existence and uniqueness of a solution for the initial value problem we have to first define some terms.

#theorem[Picard-Lindelöf][
Consider the initial value problem
$
y^' = f(y(x),x),\
y(x_0) = eta,
$
where $f: RR^n times I mapsto RR^n$, $I subset.eq RR$ is an open interval containing $x_0$, and $eta in RR^n$. And assume that $f$ is continuous and L-Lipschitz in the first argument.
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

#definition[fixed point][
Suppose $T: X mapsto X.$ A fixed point is a point $x in X$ such that $T(x) = x.$
]

#lemma[][If $T: X mapsto X$ is a contracting map, then $T$ can have at most one fixed point.] 

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
but because $y_1$ and $y_2$ are fixed points 
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
If $(X, varrho)$ is a Cauchy complete space and $T: X mapsto X$ is a contracting map, then $T$ has a unique fixed point.
]

#proof[][
Let $x_0 in X$ be a fixed point of $T.$ We claim that ${T^n (x)}$ converges to a fixed point $T^n (x) arrow.r x_infinity " for " n arrow.r infinity.$

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
  lt.eq varrho(x, T(x)) + c varrho(x, T(x)) + dots + c^(k-1) varrho(x, T(x))=\
  = varrho(x, T(x)) ( 1 + c + c^2 + dots + c^(k-1))
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

+ Secondly, we need to show that the series converges to a fixed point.

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

#proof[Picard-Lindelof theorem][
Rewrite the equation into its integral form
$
y(x)-y(x_0) = integral_(x_0)^x f(y(s), s) dif s,
$
plugging in the initial condition gives
$
y(x) = eta + integral_(x_0)^x f(y(s), s) dif s.
$
If a continuous function $y$ satisfies this integral equation, then the continuity of $f$ and the fundamental theorem of calculus imply
$
y^' = f(y(x), x).
$
Moreover evaluating $y$ at $x_0$ gives $y(x_0) = eta$, thus the IVP is equivalent to the integral equation.

+ Define the Picard operator

  Choose $delta > 0$ such that
  $
  chevron.l h-delta, h+delta chevron.r subset I " and " L delta < 1.
  $
  Denote the interval $chevron.l h-delta, h+delta chevron.r$ with $D.$ Consider the space
  $
  X = cal(C)(D; RR^n)
  $
  equipped with the supremum norm
  $
  norm(y)_infinity = max_(x in D) norm(y(x)).
  $
  The normed space $(X, norm(dot.op)_infinity)$ is a Banach space.

  Define operator $T: X mapsto X$ by
  $
  T y(x) = eta integral_(x_0)^x f(y(s), s) dif s.
  $

  + Proove the operator is well defined

    + $T y$ exists for all $x in D$
      
      Choose some $y in X$, from the definiotion of $X$ the function $y$ is continuous. The function $f(x, y(x))$ is also continuous, from assumptions.
      Now consider the integrand in the operator
      $
      g(s) := f(s, y(s)),
      $
      we want to show, that it is continuous.

      Define
      $
      phi = D mapsto I times RR^n
      $
      This function is continuous, because
      $
      &s mapsto s quad &"trivialy",\
      &s mapsto y(s) quad &y in X.
      $
      Now
      $
      g(s) = f circle.small phi = f(phi(s)), quad s in D.
      $
      A composition of continuous function is also continuous, thus $g$ is also continuous.

      Every continuous function on a compact interval is integrable, thus $T y$ exists on $D.$

    + $T y$ is continuous

      Recall that
      $
      T y = eta + integral_(x_0)^x f(s, y(s)) dif s.
      $
      Since $f(x, y(x))$ is continuous
      $
      (dif)/(dif x) integral_(x_0)^x f(s, y(s)) dif s = f(x, y(x)).
      $
      Therefore
      $
      (dif)/(dif x) T y = f(x, y(x)), quad x in D.
      $
      Since every differentiable function is continuous, the function $T y$ is continuous.



  + Proove the operator is contracting

    Let $y,z in X.$ For any $x in D$ we have 
    $
    norm(T y (x) - T z (x)) &= norm(integral_(x_0)^x [f(y(s),s) - f(z(s),s)] dif s)\
    &lt.eq abs(integral_(x_0)^x norm(f(y(s),s) - f(z(s),s))dif s)\
    &lt.eq L integral_(min(x_0, x))^(max(x_0, x)) norm(f(y(s),s) - f(z(s),s)) dif s\
    &lt.eq L delta norm(y - z)_infinity.
    $
    Taking the supremum over $x in D$ gives
    $
    norm(T y - T z )_infinity lt.eq L norm(y - z)_infinity.
    $
    Thus the $T: X mapsto X$ is contracting.

  We have shown that the operator $T$ is well defined and contracting.
  Using the Banach fixed point theorem, there exists and is unique a fixed point of the operator $T.$

  Therefore there exists a $y in X$ satisfying
  $
  T y = y.
  $
  From the definition of $T$
  $
  T y = eta + integral_(x_0)^x f(y(s),s) dif s.
  $
  Differentiating we obtain
  $
  dif/(dif x)T y(x) = y^' (x) = f(y(x), x)
  $
  and setting $x =x_0$
  $
  y(x_0) = eta.
  $
  Thus $y$ solves the original IVP and because the fixed point is unique the solution is also unique on the interval $D = chevron.l x_0-delta, x_0+delta chevron.r.$
]

#theorem[Global existence and uniqueness][]

#lemma[][
Suppose a function $f(y,x),$ where $y in RR^n, x in I subset.eq RR$, $I$ is on open interval.  
If $(partial f)/(partial y)$ is continuous then $f$ is L-Lipschitz in $y.$
]

#proof[][]



== General one-step method

The methods we are focusing on are discrete one step methods. Meaning we are solving the equations on a finite set of points $x_n, n = 0,1,...,N$ inside the interval $chevron.l a,b chevron.r$ spaced with the integration step $h_n > 0$, that need not be constant.
The discretization then looks like
$
x_n = x_(n-1) + h_n , quad  n = 0,1,...,N " such that " x_0 = a " and " x_N = b.
$
For simplicity we will usually use constant integration step $forall i (h_i = h)$, then the discretization gets simplified to
$
x_n = a + n h, quad n = 0,1,...,N " such that " x_0 = a " and " x_N = b.
$

Denote by $y_n$ the approximate solution at point $x_n$. We compute every consequent $y_n$ using the reccurent formula
#numbered_eq($
y_(n+1) = y_n + h Phi(x_n, y_n, h).
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
Suppose that $y$ is the exact solution. We say that a general one step method with the step $h$ and ... $Phi$ is convergent if
$
forall x in chevron.l a,b chevron.r thick : thick lim_(h arrow.r 0^+) y_n = y(x), thick x_n = x
$
]

#definition[Convergence][
Denote by $e(h)$ the maximal approximation error of a method with step $h$
$
e(h) = max_(x_n in chevron.l a,b chevron.r) abs(e(x)), thick x_n = a + h n.
$
We say that the method is convergent if
$
lim_(h arrow.r 0^+)e(h) = 0.
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

#lemma[][
Let $A,B gt.eq 0, N gt.eq 1$ and suppose the following
$
abs(xi_(n+1)) lt.eq A abs(xi_n) + B, quad n = 0, 1, dots, N-1
$
Then $abs(xi_n)$ can be bound with
$
abs(xi_n) lt.eq A^n abs(xi_0) + cases((A^n-1)/(A-1)B quad &: quad A eq.not 1,B n &: quad A = 1)
$
]<lemma1>

#proof[][

Start with
$
abs(xi_(1)) lt.eq A abs(xi_0) + B\
abs(xi_(2)) lt.eq A abs(xi_1) + B lt.eq A (A abs(xi_0) + B) + B\
abs(xi_(3)) lt.eq A abs(xi_2) + B lt.eq A (A (A abs(xi_0) + B) + B) + B = A^3 abs(x_0) + A^2 B + A B + B.
$
Generalize for $n$
$
abs(xi_n) lt.eq A^n abs(xi_0) + B sum_(i = 0)^(n-1) A^i.
$
From the formula for a sum of a geometric series
$
abs(xi_n) lt.eq A^n abs(xi_0) + cases((A^n-1)/(A-1)B quad &: quad A eq.not 1,B n &: quad A = 1)
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
And assume $Phi$ to be
+  defined and continuous on
  $
  cal(D) = \{(x,y,h): x in chevron.l a, b chevron.r, y in (-infinity, infinity), h in chevron.l 0, h_0 chevron.r\}
  $
+ L-Lipschitz in $cal(D)$ in the second argument
  $
  abs(Phi(x,y,h) - Phi(x,y^*,h)) lt.eq L abs(y-y^*).
  $
Then for the total approximation error it can be said that
$
abs(e_n) lt.eq (h^p K)/L (e^(L(x_n -a))-1)
$
for all $h$ small enough.
]

#proof[][
We know that
$
e_0 = y_0 - y(x_0) = 0.
$
We also have the equations
$
y_(n+1) = y_(n) + h Phi(x_n, y_n, h)\
y(x_(n+1)) = y(x_n) + h Phi(x_n, y(x_n), h) + h delta_n,
$
where
$
delta_n = Delta(x_n, y(x_n),h) - Phi(x_n, y(x_n),h),\
Delta(x, y(x),h) = (y(x+h)-y(x))/h
$
Subtracting the second equation from the first
$
y_(n+1) -y(x_(n+1)) = y_(n) - y(x_n)+ h Phi(x_n, y_n, h) - h Phi(x_n, y(x_n), h)-\
quad - h Delta(x_n, y(x_n),h) - h Phi(x_n, y(x_n),h)\
e_(n+1) lt.eq e_n + h L abs(y_n - y(x_n)) - K h^(p+1) = e_n (1+h L) + K h^(p+1) 
$
Using the @lemma1 we obtain
$
e_n &lt.eq (1+h L)^n e_0 + K h^(p+1) ((1+h L)^n -1)/(h L) = K h^(p+1) ((1+h L)^n -1)/(h L)lt.eq\
    &lt.eq K h^(p+1) ((1+h L)^n -1)/(h L) lt.eq K h^p (e^(L h n)-1)/L = K h^p (e^(L(x_n - a))-1)/L
$
Yielding the final bound
$
e_n lt.eq K h^p (e^(L(x_n - a))-1)/L
$
]


#definition[Stability][]

#definition[Consistence][
We say, that a one-step method for the @first_order_ode  is consitent if
$
Phi(x,y,0) = f(x,y), quad x in chevron.l a,b chevron.r, thick y in RR^n
$
]

#theorem[Lax convergence theorem][]

#proof[][]

== Runge-Kutta

For Runge-Kutta methods the function $Phi$ looks like
$
Phi(x,y,h) = sum_(i=1)^P w_i k_i(x,y,h),
$
where
$
k_i(x,y,h) = f(x+alpha_i h, y + h sum_(j=1)^(i-1)beta_(i j)k_j(x,y,h)).
$
Here $P, w_i, alpha_i, beta_(i j)$ are constants choosen such that the method is of order $p.$

=== Explicit Runge-Kutta

For explicit Runge-Kutta methods the matrix $beta_(i j)$ is strictly lower trianugular.

=== Embedded Runge-Kutta

=== Implicit Runge-Kutta

== Symplectic and energy conservative methods

== Special Second order methods

=== Newmark methods

