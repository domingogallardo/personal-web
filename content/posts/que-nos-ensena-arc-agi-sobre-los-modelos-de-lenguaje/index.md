---
title: "Qué nos enseña ARC-AGI sobre los modelos de lenguaje"
date: 2026-03-24
draft: false
tags:
  - "newsletter"
  - "ARC-AGI"
  - "LLMs"
---

> ARC-AGI ha funcionado como un instrumento de diagnóstico de la evolución real de los LLMs.

![Cartel de presentación de ARC-AGI-3](arc-agi-3-event.png)

Tengo una especial fijación con la prueba ARC-AGI y con su autor, François Chollet. Durante 2024 publiqué [una reseña del ARC Prize](/posts/del-1-al-15-de-junio-11-de-2024/), un [extenso resumen de una entrevista](/posts/francois-chollet-20-de-2024/) y una de las noticias que más me impactaron desde la aparición de ChatGPT: [la resolución de ARC-AGI-1 por o3](/posts/o3-soluciona-arc-agi/). Ha pasado más de un año desde entonces y, coincidiendo con la [presentación esta semana](https://events.ycombinator.com/ARC-AGI-3-Launch) de [**ARC-AGI-3**](https://arcprize.org/arc-agi/3/), me parece un buen momento para volver sobre ARC y reflexionar sobre lo que nos ha enseñado realmente acerca de los modelos de lenguaje.

Mi impresión es que ARC-AGI no ha sido solo un benchmark especialmente difícil. Ha sido también una forma muy útil de observar cambios cualitativos en los LLMs. No todos los tests sirven para eso. Muchos benchmarks permiten medir mejoras graduales de eficiencia o rendimiento entre versiones sucesivas. ARC-AGI, en cambio, parece señalar otra cosa: cuando un modelo empieza a resolver una parte sustancial de sus tareas, lo que aparece no es solo una mejora cuantitativa, sino **una nueva forma de abordar problemas**.

## Qué intenta medir ARC

La idea original de ARC, [formulada por François Chollet en 2019](https://arxiv.org/abs/1911.01547), era ambiciosa. No se trataba de medir conocimiento acumulado ni habilidad en tareas muy vistas, sino algo más cercano a la **eficiencia en la adquisición de nuevas habilidades**. Es lo que el propio Chollet ha denominado [_fluid intelligence_](https://x.com/fchollet/status/1999504459341459843): la capacidad de enfrentarse a problemas nuevos construyendo una solución o modelo sobre la marcha, en vez de limitarse a aplicar habilidades ya memorizadas o patrones aprendidos.

Dicho de otro modo: no cuánto sabe un sistema, sino hasta qué punto puede inferir una regla nueva que generalice bien a partir de una experiencia muy limitada. Por eso los puzles de ARC obligan a inducir una regla a partir de muy pocos ejemplos y aplicarla después a un caso nuevo.

Por ejemplo, las siguientes tareas forman parte de ARC-AGI-1. Te propongo que intentes encontrar la regla que transforma cada rejilla de entrada en su rejilla de salida. Puedes ver la solución en la nota al pie [^1].

<figure>
  <img src="/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/arc-agi-1-sample-tasks.png" alt="Tres tareas de ejemplo de ARC-AGI-1">
  <figcaption>Ejemplos de tareas de ARC-AGI-1. Debes encontrar la regla que transforma cada rejilla de entrada en su rejilla de salida.</figcaption>
</figure>

## Lo que ARC-AGI-1 reveló sobre los LLMs

El [dataset ARC-AGI-1](https://github.com/fchollet/arc-agi) se construyó para el ARC Prize 2024. Consistía en 1.000 tareas, de las cuales 200 se mantuvieron en secreto para evaluar a los participantes. La competición oficial se lanzó en Kaggle el 11 de junio de 2024 y terminó el 10 de noviembre de 2024. Las soluciones debían ejecutarse en local, en tarjetas NVIDIA P100 con 16 GB de VRAM. El equipo ganador de la [competición](https://arcprize.org/competitions/2024/) (the ARChitects) consiguió un 53,5% de aciertos, lejos del 85% necesario para ganar el premio de USD 600.000.

En cuanto se lanzó el premio, todos nos preguntamos **cuál sería el rendimiento de los LLMs frontera** de aquel momento, como GPT-4o o Claude 3.5 Sonnet. Dadas las condiciones de la competición, no era posible probarlos directamente en Kaggle. Pero [pronto](https://arcprize.org/blog/introducing-arc-agi-public-leaderboard) el equipo del ARC Prize realizó evaluaciones oficiales con un conjunto semi-privado de 100 tareas. **Los resultados fueron desastrosos**: Claude 3.5 Sonnet consiguió resolver un 14% de las tareas y GPT-4o solo un 5% ([ARC Prize 2024: Technical Report](https://arxiv.org/abs/2412.04604)).

Y lo más llamativo es que, incluso cuando los modelos se han ido haciendo más grandes y más potentes, los resultados de los **LLMs no razonadores** no han mejorado demasiado. Ni siquiera en los LLMs actuales. Por ejemplo, la [tarea 2072aba6](https://arcprize.org/tasks/2072aba6/) solo ha podido ser resuelta modelos no razonadores a partir de diciembre de 2025 (`gpt-5-2-2025-12-11-thinking-none` fue el primero en hacerlo). En cambio, la [tarea 3391f8c0](https://arcprize.org/tasks/3391f8c0/), que en apariencia es muy sencilla, no puede ser resuelta hoy por ningún modelo no razonador.

<figure>
  <img src="/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/arc-agi-1-task-2072aba6.png" alt="Resultado de la tarea 2072aba6">
  <figcaption>La tarea 2072aba6 de ARC-AGI-1 solo ha podido ser resuelta por modelos no razonadores a partir de diciembre de 2025.</figcaption>
</figure>

<figure>
  <img src="/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/arc-agi-1-task-3391f8c0.png" alt="Resultado de la tarea 3391f8c0">
  <figcaption>La tarea 3391f8c0 no puede ser resuelta hoy por ningún modelo no razonador.</figcaption>
</figure>

De hecho, [solo un 13% de las 400 tareas públicas de ARC-AGI-1](https://arcprize.org/tasks/?dataset=arc-agi-1&provider=OpenAI%2CGoogle&type=Base+LLM) han sido resueltas por un LLM no razonador avanzado como GPT-5.2.

Eso explica bien por qué ARC llamó tanto la atención. En un momento en que los modelos empezaban a impresionar por su amplitud y versatilidad, ARC apuntaba a otra cuestión. Pedía algo mucho más cercano a lo que solemos entender por inteligencia: detectar qué regularidades importan, proponer una regla plausible y aplicarla con consistencia a partir de muy pocos ejemplos. **ARC-AGI-1 muestra el límite de los LLMs no razonadores.**

¿Cuándo empezaron los modelos a conquistar ARC-AGI-1? Cuando, a finales de 2024, llegó el primer cambio de paradigma: los LLMs razonadores. Usando el denominado CoT (_Chain-of-Thought_), estos modelos podían generar, en lugar de una respuesta instantánea, [**trazas de razonamiento**](https://openai.com/index/learning-to-reason-with-llms/). Cuanto más largas eran esas trazas, es decir, cuanto más tiempo se les dejaba funcionar, mejores resultados obtenían. Se abría así un nuevo paradigma, el denominado _inference-time computing_, basado en entrenar a los LLMs mediante RL (_Reinforcement Learning_) para que aprendan a generar cadenas de razonamiento que exploren y evalúen distintas estrategias y a quedarse con los mejores resultados.

A finales de 2024, el modelo razonador [o3 de OpenAI consiguió resolver ARC-AGI-1](https://arcprize.org/blog/oai-o3-pub-breakthrough): alcanzó un 87,5% de aciertos, aunque con un coste elevadísimo de USD 4.5k por tarea. Un año después, GPT-5.2 Pro (X-High) [consiguió un 90,5% con un coste de USD 11.64 por tarea](https://x.com/arcprize/status/1999182732845547795?s=20), una mejora en eficiencia de ≈390× en un año. En la actualidad, los [mejores resultados en la clasificación de ARC-AGI-1](https://arcprize.org/leaderboard) son los de Gemini 3.1 Pro, [con un 98% de aciertos y un coste de USD 0.522 por tarea](https://x.com/arcprize/status/2024522812728496470?s=20). **ARC-AGI-1 había dejado de ser una barrera para los modelos razonadores**.

## ¿Qué cambia con ARC-AGI-2?

Cuando ARC-AGI-1 empezó a ceder, lo que apareció no fue solo un modelo que “sabía más”, sino un cambio de fase en el modo de razonar. Se pasó de modelos capaces sobre todo de dar una respuesta inmediata ([inteligencia Sistema 1](/posts/francois-chollet-20-de-2024/)) a sistemas que combinan intuiciones iniciales con **exploración en _tiempo de inferencia_**, verificación de hipótesis y búsqueda deliberada (inteligencia Sistema 2). ARC-AGI-2 nace precisamente para poner a prueba ese tipo de sistema.

Mientras estaba en marcha el ARC Prize 2024, el equipo de Chollet ya estaba diseñando el nuevo conjunto de tareas para la siguiente edición. ARC-AGI-2 [se presentó el 20 de mayo de 2025](https://arcprize.org/blog/arc-agi-2-technical-report) ([informe técnico](https://arxiv.org/abs/2505.11831)) con 240 nuevas tareas: 120 para la evaluación semi-privada ([puedes probarlas aquí](https://arcprize.org/tasks/?dataset=arc-agi-2)) y 120 para la evaluación privada final. El objetivo era endurecer el benchmark buscando señales de **razonamiento más profundo**, especialmente **composición de conceptos y reglas múltiples**, **interpretación simbólica** y **aplicación contextual de reglas**, además de hacerlo menos vulnerable a búsqueda bruta.

Un buen ejemplo es la [tarea 1ae2feb7](https://arcprize.org/tasks/1ae2feb7/). A mí me ha costado más de 10 minutos y me parece un excelente ejemplo de combinación de reglas. ¿Cuánto tiempo tardas tú? [^2]

<figure>
  <img src="/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/arc-agi-2-task-1ae2feb7.png" alt="Tarea 1ae2feb7 de ARC-AGI-2">
  <figcaption>La tarea 1ae2feb7 de ARC-AGI-2 es un ejemplo de combinación de reglas. ¿Cuánto tiempo tardas en resolverla?</figcaption>
</figure>

Y funcionó, al menos al principio. Nada más lanzado el dataset, se probó con los modelos que obtenían los mejores resultados en ARC-AGI-1 y solo pudieron resolver un número mínimo de tareas. Por ejemplo, en ese momento o3 (Medium) resolvía el 53% de las tareas de ARC-AGI-1, pero **solo un 3% de ARC-AGI-2**. La competición oficial, el ARC Prize 2025, reforzó esa impresión. Se inauguró el 26 de marzo de 2025 con condiciones parecidas a las de 2024, aunque en un entorno algo más potente: 4 GPUs de NVIDIA con un total de 24 GB de memoria. Participaron 1.455 equipos y se enviaron más de 15.000 soluciones. Cuando se cerró la competición, el 3 de noviembre de 2025, los [resultados finales](https://arcprize.org/blog/arc-prize-2025-results-analysis) demostraron la dureza del nuevo benchmark: los equipos ganadores, usando sobre todo técnicas avanzadas basadas en bucles de refinamiento, solo consiguieron entre un 12% y un 24% de las tareas.

La pregunta siguiente era si los modelos comerciales de frontera iban a empezar también a superarlo. Los LLMs comerciales empezaron a responder algo mejor en el otoño de 2025, aunque todavía de forma modesta. Por ejemplo, [en octubre GPT-5 Pro consiguió](https://x.com/arcprize/status/1976329182893441209?s=20) un 18.3% en ARC-AGI-2 (USD 7.41/tarea).

Pero a finales de 2025 el panorama cambió deprisa. Uno tras otro, los nuevos modelos de Anthropic, OpenAI y Google fueron conquistando la clasificación pública, resolviendo cada vez más tareas y con menos gasto por tarea resuelta. El [24 de noviembre Opus 4.5](https://x.com/arcprize/status/1993036393841672624?s=20) consiguió un 37.64% (USD 2.40/tarea), el [17 de diciembre Gemini 3 Flash](https://x.com/arcprize/status/2001330153902023157?s=20) llegó al 33.6% (USD 0.23/tarea). El momento cumbre llegó el 5 de marzo de 2026, cuando [GPT-5.4 Pro alcanzó un 83.3% (USD 16.41/tarea)](https://x.com/arcprize/status/2029624001350488495?s=20). **ARC-AGI-2 había sido conquistado también por los LLMs**.

Es difícil no relacionar estas fechas con otro cambio cualitativo que sacudió el mundo de la programación a partir de diciembre de 2025. Herramientas como Claude Code o Codex CLI, guiadas por los nuevos LLMs, empezaron a mostrar por primera vez una capacidad sostenida para **razonar durante decenas de minutos y gestionar proyectos de miles de líneas de código**. La coincidencia temporal no parece casual. Una pista especialmente interesante está en el [proyecto beetree/ARC-AGI](https://github.com/beetree/ARC-AGI) de Johan Land, que el 5 de enero de 2026 llegó al 76.11% en ARC-AGI-2 usando un enfoque que él llama _Multi-Model Reflective Reasoning_: combinación de varios modelos frontera, razonamiento de largo horizonte (≈6 horas por problema), generación agéntica de código, razonamiento visual y una especie de “consejo de jueces” para evaluar soluciones.

<figure>
  <img src="/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/johan-land-arc-agi-2.png" alt="Captura del resultado compartido por Johan Land">
  <figcaption><a href="https://x.com/LandJohan/status/2008197725263716589?s=20">Post en X de Johan Land</a> explicando la arquitectura de su solución de ARC-AGI-2.</figcaption>
</figure>

Es posible que las estrategias de GPT-5.4 Pro para resolver ARC-AGI-2 sean similares a las usadas por el _harness_ de Johan Land. Pero en lugar de usar un andamiaje externo, el modelo de OpenAI está usando sus propias trazas de pensamiento y sus capacidades nativas de sistema 1. Como explica [Mike Knoop en X](https://x.com/mikeknoop/status/2036323325912424885?s=20) todo indica que los harnesses suelen adelantarse a capacidades que después aparecen de forma nativa en los sistemas LLM.

ARC-AGI-2 muestra, por tanto, algo más que una mejora de puntuaciones. **Muestra el salto a sistemas razonadores y agénticos.** Su conquista indica que han empezado a ser capaces de sostener durante horas una búsqueda deliberada, usar herramientas de forma consistente, generar y verificar código y coordinar distintos procesos orientados a un objetivo.

## Lo que pretende ARC-AGI-3

ARC-AGI-2 mostró que el progreso reciente ya no dependía solo de LLMs más capaces, sino de sistemas capaces de razonar, usar herramientas y sostener una búsqueda deliberada durante largos periodos de tiempo. La cuestión ahora es si eso basta. Y [ARC-AGI-3](https://arcprize.org/arc-agi/3/) sugiere que no: el siguiente umbral podría exigir no solo razonar sobre un problema dado, sino aprender a resolverlo interactuando con él.

En esta nueva versión no solo se debe inferir una regla a partir de unos pocos ejemplos estáticos, sino que hay que descubrir patrones y regularidades explorando juegos interactivos. Cada juego contiene varios niveles de dificultad creciente. Al estilo de los mejores videojuegos clásicos, cada nivel introduce nuevas reglas que hay que descubrir y aprender. Y, conforme avanzas, debes reutilizar lo aprendido en niveles anteriores y combinarlo con reglas nuevas. ARC-AGI-3 apunta así al siguiente umbral: razonamiento interactivo y aprendizaje continuo.

Podemos ver algunos ejemplos de cómo van a ser los juegos interactivos en la [la web del proyecto](https://three.arcprize.org). Por ejemplo, en el juego que se muestra en la siguiente animación el objetivo es mover el cuadrado naranja y azul hasta el símbolo de la esquina inferior derecha, pero antes hay que transformar la orientación y el color del símbolo situado en la esquina inferior izquierda para que coincida con él. En niveles anteriores hemos aprendido que, al pasar por encima de la cruz blanca, podemos girar el patrón, y que los cuadrados amarillos sirven para recuperar energía. En este nivel aprendemos además que el cuadrado de colores permite cambiar el color del patrón y que las barras blancas empujan nuestro bloque hasta la siguiente pared. Y todo ese aprendizaje será necesario en niveles posteriores, en los que habrá que combinar esas reglas con otras nuevas.

<figure>
  <img src="/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/arc-agi-3-curated.gif" alt="Animación de ejemplo de ARC-AGI-3">
  <figcaption>Nivel 3 (de 7) de uno de los juegos interactivos de ARC-AGI-3.</figcaption>
</figure>

Este es solo uno de los más de 150 juegos y más de 1.000 niveles que han diseñado el equipo de ARC-AGI-3. Pero lo verdaderamente importante no es la escala, sino el tipo de capacidad que se intenta poner a prueba. En ARC-AGI-1 y ARC-AGI-2 cada tarea era independiente de las demás: el modelo debía inferir una o varias reglas de transformación a partir de unos pocos ejemplos, pero no se premiaba ningún aprendizaje acumulativo. Aquí ocurre lo contrario. Para resolver un juego el sistema debe explorar cada nivel, descubrir regularidades, recordar lo aprendido y reutilizarlo más adelante, combinándolo con reglas nuevas.

Eso encaja bien con la formulación que ha dado el propio Chollet, [en X](https://x.com/fchollet/status/2004276612385108221):

> ARC-AGI-3 (que se lanzará en marzo de 2026) pone a prueba el razonamiento interactivo: evaluamos cómo los sistemas exploran entornos desconocidos, construyen modelos de esos entornos, se fijan sus propios objetivos y planifican y ejecutan acciones para alcanzarlos de forma autónoma, sin instrucciones.

Para resolver este nuevo reto, los modelos tendrán que acercarse más a esa idea de inteligencia fluida que Chollet lleva años defendiendo. Y, además, **tendrán que ofrecer unas primeras muestras de aprendizaje continuo**, [una de las carencias más visibles de los sistemas actuales](https://x.com/emollick/status/2020713378319417626?s=20).

ARC ha servido menos como tabla de clasificación y más como herramienta de investigación. Ha ido obligando a la comunidad a formular mejores preguntas sobre qué significa realmente generalizar, razonar y adaptarse. En ese sentido, creo que Chollet tiene razón cuando [resume retrospectivamente el proyecto](https://x.com/fchollet/status/2022036543582638517) diciendo que ARC fue concebido para orientar la investigación en IA hacia la inteligencia fluida, y que lo consiguió. No porque haya resuelto el problema, sino porque ha ido señalando con bastante precisión dónde seguían estando los límites. Y eso es justamente lo que ha hecho de ARC-AGI una prueba tan valiosa.

[^1]: **Tarea 1**: completar los cuadrados morados con una celda de color amarillo. **Tarea 2**: bajar las celdas de color azul claro hasta la barra horizontal inferior. **Tarea 3**: girar la rejilla original 180º

[^2]: Da igual que la fila original de celdas a la izquierda de la barra amarilla esté pegada o no a ella, hay que fijarse en el número de celdas del mismo color, n. La regla es poner a la derecha de la barra amarilla un patrón que empieza por una única celda de ese color y dejar n-1 celdas vacías. Se puede ver bien esa regla en las tres primeras filas. En la primera hay 4 celdas grises; ponemos a la derecha una celda gris y 3 vacías. En la segunda hay 2 celdas azules; ponemos a la derecha 1 celda azul y 1 vacía. En la tercera hay 0 celdas vacías, todo es una repetición de 1 celda roja. ¿Y qué pasa cuando hay más de un color? Esta es la idea de la **composición**: hay que aplicar la regla anterior con cada color, según los encontramos de derecha a izquierda y solo mostrando el color en las celdas que ha dejado vacías la aplicación de la regla al color previo. La solución es la siguiente imagen:

    ![Solución de la tarea 1ae2feb7](arc-agi-2-solution.png)
