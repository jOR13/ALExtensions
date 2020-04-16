pageextension 50864 pmtTermsExt extends "Payment Terms"
{
    Editable = true;
    layout
    {
        addafter(Description)
        {
            field(MetodoDePago; MetodoDePago)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}