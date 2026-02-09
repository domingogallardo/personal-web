---
title: "Result builders en Swift (2)"
date: 2025-04-27
draft: false
tags:
  - "programación"
---

> Segundo post antiguo recuperado, de julio de 2022.

> He añadido un [_addendum_ al final](#addendum-abril-2025-que-ha-pasado-en-swift-en-estos-tres-anos), generado por GPT o3, en el que se comentan los cambios introducidos en Swift en los últimos tres años que afectan a lo comentando en el artículo.

En el [post anterior](/posts/result-builders-en-swift-1/) de la serie sobre _result builders_ vimos cómo éstos permiten utilizar un DSL para definir una clausura o un bloque de código que construye un componente a partir de componentes elementales.

Vimos el ejemplo sencillo de un constructor de cadenas:

```swift
@resultBuilder
struct StringConcatenator {
    static func buildBlock(_ components: String...) -> String {
        return components.joined(separator: ", ")
    }
}
```

El código anterior crea la anotación `@StringConcatenator` que podemos usar
para aplicar el _result builder_. Por ejemplo, podemos aplicarlo a la
definición de una función:

```swift
@StringConcatenator
func holaMundo() -> String {
    "Hola"
    "mundo"
}

print(holaMundo())
// Imprime: Hola, mundo
```

La función anterior construye una cadena uniendo las cadenas
elementales que definimos en su cuerpo. Recordemos que el _result
builder_ transforma en tiempo de compilación este cuerpo,
convirtiéndolo en algo como:

```swift
func holaMundo() -> String {
    let v0 = "Hola"
    let v1 = "mundo"
    return StringConcatenator.buildBlock(v0, v1)
}
```

Por último, terminamos explicando que si anotábamos con el atributo un
parámetro de una función, el _result builder_ se aplicaba a la clausura
que se pasaba como parámetro. Algo interesante porque permite usar el
_result builder_ sin que aparezca la anotación:

```swift
func imprimeSaludo(@StringConcatenator _ contenido: () -> String) {
    print(contenido())
}

// Llamamos a la función con una clausura que usa el DSL.
// No es necesario añadir la anotación @StringConcatenator.
imprimeSaludo {
    "Hola"
    "mundo"
}
// Imprime: Hola, mundo
```

En este segundo post vamos a ver otros lugares en los que se puede usar el
atributo del _result builder_ y otras transformaciones que se pueden realizar.

## Result builders en inicializadores ##

En SwiftUI se utiliza el _result builder_
[ViewBuilder](https://developer.apple.com/documentation/swiftui/viewbuilder)
para construir vistas. Un ejemplo es el siguiente:

```swift
let vista = 
    HStack {
        ForEach(
            1...5,
            id: \.self
        ){
            Text("Ítem \($0)")
        }
    }
```

La vista construida es una pila horizontal con cinco subvistas de tipo
`Text`:

![](hstack.webp)

Vemos que el `HStack` recibe una clausura con código DSL que
especifica las subvistas. El `ViewBuilder` transformará ese DSL en
código Swift. 

¿Por qué no tenemos que usar el atributo `@ViewBuilder`?. La
explicación está en que ese atributo se ha usado en un parámetro de
una función. En concreto en un parámetro del inicializador de
`HStack`.

Vamos a hacer algo similar con el `StringConcatenator`.

### Ejemplo de _result builder_ en un inicializador  ###

Supongamos la siguiente estructura `Persona`:

```swift
struct Persona {
    let contenido: () -> String

    var saludo: String {
        contenido()
    }

    init(@StringConcatenator contenido: @escaping () -> String) {
        self.contenido = contenido
    }
}
```

Estamos definiendo una estructura con una propiedad almacenada
`contenido` que contiene una clausura sin parámetros que devuelve una
cadena. Y una variable calculada `saludo` que devuelve la cadena
resultante de ejecutar esa clausura.

Definimos también el inicializador de `Persona` con el parámetro que
inicializa la propiedad `contenido`. Para construir una instancia de
`Persona` debemos pasar como argumento la clausura que va a generar el
saludo. Y añadimos a ese parámetro el atributo `@StringConcatenator`
para indicar el argumento que pasemos debe ser transformado por el
_result builder_. El atributo `@escaping` no es importante; tiene que
ver con la forma de gestionar el ámbito de la clausura y el compilador
da un error si no lo ponemos.

Ahora ya podemos crear una instancia de `Persona` pasando una clausura
que usa el DSL:

```swift
let frodo = Persona {
    "Hola"
    "me"
    "llamo"
    "Frodo"
}
```

Una vez construida la instancia, se habrá guardado en su propiedad
`contenido` la clausura que devuelve el saludo. Llamamos a la clausura
accediendo a la propiedad `saludo`:

```swift
print(frodo.saludo)
```

Se imprime:

```text
Hola, me, llamo, Frodo
```

### Simplificando el inicializador ###

A los ingenieros que diseñaron los _result builders_ se les ocurrió un
_azucar sintáctico_ que permite hacer más sencilla todavía la
construcción anterior.

Dado que las estructuras en Swift generan automáticamente un
[inicializador
memberwise](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID213),
se podría usar el atributo del _result builder_ directamente en la
propiedad. No tenemos que definir el inicializador porque Swift lo
crea automáticamente:

```swift
struct PersonaSimple {
    @StringConcatenator let contenido: () -> String

    var saludo: String {
        contenido()
    }
}
```

No hace falta especificar nada más. Swift genera automáticamente el inicializador de
la estructura correctamente y podemos usarlo de la misma forma que antes:

```swift
let frodo2 = PersonaSimple {
    "Hola"
    "me"
    "llamo"
    "Frodo"
}

print(frodo2.saludo)
// Imprime: Hola, me, llamo, Frodo
```

Esta forma de definir un _result builder_ es una de las más usadas. Se
utiliza en la gran mayoría de DSLs construidos en Swift, incluido
SwiftUI.

## Result builders en protocolos ##

Otra forma de aplicar un _result builder_ sin usar explícitamente la
anotación correspondiente es mediante un protocolo. Si marcamos con la
anotación un método o una propiedad de un protocolo se aplicará el
_result builder_ en el código que adopta el protocolo.

Vamos a seguir con el ejemplo del saludo construido con el
`@StringConcatenator`. Podemos definir un protocolo con una
propiedad con el saludo:

```swift
protocol Educado {
    @StringConcatenator var saludo: String {get}
}
```

Al definir de esta forma la propiedad, cualquier tipo que adopte el
protocolo `Educado` deberá definir una propiedad `saludo` en la que se
podrá usar el _result builder_. Por ejemplo, definimos la estructura
`PersonaEducada` de la siguiente forma:

```swift
struct PersonaEducada: Educado {
    var nombre: String
    var saludo: String {
        "Hola"
        "me"
        "llamo"
        nombre
    }
}
```

Estamos definiendo el `saludo` con las cadenas que se muestran en las
distintas sentencias (`"Hola"`, `"me"`, `"llamo"`) y la propiedad
`nombre`. El _result builder_ `@StringConcatenator` transformará este
código de la forma que hemos visto anteriormente.

Al ser `saludo` una variable calculada, la única variable almacenada
que hay que especificar al crear la estructura es el `nombre` de la
persona. Lo hacemos de la forma siguiente, llamando al inicializador
_memberwise_ creado automáticamente:

```swift
let gandalf = PersonaEducada(nombre: "Gandalf")
```

Y, una vez creada la instancia de una `PersonaEducada` podemos pedir
su saludo:

```swift
print(gandalf.saludo)

```

Como siempre, se imprimirá:

```text
Hola, me, llamo, Gandalf
```

## Transformaciones más elaboradas ##

Hasta ahora hemos visto cómo el _result builder_ construye un
componente complejo a partir de componentes elementales usando la
función estática `buildBlock`.

El perfil de esta función es el siguiente:

```swift
static func buildBlock(_ components: Component...) -> Component
```

En el caso de los ejemplos anteriores el tipo componente es un
`String` y la función `buildBlock` recibe un número variable de
cadenas y construye la cadena resultante.

Sin embargo, es posible que en ciertos DSLs tengamos que hacer algún
tipo de transformación en los componentes iniciales. O aplicar una
última transformación al valor resultante. Para tener este control más
fino podemos especificar dos funciones adicionales en el _result
builder_, las funciones `buildExpression` y `buildFinalResult`.

El perfil de ambas funciones es el siguiente:

```swift
static func buildExpression(_ expression: Expression) -> Component
static func buildFinalResult(_ component: Component) -> FinalResult
```

- La función `buildExpression(_ expression: Expression) -> Component`
  se utiliza para transformar los resultados de las sentencias del
  DSL, del tipo _Expression_ en el tipo resultante _Component_ que se
  va a usar en el `buildBlock`. Permite que el tipo de las expresiones
  que aparecen en el DSL sea distinto del tipo resultante.

- La función `buildFinalResult(_ component: Component) -> FinalResult`
  se usa para construir el resultado final que va a devolver el
  _result builder_. Permite distinguir el tipo componente del tipo
  resultado de forma que, por ejemplo, el _result builder_ podría
  realizar transformaciones internas en un tipo que no queremos
  exponer a los clientes y al final realizar una transformación al
  tipo resultante.

Estas funciones son opcionales. Si no las especificamos, el _result
builder_ solo trabaja con el tipo _Component_ tal y como hemos visto
en los ejemplos anteriores.

Un ejemplo sencillo es el siguiente, en el que definimos un _result
builder_ que construye un array de números reales. Las expresiones que
escribimos en el DSL son de números enteros.

```swift
@resultBuilder
struct ArrayBuilder {
    static func buildExpression(_ expression: Int) -> [Int] {
        return [expression]
    }

    static func buildBlock(_ components: [Int]...) -> [Int] {
        return Array(components.joined())
    }

    static func buildFinalResult(_ component: [Int]) -> [Double] {
        component.map {Double($0)}
    }
}
```

- La función `buildExpression` transforma el número entero original en
un array con un único dato. En este caso el tipo _Expression_ es un
`Int` y el tipo _Component_ resultante es un `[Int]`.

- La función `buildBlock` es la que une varios componentes (arrays de
enteros de un elemento) en un resultado final, un array de enteros.

- Y la función `buildFinalBlock` transforma el componente resultante de
la función anterior en el tipo _FinalResult_, un `[Double]`.

Podemos ver un resultado del funcionamiento en el siguiente ejemplo:

```swift
@ArrayBuilder
func buildArray() -> [Double] {
    100
    100+100
    (100+100)*2
}

print(buildArray())
```

En el DSL que define el cuerpo de la función se escriben tres
sentencias que devuelven enteros. Estas tres sentencias son las
expresiones que va a tomar el _result builder_ para aplicar todas las
transformaciones anteriores.

El resultado final es el siguiente array de números reales:

```text
[100.0, 200.0, 400.0]
```

## Referencias ##

- [Propuesta de Result Builders en Swift Evolution](https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md) 
- [Explicación detallada en Language Reference](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder)
- [Fichero de código con los ejemplos del post](https://github.com/domingogallardo/blog/blob/main/posts/0002-result-builders-2/code/result-builders-2.swift)

## Addendum (abril 2025) — ¿Qué ha pasado en Swift en estos tres años?

> **Contexto rápido**  
> Desde que publicaste este segundo artículo (2022) Swift ha seguido evolucionando.  
> Este apéndice resume los cambios que impactan en los temas que tratabas: inicializadores, protocolos y funciones avanzadas (`buildExpression`, `buildFinalResult`).

### 1. Inicializadores + *result builder* → ahora también en **clases**  

*Swift 5.8* amplió la capacidad de marcar **initializers designados de clase** con atributos de builder.  
Ejemplo adaptado a tu `Persona`:

```swift
class Persona {
    private let contenido: () -> String
    var saludo: String { contenido() }

    init(@StringConcatenator contenido: @escaping () -> String) {      // ✅ válido en 5.8+
        self.contenido = contenido
    }
}
```

### 2. Memberwise + atributos: se generan **automáticamente**  

A partir de *Swift 5.9*, cuando anotas una propiedad stored con un builder (p. ej. `@StringConcatenator let contenido: () -> String`) el compilador ya **no exige** que marques el parámetro del member‑wise initializer con el mismo atributo; lo hace solo.

```swift
struct PersonaSimple {
    @StringConcatenator let contenido: () -> String        // ← suficiente
}
```

### 3. Protocolos con builders: ahora admiten **`async`/`throws`**  

Con la adopción de *Strict Concurrency* (Swift 5.10), los requirements de protocolo pueden declararse:

```swift
protocol Educado {
    @StringConcatenator var saludo: String { get async }
}
```

Quien implemente el protocolo podrá usar un builder y además devolver un valor asíncrono.

### 4. Nuevas funciones de fase intermedia  

Swift 5.7 introdujo `buildPartialBlock(first:)` y `buildPartialBlock(accumulated:)`.  
Si las implementas puedes **omitir** `buildBlock`, y el compilador ensamblará el resultado incrementalmente (útil para performance en builders pesados).

```swift
static func buildPartialBlock<each T>(first value: repeat each T) -> (repeat each T) { value }
static func buildPartialBlock<each T>(accumulated: (repeat each T), next: (repeat each T)) -> (repeat each T) {
    (repeat each accumulated, repeat each next)
}
```

> *Tip*: Con **parameter packs** (`<each T>`) no necesitas sobrecargas de 1…10 elementos.


### 5. `buildExpression` + registros de errores  

Si tu `buildExpression` puede lanzar, ya puedes marcarla `throws` (Swift 5.9).  
El error se propaga al punto donde se usa el builder; no es necesario capturarlo dentro.

```swift
static func buildExpression(_ value: Int) throws -> [Int] { … }
```

### 6. Macros vs. Result Builders (recordatorio breve)  

La nueva era de **Swift Macros** (SE‑0389/0397) no reemplaza a los builders pero sí cubre casos que antes forzábamos con ellos:

| Qué quiero lograr | Builder | Macro |
| ----------------- | ------- | ----- |
| DSL declarativo (SwiftUI, HTML…) | ✔︎ | ✔︎ |
| Generar *nuevas* declaraciones, envoltorios, `Codable` automático… | ✗ | ✔︎ |
| Validación del AST completo en compile‑time | ✗ | ✔︎ |

### Para seguir profundizando

* SE‑0390 – *Variadic Generics* (parameter packs)  
* SE‑0389 / SE‑0397 – *Swift Macros*  
* WWDC23 “Design Data‑Driven Apps with Result Builders”
