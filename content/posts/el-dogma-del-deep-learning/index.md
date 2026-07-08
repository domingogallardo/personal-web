---
title: "El dogma del deep learning"
date: 2024-12-18
draft: false
tags:
  - "newsletter"
  - "LLMs"
---
<p>
</p>

<p>
<img src="Pasted image 20241215092155.png" alt="">
</p>

<h2>El artículo de McCulloch y Pitts</h2>

<p>El artículo de <strong>McCulloch y Pitts</strong> de 1943, <em>
<a href="https://home.csulb.edu/~cwallis/382/readings/482/mccolloch.logical.calculus.ideas.1943.pdf">A Logical Calculus of the Ideas Immanent in Nervous Activity</a>
</em>, constituyó el trabajo fundacional del conexionismo y de las redes neuronales artificiales (ANNs, en inglés). El artículo parte de lo que se conocía en la época sobre el funcionamiento de las neuronas y establece, de una forma densa y muy matemática (tiene 19 páginas en las que se demuestran hasta diez teoremas) una equivalencia entre el funcionamiento de las neuronas y el de una<strong> red de proposiciones lógicas</strong> en las que las neuronas representan variables que solo pueden tener dos valores ("all-or-none") que los autores identifican con los valores booleanos TRUE o FALSE.</p>

<p>
<img src="Pasted image 20241215092106.png" alt="">
</p>

<p>Imagen del artículo original de McCulloch y Pitts que muestra las neuronas como unidades lógicas.</p>

<p>Cinco años antes, en 1938, <strong>Claude Shannon</strong> había publicado en el MIT su tesis de máster <em>
<a href="https://dspace.mit.edu/handle/1721.1/11173">A Symbolic Analysis of Relay and Switching Circuits</a>
</em>, en la que demostraba cómo diseñar circuitos eléctricos concretos que implementaran operaciones lógicas definidas por el álgebra de Boole. Este enfoque práctico permitió construir <strong>dispositivos capaces de realizar funciones lógicas</strong> básicas como AND, OR y NOT y fue el punto inicial de la vertiginosa década de los 40 en la que investigadores como <strong>Von Neumann</strong> o <strong>Alan Turing</strong> diseñaron los primeros ordenadores digitales.</p>

<p>
<img src="Pasted image 20241215122123.png" alt="">
</p>

<p>Tabla en el artículo de Shannon en la que se muestran las operaciones lógicas realizadas por los circuitos diseñados.</p>

<p>Aunque <strong>McCulloch y Pitts</strong> no citaron en su artículo a <strong>Shannon</strong>
<a class="footnote-anchor" data-component-name="FootnoteAnchorToDOM" id="footnote-anchor-1" href="#footnote-1" target="_self">1</a>, es bastante probable que se inspiraran en su concepto de <strong>circuitos lógicos</strong>. Si esos circuitos podían ser la base del funcionamiento de los nuevos computadores digitales que se estaban empezando a desarrollar, ¿por qué no podían ser también la forma en la que las neuronas funcionaban? En cualquier caso, ambos artículos se convirtieron en fundacionales y sentaron las bases de la revolución de los computadores digitales de finales de los años 40 y de la revolución actual de la inteligencia artificial. Como curiosidad, ambos modelos estaban basados en el <strong>álgebra de Boole</strong>, un sistema teórico propuesto 100 años antes por el matemático inglés <strong>George Boole</strong>. Este es un ejemplo fascinante de cómo un trabajo matemático que en principio solo tiene importancia teórica es la base, un siglo después, de unos avances tecnológicos radicales: los computadores digitales y la Inteligencia Artificial.</p>

<p>El modelo de <strong>McCulloch y Pitts</strong> con el tiempo ha sufrido algunas modificaciones, siendo la más importante de ellas el modelo de <strong>Perceptron</strong> introducido por <strong>Frank Rosenblatt</strong> en 1958. En este modelo se añadían <strong>pesos</strong> a las conexiones entre las neuronas y se introducía un umbral de activación, que determinaba si una neurona “se activaba” o no (produciendo un 1 o un 0) en función de la suma ponderada de sus entradas. Si la suma superaba el umbral, la neurona se activaba.</p>

<p>En las redes neuronales modernas, este concepto ha evolucionado significativamente. Las funciones de activación actuales, como la sigmoide, la tangente hiperbólica (tanh) o la ReLU (Rectified Linear Unit), permiten que las neuronas tomen <strong>valores continuos</strong> en lugar de binarios. Por ejemplo, la función sigmoide produce valores en el rango [0, 1], mientras que la tangente hiperbólica los normaliza en el intervalo [-1, 1]. Esta evolución ha dotado a las redes neuronales modernas de mayor flexibilidad y capacidad de aprendizaje, facilitando la representación de relaciones complejas y la propagación eficiente de errores durante el entrenamiento.</p>

<p>Con estas modificaciones, con el descubrimiento de algoritmos eficientes de actualización de los pesos y con la <strong>multiplicación exponencial</strong> del número de neuronas<a class="footnote-anchor" data-component-name="FootnoteAnchorToDOM" id="footnote-anchor-2" href="#footnote-2" target="_self">2</a>, se ha conseguido que las ANNs puedan hacer, en <a href="https://github.com/shun-liang/readable-talks-transcriptions/blob/main/neurips_2024/Vincent%20Weisser%20-%20.%40ilyasut%20full%20talk%20at%20neurips%202024%20pre-training%20as%20we%20know%20it%20will%20end%20and%20what%20comes%20next%20is%20superintelligence%20agentic%2C%20reasons%2C%20understands%20and%20is%20self%20aware.md">palabras de Ilya Sutskever</a> en su charla en la conferencia NIPS 2024, cualquier cosa que un humano pueda hacer de forma intuitiva:</p>

<blockquote>
<p>Pueden hacer cualquier cosa que un ser humano pueda hacer en una fracción de segundo.</p>

</blockquote>

<h2>El cerebro humano como una enorme red neuronal artificial</h2>

<p>Hace más de 80 años, en las conclusiones de su artículo, <strong>McCulloch y Pitts</strong> realizaban afirmaciones rotundas en las que asimilaban el funcionamiento completo del cerebro al estado de su propuesta red de neuronas lógicas:</p>

<blockquote>
<p>La especificación, en un momento dado, de la estimulación aferente y de la actividad de todas las neuronas constituyentes, cada una con un comportamiento de “todo o nada”, determina el estado [global del cerebro]. <strong>La especificación de la red nerviosa proporciona la ley de conexión necesaria, mediante la cual se puede calcular, a partir de la descripción de cualquier estado, el estado sucesivo.</strong>
</p>

<p>
<strong>Cada idea y cada sensación</strong> se realiza a través de la actividad dentro de esa red.</p>

</blockquote>

<p>El nivel de autocomplacencia y falta de humildad es sorprendente. Estas afirmaciones no se planteaban como hipótesis o especulaciones futuras, sino como conclusiones definitivas. Sin embargo, carecían de evidencia experimental, ya que se basaban únicamente en una formulación matemática, sin referencias a investigaciones en fisiología neuronal o celular que respaldaran tales ideas.</p>

<p>Curiosamente, parece que el tiempo les ha dado la razón. La noción de que las ANNs representan una abstracción válida del funcionamiento de las neuronas naturales se ha consolidado como el <strong>dogma central del conexionismo</strong>, como lo describe <strong>Ilya Sutskever,</strong> quien en la mencionada conferencia NIPS 2024 afirmó:</p>

<blockquote>
<p>Es la <strong>idea central del aprendizaje profundo</strong>: la idea del conexionismo. Es la creencia de que, si aceptas que <strong>una neurona artificial es en cierta medida análoga a una neurona biológica</strong>, entonces puedes confiar en que redes neuronales muy grandes —aunque no necesariamente tan grandes como el cerebro humano— pueden configurarse para realizar prácticamente todas las tareas que nosotros, como seres humanos, somos capaces de llevar a cabo.</p>

</blockquote>

<p>
</p>

<p>
<img src="Pasted image 20241216132628.png" alt="">
</p>

<p>Ilya Sutskever en su conferencia plenaria en NIPS 2024, planteando la idea central del conexionismo.</p>

<p>Muchos científicos actuales de IA comparten este enfoque reduccionista. Por ejemplo <strong>Oriol Vinyals</strong>, investigador destacado de <strong>Google DeepMind</strong>, declaraba en una entrevista en el <a href="https://youtu.be/78mEYaztGaw?si=LMTItsoqTGAm-DX2">podcast de Deep Mind</a>:</p>

<blockquote>
<p>Puedes imaginar una neurona conectada a varias otras, y lo que haces esencialmente es sumar todas las activaciones de las neuronas entrantes, multiplicadas por sus respectivos pesos. <strong>Es, en esencia, cómo funciona un cerebro</strong>, con cierta libertad creativa.</p>

</blockquote>

<p>Una de las principales ventajas de esta abstracción ha sido la <strong>eficacia en su computación</strong>. Las neuronas y sus pesos se pueden representar mediante enormes matrices de números reales, y son procesadas en paralelo por potentes GPUs diseñadas para realizar cálculos masivos de álgebra lineal. Esto ha permitido entrenar ANNs cada vez más grandes y complejas, logrando éxitos espectaculares en reconocimiento de patrones y regularidades, que imitan el desempeño de las redes neuronales biológicas.</p>

<p>Este enfoque reduccionista no es fruto del desconocimiento, sino que es una <strong>decisión deliberada</strong> de ignorar las complejidades biológicas que subyacen al comportamiento de las redes neuronales naturales. Por ejemplo, <strong>Demis Hassabis</strong>, tras varios años explorando el funcionamiento biológico de la inteligencia, considera en su artículo <em>
<a href="https://www.cell.com/neuron/pdf/S0896-6273%2817%2930509-3.pdf">Neuroscience-Inspired Artificial Intelligence</a>
</em> que es una cuestión de trabajar con el <strong>nivel de abstracción correcto</strong>, y que éste se sitúa por encima del sustrato neuronal real:</p>

<blockquote>
<p>Desde un punto de vista práctico, no necesitamos adherirnos estrictamente a la plausibilidad biológica para construir sistemas de IA. Lo que funciona es, en última instancia, lo que importa. Por lo tanto, <strong>la plausibilidad biológica es solo una guía</strong>, no un requisito estricto. Nuestro interés radica en una comprensión <strong>a nivel algorítmico y computacional</strong> del cerebro, dejando de lado el nivel de implementación biológica.</p>

</blockquote>

<p>
<strong>Hassabis</strong> hace referencia explícita a los <strong>tres niveles de análisis</strong> propuestos por <strong>David Marr</strong>, y considera que el nivel más bajo, el de los mecanismos físicos del sustrato neuronal, es menos relevante:</p>

<blockquote>
<p>Nuestro interés radica en los dos niveles superiores de los tres niveles de análisis que <strong>Marr</strong> estableció para comprender cualquier sistema biológico complejo: el nivel computacional (el objetivo del sistema y el problema que resuelve) y el nivel algorítmico (los procesos y algoritmos que permiten alcanzar ese objetivo). El nivel de implementación, que aborda los <strong>mecanismos físicos</strong> específicos, <strong>es menos relevante</strong> aquí.</p>

</blockquote>

<h2>Los ritmos de las neuronas</h2>

<p>Lo que es poco relevante para los ingenieros e informáticos es el día a día de investigación de los neurocientíficos. Y la visión que ellos tienen es completamente distinta.</p>

<p>Por un lado, para <strong>simular de forma teórica el funcionamiento de una neurona</strong>, deben emplear complejas ecuaciones diferenciales que describen la evolución temporal de distintas concentraciones de iones a través de sus membranas celulares, incluyendo los cambios que ocurren en las sinapsis. Hay conexiones que refuerzan el potencial (excitadoras) y otras que lo inhiben (inhibidoras). Ambas interacciones ocurren como <strong>parte de patrones dinámicos de disparo</strong> en redes formadas por <strong>miles de neuronas</strong> conectadas. El resultado de toda esta interacción es una ráfaga de disparos (<em>
<strong>spikes</strong>
</em>) de la neurona que, a su vez, se convierte en la entrada para muchas otras neuronas.</p>

<p>
<img src="4-Figure1-1.png" alt="">
</p>

<p>Esquema con la secuencia temporal de disparos que entran en una neurona y la secuencia de salida de disparos de la misma neurona.</p>

<p>Por otro lado, los avances experimentales han permitido observar directamente la actividad neuronal gracias a técnicas como el uso de <strong>micro-electrodos</strong>, que pueden registrar tanto la actividad de poblaciones completas como la de neuronas individuales. Estos registros han revelado que las neuronas se disparan en patrones temporales precisos, y que la <strong>frecuencia</strong> de estos disparos puede <strong>codificar información</strong>. Por ejemplo, en neuronas conectadas a músculos, la intensidad de los disparos puede reflejar la fuerza del movimiento que se requiere, mientras que en otras áreas del cerebro los patrones temporales están asociados con la transmisión de señales sensoriales o cognitivas.</p>

<p>
<img src="Pasted image 20241218090922.png" alt="">
</p>

<p>Registro temporal de la actividad de neuronas individuales mientras un ratón se desplaza a lo largo de un entorno lineal de 170 cm. (G) El panel superior muestra las ráfagas de disparos (<em>spikes</em>) de distintas neuronas (celdas numeradas) en relación con la posición y la velocidad del ratón. Cada punto de color representa un evento de disparo asociado a una neurona específica. (H) Los recuadros ampliados (marrón, amarillo y morado) muestran los patrones precisos de disparos en intervalos de 250 ms, destacando la dinámica temporal y la sincronización entre las neuronas. Este tipo de actividad refleja cómo las redes neuronales biológicas organizan la información en escalas temporales precisas y exhiben ritmos que facilitan la integración de estímulos espaciales y motores. György Buzsáki y Mihály Vöröslakos, <em>
<a href="https://www.sciencedirect.com/science/article/pii/S0896627323002143">"Brain rhythms have come of age”</a>, Neuron, Abril 2023.</em>
</p>

<p>La importancia de los <strong>ritmos del cerebro</strong> es un campo de creciente interés en la neurociencia actual. Además de los patrones de disparo individuales, se han identificado <strong>oscilaciones rítmicas</strong> en distintas frecuencias, como theta, gamma y delta, que organizan la actividad neuronal en escalas temporales más amplias. </p>

<p>
<strong>Jeff Lichtman</strong>, destacado neurocientífico de Harvard y pionero en el mapeo del conectoma, destacó en una reciente entrevista en el <a href="https://www.preposterousuniverse.com/podcast/2024/12/09/298-jeff-lichtman-on-the-wiring-diagram-of-the-brain/"><em>podcast Mindscape</em></a> de <strong>Sean Carroll</strong> que, aunque los avances en la neurociencia han permitido mapear con gran detalle las conexiones neuronales, estas no pueden capturar la <strong>complejidad dinámica</strong> del cerebro. Como él mismo señala:</p>

<blockquote>
<p>Aunque es posible mapear con gran detalle la red de conexiones neuronales, estos mapas <strong>no revelan</strong> la fuerza de las sinapsis, las <strong>no linealidades</strong> en la respuesta de las células y, especialmente, el momento en que los diferentes estímulos activan la célula. Hay tanto entradas excitadoras como inhibidoras, además de entradas moduladoras de neurotransmisores. Y todo eso es latente, pero no alcanzable, en el diagrama de conexiones.</p>

</blockquote>

<p>Esta dimensión temporal es un fenómeno físico exclusivo de las redes neuronales biológicas, que los modelos conexionistas de deep learning no pueden capturar. Su existencia en el cerebro real sugiere que desempeñan un papel fundamental que aún no comprendemos del todo. Como, según <strong>Lichtman</strong>, tampoco comprendemos la complejidad del cerebro:</p>

<blockquote>
<p>Hay ciertas cosas en el mundo, quizá el cerebro sea un ejemplo, que no tienen simplificación posible. Si la hubiera, los cerebros habrían sido más simples.</p>

</blockquote>

<p>¿Para qué sirven las oscilaciones rítmicas del cerebro? ¿Qué codifican? ¿Qué importancia tienen los distintos patrones de disparo de las neuronas? </p>

<p>En el próximo artículo revisaremos estas preguntas con más detalle y plantearé mi <strong>especulación favorita</strong>: la <strong>consciencia</strong> podría ser un fenómeno emergente de los patrones oscilatorios del cerebro. Más específicamente, la 'capacidad de sentir' (<em>
<strong>sentience</strong>
</em>, en inglés) sería el resultado de los patrones de disparo en las redes neuronales biológicas, presentes en la mayor parte de los <strong>seres vivos con sistemas neuronales complejos</strong>. Sin embargo, esta capacidad resulta <strong>inalcanzable</strong> para los sistemas artificiales basados en procesos secuenciales algorítmicos que, por su propia naturaleza, nunca tendrán la capacidad de experimentar sensaciones.</p>

<div>
<hr>

</div>
<p>¡Hasta la próxima, nos leemos! 👋👋</p>

<div class="footnote" data-component-name="FootnoteToDOM">
<a id="footnote-1" href="#footnote-anchor-1" class="footnote-number" contenteditable="false" target="_self">1</a>
<div class="footnote-content">
<p>En su artículo solo había tres referencias, una de ellas al <em>Principia Mathematica</em> de <strong>Russell</strong>. Un joven ingeniero de veintipocos años como <strong>Shannon</strong>, que acababa de graduarse con una tesis de máster, no tenía el pedigrí suficiente para aparecer junto a esos pocos gigantes referenciados.</p>

</div>
</div>
<div class="footnote" data-component-name="FootnoteToDOM">
<a id="footnote-2" href="#footnote-anchor-2" class="footnote-number" contenteditable="false" target="_self">2</a>
<div class="footnote-content">
<p>Se ha pasado de los primeros modelos de decenas de neuronas distribuidas en una o dos capas de las ANNs multi-capa de los años 1980 a las decenas de millones de neuronas distribuida en alrededor de 100 capas de GPT-3 en los años 2020.</p>

<p>
</p>

</div>
</div>
