codeunit 50876 codeUnitWS
{
    procedure Refresh();
    var
        ft: Record facturasTimbradas;
        ftc: Record Conceptos;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
        i: Integer;
        t: JsonToken;
        txtSplitCer: Text;
        values: List of [Text];
        item: Text;
        Lenght: Integer;
        txtSplit: Text;
        txtSplit2: Text;
        j: Integer;
        cont: Integer;
        base: Codeunit base64;
        rfcReceptor: Text;
    begin
        //ftc.DeleteAll;
        //ft.DeleteAll;
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        if not HttpClient.Get('https://jor13.github.io/ALCurso/', ResponseMessage)
        then
            Error('La llamada al servicio web falló.');
        if not ResponseMessage.IsSuccessStatusCode then
            error('El servicio web devolvió el siguiente mensaje:\\' + 'Respuesta: %1\' + 'Description: %2',
                  ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);

        if not JsonArray.ReadFrom(JsonText) then
            Error('Respuesta invalida, Se espera un JSON array como objeto');

        foreach t in JsonArray do begin
            // for i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, JsonToken);
            JsonObject := JsonToken.AsObject;
            ft.init;
            txtSplitCer := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.Certificado').AsValue.AsText();
            Lenght := StrLen(txtSplitCer);
            txtSplit := txtSplitCer.Substring(1, Lenght / 2);
            txtSplit2 := txtSplitCer.Substring(Lenght / 2);
            ft.CertificadoCadena := (txtSplit);
            ft.CertificadoCadenaPart2 := (txtSplit2);
            ft.tipoDeComprobante := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.TipoDeComprobante').AsValue.AsText();
            ft."Metodo de pago" := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.MetodoPago').AsValue.AsText();
            ft."Lugar de expedición" := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.LugarExpedicion').AsValue.AsText();
            ft.Moneda := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.Moneda').AsValue.AsText();
            ft."Regimen Fiscal" := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Emisor.RegimenFiscal').AsValue.AsText();
            ft.UsoCFDI := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Receptor.UsoCFDI').AsValue.AsText();
            ft.FormaDePago := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.FormaPago').AsValue.AsText();
            ft.Fecha := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.Fecha').AsValue.AsText();
            ft.Nombre := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Emisor.Nombre').AsValue.AsText;
            ft.RFC := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Emisor.Rfc').AsValue.AsText;
            ft.Folio := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.Folio').AsValue.AsText;
            ft.Subtotal := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.SubTotal').AsValue.AsDecimal();
            ft.IVA := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Impuestos.TotalImpuestosTrasladados').AsValue.AsDecimal();
            ft.Total := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.Total').AsValue.AsDecimal();
            ft.UUID := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Complemento.tfd:TimbreFiscalDigital.UUID').AsValue.AsText;
            ft.SelloDigitalCFD := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Complemento.tfd:TimbreFiscalDigital.SelloCFD').AsValue.AsText;
            ft.SelloSAT := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Complemento.tfd:TimbreFiscalDigital.SelloSAT').AsValue.AsText;
            ft.NoCertificado := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.NoCertificado').AsValue.AsText;
            ft.NoCertificadoSAT := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Complemento.tfd:TimbreFiscalDigital.NoCertificadoSAT').AsValue.AsText;
            ft.FechaTimbrado := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Complemento.tfd:TimbreFiscalDigital.FechaTimbrado').AsValue.AsText;
            rfcReceptor := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Receptor.Rfc').AsValue.AsText;

            ft."QR String" := 'https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx?id=' + ft.UUID + '%26re=' + ft.RFC + '%26rr=' + rfcReceptor + '%26tt=' + Format(ft.Total) + '%26fe=03316950';
            cont := (SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto').AsArray().Count());

            for j := 0 to cont - 1 do begin
                ftc.Init();
                ftc.Descripcion := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].Descripcion').AsValue.AsText;
                ftc.Cantidad := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].Cantidad').AsValue.AsDecimal();
                ftc.ClaveProdServ := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].ClaveProdServ').AsValue.AsText;
                ftc.ClaveUnidad := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].ClaveUnidad').AsValue.AsText;
                ftc.Importe := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].Importe').AsValue.AsDecimal();
                ftc.NoIdentificacion := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].NoIdentificacion').AsValue.AsText;
                ftc.Unidad := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].Unidad').AsValue.AsText;
                ftc.ValorUnitario := SelectJsonToken(JsonObject, '$.cfdi:Comprobante.cfdi:Conceptos.cfdi:Concepto.[' + Format(j) + '].ValorUnitario').AsValue.AsDecimal();
                ftc.Folio := ft.Folio;
                ftc.Insert();
                ftc.id := ftc.id + 1;
            end;
            if ft.Insert then begin
                ft.id := ft.id + 1;
                i += 1;
            end else begin
                Error('Las facturas ya han sido actualizadas');
            end;
        end;
        Commit();
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        Message('%1', JsonToken);
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('No se puede encontrar el nodo en la ruta %1', TokenKey);
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    var
        j: Integer;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('No se puede encontrar el nodo en  la ruta  %1', Path);
    end;

    /*
      procedure PaymentTerms()
      var
          pt: Record "Payment Terms";
      begin
          if pt.FindSet() then begin
              repeat begin
                  pt.Init();
                  if pt.Description = 'Contado' then begin
                      if pt.MetodoDePago <> '' then begin
                          pt.MetodoDePago := 'PUE';
                          pt.Modify();
                      end;
                  end else begin
                      if pt.MetodoDePago <> '' then begin
                          pt.MetodoDePago := 'PPD';
                          pt.Modify();
                      end;
                  end;
              end until pt.Next() = 0;
          end;
          Commit();
      end;
    */
}
