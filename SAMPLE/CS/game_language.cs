// -- TYPES

public class GAME_LANGUAGE : LANGUAGE
{
    // -- INQUIRIES

    public virtual string New_game(
        )
    {
        return "";
    }

    // ~~

    public virtual string Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "";
    }

    // ~~

    public virtual string Pears(
        TRANSLATION count_translation
        )
    {
        return "";
    }
}