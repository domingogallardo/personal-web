---
title: "Example of mathematics in Markdown"
date: 2026-07-06
draft: false
math: true
tags:
  - "mathematics"
---

This post is a small check that the website can now render mathematical expressions written in Markdown. The idea comes from [Algebrica](https://algebrica.org/indefinite-integrals/), where entries combine ordinary text with LaTeX for inline and display formulas.

An inline expression can be written with `$...$` delimiters, as in Algebrica: $f(x) = x^2 + 1$. The `\(...\)` form also works, for example \(e^{i\pi} + 1 = 0\). The result is integrated into the paragraph without needing images.

For display equations, `$$` can be used:

$$
\int_0^1 x^2 \, dx = \frac{1}{3}
$$

Multi-line expressions work too:

$$
\begin{aligned}
F(x) &= \int 3x^2 \, dx \\
     &= x^3 + c
\end{aligned}
$$

And it is possible to write slightly denser identities, such as the closed form of the geometric sum:

$$
\sum_{k=0}^{n} ar^k =
\begin{cases}
a(n + 1), & r = 1 \\
a \dfrac{1-r^{n+1}}{1-r}, & r \ne 1
\end{cases}
$$

The page loads the KaTeX stylesheet only because this post declares `math: true` in the front matter.
