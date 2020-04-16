tableextension 50777 TablePaymentTermsExt extends "Payment Terms"
{
    fields
    {
        field(50777; MetodoDePago; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}