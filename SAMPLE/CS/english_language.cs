// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class ENGLISH_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public ENGLISH_LANGUAGE(
            )
        {
            Name = "English";
            DotCharacter = '.';
        }

        // -- INQUIRIES

        public override PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetEnglishCardinalPlurality();
        }

        // ~~

        public override PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetEnglishOrdinalPlurality();
        }

        // ~~

        public override string NewGame(
            )
        {
            return "New game";
        }

        // ~~

        public override string Welcome(
            TRANSLATION first_name_translation,
            TRANSLATION last_name_translation
            )
        {
            return "Welcome, " + first_name_translation.Text + " " + last_name_translation.Text + "!";
        }

        // ~~

        public override string Pears(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( count_translation.Quantity + " " );

            if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "pear" );
            }
            else
            {
                result_translation.AddText( "pears" );
            }

            return result_translation.Text;
        }
    }
}
