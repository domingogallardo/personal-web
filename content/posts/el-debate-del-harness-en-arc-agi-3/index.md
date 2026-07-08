---
title: "El debate del harness en ARC-AGI-3"
date: 2026-04-01
draft: false
tags:
  - "ARC-AGI"
  - "LLMs"
---

El lanzamiento de ARC-AGI-3 nos ha traído un debate muy interesante sobre el uso de _harnesses_. ¿Se debe permitir su uso en la evaluación de LLMs en ARC-AGI-3? François Chollet y su equipo han decidido que no, que no van verificar soluciones que contengan LLMs con _harnesses_ avanzados. Todos los modelos que se incluyan en la clasificación oficial denominada ["Verified"](https://arcprize.org/leaderboard), la que realizan con LLMs y modelos grandes fuera de la competición Kaggle, deben ejecutarse con un _harness_ mínimo. Solo deben tener el _prompt_ básico que les permita la ejecución de la prueba, tal y como se define en el [informe técnico de ARC-AGI-3](https://arcprize.org/media/ARC_AGI_3_Technical_Report.pdf)

> "Estás jugando a un juego. Tu objetivo es ganar. Responde con la acción exacta que quieres realizar. La acción final de tu respuesta se ejecutará en el siguiente turno."

![ARC-AGI-3 system prompt](arc-agi-3-system-prompt.png)

¿Qué es el _harness_ de un sistema LLM? La palabra (también se usa _scaffolding_) se ha hecho popular con la llegada de herramientas avanzadas como Claude Code o Codex App. En estas herramientas el LLM se usa dentro de un complicado bucle que gestiona el contexto, realiza llamadas externas solicitadas por el propio LLM o actualiza ficheros auxiliares en donde se mantiene el estado y la memoria del proceso completo. Incluso, en versiones más avanzadas, los _harnesses_ permiten gestionar sistemas multi-agente, coordinando distintos LLMs para conseguir un objetivo.

En el caso de la competición ARC-AGI-2, a principios de 2026 varios sistemas _harness_ + LLM consiguieron resultados excelentes, mejorando muchos los resultados obtenidos por LLMs en solitario. Lo contamos en el [post anterior](https://domingogallardo.com/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/), donde comentábamos el ejemplo del [proyecto beetree/ARC-AGI](https://github.com/beetree/ARC-AGI) de Johan Land, que el 5 de enero de 2026 llegó al 76.11% en ARC-AGI-2. El _harness_ que usó permitía la combinación de GPT-5.2, Gemini-3 y Opus 4.5 en un bucle de razonamiento de largo horizonte (≈6 horas por problema) en donde se generaban más de 100.000 llamadas a código Python, se usaba razonamiento visual y una especie de “consejo de jueces” para evaluar soluciones.

La [justificación del equipo de Chollet](https://x.com/arcprize/status/2037377865302589564) es que evaluar sistemas LLMs con _harnesses_ no da una indicación fiable de las capacidades del LLM con respecto a la prueba, sino que está incluyendo en esa evaluación al propio harness. Si el sistema _harness_ + LLM resuelve una prueba, puede ser que una parte importante del éxito sea la estrategia definida por el propio _harness_, que ha sido diseñado por un equipo humano. Y eso va en contra de la idea de comprobar la _inteligencia fluida_ que tiene el sistema. El LLM debería ser el que, por si mismo, [descubriera las estrategias definidas por el _harness_](https://x.com/fchollet/status/2037380345436467541?s=20) y tuviera las capacidades proporcionadas por él. Algo así es lo que ha sucedido con ARC-AGI-2, que primero fue resuelto por sistemas mixtos _harness_ + LLM y luego, un par de meses después, por los nuevos LLMs frontera.

Hay una parte económica en la discusión que no se menciona demasiado. La ejecución de una evaluación en la que se usan _harnesses_ es cara, porque realizan un uso intensivo del API de las últimas versiones de LLMs, las versiones de coste más elevado. Con la decisión de no incluir en el ranking público estos sistemas, la organización está manifestando que no va a asumir el coste de su evaluación. 

Ha habido [voces discrepantes en X](https://x.com/scaling01/status/2036855187738943732) y algún equipo de investigación que ya [ha conseguido un resultado aceptable](https://x.com/symbolica/status/2037322403316117831) en ARC-AGI-3 usando un harness propio. La [respuesta del Arc Prize](https://x.com/arcprize/status/2037377867210973427) me parece razonable: que sean los propios equipos que propongan nuevos sistemas mixtos son hagan las evaluaciones usando las tareas públicas y que se publiquen en un ranking mantenido por la propia organización, el [ARC-AGI Community Leaderboard](https://arcprize.org/leaderboard/community). De esta forma se da publicidad al enfoque y al resultado, pero separándolo de la verificación oficial y de la competición oficial.

Mike Knoop, cofundador del Arc Prize, comenta también el [interés de estudiar los sistemas mixtos](https://x.com/mikeknoop/status/2036323325912424885). Un supuesto _harness_ + LLM que resolviera ARC-AGI-3 nos daría pistas de capacidades necesarias que faltarían en los modelos básicos que podrían resolverse en futuros modelos más avanzados. También podrían servir como _benchmark_ de modelos: distintos modelos usando el mismo _harness_ tendrán distintas puntuaciones, de forma que el _harness_ nos serviría para diferenciar capacidades de los propios modelos.

Pero que estos sistemas deban ser analizados no justifica que se usen en el ranking oficial de la competición. Estoy de acuerdo con Chollet en que lo importante llegará cuando los LLMs sean capaces ellos solos de hacer lo que hacen estos _harnesses_. Y eso solo lo podemos comprobar si son los propios LLMs los que resuelven, sin ninguna ayuda, ARC-AGI-3.

