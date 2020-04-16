
report 50894 ReporteCFDI
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    //EnableExternalImages = true;
    WordLayout = 'ReporteFacturas.docx';
    //EnableHyperlinks = true;

    dataset
    {
        dataitem(temporal; temporal)
        {
            column(getRec; getRec) { }
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {

            DataItemLinkReference = temporal;
            DataItemLink = "No." = field(getRec);
            column(Work_Description; "Work Description") { }
            column(Order_Date; "Order Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Posting_Description; "Posting Description") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Due_Date; "Due Date") { }
            column(Payment_Discount__; "Payment Discount %") { }
            column(Pmt__Discount_Date; "Pmt. Discount Date") { }
            column(Order_No_; "Order No.") { }
            column(Amount; Amount) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Bill_to_County; "Bill-to County") { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code") { }
            column(Document_Date; "Document Date") { }
            column(External_Document_No_; "External Document No.") { }
            column(VAT_Bus__Posting_Group; "VAT Bus. Posting Group") { }
            column(Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.") { }
            column(CFDI_Purpose; "CFDI Purpose") { }
            column(CFDI_Relation; "CFDI Relation") { }
            column(No_Sales_Header; "No.") { }
        }

        dataitem(DataItemTablaFacturasTimbradas; facturasTimbradas)
        {
            DataItemLinkReference = "Sales Invoice Header";
            DataItemLink = Folio = field("No.");
            column(CertificadoCadena; CertificadoCadena) { }
            column(Descripcion; Descripcion) { }
            column(Fecha; Fecha) { }
            column(FechaTimbrado; FechaTimbrado) { }
            column(Folio; Folio) { }
            column(tipoDeComprobante; tipoDeComprobante) { }
            column(FormaDePago; FormaDePago) { }
            column(IVA; IVA) { }
            column(Lugardeexpedicin; "Lugar de expedición") { }
            column(Metododepago; "Metodo de pago") { }
            column(Moneda; Moneda) { }
            column(NoCertificado; NoCertificado) { }
            column(NoCertificadoSAT; NoCertificadoSAT) { }
            column(Nombre; Nombre) { }
            column(RFC; RFC) { }
            column(RegimenFiscal; "Regimen Fiscal") { }
            column(SelloDigitalCFD; SelloDigitalCFD) { }
            column(SelloSAT; SelloSAT) { }
            column(Subtotal; Subtotal) { }
            column(Total; Total) { }
            column(UUID; UUID) { }
            column(UsoCFDI; UsoCFDI) { }
            column(id; id) { }
            column(QR_String; "QR String") { }
            column(temp; temp.blob) { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                eventHandler.DoGenerateBarcode(DataItemTablaFacturasTimbradas."QR String", temp, DataItemTablaFacturasTimbradas.UUID);
            end;
        }
        dataitem(Cust__Ledger_Entry; "Cust. Ledger Entry")
        {
            DataItemLinkReference = "Sales Invoice Header";
            DataItemLink = "Document No." = field("No.");
            column(Document_Type; "Document Type") { }
            column(Description; Description) { }
        }
        dataitem(Customer; Customer)
        {
            DataItemLinkReference = "Cust__Ledger_Entry";
            DataItemLink = "No." = field("Customer No.");
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Address; Address) { }
            column(Address_2; "Address 2") { }
            column(City; City) { }
            column(County; County) { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
            column(E_Mail; "E-Mail") { }
            column(Responsibility_Center; "Responsibility Center") { }
        }
        dataitem(Sales_Invoice_Line; "Sales Invoice Line")
        {
            DataItemLinkReference = "Sales Invoice Header";
            DataItemLink = "Document No." = field("No.");
            column(UnitCost; "Unit Cost") { }
            column(AmountLine; Amount) { }
            column(VATBaseAmount; "VAT Base Amount") { }
            column(DescriptionLine; Description) { }
            column(VATBusPostingGroup; "VAT Bus. Posting Group") { }
            column(AmountIncludingVAT; "Amount Including VAT") { }
            column(Quantity; Quantity) { }
            column(Unit_of_Measure; "Unit of Measure") { }
            column(Unit_Price; "Unit Price") { }
            dataitem(Item; Item)
            {
                DataItemLinkReference = "Sales_Invoice_Line";
                DataItemLink = "No." = field("No.");
                column(SAT_Item_Classification; "SAT Item Classification") { }
                column(ItemDescription; Description) { }
            }

        }

    }



    /*
requestpage
    {
        // SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CurrReport; CurrReport."Sales Invoice Header"."No.")
                    {
                        TableRelation = temporal.getRec;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Factura seleccionada';
                        ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            //if CurrReport.Sales_Invoice_Line."Order No." =   then
            //CurrReport.Sales_Invoice_Line."Order No." := '114525';
            //tabla.Init();
            if tabla.FindLast() then begin
                num := tabla.getRec;
            end;
            //Commit();

        end;

    }

*/

    var
        num: text;
        tabla: Record temporal;
        temp: Record TempBlob temporary;
        eventHandler: Codeunit cuqr;

}
