// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class FRENCH_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    FRENCH_LANGUAGE(
        )
    {
        Name = "French";
        DotCharacter = ',';
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetFrenchCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetFrenchOrdinalPlurality();
    }

    // ~~

    String NewGame(
        )
    {
        return "Nouveau jeu";
    }

    // ~~

    String Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( "Bienvenue, " );
        result_translation.AddText( first_name_translation );
        result_translation.AddText( " " );
        result_translation.AddText( last_name_translation );
        result_translation.AddText( " !" );

        return result_translation.Text;
    }

    // ~~

    String Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( count_translation.Quantity );
        result_translation.AddText( " " );

        if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "poire" );
        }
        else
        {
            result_translation.AddText( "poires" );
        }

        return result_translation.Text;
    }
}
