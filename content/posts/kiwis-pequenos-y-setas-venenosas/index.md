---
title: "Kiwis pequeños y setas venenosas (#18 de 2024)"
date: 2024-11-01
draft: false
tags:
  - "newsletter"
  - "LLMs"
---
<p>Vamos con una continuación del <a href="/posts/donde-dije-sentido-comun-digo-razonamiento/">artículo de la semana pasada</a>. Me gustó mucho el engaño utilizado en el artículo que mencionamos de Apple para demostrar los problemas a los que se enfrentan los modelos de lenguaje con el razonamiento, y he estado modificándolo y <strong>probándolo con distintos modelos</strong>. Sin embargo, mi objetivo no es investigar el tema del razonamiento, sino explorar el otro aspecto que mencionamos: el de la comprensión.</p>

<p>Por si no tienes tiempo de leer hasta el final, adelanto las conclusiones de estas pruebas. Los experimentos que vamos a detallar muestran cómo: (1) los LLMs poseen una comprensión del lenguaje natural que influye en su competencia en los razonamientos que realizan, y (2) cuanto mayor es el LLM, más abstracta resulta ser esta comprensión.</p>

<p>No estoy descubriendo nada nuevo. Que los LLMs puedan configurarse mediante lenguaje natural para mejorar su competencia es algo conocido desde los inicios de los chatbots, cuando&nbsp;<a href="https://arstechnica.com/information-technology/2023/02/ai-powered-bing-chat-spills-its-secrets-via-prompt-injection-attack/">se filtraron los prompts de Sydney</a>. Además, que el tamaño del LLM aumente su capacidad de abstracción es un tema que hemos tratado en varias ocasiones al mencionar la&nbsp;<a href="https://gwern.net/scaling-hypothesis">hipótesis de escalado</a>. Pero en este artículo, vamos a ofrecer <strong>ejemplos sencillos</strong> que nos permitirán comprender mejor estas ideas.</p>

<p>¡Gracias por leerme!</p>

<p>
<img src="EBEDA640-FEEA-4EB8-BE9F-20A94C897E91.webp" alt="">
</p>

<h2>Un kiwi pequeño sigue siendo un kiwi</h2>

<p>Empecemos explicando la trampa que los investigadores de Apple tienden a los LLMs. La analizan en detalle en&nbsp;<a href="https://arxiv.org/abs/2410.05229">su artículo</a>, donde explican cómo basta con añadir algún dato aparentemente irrelevante a un enunciado de un problema de primaria para confundir al LLM y hacer que no lo resuelva correctamente.</p>

<p>Primero, veamos el enunciado sin trampa. Es sencillo, pero requiere un poco de razonamiento:</p>

<blockquote>
<p>Oliver recoge 44 kiwis el viernes. Luego, recoge 58 kiwis el sábado. El domingo, recoge el doble de kiwis que recogió el viernes. ¿Cuántos kiwis tiene Oliver en total?</p>

</blockquote>

<p>He descargado&nbsp;<a href="https://lmstudio.ai/">LM Studio</a>&nbsp;en mi MacBook Air (M3 con 16 GB de RAM) y he probado los modelos pequeños&nbsp;<strong>
<a href="https://huggingface.co/mlx-community/Qwen2-7B-Instruct-4bit">Qwen2-7B-Instruct-4bit</a>
</strong>&nbsp;y&nbsp;<strong>
<a href="https://huggingface.co/mlx-community/Meta-Llama-3.1-8B-Instruct-4bit">Meta-Llama-3.1-8B-Instruct-4bit</a>
</strong>. Ambos lo resuelven sin problema, como se muestra en la imagen.</p>

<p>
<img src="Pasted image 20241031164210.png" alt="">
</p>

<p>Podría parecer que los modelos están razonando, pero los autores demuestran que no es así mediante un truco muy ingenioso. Añaden un <strong>dato irrelevante</strong> al enunciado, concretamente la siguiente frase (la frase añadida está en negrita):</p>

<blockquote>
<p>Oliver recoge 44 kiwis el viernes. Luego, recoge 58 kiwis el sábado. El domingo, recoge el doble de kiwis que recogió el viernes,&nbsp;<strong>pero cinco de ellos eran más pequeños que la media</strong>. ¿Cuántos kiwis tiene Oliver en total?</p>

</blockquote>

<p>La mención de que cinco de los kiwis son más pequeños es irrelevante. Esos kiwis deberían contarse igual, y Oliver debería seguir teniendo 190 kiwis en total. Sin embargo, estos LLMs básicos se confunden y los descuentan. A continuación, mostramos la imagen de<strong> Llama-3.1-8B</strong>.</p>

<p>
<img src="Pasted image 20241031171141.png" alt="">
</p>

<p>¿Por qué se confunden? Porque aplican de forma literal un patrón que han aprendido: al encontrar una frase del tipo “pero bla, bla, bla”, tienden a restar los ítems mencionados en el “bla, bla, bla”. No se dan cuenta de que es irrelevante que cinco kiwis sean más pequeños.</p>

<h2>Los modelos pequeños son inflexibles</h2>

<p>En el&nbsp;<a href="https://aiguide.substack.com/p/the-llm-reasoning-debate-heats-up"><strong>artículo de Melanie Mitchell</strong></a>, que también comentábamos la semana pasada, se enlazaba a un&nbsp;<a href="https://x.com/boazbaraktcs/status/1844763538260209818">tweet</a>&nbsp;en el que se sugería que otra posible explicación del fallo de los LLMs era la<strong> falta de contexto</strong> suficiente. Puede que los LLMs, entrenados para conversar, se confundan porque interpretan que, por ejemplo, a Oliver no le gustan los kiwis pequeños. Deberíamos explicar al LLM que se trata de un ejercicio de matemáticas. En el tweet se dice:</p>

<blockquote>
<p>Mi conjetura es que, por ejemplo, con algo de prompt engineering con la que le explicáramos al LLM que esto es un examen de matemáticas, probablemente la mayoría de estos problemas desaparecerían.</p>

</blockquote>

<p>Pues bien, <strong>no es así</strong>. Al menos con estos modelos pequeños. Por mucha explicación que he añadido, no he conseguido que los modelos pequeños dejen de confundirse. He probado con varias introducciones al problema, como las siguientes:</p>

<ul>
<li>
<p>"Resuelve el siguiente problema de matemáticas."</p>

</li>
<li>
<p>"Supongamos que estás en clase de matemáticas y el profesor te pone el siguiente problema. "</p>

</li>
<li>
<p>"Supongamos que estás en clase de matemáticas y el profesor te pone el siguiente problema. Es un profesor bastante quisquilloso, que a veces pone problemas que tienen alguna trampa en el enunciado."</p>

</li>
</ul>

<p>Incluso indicándoles explícitamente que no deben confundirse con detalles irrelevantes, no obtengo buenos resultados:</p>

<ul>
<li>
<p>"Supongamos que estás en clase de matemáticas y el profesor te pone el siguiente problema. Debes sumar todos los kiwis, independientemente de su tamaño."</p>

</li>
<li>
<p>"Debes sumar todos los kiwis, no restes los que son más pequeños de lo normal."</p>

</li>
<li>
<p>"Debes sumar TODOS los kiwis. NO DEBES RESTAR los que son más pequeños de lo normal. "</p>

</li>
</ul>

<p>La última instrucción es la más directa posible, con frases en mayúscula para resaltar su importancia, y ni siquiera así funcionan bien:</p>

<p>
<img src="Pasted image 20241031175404.png" alt="">
</p>

<p>Cuando ves esto, te das cuenta de la fe que debieron tener los investigadores de OpenAI para <strong>no desanimarse </strong>con los primeros modelos.</p>

<h2>Los modelos grandes no se confunden fácilmente</h2>

<p>Vamos ahora a probar con LLMs mucho más grandes: <strong>ChatGPT 4o</strong> y <strong>4o mini</strong>. Dejamos fuera el modelo o1 porque no es un LLM puro.</p>

<p>Los modelos pequeños anteriores cuentan con 8 mil millones de parámetros (8B). <strong>OpenAI</strong> no ha hecho público el número de parámetros de <strong>GPT-4o</strong>, pero sabemos que <strong>GPT-3.5</strong> tenía 175 mil millones (175B), y se rumorea que <strong>GPT-4</strong> tiene algo más de un billón (1.000B). No importa demasiado, ya que estamos realizando un experimento sin mucho rigor científico, así que basta con considerar los órdenes de magnitud:</p>

<ul>
<li>
<p>Los modelos pequeños anteriores tienen 8B parámetros.</p>

</li>
<li>
<p>
<strong>GPT-4o</strong> cuenta con alrededor de dos órdenes de magnitud más (100x).</p>

</li>
<li>
<p>Presumiblemente, <strong>4o mini</strong> es algo más pequeño que <strong>4o</strong>.</p>

</li>
</ul>

<p>Al probar el problema original de los kiwis, vemos que este salto de dos órdenes de magnitud se nota bastante: <strong>ChatGPT 4o</strong> lo resuelve siempre perfectamente.</p>

<p>
<img src="Pasted image 20241031181604.png" alt="">
</p>

<p>Fue una pequeña decepción que funcionaran tan bien, ya que no podía realizar los experimentos previos de añadir contexto antes del problema. Entonces, se me ocurrió enredar un poco más el problema: ¿y si en lugar de hablar de kiwis pequeños mencionamos <strong>setas venenosas</strong>?</p>

<blockquote>
<p>Oliver recoge 44 setas el viernes. Luego, recoge 58 setas el sábado. El domingo, recoge el doble de setas que recogió el viernes, pero cinco de ellas eran venenosas. ¿Cuántas setas tiene Oliver en total?</p>

</blockquote>

<p>Aquí las posibilidades de confusión son mucho mayores. De hecho, si no lo consideramos un problema de matemáticas, muchos diríamos que la respuesta es 185, porque asumiríamos que Oliver está recogiendo setas para después comérselas. En efecto, tanto <strong>4o</strong> como <strong>4o mini</strong> responden de esta forma. <strong>4o</strong> incluso especifica que se refiere a “setas comestibles”:</p>

<blockquote>
<p>Ahora, sumamos todas las setas comestibles:<br>
<code>44 + 58 + 83 = 185</code>
</p>

<p>
<strong>Respuesta</strong>: Oliver tiene un total de 185 setas comestibles.</p>

</blockquote>

<p>Perfecto, es justo lo que buscaba. Ahora puedo empezar a añadir contexto y experimentar cuánta información es necesaria para que <strong>ChatGPT</strong> considere que hay que sumar todas las setas, sean comestibles o no.</p>

<p>Por cierto, es curioso (y nos dice bastante de la capacidad de comprensión de estos modelos) que al cambiar el enunciado y mencionar que Oliver “hace fotos” en lugar de “recoger” setas, los modelos <strong>ya no se confunden</strong>:</p>

<blockquote>
<p>Oliver hace fotos a 44 setas el viernes. Luego, hace fotos a 58 setas el sábado. El domingo, hace fotos al doble de setas que hizo el viernes, pero cinco de ellas eran venenosas. ¿Cuántas fotos de setas tiene Oliver en total?</p>

</blockquote>

<p>Tanto <strong>4o</strong> como <strong>4o mini</strong> responden siempre 190, reconociendo que, para obtener fotos de las setas, no importa si son venenosas o no.</p>

<h2>Cuanto mayor es el modelo, más abstractas pueden ser las indicaciones</h2>

<p>Ya tenemos entonces el problema que causa confusión en los modelos grandes:</p>

<blockquote>
<p>Oliver recoge 44 setas el viernes. Luego, recoge 58 setas el sábado. El domingo, recoge el doble de setas que recogió el viernes, pero cinco de ellas eran venenosas. ¿Cuántas setas tiene Oliver en total?</p>

</blockquote>

<p>Lo que hice fue, igual que con los modelos pequeños, ir añadiendo una explicación al principio, para contextualizar el problema, y probarlo tanto en <strong>4o</strong> como en <strong>4o mini</strong>. Puedes probarlo tú también para comprobar si te salen los mismos resultados. Recuerda que debes iniciar un chat nuevo cada vez.</p>

<ol>
<li>
<p>Comenzamos añadiendo la frase <strong>“</strong>
<em>
<strong>Resuelve el siguiente problema de matemáticas</strong>
</em>
<strong>”.</strong> No funciona; este contexto no es suficiente, y ambos modelos responden incorrectamente.</p>

</li>
<li>
<p>Añadimos más contexto: <strong>“</strong>
<em>
<strong>Supongamos que estás en clase de matemáticas y el profesor te plantea el siguiente problema. ¿Qué contestarías?</strong>
</em>
<strong>”</strong>. Tampoco funciona.</p>

</li>
<li>
<p>Añadimos aún más contexto, aunque de forma sutil, para que la pista no sea tan directa: <strong>“</strong>
<em>
<strong>Supongamos que estás en clase de matemáticas y el profesor te plantea el siguiente problema. Es un profesor bastante quisquilloso, que a veces incluye trampas en los enunciados. ¿Qué contestarías?</strong>
</em>
<strong>”</strong> Ahora sí, esta frase es suficiente para que <strong>4o </strong>acierte alrededor de la mitad de las veces (recordemos que los LLMs son modelos estocásticos), respondiendo en ocasiones que tiene 190 setas. Sin embargo, <strong>4o mini </strong>sigue contestando incorrectamente.</p>

</li>
<li>
<p>Luego, damos una indicación más concreta: <strong>“</strong>
<em>
<strong>Debes considerar todos los ítems recogidos, sean comestibles o no</strong>
</em>
<strong>”</strong>. Esto permite que&nbsp;<strong>4o acierte casi siempre</strong>&nbsp;y diga 190 setas, mientras que 4o mini solo acierta algunas veces.</p>

</li>
<li>
<p>Finalmente, al cambiar “ítems” por “setas”,&nbsp;<strong>ambos modelos responden siempre correctamente</strong>, tanto <strong>4o </strong>como <strong>4o mini</strong>. El contexto completo sería: <strong>“</strong>
<em>
<strong>Resuelve el siguiente problema de matemáticas. Debes considerar todas las setas recogidas, sean comestibles o no.</strong>
</em>
<strong>”</strong>
</p>

</li>
</ol>

<p>Resumiendo los experimentos, al presentar el problema a <strong>ChatGPT 4o</strong> y <strong>4o mini</strong>, ambos modelos inicialmente fallaron al interpretarlo, descontando las setas venenosas en lugar de sumarlas. La idea de que no deben contar las setas venenosas es <strong>demasiado potente</strong> y difícil de eliminar. Sin embargo, cuando introdujimos la posibilidad de que “intenten ponerte una trampa”, <strong>4o </strong>empezó a acertar algunas veces. Luego, al añadir indicaciones concretas de sumar todos los ítems,<strong> 4o</strong> respondió correctamente casi siempre, mientras que <strong>4o mini</strong> aún no pudo aplicar esta misma abstracción, requiriendo que sustituyéramos “ítems” por “setas” para responder correctamente.</p>

<p>Estos experimentos ilustran de forma muy gráfica cómo, una vez superado cierto tamaño, los LLMs pueden ser orientados y corregidos mediante explicaciones en lenguaje natural. Y ademas, que cuanto mayor es el tamaño del modelo, <strong>más abstractas</strong> pueden ser esas explicaciones.</p>

<p>¿Qué sucederá en un futuro próximo, cuando <strong>OpenAI</strong>, <strong>Google</strong> y <strong>Meta</strong> lancen la siguiente generación de modelos de lenguaje que están cocinando en sus laboratorios? Es previsible que los modelos futuros, de mayor tamaño, sean mucho más receptivos a las indicaciones y correcciones en lenguaje natural. Cuando cometan un error, será mucho más sencillo guiarlos y corregirlos, comprenderán conceptos más abstractos, y podremos encargarles tareas más complejas. </p>

<p>Se equivocarán en muchas ocasiones, pero, al igual que con colegas humanos, bastará con ofrecerles explicaciones adicionales para aclarar la situación. No nos frustraremos intentando corregirlos sin éxito, será fácil orientarlos para alinearlos con nuestro contexto. Los consideraremos herramientas con las que podremos explorar problemas y encontrar soluciones juntos. </p>

<p>Creo que estamos ya muy cerca de alcanzar este nivel de asistente humano. No será aún una AGI, pero será muy útil y nos ahorrará mucho trabajo.</p>

<div>
<hr>

</div>
<p>¡Hasta la próxima, nos leemos! 👋👋</p>

<p>
</p>
