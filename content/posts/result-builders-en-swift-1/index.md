---
title: "Result builders en Swift (1)"
date: 2025-04-27
draft: false
tags:
  - "programación"
---

> Rescato un post antiguo, que publiqué hace tres años, en julio de 2022. He añadido otros dos, [la segunda parte de este](https://domingogallardo.bearblog.dev/result-builders-en-swift-2/) y la explicación de [cómo se pueden definir arrays con distintos tipos de datos en Swift](https://domingogallardo.bearblog.dev/arrays-con-distintos-tipos-de-datos-en-swift/).

> He añadido un [_addendum_ al final](#addendum-abril-2025-que-ha-pasado-en-swift-en-estos-tres-anos), generado por GPT o3, en el que se comentan los cambios introducidos en Swift en los últimos tres años que afectan a lo comentando en el artículo.

Desde que Apple presentó
[_SwiftUI_](https://developer.apple.com/documentation/swiftui/) en la
[WWDC19](https://developer.apple.com/wwdc19/204) he querido entender
las funcionalidades de Swift sobre las que se construye esta tecnología. Leí [algún que otro
post](https://www.swiftbysundell.com/articles/the-swift-51-features-that-power-swiftuis-api/)
que entraba en el tema y me quedé con la idea de que en Swift 5.1
habían introducido algo llamado _function builders_ que era la
funcionalidad  que permitía construir las vistas de SwiftUI de forma
declarativa, pero no seguí estudiando más el tema.

Una cosa extraña de los _function builders_ era que se trataba de una
funcionalidad no documentada de Swift, que no había pasado por el
proceso habitual de [evolución del
lenguaje](https://github.com/apple/swift-evolution) en el que las
propuestas de nuevas características se terminan aprobando o no tras
una discusión abierta con la comunidad.

No tardó mucho en aparecer [una
propuesta](https://github.com/apple/swift-evolution/blob/9992cf3c11c2d5e0ea20bee98657d93902d5b174/proposals/XXXX-function-builders.md)
y [un _pitch_](https://forums.swift.org/t/function-builders/25167) en
los foros de la comunidad. Las discusiones se alargaron, se
consideraron distintas alternativas, cambió de nombre a _result
builders_ y al final, casi dos años después, terminó siendo
[aceptada](https://forums.swift.org/t/accepted-se-0289-result-builders/41377)
en octubre de 2020 y publicada en el lenguaje en la [versión
5.4](https://www.swift.org/blog/swift-5.4-released/) lanzada en abril
de 2021.

Más de un año después me he puesto realmente a estudiar los _result
builders_ y a intentar entender cómo funcionan. Después de pasar unos
días leyendo documentación, creando algunas notas en Obsidian y
haciendo pruebas con código Swift ha llegado el momento de intentar
poner en todo en orden y hacer un post sobre el tema.

## Objetivo de los _result builders_ ##

Vamos a empezar explicando cuál es el objetivo de los _result
builders_ y después explicaremos cómo funcionan.

### Un ejemplo con SwiftUI ###

Si vemos un ejemplo sencillo de código SwiftUI comprobaremos que
podemos identificarlo como código Swift, pero que hay algo que no
encaja del todo. Por ejemplo, el siguiente
código construye una vista en la que se apilan verticalmente una
imagen y un texto.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}
```

El resultado es el siguiente:

![](hello-world-swiftui.webp)

En el código se define un `struct` denominado `ContentView` que cumple el 
protocolo `View`. Este protocolo obliga a definir una propiedad `body`, que también
debe cumplir el tipo `View`, construyéndose así, de forma recursiva, un árbol de
vistas que SwiftUI se encarga de renderizar. 

La propiedad `body` es una propiedad calculada,
de tipo `some View`, que devuelve un `VStack`. Dejemos para otro post el uso de `some` y
vamos a centrarnos en la construcción del `VStack`:

```swift
VStack {
    Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
    Text("Hello, world!")
}
```

Las llaves después de `VStack` definen una _trailing_ clausura que se le pasa al
incializador. Es equivalente a:

```swift
VStack(content: {
    Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
    Text("Hello, world!")
})
```

Si nos fijamos en el código de la clausura, veremos que hay algo raro. Hay dos
sentencias que construyen una instancia de `Image` y otra instancia de
`Text`. Son precisamente la imagen y el texto que se apilan y que se
muestran en la vista resultante. Pero no se hace nada con esas
instancias. ¿Cómo se pasan al `Vstack`? ¿Dónde está el return de la
clausura?. ¿Qué magia es esta?

La explicación está en que SwiftUI define un _result builder_ que
realiza una transformación en tiempo de compilación del código
anterior (que no es código Swift correcto) en un código similar al
siguiente:

```swift
VStack {
    let v0 = Image(systemName: "globe")
                 .imageScale(.large)
                 .foregroundColor(.accentColor)
    let v1 = Text("Hello, world!")
    return ViewBuilder.buildBlock(v0, v1)
}
```

Este código sí que es código correcto de Swift. Las instancias creadas
de `Image` y de `Text` se guardan en dos variables auxiliares y se
llama a una función estática (`ViewBuilder.buildBlock`) que recibe
estas dos vistas y las combina en una estructura, una pareja, que también es del tipo 
`View` y que se devuelve.

Aunque no lo hemos visto en el ejemplo, también sería posible construir
los elementos constituyentes de forma recursiva usando el mismo
DSL. Por ejemplo, uno de los elementos que se pasan al `VStack` podría
ser a su vez otro `VStack` formado por la combinación de otros
elementos básicos.

### Creación de DSLs ###

Mediante el _result builder_ anterior podemos entonces transformar el
código limpio y claro del principio (que no funciona en Swift) en un
código compilable. El _result builder_ añade todo lo necesario
(variables temporales, llamada a la función de construcción, etc.)
para que el código resultante sea correcto para el compilador. Y lo
hace de forma totalmente transparente. El desarrollador no ve nada del
segundo código, sólo ve el primero, el código limpio y claro.

El código que transforma el _result builder_ es lo que se denomina un
DSL (_Domain Specific Language_). En este caso, el DSL nos permite
construir vistas de _SwiftUI_, describiendo y combinando sus elementos
constituyentes.

Los _result builders_ no solo se han utilizado para construir SwiftUI,
sino que la comunidad ha creado una gran [cantidad de
DSLs](https://github.com/carson-katri/awesome-result-builders) para
definir todo tipo de elementos, como HTML, CSS, grafos, funciones
REST o tests. Incluso en la reciente WWDC22 se ha presentado un DSL
para construir expresiones regulares en Swift,
[SwiftRegex](https://developer.apple.com/wwdc22/110357).

Resumiendo, al igual que las macros en lenguajes de programación como
LISP, o los `define` de C, los _result builders_ permiten especificar
unas transformaciones que se aplicarán al código fuente en tiempo de
compilación. Veremos a continuación cómo se ha incluido esa
funcionalidad en el lenguaje Swift.


## Primer ejemplo ##

En primer lugar, para definir un _result builder_ debemos especificar
una función `buildBlock` que construya un resultado a partir de unos
elementos. En el caso del ejemplo anterior se debe construir una
composición de dos vistas a partir de las vistas individuales (la
instancia de `Image` y de `Text`).

¿Cómo podemos definir esta función? La forma más sencilla es definir
una función estática, a la que se pueda llamar sin necesidad de crear
una instancia. Esta función se debe llamar `buildBlock` y debe tomar
como parámetros los componentes individuales y devolver un nuevo
componente resultado de su composición. Podemos definirla en una
estructura, una clase o un enumerado anotado con el atributo
`@resultBuilder`.

Un ejemplo muy sencillo que trabaja con cadenas es el siguiente:

```swift
@resultBuilder
struct StringConcatenator {
    static func buildBlock(_ component1: String, _ component2: String) -> String {
        return component1 + ", " + component2
    }
}
```

La función `buildBlock` toma dos cadenas y devuelve su concatenación,
separándolas por una coma. La definimos como una función `static` de la
estructura `StringConcatenator`. El atributo `@resultBuilder` indica
que este tipo es un _result builder_ y que vamos a poder especificar
un DSL con él.

¿Cómo podemos ahora indicar que queremos usar este _result builder_?
A los ingenieros de Swift se les ocurrió una idea genial. Al definir
el tipo `StringConcatenator` como un _result builder_ el compilador
crea el atributo `@StringConcatenator` que podremos usar donde nos
interese aplicarlo.

Por ejemplo, podemos escribir el siguiente código:

```swift
@StringConcatenator
func holaMundo() -> String {
    "Hola"
    "mundo"
}

print(holaMundo())
```

La función `holaMundo()` no sería correcta en Swift porque no tiene
ningún `return` con la cadena a devolver. Además, sus dos sentencias
no hacen nada, solo definir las cadenas `"Hola"` y `"mundo"`. Pero si
ejecutamos el código anterior veremos que el compilador no da ningún
error y que el código se ejecuta correctamente e imprime el típico
mensaje:

```text
Hola, mundo
```

¿Qué está pasando? Al utilizar el atributo `@StringConcatenator` en la
función `holaMundo()` estamos declarando que se trata de una función
cuyo cuerpo lo estamos definiendo con un DSL que va a procesar el
_result builder_ `StringConcatenator`.

Al igual que en el ejemplo anterior de `SwiftUI`, cada sentencia del
cuerpo de la función especifica un componente que el compilador debe
procesar. En este caso son cadenas. Y al final se debe llamar a
`buildBlock` para combinar estos componentes y devolver la cadena resultante.
En concreto, el código resultante de la transformación es
el siguiente:

```swift
func holaMundo() -> String {
    let v0 = "Hola"
    let v1 = "mundo"
    return StringConcatenator.buildBlock(v0, v1)
}
```

Este código transformado es el que se ejecuta finalmente en el
programa y el que devuelve la cadena `"Hola, mundo"`.

### Número variable de argumentos ###

En el ejemplo anterior la función `buildBlock` está definida
únicamente sobre dos argumentos. No funcionaría si quisiéramos
construir una cadena con más de dos componentes. Podemos mejorarla
usando la capacidad de Swift de definir funciones con un número
variable de argumentos:

```swift
@resultBuilder
struct StringConcatenator {
    static func buildBlock(_ components: String...) -> String {
        return components.joined(separator: ", ")
    }
}
```

Ahora la función `buildBlock` recibe un número variable de cadenas
guardadas en el array `components`. Y la función de orden superior
`joined` recorre el array de cadenas y las une todas con una coma y un
espacio.

Con este `buildBlock` podemos componer el número de cadenas que
queramos en el DSL. Por ejemplo, podemos definir un saludo a partir de
cuatro cadenas:

```swift
@StringConcatenator
func saludo(nombre: String) -> String {
    "Hola"
    "me"
    "llamo"
    nombre
}
```

Además, en este ejemplo, hemos añadido un parámetro `nombre` a la
función. Este parámetro permite especificar el nombre que está
saludando.

El _result builder_ `@StringConcatenator` transforma el código
anterior en:

```swift
func saludo(nombre: String) -> String {
    let v0 = "Hola"
    let v1 = "me"
    let v2 = "llamo"
    let v3 = nombre
    return StringConcatenator.buildBlock(v0, v1, v2, v3)
}
```

Si llamamos a la función original

```swift
print(saludo(nombre: "Frodo"))
```

se imprimirá lo siguiente:

```text
Hola, me, llamo, Frodo
```

## DSL en variables calculadas ##

Según la [documentación
oficial](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder)
de Swift, podemos usar el atributo del _result builder_ en los
siguientes lugares:

- En la declaración de una función, y el _result builder_ construye el
  cuerpo de la función.
- En una declaración de variable que incluye un _getter_, y el _result
  builder_ construye el cuerpo del _getter_.
- En un parámetro de tipo clausura de una declaración de una función,
  y el _result builder_ construye el cuerpo de la clausura que se pasa
  al argumento correspondiente.
  
El primer caso lo hemos visto en el apartado anterior. Vamos a ver un
ejemplo del segundo caso.

Por ejemplo, podemos definir la siguiente estructura:

```swift
struct Persona {
    let nombre: String

    @StringConcatenator
    var saludo: String {
        "Hola"
        "me"
        "llamo"
        nombre
    }
}

let frodo = Persona(nombre: "Frodo")
print(frodo.saludo)
```

Ahora el DSL se utiliza para definir el _getter_ de la variable
calculada `saludo`. El _result builder_ transforma ese _getter_ de la
misma forma que en los ejemplos anteriores, creando un _getter_ que
devuelve una cadena a partir de las cadenas que aparecen en las
distintas sentencias del código original.

La instrucción `let` crea una instancia de `Persona` inicializando su
nombre. Y la siguiente sentencia llama a la variable calculada, que
devuelve la cadena con el saludo, y la imprime:

```text
Hola, me, llamo, Frodo
```

## DSL en parámetros ##

En la especificación de cómo usar el atributo del _result builder_ se
menciona en último lugar la posibilidad de usarlo en un parámetro de
tipo clausura. Veamos un ejemplo:

```swift
func imprimeSaludo(@StringConcatenator _ contenido: () -> String) {
    let resultado = contenido()
    print(resultado)
}
```

Estamos definiendo una función que va a recibir una clausura sin
argumentos que va a devolver una cadena. En el cuerpo de la función se
ejecuta la clausura y se imprime el resultado. La anotación
`@StringConcatenator` establece que podremos pasar como argumento
clausuras DSL y que esas clausuras serán transformadas por el _result
builder_.

De esta forma, podemos llamar a la función anterior usando una
clausura en la que definimos las cadenas que van a aparecer en el
saludo. Y además podemos hacerlo sin usar el atributo
`@StringConcatenator` (ya se ha definido en el parámetro de la función):

```swift
imprimeSaludo {
    "Hola"
    "mundo"
}
```

El código anterior imprime:

```text
Hola, mundo
```

Veamos con más detalle cómo funciona el ejemplo. La función
`imprimeSaludo` recibe como parámetro la clausura `contenido`. Se
trata de una clausura sin parámetros que devuelve una cadena. Y está
precedido del atributo `@StringConcatenator`. Esto hace que cualquier
argumento que se pase (una clausura que devuelve una cadena) sea
transformado por el _result builder_.

En la llamada a la función vemos que se utiliza la característica de
Swift de la clausura al final, mediante la que se pueden omitir los
paréntesis cuando el último argumento es una clausura.

El código final generado por el compilador es el siguiente:

```swift
imprimeSaludo({
    let v0 = "Hola"
    let v1 = "mundo"
    return StringConcatenator.buildBlock(v0, v1)
})
```

Evidentemente, este código es mucho menos claro y directo que el
código anterior: 

```swift
imprimeSaludo {
    "Hola"
    "mundo"
}
```

## DSLs avanzados ##

En los ejemplos anteriores hemos visto cómo se puede usar un DSL para
construir un componente a partir de componentes elementales. Pero sólo
hemos visto una pequeña parte de todo lo que permiten hacer los
_result builders_.

Si vemos un ejemplo avanzado de SwiftUI veremos que el _result
builder_ definido en SwiftUI (la estructura
[ViewBuilder](https://developer.apple.com/documentation/swiftui/viewbuilder))
permite un DSL mucho más avanzado, en el que podemos usar bucles
(`ForEach`) y condicionales (`if`).

Ejemplo del artículo de _Hacking with Swift_
[List Items Inside if
Statements](https://www.hackingwithswift.com/forums/swiftui/list-items-inside-if-statements/1627):

```swift
struct TestView: View {
    ...
    var body: some View {
        List {
            Button("Add a fresh potato") {
                self.basket.vegetables.append(Vegetable(name: "Potato", freshness: 1))
            }.foregroundColor(.blue)                        

            Section(header: Text(sectionHeadings[0])) {
                ForEach(self.basket.vegetables) { vegetable in
                    if vegetable.freshness == 0 {
                        Text(vegetable.name)
                    }
                }
            }

            Section(header: Text(sectionHeadings[1])) {
                ForEach(self.basket.vegetables) { vegetable in
                    if vegetable.freshness == 1 {
                        Text(vegetable.name)
                    }
                }
            }
        }
    }
}
```

En próximos posts seguiremos explorando el funcionamiento de los
_result builders_ y cómo utilizarlos para construir este tipo de DSL
tan potente.

## Referencias ##

- [Propuesta en Swift Evolution](https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md) 
- [Introducción en la Guía de Swift](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators/#Result-Builders)
- [Explicación detallada en Language Reference](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder)
- [Fichero de código con los ejemplos del post](https://github.com/domingogallardo/blog/blob/main/posts/0001-result-builders-1/code/result-builders.swift)

## Addendum (abril 2025) — ¿Qué ha pasado en Swift en estos tres años?  

> **TL;DR**  
> Las ideas básicas del post siguen siendo correctas, pero Swift ha eliminado varias limitaciones de los *result builders* y ha incorporado nuevas –y poderosas– macros que conviene conocer. Este apéndice resume los cambios relevantes (Swift 5.7 → 5.10) manteniendo el tono divulgativo del artículo original.

### 1. Fin del “límite de 10” gracias a *parameter packs*

En 2021 los *result builders* gestaban internamente una tupla de hasta diez genéricos, de ahí la restricción que comentaba el post.  
Desde **Swift 5.9** el compilador entiende *variadic generics* (propuesta SE‑0390) y la librería estándar ha reescrito `ViewBuilder` así:

```swift
@resultBuilder
public enum ViewBuilder {
    public static func buildBlock<each Content>(
        _ components: repeat each Content
    ) -> TupleView<(repeat each Content)> where repeat each Content: View
}
```

*Parameter packs* (`<each T>` / `repeat each T`) delegan la aridad al compilador, por lo que el *DSL* de SwiftUI (y cualquier builder que adopte ese patrón) acepta ahora **tantos elementos como quieras**, sin sobrecargas manuales.

> **Cómo adaptarlo a tus builders**  
> Sustituye tu viejo  
> ```swift
> static func buildBlock(_ parts: String...) -> String
> ```  
> por la variante moderna:  
> ```swift
> static func buildBlock<each S>(_ parts: repeat each S) -> String
>     where repeat each S == String
> ```

### 2. Entra en escena la nueva familia de **macros**

Swift 5.9 introdujo macros de compilador (SE‑0389, SE‑0397).  
Aunque en el post comparábamos los *result builders* con las macros de LISP/C, las macros nativas de Swift juegan **en otra liga**:


| Característica                                            | Result Builder | Macro                         |
| ---------------------------------------------------------- | -------------- | ----------------------------- |
| Se aplica **dentro** de un cuerpo (`{ … }`)                | ✔︎             | Opcional                      |
| Genera código **expresivo** (vistas, HTML…)                | ✔︎             | ✔︎                            |
| Puede **crear o alterar declaraciones** completas          | ✗             | ✔︎                            |
| Tiene acceso al **AST completo**                           | ✗ (solo su cuerpo) | ✔︎                         |
| Se invoca con atributo                                     | `@MiBuilder`   | `@attachedMacro`, `#macro`    |

**Cuándo elegir qué**

*   Usa *result builders* para *DSLs* puramente declarativos (SwiftUI, RegexBuilder…).  
*   Elige macros para generación de API, validaciones *compile‑time* o atributos como `@Observable`.


### 3. SwiftRegex ya forma parte del lenguaje

Lo que en WWDC22 se presentó como “SwiftRegex” quedó integrado en la sintaxis estándar a partir de **Swift 5.7**.  
Hoy puedes escribir:

```swift
let fecha  = "27/04/2025"
let patron = Regex(#"\d{2}/\d{2}/\d{4}"#)

if fecha ~= patron {
    // …
}
```
El builder subyacente emplea componentes de expresiones regulares, no un *result builder* clásico, pero tu explicación sobre *DSLs declarativos* sigue plenamente vigente.

### 4. Concurrencia estricta y builders asíncronos

Desde **Swift 5.10** el modo *Strict Concurrency* está activo por defecto.  
Si tu builder genera código `async`:

```swift
@MyBuilder
func vista() async -> some View {
   // … 
}
```

marca las sobrecargas `buildBlock` con `async`/`throws` pertinentes o el compilador mostrará advertencias.


### 5. Otras minucias de sintaxis

* **Inferencias parciales**: puedes declarar `let saludo: _ = …` y dejar que el builder resuelva el tipo.  
* **`buildPartialBlock`**: permite que `buildBlock`, `buildEither` y familia sean opcionales; el compilador los sintetiza si faltan.  
* El atributo del builder puede aplicarse ahora sobre *initializers*, muy útil para crear objetos complejos de forma declarativa.

#### Para profundizar

* Propuesta **SE‑0390** – *Variadic Generics*.  
* **SE‑0389 / SE‑0397** – *Swift Macros*.  
* *The Swift Programming Language* → **Macros → Result Builders**.  
* Vídeo WWDC23 “Expand Swift macros” (muestra macros y builders trabajando juntos).
