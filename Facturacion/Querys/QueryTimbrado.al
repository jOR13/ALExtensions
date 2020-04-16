query 50754 WSTimbrado
{
    QueryType = Normal;
    Caption = 'WS-Timbrado';

    elements
    {
        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            //DataItemTableFilter = UUID = filter('');
            column(Folio; "No.") { }
            column(Serie; "Order No.") { }
            column(Fecha; "Posting Date") { }
            //column(FormaPago; "Payment Method Code") { }
            column(CondicionesDePago; "Due Date") { }
            column(Subtotal; Amount) { }
            column(Moneda; "Currency Code") { }
            column(TipoCabio; "Currency Factor") { }
            column(Total; "Amount Including VAT") { }
            //column(MetodoPago; "Payment Terms Code") { }
            column(Receptor_Nombre; "Sell-to Customer Name") { }
            column(Receptor_RFC; "VAT Registration No.") { }
            column(UsoCFDI; "CFDI Purpose") { }

            dataitem(SalesLineInfo; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";

                SqlJoinType = InnerJoin;

                dataitem(ArticuloInfo; Item)
                {
                    DataItemLink = "No." = SalesLineInfo."No.";
                    //column(RegimenFiscal; "SAT Item Classification") { }

                    dataitem(InformacionCompañia; "Company Information")
                    {
                        DataItemLink = "Country/Region Code" = Sales_Invoice_Header."VAT Country/Region Code";
                        //column(AmountIncludingVAT; "Amount Including VAT"){}
                        //column(LineDiscountAmount; "Line Discount Amount"){}
                        column(LugarDeExpedicion; "Post Code") { }
                        column(Emisor_RFC; "VAT Registration No.") { }
                        column(Emisor_Nombre; Name) { }
                        column(RegimenFiscal; "SAT Tax Regime Classification") { }


                        dataitem(Payment_Method; "Payment Method")
                        {
                            DataItemLink = Code = Sales_Invoice_Header."Payment Method Code";

                            column(FormaPago; Description) { }


                            dataitem(Payment_Terms1; "Payment Terms")
                            {
                                DataItemLink = Code = Sales_Invoice_Header."Payment Terms Code";

                                column(MetodoPago; MetodoDePago) { }
                            }
                        }

                    }

                }

            }

            /*


            */





        }
    }

    /*
     trigger OnBeforeOpen()
     var
         cu: Codeunit codeUnitWS;
     begin
         cu.PaymentTerms();
     end;
    */
}


