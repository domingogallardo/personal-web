---
title: "Ejemplo de matemáticas en Markdown"
date: 2026-07-06
draft: false
math: true
tags:
  - "matemáticas"
---

Este post sirve para comprobar que la web ya puede renderizar expresiones matemáticas escritas en Markdown. La idea viene de [Algebrica](https://algebrica.org/indefinite-integrals/), donde las entradas combinan texto normal con LaTeX para fórmulas inline y en bloque.

Una expresión inline se puede escribir con delimitadores `$...$`, igual que en Algebrica: $f(x) = x^2 + 1$. También funciona la forma `\(...\)`, por ejemplo \(e^{i\pi} + 1 = 0\). El resultado queda integrado en el párrafo sin necesidad de imágenes.

Para ecuaciones destacadas se puede usar `$$`:

$$
\int_0^1 x^2 \, dx = \frac{1}{3}
$$

También funcionan expresiones con varias líneas:

$$
\begin{aligned}
F(x) &= \int 3x^2 \, dx \\
     &= x^3 + c
\end{aligned}
$$

Y se pueden escribir identidades algo más densas, como la forma cerrada de la suma geométrica:

$$
\sum_{k=0}^{n} ar^k =
\begin{cases}
a(n + 1), & r = 1 \\
a \dfrac{1-r^{n+1}}{1-r}, & r \ne 1
\end{cases}
$$

La página carga la hoja de estilos de KaTeX solo porque este post declara `math: true` en el front matter.
