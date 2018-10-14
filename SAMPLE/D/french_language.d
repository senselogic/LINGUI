module lingui.french_language;

// -- IMPORTS

import lingui.genre;
import lingui.plurality;
import lingui.translation;
import lingui.game_language;

// -- TYPES

class FRENCH_LANGUAGE : GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        Name = "French";
        DecimalSeparator = ',';
    }

    // -- INQUIRIES

    override string NewGame(
        )
    {
        return "Nouveau jeu";
    }

    // ~~

    override string Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( "Bienvenue, " );
        result_translation.AddText( first_name_translation );
        result_translation.AddText( " " );
        result_translation.AddText( last_name_translation );
        result_translation.AddText( " !" );

        return result_translation.Text;
    }

    // ~~

    override string Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

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
