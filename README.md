![](https://github.com/senselogic/LINGUI/blob/master/LOGO/lingui.png)

# Lingui

Internationalization code generator.

## Description

Lingui converts human-readable translation scripts into compilable C#/D/Dart code which can be directly integrated into the localized application.

Its minimalistic syntax is designed to allow professional translators to specify both static and parametric translations in a simple way.

## Sample

### Lingui

```lua
LANGUAGE

    GameOver

    Welcome first_name last_name

    Pears :count

ENGLISH_LANGUAGE : LANGUAGE

    "princess"
        1*"princess":female

    "NewGame"
        "New game"

    GameOver
        "Game over!"

    Welcome first_name last_name
        "Welcome, " ~ first_name ~ " " ~ last_name ~ "!"

    Pears :count
        *count ~ " "
        if @count = one
            "pear"
        else
            "pears"

GERMAN_LANGUAGE : LANGUAGE

    "princess"
        1*"Prinzessin":female

    "NewGame"
        "Neues Spiel"

    GameOver
        "Spiel vorbei!"

    Welcome first_name last_name
        "Willkommen, " ~ first_name ~ " " ~ last_name ~ "!"

    Pears :count
        *count ~ " "
        if @count = one
            "Birne"
        else
            "Birnen"

FRENCH_LANGUAGE : LANGUAGE

    "princess"
        1*"princesse":female

    "NewGame"
        "Nouveau jeu"

    GameOver
        "Fin du jeu !"

    Welcome first_name last_name
        "Bienvenue, " ~ first_name ~ " " ~ last_name ~ " !"

    Pears :count
        *count ~ " "
        if @count = one
            "poire"
        else
            "poires"
```

### C&#35;

```cs
// -- IMPORTS

using System;
using LINGUI;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        LANGUAGE language
        )
    {
        Console.WriteLine( language.GetTranslation( "princess" ).Text );
        Console.WriteLine( language.GetTranslation( "NewGame" ).Text );
        Console.WriteLine( language.GameOver() );
        Console.WriteLine( language.Welcome( "Jack", "Sparrow" ) );
        Console.WriteLine( language.Pears( new TRANSLATION( 0 ) ) );
        Console.WriteLine( language.Pears( new TRANSLATION( 1 ) ) );
        Console.WriteLine( language.Pears( new TRANSLATION( 2 ) ) );
    }

    // ~~

    public static void Main(
        string[] argument_array
        )
    {
        TestLanguage( new ENGLISH_LANGUAGE() );
        TestLanguage( new GERMAN_LANGUAGE() );
        TestLanguage( new FRENCH_LANGUAGE() );
    }
}
```

### D

```d
// -- IMPORTS

import lingui.english_language;
import lingui.french_language;
import lingui.german_language;
import lingui.language;
import lingui.translation;
import std.stdio : writeln;

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    writeln( language.GetTranslation( "princess" ).Text );
    writeln( language.GetTranslation( "NewGame" ).Text );
    writeln( language.GameOver() );
    writeln( language.Welcome( "Jack", "Sparrow" ) );
    writeln( language.Pears( TRANSLATION( 0 ) ) );
    writeln( language.Pears( TRANSLATION( 1 ) ) );
    writeln( language.Pears( TRANSLATION( 2 ) ) );
}

// ~~

void main(
    string[] argument_array
    )
{
    TestLanguage( new ENGLISH_LANGUAGE() );
    TestLanguage( new GERMAN_LANGUAGE() );
    TestLanguage( new FRENCH_LANGUAGE() );
}
```

### Dart

```dart
// -- IMPORTS

import "english_language.dart";
import "french_language.dart";
import "german_language.dart";
import "language.dart";
import "translation.dart";

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    print( language.GetTranslation( "princess" ).Text );
    print( language.GetTranslation( "NewGame" ).Text );
    print( language.GameOver() );
    print( language.Welcome( "Jack", "Sparrow" ) );
    print( language.Pears( TRANSLATION( 0 ) ) );
    print( language.Pears( TRANSLATION( 1 ) ) );
    print( language.Pears( TRANSLATION( 2 ) ) );
}

// ~~

void main(
    List<String> argument_list
    )
{
    TestLanguage( ENGLISH_LANGUAGE() );
    TestLanguage( GERMAN_LANGUAGE() );
    TestLanguage( FRENCH_LANGUAGE() );
}
```

### Result

```
princess
New game
Game over!
Welcome, Jack Sparrow!
0 pears
1 pear
2 pears
Prinzessin
Neues Spiel
Spiel vorbei!
Willkommen, Jack Sparrow!
0 Birnen
1 Birne
2 Birnen
princesse
Nouveau jeu
Fin du jeu !
Bienvenue, Jack Sparrow !
0 poire
1 poire
2 poires
```

## Syntax

### Indentation

Lingui scripts are indentation-based.

The first level contains the language class names, and the second level contains the translation constants and functions.

### Language classes

A language class can extend another one, by specifying the base language after a colon (`:`).

A base language must be declared before its derived languages.

The first language generally defines the application interface,
by declaring the translation functions available to the localized application,
while the next languages provide their language-specific implementations.

### Translation values

A translation value has one or several of the following properties :

*   a text (`$`);
*   a quantity text (`*`), with an integer (`#`) or real (`%`) value;
*   a genre (`&`).

### Translation constants

A translation constant has a quoted name, and is defined by a single line expression.

Its translation will be evaluated once, and stored inside the translation dictionary of each language.

### Translation functions

Functions have parameters and declare local variables.

The function result is the concatenation of its evaluated expressions,
accumulated inside an implicit `result` translation variable.

If the function has a single-line definition starting with `"` or `(`, it directly returns its result.

Adding an empty `var` declaration prevents this optimization.

Functions declared with a `:` prefix return a translation value instead of a string.

Function parameters and variables declared with a `:` prefix store a translation value instead of a string.

### Function statements

*   Textual expressions

    ```lua
    "Some text...\n"
    GetTitleCase( Swords( 2* ) )
    ```

*   Conditions

    ```lua
    if @person = one
        if &person = female
            ...
        elseif &person = male
            ...
        else
            ...
    elseif #person <= 3
        ...
    else
        ...
    ```

*   Variable declarations and assignments

    ```lua
    var :kings :queens :princes
    kings = Kings( 1* )
    $queens = "reinas"
    *queens = "2"
    &queens = female
    princes = 3*"príncipes":male
    ```

### Accessors

Variable names can be prefixed by the following accessors :

```lua
$    text
*    quantity text
^    quantity first character
#    quantity integer value
%    quantity real value
!    quantity is integer
.    quantity is real
@    cardinal plurality (zero, one, two, few, many, other)
°    ordinal plurality (zero, one, two, few, many, other)
&    genre (neutral, male, female)
```

### Operators

Expressions and conditions can use the following operators :

```lua
~      text concatenation
+      addition
-      substraction
*      multiplication
/      division
%      division remainder
not    logical not
and    logical and
or     logical or
<      lower
>      higher
<=     lower equal
>=     higher equal
=      equal
<>     not equal
( )    grouping parentheses
```

### Constants

```lua
"Some text.\n"          text
'.'                     character
1                       integer
2.5                     real
3*                      integer quantity
4*"perros"              integer quantity and text
5*"fiestas":female      integer quantity, text and genre
6.5*                    real quantity
7.5*"metros"            real quantity and text
8.5*"vueltas":female    real quantity, text and genre
```

### Predefined constants

```lua
zero
one
two
few
many
other

neutral
male
female
```

### Predefined functions

```lua
MakeTranslation( text, quantity, genre )
MakeTranslation( text, quantity )
MakeTranslation( text, genre )
MakeTranslation( text )
MakeTranslation( integer_quantity, genre )
MakeTranslation( integer_quantity )
HasTranslation( key )
GetTranslation( key )
GetLowerCase( text )
GetLowerCase( translation )
GetUpperCase( text )
GetUpperCase( translation )
GetTitleCase( text )
GetTitleCase( translation )
GetSentenceCase( text )
GetSentenceCase( translation )
HasFirstCharacter( text, first_characters )
HasFirstCharacter( translation, first_characters )
HasPrefix( text, prefix )
HasPrefix( translation, prefix )
HasSuffix( text, prefix )
HasSuffix( translation, prefix )
GetIntegerReal( integer )
GetRealInteger( real )
GetTextInteger( text )
GetTextReal( text )
GetIntegerText( integer )
GetRealText( real, minimum_fractional_digit_count, maximum_fractional_digit_count, dot_character );
GetGenreText( genre )
GetPluralityText( plurality )
GetCardinalPlurality( translation )
GetOrdinalPlurality( translation )
```

### Comments

```
# This is a comment.
```

### Conventions

*   Class names are written in upper case.
*   Function names start by an upper case letter.
*   Parameter and variable names start by a lower case letter.

### Limitations

Predefined constant names can't be used for function parameter and variable names.

Operators and variables must be separated by spaces.

### Installation

Install the [DMD 2 compiler](https://dlang.org/download.html) appropriate to your system (Linux, Windows or macOS).

Then build the executable with the following command line :

```bash
dmd -m64 lingui.d
```

### Command line

```bash
lingui [options] language.lingui [language.lingui ...] OUTPUT_FOLDER/
```

### Options

```
--cs : generate C# files
--d : generate D files
--dart : generate Dart files
--base : generate the base classes
--namespace LINGUI : use this namespace
--uppercase : generate uppercase filenames
--verbose : show the processing messages
```

The `--cs`, `--d` and `--dart` options are mutually exclusive.

### Examples

```bash
lingui --dart --base --namespace game --verbose language.lingui english_language.lingui german_language.lingui DART/
```

Converts Lingui files to Dart source code files, generating the base classes too and using "game" as namespace.

```bash
lingui --cs --verbose language.lingui english_language.lingui german_language.lingui CS/
```

Converts Lingui files to C# source code files.

## Limitations

*   The cardinal and ordinaly pluralities are provided only for the following languages :
    *   English
    *   Japanese
    *   Korean
    *   Chinese
    *   German
    *   French
    *   Italian
    *   Spanish
    *   Portuguese
    *   Russian
    *   Turquish
    *   Dutch
    *   Swedish
    *   Norwegian
    *   Danish
    *   Arabic

## Version

2.2

## Author

Eric Pelzer (ecstatic.coder@gmail.com).

## License

This project is licensed under the GNU Lesser General Public License version 3.

See the [LICENSE.md](LICENSE.md) file for details.
