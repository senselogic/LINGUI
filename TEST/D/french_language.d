module lingui.french_language;

// -- IMPORTS

import lingui.genre;
import lingui.plurality;
import lingui.game_language;
import lingui.translation;

// -- TYPES

class FRENCH_LANGUAGE : GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        Name = "French";
    }

    // -- INQUIRIES

    override string Main_menu(
        )
    {
        return "Menu principal";
    }

    // ~~

    override TRANSLATION Chests(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        if ( count_translation.IntegerQuantity <= 1 )
        {
            result_translation.AddText( "coffre" );
        }
        else
        {
            result_translation.AddText( "coffres" );
        }

        result_translation.SetQuantity( count_translation.Quantity );
        result_translation.SetGenre( GENRE.Male );

        return result_translation;
    }

    // ~~

    override TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "épée" );
        }
        else
        {
            result_translation.AddText( "épées" );
        }

        result_translation.SetQuantity( count_translation.Quantity );
        result_translation.SetGenre( GENRE.Female );

        return result_translation;
    }

    // ~~

    override string The_items(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        if ( items_translation.IntegerQuantity == 0 )
        {
            if ( items_translation.Genre == GENRE.Female )
            {
                result_translation.AddText( "Aucune " );
            }
            else
            {
                result_translation.AddText( "Aucun " );
            }
        }
        else if ( items_translation.IntegerQuantity == 1 )
        {
            if ( HasFirstCharacter( GetLowerCase( items_translation.Text ), "aâeéêèiîoôuûh" ) )
            {
                result_translation.AddText( "L'" );
            }
            else if ( items_translation.Genre == GENRE.Female )
            {
                result_translation.AddText( "La " );
            }
            else
            {
                result_translation.AddText( "Le " );
            }
        }
        else
        {
            result_translation.AddText( "Les " );
            result_translation.AddText( items_translation.Quantity );
            result_translation.AddText( " " );
        }

        result_translation.AddText( items_translation );

        return result_translation.Text;
    }

    // ~~

    string Have(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        if ( items_translation.IntegerQuantity == 0 )
        {
            result_translation.AddText( " n'a" );
        }
        else if ( items_translation.IntegerQuantity <= 1 )
        {
            result_translation.AddText( " a" );
        }
        else
        {
            result_translation.AddText( " ont" );
        }

        return result_translation.Text;
    }

    // ~~

    string Been_found(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( " été trouvé" );

        if ( items_translation.Genre == GENRE.Female )
        {
            result_translation.AddText( "e" );
        }

        if ( items_translation.IntegerQuantity > 1 )
        {
            result_translation.AddText( "s" );
        }

        return result_translation.Text;
    }

    // ~~

    override string The_items_have_been_found(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( The_items( items_translation ) );
        result_translation.AddText( Have( items_translation ) );
        result_translation.AddText( Been_found( items_translation ) );
        result_translation.AddText( ".\n" );

        return result_translation.Text;
    }
}