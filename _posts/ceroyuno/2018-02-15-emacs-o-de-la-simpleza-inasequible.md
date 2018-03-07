---
layout: archive
title: "Cero y uno"
---

# Emacs o de la simpleza inasequible

![logo](https://www.gnu.org/software/emacs/images/emacs.png)

> An extensible, customizable,
>
> <font color="#7f5ab6">free/libre</font>
>
> text editor -- and more.

## Instalación

### ¿Por qué instalé **Emacs (GNU Emacs)**?

-   Para los editores más vistosos, cruzar el puente es su condena; son demasiado aparatosos
-   Escuché buenas cosas de Emacs (i.e. porque sí)
-   Traté con [vim](http://www.vim.org/); perdí
-   Nos es dado confiarnos a la virtud de la simpleza, incluso aquella de escarpado acceso

### Instalar en Debian

**OS:** Debian testing buster

**Kernel:** x86_64 Linux 4.14.0-3-amd64

```sh
$ sudo apt-get install emacs25
$ sudo apt-get install emacs25-common-non-dfsg
# This last one is optional. Read foot notes.
```

## Instalar en MacOS

Siempre [brew](https://brew.sh/) (y algunas buenas [sugerencias](https://stackoverflow.com/questions/44092539/how-can-i-install-emacs-correctly-on-os-x#44094859)):

```sh
brew install emacs --with-cocoa --with-gnutls --with-rsvg --with-imagemagick
```

## Tutorial

El mejor lúgar para empezar es el tutorial _oficial_ de GNU Emacs. También es una buena oportunidad para _sensibilizarse_ sobre la curva de aprendizaje.

## Init file (`.el`)

Aquí empieza la **personalización**. El archivo `init.el` tiene el código **EmacsLisp**, que se ejecuta al iniciar Emacs.

-   En una instalación nueva, es probable que el archivo no exista
-   Es común guardarlo aquí: `~/.emacs.d/init.el`; lo común que es mi común

> emacswiki [\*](https://www.emacswiki.org/emacs/InitFile)

## El _package manager_

Esto no parece tener mucho tiempo. Algún día fue complejo administrar los paquetes de Emacs (yo no estuve ahí). Uno tenía que escribir los _requirements_ en el archivo `init.el`, guardar los archivos del paquete con determinada estructura y **mantenerlo** (actualizaciones, etc.): **la burocracia de lo simple**.

A la fecha hay varias maneras de hacerlo con un package manager:

### MELPA

-   <https://melpa.org/#/>
-   Mi elección, por el frío método de eliminación
-   Es el [repositorio](https://github.com/melpa/melpa) con más actividad recientemente

Para usarlo, el archivo `init.el` debe contener lo siguiente:

```emacs-lisp
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
```

O más simple[\*](https://www.emacswiki.org/emacs/InstallingPackages):

```emacs-lisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
```

La diferencia que destaca: el primer bloque de código tiene la opción de instalar las [versiones estables](https://melpa.org/#/getting-started) de los paquetes (si la etiqueta _stable_ existe) desde el repositorio `melpa-stable`. Para **habilitar** estas descargas, se debe descomentar una línea --como lo indica una lectura rápida del código. La diferencia no fue relevante para mí. Y sin embargo, ese primer bloque de código fue el que escogí; uno nunca sabe.

### Marmelade

-   <https://marmalade-repo.org/>
-   No es difícil juzgarla popular; simplemente **no** lo escogí por su empolvado [repositorio](https://github.com/nicferrier/elmarmalade)

### GNU ELPA

-   Es el package manager oficial de GNU Emacs (`> emacs24`)

## Últimos primeros pasos

### Instalar paquetes con MELPA

-   Aprender a instalar paquetes es un buen primer paso
-   El paquete `better-defaults` es un buen ejemplo para empezar (ver [aquí](https://github.com/technomancy/better-defaults)) o con melpa:

1.  `M-x list-packages`
2.  Buscar el paquete: `C-s better-defaults`
3.  `Enter` mostrará información relativa al paquete
4.  Mover el cursor a `Install`; o también seleccionar con `i` y ejecutar con `x`

Algunos comandos básicos para instalar:

| tecla   | descripción                                 |
| ------- | ------------------------------------------- |
| `Enter` | Describe el paquete                         |
| `i`     | Marcar para instalación                     |
| `u`     | Desmarcar                                   |
| `d`     | Marcar para desinstalación                  |
| `x`     | Ejecutar selecciones                        |
| `r`     | Actualizar la lista de paquetes             |
| `U`     | (u mayúscula) Actualizar todos los paquetes |

> ergomacs [\*](http://ergoemacs.org/emacs/emacs_package_system.html)

### Desinstalar paquetes

1.  **La forma rápida.** Borrar el folder del paquete (comúnmente en `~/.emacs.d/elpa/{package_name}`)
2.  **Con un paquete.** Instalando el paquete `package-utils` ofrece comandos sencillos para actualizar y eliminar paquetes

### Personalización con Temas

El comando `M-x customize-themes` abre un menú muy intuitivo para cambiar el tema del editor.

-   Emacs Themes tiene una buena galería de temas [aquí](https://emacsthemes.com/).

### Sobre los `major-modes` y `minor-modes`

Tomemos como (lacónico) ejemplo el lenguaje Markdown (esto está siendo escrito en Markdown). Instalar con MELPA: `M-x package-install ENT markdown-mode ENT`. En Debian, vale la pena asegurarse de tener instalado:

```sh
sudo apt-get install pandoc
sudo apt-get install markdown
```

-   Al abrir un archivo markdown (comúnmente con extensiones `.md` o `.markdown`), se activa el modo markdown.
-   Podemos entonces ejecutar una serie de comandos activados para este modo.

### Embellecer el código

Qué dolorosamente difícil es traducir _code beautifying_. Tanto como encontrar un paquete que embellezca todo código en Emacs (similar al paquete de [atom](https://atom.io/packages/atom-beautify)). La búsqueda hasta el momento no ha dado resultados esperados. Esto sucede también porque la estrategia no es correcta: hay buenos paquetes que embellecen código, pero estos existen sólo para cada lenguaje en particular y así debe dirigirse su búsqueda. Uno acaba descubriendo que no sólo hay _embellecedores_, sino más que eso, completos ambientes para desarrollo para cada lenguaje. Como botón de muestra, este paquete para escribir en Python: [Elpy](https://github.com/jorgenschaefer/elpy).

> emacswiki [\*](https://www.emacswiki.org/emacs/CodeBeautifying)
>
> Chillar Anand [\*](http://avilpage.com/2015/05/automatically-pep8-your-python-code.html)

* * *

1.  ¡Gracias por tu entusiasmo, @magnars! ([settings de @magnars](https://github.com/magnars/.emacs.d)). Y más: [Aaron Bedra](http://aaronbedra.com/emacs.d/), [better defaults](https://github.com/technomancy/better-defaults).
2.  Sobre `emacs25-common-non-dfsg` (Debian Free Software Guidelines). Básicamente para tener el _Emacs Manual_. [1](https://askubuntu.com/questions/572026/what-is-the-purpose-of-the-package-emacs24-common-non-dfsg)
3.  The levels of emacs proficiency[\*](http://blog.vivekhaldar.com/post/3996068979/the-levels-of-emacs-proficiency).
4.  Emacs Rocks[\*](http://emacsrocks.com/e02.html).
5.  El buen [Ikerpiks](https://github.com/ikatza) inspiró mi curiosidad por Emacs.
6.  Package managers: diferencias prácticas. [1](https://emacs.stackexchange.com/questions/268/what-are-the-practical-differences-between-the-various-emacs-package-repositorie) [2](https://www.wisdomandwonder.com/article/8012/how-to-choose-packages-between-two-elpa-repositories)
7.  Es relevante el repositorio de versiones estables de MELPA. [1](https://camdez.com/blog/2015/04/03/switching-to-melpa-stable/)
