page 50874 facturas
{
    PageType = List;
    SourceTable = facturasTimbradas;
    CaptionML = ENU = 'Facturas timbradas';
    Editable = false;
    SourceTableView = order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Fecha; Fecha)
                {
                    ApplicationArea = All;
                }
                field(CertificadoCadena; CertificadoCadena)
                {
                    ApplicationArea = All;
                }

                field(CertificadoCadenaPart2; CertificadoCadenaPart2)
                {
                    ApplicationArea = All;
                }

                field(Descripcion; Descripcion)
                {
                    ApplicationArea = All;
                }
                field(FechaTimbrado; FechaTimbrado)
                {
                    ApplicationArea = All;
                }
                field(Folio; Folio)
                {
                    ApplicationArea = All;
                }
                field(FormaDePago; FormaDePago)
                {
                    ApplicationArea = All;
                }
                field(IVA; IVA)
                {
                    ApplicationArea = All;
                }
                field("Lugar de expedición"; "Lugar de expedición")
                {
                    ApplicationArea = All;
                }
                field("Metodo de pago"; "Metodo de pago")
                {
                    ApplicationArea = All;
                }
                field(Moneda; Moneda)
                {
                    ApplicationArea = All;
                }
                field(NoCertificado; NoCertificado)
                {
                    ApplicationArea = All;
                }
                field(NoCertificadoSAT; NoCertificadoSAT)
                {
                    ApplicationArea = All;
                }
                field(Nombre; Nombre)
                {
                    ApplicationArea = All;
                }
                field(RFC; RFC)
                {
                    ApplicationArea = All;
                }
                field("Regimen Fiscal"; "Regimen Fiscal")
                {
                    ApplicationArea = All;
                }
                field(SelloDigitalCFD; SelloDigitalCFD)
                {
                    ApplicationArea = All;
                }
                field(SelloSAT; SelloSAT)
                {
                    ApplicationArea = All;
                }
                field(Subtotal; Subtotal)
                {
                    ApplicationArea = All;
                }

                field(Total; Total)
                {
                    ApplicationArea = All;
                }
                field(UUID; UUID)
                {
                    ApplicationArea = All;
                }
                field(UsoCFDI; UsoCFDI)
                {
                    ApplicationArea = All;
                }
                field(id; id)
                {
                    ApplicationArea = All;
                }

                field(tipoDeComprobante; tipoDeComprobante)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshList)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Refrescar lista';
                Promoted = true;
                PromotedCategory = Process;
                Image = CalculateLines;
                trigger OnAction();
                begin
                    RefreshList();
                    CurrPage.Update;
                    if FindFirst then;
                end;
            }

            action(Reporte)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                //reporte: Report ReporteCFDI;
                begin
                    //reporte.RunModal();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        //RefreshIssues();
        //if FindFirst then;
    end;
}