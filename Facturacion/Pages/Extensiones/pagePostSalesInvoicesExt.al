pageextension 50456 pagePostSalesInvoicesExt extends 143
{
    actions
    {
        addfirst(Navigation)
        {
            group("Facturación electrónica HG")
            {
                Image = Invoice;
                action("PDF de la Factura")
                {
                    ApplicationArea = All;
                    Image = Report;
                    trigger OnAction()
                    var
                        reporte: Report ReporteCFDI;
                        cod: Codeunit codeUnitWS;
                        temp: Record temporal;
                        facturas: Record facturasTimbradas;

                    begin
                        //CurrPage.SetSelectionFilter(Rec);
                        //Message('%1', Rec."No.");
                        //reporte.UseRequestPage(false);
                        if facturas.FindSet() then begin
                            repeat begin
                                if (facturas.Folio = rec."No.") then begin
                                    temp.Init();
                                    temp.getRec := Rec."No.";
                                    temp.Insert();
                                    Commit();
                                    reporte.RunModal();
                                    temp.DeleteAll();
                                end;
                            end until facturas.Next = 0;
                        end;
                    end;
                }

                action("Timbrar facturas")
                {
                    ApplicationArea = All;
                    Image = AddAction;
                    trigger OnAction()
                    begin
                        HYPERLINK('http://192.168.1.73');
                    end;
                }

                action("Descargar XML")
                {
                    ApplicationArea = All;
                    Image = XMLFile;
                    trigger OnAction()
                    begin

                    end;
                }
            }
        }
    }
}


