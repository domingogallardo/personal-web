---
title: "o3 resuelve ARC-AGI"
date: 2024-12-22
draft: false
tags:
  - "newsletter"
---
<p>Cuando a principios de la semana envié el último artículo, pensaba que iba a ser el último del año. Quería terminar el año hablando <a href="/posts/el-dogma-del-deep-learning/">del dogma del </a>
<em>
<a href="/posts/el-dogma-del-deep-learning/">deep learning</a>,</em> abriendo el camino para una futura continuación en la que hablara sobre la <strong>consciencia</strong>. Y quería dejar quieta la newsletter unas semanas y trabajar poco a poco, con tranquilidad, en este nuevo artículo. </p>

<p>De hecho, le he cambiado el título a la newsletter, <strong>ya no se llama Quince días</strong>. Así me quito la presión de tener que hacer dos entregas mensuales y de contar la actualidad. Ya hay otras newsletters muy interesantes de noticias de IA. Quiero continuar con el enfoque que le he dado en los últimos números, en los que toco con cierta profundidad algún tema, que no tiene por qué ser de actualidad.</p>

<p>Pero el viernes pasó algo que hay que contar aquí, sí o sí. </p>

<p>OpenAI ha hecho públicos unos resultados impresionantes de <strong>su nuevo modelo razonador o3</strong>, la siguiente versión de <strong>o1</strong>. A continuación está el vídeo con la presentación:</p>

<div id="youtube2-SKBG1sqdyIU" class="youtube-wrap" data-attrs="{&quot;videoId&quot;:&quot;SKBG1sqdyIU&quot;,&quot;startTime&quot;:null,&quot;endTime&quot;:null}" data-component-name="Youtube2ToDOM">
<div class="youtube-inner">
<iframe src="https://www.youtube-nocookie.com/embed/SKBG1sqdyIU?rel=0&amp;autoplay=0&amp;showinfo=0&amp;enablejsapi=0" frameborder="0" loading="lazy" gesture="media" allow="autoplay; fullscreen" allowautoplay="true" allowfullscreen="true" width="728" height="409">
</iframe>
</div>
</div>
<p>Todos los resultados que presentan muestran un salto espectacular en los benchmarks más complicados. Por ejemplo, <strong>pasan del 48,9% al 71,7% en SWE-bench Verified</strong>, un benchmark de problemas de programación. O <strong>pasan del 3% al 25% en el “AI's Frontier Math”</strong>, un test que está compuesto de problemas de matemáticas del nivel de doctorado.</p>

<p>
<img src="Screenshot 2024-12-21 at 10.52.05.png" alt="">
</p>

<p>Pero lo que ha sido realmente sorprendente ha sido que <strong>han conseguido resolver la <a href="/posts/del-1-al-15-de-junio-11-de-2024/">competición ARC-AGI</a> de François Chollet</strong>. En el vídeo de presentación de <strong>o3</strong>, mostraron la figura anterior, en la que se muestra cómo <strong>o3</strong> ha conseguido acertar un 75,7% en su versión "low" y un 87% en su versión "high". </p>

<p>¿Qué es esto de "low" y "high"? Como vimos en el artículo en el que hablamos de <a href="/posts/como-funciona-o1-15-de-2024/">cómo funciona o1</a>, estos modelos razonadores pueden afinar sus resultados cuando tienen más tiempo de computación. Los modos "low" y "high" son denominaciones que han dado los investigadores de OpenAI a un funcionamiento de <strong>o3</strong> con poco tiempo de computación y con mucho tiempo de computación. En la gráfica también se muestra que el tiempo de computación del modo "low" de <strong>o3</strong> es significativamente mayor que el del modo "high" de <strong>o1</strong> que consigue un 32% (no dicen si la escala horizontal es lineal o logarítmica, supongo que será lineal, igual que la vertical).</p>

<p>En el momento en que en la retransmisión de OpenAI apareció <a href="https://x.com/GregKamradt">Greg Kamradt</a>, presidente del premio ARC, y explicó todo lo anterior, <strong>me explotó la cabeza</strong>. No me lo terminaba de creer. Fui corriendo a X a comprobar las reacciones, empecé a ver los posts de gente relacionada con la competición, y, por fin, <strong>cuando vi <a href="https://x.com/fchollet/status/1870169764762710376">la reacción del propio Chollet</a> fue cuando confirmé que era real</strong>. El equipo de OpenAI responsable de los modelos “o” había hecho algo histórico, resolver ARC-AGI. Se había resuelto en tres meses, desde la presentación de <strong>o1</strong>, un reto propuesto para identificar capacidades de razonamiento y de inteligencia humana.</p>

<p>¿Qué implicaciones tiene este enorme éxito en el desarrollo de <strong>o3</strong>?</p>

<p>La implicación más importante es que se <strong>valida el enfoque</strong> de la serie de modelos razonadores "o", y se comprueba que estos modelos integran perfectamente la intuición (System 1) de los LLMs tradicionales con algún tipo de razonamiento System 2 deductivo e iterativo. OpenAI ha encontrado los ingredientes de la sopa definitiva, la que permite combinar los dos tipos de razonamiento de los que hablamos en el <a href="/posts/francois-chollet-20-de-2024/">artículo sobre Chollet</a>. Esta combinación es clave para el futuro, porque garantiza la mejora continua de los modelos. Por un lado, cuando se consiga un nuevo modelo intuitivo mejor (GPT-5) se integrará fácilmente en el nuevo modelo "o". Y cuando se mejoren las capacidades deductivas y se abarate el coste de computación también se podrá conseguir mejoras sustanciales.</p>

<p>Otra implicación fundamental es que se confirma <strong>el papel de NVIDIA</strong> y de los fabricantes de chips. Y de la energía necesaria para alimentarlos. Quien tenga más MegaFLOPS será el que mejores resultados obtenga. Ilya Sutskever acaba de decir que los datos son la nueva energía fósil. También lo es la potencia de computación.</p>

<p>Por último, hay que destacar la enorme suerte (o el bien hacer) de OpenAI, que ha podido terminar el año con un avance espectacular y ha encontrado con los modelos "o" una forma de avanzar en su camino hacia la AGI sin tener que echar mano de su siguiente modelo GPT. Hoy mismo, <a href="https://www.wsj.com/tech/ai/openai-gpt5-orion-delays-639e7693">en el Wall Street Journal</a>, se detallan todos los <strong>problemas que están teniendo para desarrollar GPT-5</strong>. Parece que los dos o tres pre-trainings que OpenAI ha intentado han fracasado después de meses de computación. Un modelo 10 veces más grande que GPT-4 necesita también 10 veces más cantidad de datos (como mínimo) y parece que están teniendo problemas con eso. El debate sobre si <a href="/posts/del-1-al-15-de-noviembre-19-de-2024/">existe un muro en el </a>
<em>
<a href="/posts/del-1-al-15-de-noviembre-19-de-2024/">deep learning</a>
</em>
<strong>todavía no se ha resuelto</strong>.</p>

<p>También hay que aclarar que, aunque el éxito de <strong>o3</strong> ha sido espectacular, todavía no hemos alcanzado la AGI. Hay muchos elementos que <strong>faltan por integrar</strong> en estos modelos, como la posibilidad de razonar con un modelo físico del mundo, el aprendizaje continuo o la creatividad.</p>

<p>Seguiremos muy atentos durante 2025 a estos temas básicos de investigación sobre el <em>deep learning</em> y los modelos de lenguaje, que marcarán el futuro de la tecnología.</p>

<p>Mientras, los avances que hemos visto en este 2024 dan para muchísimas aplicaciones que todavía están pendientes de desarrollar con los modelos ya disponibles. </p>

<p>Esto no para.</p>

<div>
<hr>

</div>
<p>¡Hasta la próxima, nos leemos! 👋👋</p>

<p>
</p>
