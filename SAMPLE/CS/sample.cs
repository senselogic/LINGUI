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
        Console.WriteLine( language.NewGame() );
        Console.WriteLine( language.Welcome( new TRANSLATION( "Jack" ), new TRANSLATION( "Sparrow" ) ) );
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
