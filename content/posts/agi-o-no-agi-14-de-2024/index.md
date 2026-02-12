---
title: "¿AGI o no AGI? (#14 de 2024)"
date: 2024-09-13
draft: false
tags:
  - "newsletter"
---
<p>Después de un descanso veraniego, esta semana os traigo otro artículo especial, en el que, en lugar de repasar lo sucedido en la última quincena, comento un único tema. Pero no os asustéis, esta vez va a ser bastante más corto que aquel que hice a finales de mayo sobre <a href="/posts/los-papiros-de-herculano-9-de-2024/">los papiros de Herculano</a> 😄.</p>

<p>La semana que viene volveremos a nuestra programación quincenal, con un número en el comentaremos algunas noticias del verano y la sorpresa de ayer: el <a href="https://openai.com/o1/">nuevo modelo de OpenAI</a>. </p>

<p>¡Gracias por leerme! Y un abrazo a los suscriptores recién llegados.</p>

<p>
</p>

<p>
<img src="agi-or-not.jpg" alt="">
</p>

<p>Imagen generada por Grok. Prompt: “A computer scientist angrily arguing with a colleague over a blackboard about the definition of AGI”.</p>

<p>Últimamente el término AGI (Artificial General Intelligence, Inteligencia Artificial General) está en boca de casi todo el mundo. Podcasts, blogs, redes sociales, newsletters, todos hablan de si vamos a alcanzar la AGI en X años o no. </p>

<p>Antes de arriesgarme a hacer ninguna predicción quiero dedicarle un rato a hablar del propio término. ¿Tiene sentido hablar de AGI? ¿O se ha convertido en un <strong>término maldito</strong>, no recomendable, desde que gente como Altman y OpenAI no para de usarlo? ¿Te van a mirar mal si hablas de AGI?</p>

<p>Vamos a empezar con una anécdota de la semana pasada.</p>

<p>Hace años seguía por Twitter a <strong>Grady Booch</strong>. Fue una figura importante de la ingeniería del software de los años 80, en los que puso de moda metodologías de diseño orientadas a objetos muy interesantes. Todavía tengo un par de libros suyos de aquella época.</p>

<p>Cuando empezaron a hacerse públicos los primeros modelos generativos, Booch se puso también a hablar de IA. Al principio era interesante, resaltaba las limitaciones y los problemas de estos modelos y su voz era un buen contrapunto a apocalípticos exagerados como <strong>Sam Harris</strong> o <strong>Nick Bostrom</strong>. Sin embargo, su <em>timeline</em> se convirtió pronto en un sonsonete del estilo del de <strong>Gary Marcus</strong>, todo negativo, todo problemático. Un día, no recuerdo con qué post, me enfadé, me puse en modo <strong>Van Gaal</strong> y dejé de seguirle.</p>

<p>Pero hace poco el algoritmo de X me mostró la siguiente <a href="https://x.com/fchollet/status/1831728150914744362">interacción de François Chollet con él</a>:</p>

<p>
<img src="Pasted image 20240911132559.png" alt="">
</p>

<p>Grady Booch:</p>

<blockquote>
<p>AGI no sucederá en tu vida. Ni en la vida de tus hijos. Ni en la vida de los hijos de tus hijos.</p>

</blockquote>

<p>El post de Booch era de hace de más de un año pero por alguna razón Chollet lo vio hace unos días. François es un chico majo (es verdad, mirad&nbsp;<a href="https://www.youtube.com/watch?v=UakqL6Pj9xo">alguno de sus vídeos en YouTube</a>) y, en lugar de hacer como yo y dejar de seguir a Booch, le contestó con buenas maneras:</p>

<blockquote>
<p>En mi propia definición de AGI, sucederá definitivamente en mi vida, de hecho es probable que en los próximos 10-15 años. Pero mi definición personal es más tangible y más restrictiva que la mayoría, para mi no es "una mente humana artificial" ni "un dios artificial". AGI es solo una IA que posee un grado de generalidad (habilidad de enfrentarse a problemas nuevos y entenderlos) al menos tan alto que el de los humanos. Hasta el momento la generalidad ha sido el ingrediente que falta en la IA. Pronto podríamos conseguir desarrollarlo.</p>

</blockquote>

<p>Booch le responde haciendo un chascarrillo con lo de la "generalidad":</p>

<p>
<img src="Pasted image 20240911134011.png" alt="">
</p>

<blockquote>
<p>En general :-) estoy de acuerdo contigo, excepto que, en general, hablando, esas medidas de generalidad son tan vagas que hacen que el listón para el éxito sea bastante bajo.</p>

</blockquote>

<p>Está claro que Booch no conoce todo el trabajo que está haciendo Chollet con su <strong>Premio ARC</strong> (<a href="https://arcprize.org/">arcprice.org</a>&nbsp;y&nbsp;<a href="https://x.com/arcprize">X</a>), precisamente para intentar medir de una forma objetiva algo de esta "generalidad" necesaria para la AGI. Ya hablamos de este premio en el post de la&nbsp;<a href="/posts/del-1-al-15-de-junio-11-de-2024/">primera quincena de junio</a>.</p>

<p>Chollet ya no le contestó. Lo que no sé es si, como yo, dejó de seguirle.</p>

<div>
<hr>

</div>
<p>Lo anterior no es solo una anécdota. La falta de entendimiento sobre el término AGI se está haciendo cada vez más intensa. Y ahora se complica todo aún más con su uso cada vez más extendido fuera del ámbito científico. Directivos de startups, aspirantes a influencers en X o YouTube, muchos usan el término principalmente para llamar la atención y captar audiencia (o dinero).</p>

<p>Pero la popularidad del término también tiene sus cosas buenas. Programas generalistas están usándolo para explicar cosas interesantes haciendo buena divulgación científica. Por ejemplo, <strong>The Economist</strong>, en su siempre interesante podcast semanal&nbsp;<a href="https://podcasts.apple.com/us/podcast/babbage-from-the-economist/id508376907">Babbage</a>, ha publicado un especial sobre AGI (<a href="https://podcasts.apple.com/es/podcast/babbage-from-the-economist/id508376907?i=1000668393081">AGI, part one: what is artificial general intelligence?</a>). En el programa se intenta dar una visión bastante académica, entrevistando a distintos perfiles como ingenieros, científicos de la computación o neurocientíficos.</p>

<p>
<a href="https://x.com/MelMitchell1">Melanie Mitchell</a>, científica de IA muy puesta en IA tradicional pero también en LLMs (ver por ejemplo su artículo&nbsp;<a href="https://oecs.mit.edu/pub/zp5n8ivs/release/1?readingCollection=9dd2a47d">Large Language Models</a>&nbsp;en&nbsp;<a href="https://oecs.mit.edu/">The Open Encylopedia of Cognitive Science</a>) comenta una definición relacionada con las capacidades humanas:</p>

<blockquote>
<p>AGI se ha definido  como una máquina que es capaz de hacer todo lo que un ser humano puede hacer. Y luego, recientemente, se ha debilitado un poco esta, definiéndose como una máquina que puede realizar todas las <strong>tareas cognitivas</strong> que un ser humano puede hacer, dejando de lado las formas físicas de inteligencia.</p>

</blockquote>

<p>Aunque después resalta que&nbsp;<strong>no le gusta demasiado</strong>&nbsp;el término AGI:</p>

<blockquote>
<p>
<strong>Presentador</strong>: ¿Crees que el uso de la frase AGI es realmente útil para los científicos en inteligencia artificial como tú, o lo ves más como una distracción?</p>

<p>
<strong>Mitchell</strong>: Creo que es un poco <strong>una distracción</strong>. La gente siente que puede tomar la inteligencia como algo que está separado de su manifestación en los humanos, en el cerebro y el cuerpo humano, y aislarla [...]. Y no estoy convencida de que eso sea realmente significativo o que nos dé una dirección clara a seguir.</p>

</blockquote>

<p>Sin embargo, el científico de Google&nbsp;<a href="https://x.com/blaiseaguera">Blaise Aguera y Arcas</a>, no se pierde en disquisiciones sobre el término y dice que el problema no es de hacer los modelos más generales, sino de&nbsp;<strong>hacerlos mejores</strong>&nbsp;en distintos aspectos:</p>

<blockquote>
<p>Creo que <strong>se trata simplemente de mejorar</strong> en un montón de cosas que a todos nos importan, como la veracidad, el razonamiento, la memoria, la planificación, tener una perspectiva consistente durante largos periodos de tiempo, y así sucesivamente [...] Así que no creo que se trate de cuán lejos estamos de algo en particular, sino más bien de qué tan rápido están mejorando estas cosas, y cuándo se volverán confiables para hacer una variedad de cosas diferentes que, en este momento, diría que no son confiables para hacer de manera autónoma.</p>

</blockquote>

<p>O sea, que no hay acuerdo ni siquiera entre los científicos que están más metidos en el tema. Unos dicen que AGI no es un término útil, otros que sí, porque precisamente lo que hace falta es eso, generalizar. Y otros dicen que casi ya estamos ahí, y que solo falta mejorar. </p>

<div>
<hr>

</div>
<p>¿Cuál es mi opinión? ¿AGI o no AGI? </p>

<p>Para mi, como dice <strong>Chollet</strong>, la clave está en la "G" del término: “general”. Esta "G" simboliza un cambio significativo en la evolución de la inteligencia artificial y de las redes neuronales, pasando de modelos especializados, como los que dominaron en la década de 2010, hacia modelos más genéricos y polivalentes como los actuales LLMs, que son capaces de almacenar todo el conocimiento humano e interaccionar en lenguaje natural. </p>

<p>Y, como dice <strong>Aguera y Arcas</strong>, nos iremos acercando a esta “G” conforme se vayan desarrollando nuevos algoritmos que mejoren las carencias de los actuales LLMs dotándoles de nuevas capacidades que les permitan resolver problemas como el premio ARC de <strong>Chollet</strong>. </p>

<p>Yo, por mi parte, <strong>seguiré hablando de AGI</strong>, aunque cada vez que lo haga tenga que referenciar este artículo para que no me confundan con un AI Bro.</p>

<p>
<img src="448a4164-85a4-4217-bb33-a8be1efed740_1024x1024.png" alt="">
</p>

<p>Imagen generada por ChatGPT 4o. Prompt: “Haz una imagen de un AI Bro”.</p>

<div>
<hr>

</div>
<p>¡Hasta la próxima quincena, nos leemos! 👋👋</p>

<p>
</p>
