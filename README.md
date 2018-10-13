![](https://github.com/senselogic/LINGUI/blob/master/LOGO/lingui.png)

# Lingui

Internationalization code generator.

## Description

Lingui converts human-readable translation scripts into compilable C#/D/Dart code which can be directly integrated into the localized application.

Its minimalistic syntax is designed to allow professional translators to specify both static and parametric translations in a simple way.

## Sample

```lua
Game
    NewGame
    Welcome first_name last_name
    Pears count

English : Game
    NewGame
        "New game"

    Welcome first_name last_name
        "Welcome, "
        first_name
        " "
        last_name
        "!"

    Pears count
        *count
        " "
        if @count = one
            "pear"
        else
            "pears"

German : Game
    NewGame
        "Neues Spiel"

    Welcome first_name last_name
        "Willkommen, "
        first_name
        " "
        last_name
        "!"

    Pears count
        *count
        " "
        if @count = one
            "Birne"
        else
            "Birnen"

French : Game
    NewGame
        "Nouveau jeu"

    Welcome first_name last_name
        "Bienvenue, "
        first_name
        " "
        last_name
        " !"

    Pears count
        *count
        " "
        if @count = one
            "poire"
        else
            "poires"
```

```cs
// -- IMPORTS

using System;
using LINGUI;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        GAME_LANGUAGE game_language
        )
    {
        Console.WriteLine( game_language.NewGame() );
        Console.WriteLine( game_language.Welcome( new TRANSLATION( "Jack" ), new TRANSLATION( "Sparrow" ) ) );
        Console.WriteLine( game_language.Pears( new TRANSLATION( 0 ) ) );
        Console.WriteLine( game_language.Pears( new TRANSLATION( 1 ) ) );
        Console.WriteLine( game_language.Pears( new TRANSLATION( 2 ) ) );
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

```
New game
Welcome, Jack Sparrow!
0 pears
1 pear
2 pears
Neues Spiel
Willkommen, Jack Sparrow!
0 Birnen
1 Birne
2 Birnen
Nouveau jeu
Bienvenue, Jack Sparrow !
0 poire
1 poire
2 poires
```

## Syntax

### Scripts

Lingui scripts are indentation-based.

The first level contains the localization languages, and the second level contains the translation functions.

### Languages

A language can extend another language, by specifying the base language after a colon (`:`).

The first language generally enumerates the translation functions available to the localized application.

The other languages then provide language-specific implementations for all these functions.

### Functions

A function can have parameters, which are translation variables with the following properties :

*   a text (`$`);
*   a quantity text (`*`), with an integer (`#`) or real (`%`) value;
*   a genre (`&`).

A function can declare local translation variables, which can be used to temporarily store partial translations.

A function returns a translated text which is the concatenation of the function textual expressions.

They are automatically accumulated inside an implicit `result` translation variable, unless the function has a single-line definition.

If the function name is prefixed by a colon (`:`), the function returns the `result` translation variable itself, instead of just its text property.

### Statements

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
    var kings queens princes
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
:    true if the quantity is integer
.    true if the quantity is real
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
GetInteger( real )
GetReal( integer )
GetText( integer )
GetText( real, minimum_fractional_digit_count, maximum_fractional_digit_count, dot_character );
```

### Comments

```
# This is a comment.
```

### Conventions

*   Language and function names start by an upper case letter.
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
lingui [options] script_file.lingui OUTPUT_FOLDER/
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
lingui --cs --base --namespace GAME --verbose test.lingui CS/
```

Converts a Lingui script file to C# source code files, generating the base classes too and using "GAME" as namespace.

```bash
lingui --d --verbose test.lingui D/
```

Converts a Lingui script file to D source code files.

## Version

1.0

## Author

Eric Pelzer (ecstatic.coder@gmail.com).

## License

This project is licensed under the GNU Lesser General Public License version 3.

See the [LICENSE.md](LICENSE.md) file for details.
