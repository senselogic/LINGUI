// -- IMPORTS

using GAME;

// -- TYPES

namespace GAME
{
    public class ENGLISH_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public ENGLISH_LANGUAGE(
            ) : base()
        {
            Name = "English";
            DotCharacter = '.';
            TranslationDictionary[ "Language:" ] = new TRANSLATION( "Language:" );
            TranslationDictionary[ "English" ] = new TRANSLATION( "English" );
            TranslationDictionary[ "French" ] = new TRANSLATION( "French" );
            TranslationDictionary[ "Spanish" ] = new TRANSLATION( "Spanish" );
            TranslationDictionary[ "Haiku" ] = new TRANSLATION( "Limits are created by mind.\nImagination can take you to the heavens.\nNow imagine something." );
            TranslationDictionary[ "Poem" ] = new TRANSLATION( "The butterfly is a thing to behold,\nwith colors more beautiful than gold.\n" + "How I enjoy your beauty, butterfly,\nas I sit and watch you flutter by." );
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

        public override string MainMenu(
            )
        {
            return "Main menu";
        }

        // ~~

        public override TRANSLATION Helmets(
            int count
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            if ( count == 1 )
            {
                result_translation.AddText( "helmet" );
            }
            else
            {
                result_translation.AddText( "helmets" );
            }

            result_translation.SetQuantity( count );

            return result_translation;
        }

        // ~~

        public override TRANSLATION Swords(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "sword" );
            }
            else
            {
                result_translation.AddText( "swords" );
            }

            result_translation.SetQuantity( count_translation.Quantity );

            return result_translation;
        }

        // ~~

        public override string TheItems(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            if ( items_translation.IntegerQuantity == 0 )
            {
                result_translation.AddText( "No " );
            }
            else if ( items_translation.IntegerQuantity == 1 )
            {
                result_translation.AddText( "The " );
            }
            else
            {
                result_translation.AddText( "The " );
                result_translation.AddText( items_translation.Quantity );
                result_translation.AddText( " " );
            }

            result_translation.AddText( items_translation );

            return result_translation.Text;
        }

        // ~~

        public override string TheItemsHaveBeenFound(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( TheItems( items_translation ) );

            if ( items_translation.IntegerQuantity == 1 )
            {
                result_translation.AddText( " has" );
            }
            else
            {
                result_translation.AddText( " have" );
            }

            result_translation.AddText( " been found.\n" );

            return result_translation.Text;
        }
    }
}
