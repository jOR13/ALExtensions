table 50895 Conceptos
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Cantidad; decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(2; ClaveProdServ; Text[20])
        {
            DataClassification = ToBeClassified;

        }

        field(3; Descripcion; Text[2000])
        {
            DataClassification = ToBeClassified;

        }

        field(4; Importe; decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(5; NoIdentificacion; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(6; Unidad; Text[20])
        {
            DataClassification = ToBeClassified;

        }

        field(8; ClaveUnidad; Text[20])
        {
            DataClassification = ToBeClassified;

        }

        field(7; ValorUnitario; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(9; id; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(10; Folio; Text[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(MyKey; id)
        {
            Clustered = true;
            Enabled = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}