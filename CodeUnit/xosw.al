codeunit 50137 Cyberpay
{
    trigger OnRun()
    begin

    end;


    procedure Login()
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestBodyObject: JsonObject;
        ResponseObject: JsonObject;
        DataObject: JsonObject;
        AccessTokenObject: JsonObject;
        RefreshTokenObject: JsonObject;
        UserObject: JsonObject;
        JsonToken: JsonToken;
        ResponseText: Text;
        RequestBody: Text;
        Setup: Record "PenRemit Setup";
    begin
        Setup.Get('SETUP');

        RequestBodyObject.Add('email', Setup.Email);
        RequestBodyObject.Add('password', Setup.Password);
        RequestBodyObject.Add('rememberMe', true);
        RequestBodyObject.WriteTo(RequestBody);

        Content.WriteFrom(RequestBody);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');

        RequestMessage.Method := 'POST';
        RequestMessage.SetRequestUri(Setup."Base URL" + Setup."Login URL");
        RequestMessage.Content := Content;

        if not Client.Send(RequestMessage, ResponseMessage) then
            Error('Failed to connect to PenRemit.');

        ResponseMessage.Content.ReadAs(ResponseText);

        if not ResponseMessage.IsSuccessStatusCode() then
            Error(ResponseText);

        ResponseObject.ReadFrom(ResponseText);

        ResponseObject.Get('data', JsonToken);
        DataObject := JsonToken.AsObject();

        // Access Token
        DataObject.Get('accessToken', JsonToken);
        AccessTokenObject := JsonToken.AsObject();

        AccessTokenObject.Get('token', JsonToken);
        Setup."Access Token" := JsonToken.AsValue().AsText();

        AccessTokenObject.Get('expiryDate', JsonToken);
        Evaluate(Setup."Access Token Expiry", JsonToken.AsValue().AsText());

        // Refresh Token
        DataObject.Get('refreshToken', JsonToken);
        RefreshTokenObject := JsonToken.AsObject();

        RefreshTokenObject.Get('token', JsonToken);
        Setup."Refresh Token" := JsonToken.AsValue().AsText();

        RefreshTokenObject.Get('expiryDate', JsonToken);
        Evaluate(Setup."Refresh Token Expiry", JsonToken.AsValue().AsText());

        // User
        DataObject.Get('user', JsonToken);
        UserObject := JsonToken.AsObject();

        UserObject.Get('id', JsonToken);
        Evaluate(Setup."User ID", JsonToken.AsValue().AsText());

        UserObject.Get('username', JsonToken);
        Setup.Username := JsonToken.AsValue().AsText();

        UserObject.Get('companyName', JsonToken);
        Setup."Company Name" := JsonToken.AsValue().AsText();

        UserObject.Get('employerCode', JsonToken);
        Setup."Employer Code" := JsonToken.AsValue().AsText();

        UserObject.Get('role', JsonToken);
        Setup.Role := JsonToken.AsValue().AsText();

        UserObject.Get('roleCategory', JsonToken);
        Setup."Role Category" := JsonToken.AsValue().AsText();

        UserObject.Get('defaultBranchId', JsonToken);
        Setup."Default Branch ID" := JsonToken.AsValue().AsInteger();

        Setup.Modify();
    end;

    procedure GetAccessToken(): Text
    var
        Setup: Record "PenRemit Setup";
    begin
        Setup.Get('SETUP');

        if (Setup."Access Token" = '') or
           (CurrentDateTime >= Setup."Access Token Expiry")
        then begin
            Login();
            Setup.Get('SETUP');
        end;

        exit(Setup."Access Token");
    end;






    procedure GetPfcReportSchedules(): Text
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeaders: HttpHeaders;
        ResponseText: Text;
        Setup: Record "PenRemit Setup";
    begin
        Setup.Get('SETUP');

        RequestMessage.Method := 'GET';
        RequestMessage.SetRequestUri(
            Setup."Base URL" +
            Setup."Schedule URL");

        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

        if not Client.Send(RequestMessage, ResponseMessage) then
            Error('Failed to send request.');

        ResponseMessage.Content.ReadAs(ResponseText);

        if not ResponseMessage.IsSuccessStatusCode() then
            Error('Status %1 : %2',
                ResponseMessage.HttpStatusCode(),
                ResponseText);

        exit(ResponseText);
    end;

    procedure ImportPfcReportSchedules()
    var
        JsonBody: Text;
        RootObject: JsonObject;
        DataToken: JsonToken;
        DataArray: JsonArray;
        RowToken: JsonToken;
        RowObject: JsonObject;
        ScheduleDetail: Record "Penremit Get Schedule";
    begin
        // STEP 1: Get the JSON body from the API
        JsonBody := GetPfcReportSchedules();

        // STEP 2: Parse it and pull out the array of rows
        if not RootObject.ReadFrom(JsonBody) then
            Error('The PFC report response could not be parsed as JSON.');

        if not RootObject.Get('data', DataToken) then
            Error('The PFC report response did not contain a "data" array.');

        DataArray := DataToken.AsArray();

        // STEP 3: Loop through each row and write it into the table
        foreach RowToken in DataArray do begin
            RowObject := RowToken.AsObject();

            if not ScheduleDetail.Get(GetJsonGuid(RowObject, 'scheduleId')) then begin
                ScheduleDetail.Init();
                ScheduleDetail."Schedule Id" := GetJsonGuid(RowObject, 'scheduleId');
                ScheduleDetail.Insert();
            end;

            ScheduleDetail."Employer Id" := GetJsonInteger(RowObject, 'employerId');
            ScheduleDetail."Created On" := GetJsonDateTime(RowObject, 'createdOn');
            ScheduleDetail.Comment := CopyStr(GetJsonText(RowObject, 'comment'), 1, MaxStrLen(ScheduleDetail.Comment));
            ScheduleDetail."Total Amount" := GetJsonDecimal(RowObject, 'totalAmount');
            ScheduleDetail."Schedule Name" := CopyStr(GetJsonText(RowObject, 'scheduleName'), 1, MaxStrLen(ScheduleDetail."Schedule Name"));
            ScheduleDetail."Employer Code" := CopyStr(GetJsonText(RowObject, 'employerCode'), 1, MaxStrLen(ScheduleDetail."Employer Code"));
            ScheduleDetail."Employer Name" := CopyStr(GetJsonText(RowObject, 'employerName'), 1, MaxStrLen(ScheduleDetail."Employer Name"));
            ScheduleDetail."Transaction Reference" := CopyStr(GetJsonText(RowObject, 'transactionReference'), 1, MaxStrLen(ScheduleDetail."Transaction Reference"));
            ScheduleDetail."Payment Reference" := CopyStr(GetJsonText(RowObject, 'paymentReference'), 1, MaxStrLen(ScheduleDetail."Payment Reference"));
            ScheduleDetail."Payment Status" := CopyStr(GetJsonText(RowObject, 'paymentStatus'), 1, MaxStrLen(ScheduleDetail."Payment Status"));
            ScheduleDetail."Payment Method" := CopyStr(GetJsonText(RowObject, 'paymentMethod'), 1, MaxStrLen(ScheduleDetail."Payment Method"));
            ScheduleDetail."Schedule Reference" := CopyStr(GetJsonText(RowObject, 'scheduleReference'), 1, MaxStrLen(ScheduleDetail."Schedule Reference"));
            ScheduleDetail."PFC Reference" := CopyStr(GetJsonText(RowObject, 'pfcReference'), 1, MaxStrLen(ScheduleDetail."PFC Reference"));
            ScheduleDetail."PFC Name" := CopyStr(GetJsonText(RowObject, 'pfcName'), 1, MaxStrLen(ScheduleDetail."PFC Name"));
            ScheduleDetail."Payment Date" := GetJsonDateTime(RowObject, 'paymentDate');
            ScheduleDetail."Schedule Detail Count" := GetJsonInteger(RowObject, 'scheduleDetailCount');
            ScheduleDetail."PFA Code" := CopyStr(GetJsonText(RowObject, 'pfaCode'), 1, MaxStrLen(ScheduleDetail."PFA Code"));
            ScheduleDetail."PFA Name" := CopyStr(GetJsonText(RowObject, 'pfaName'), 1, MaxStrLen(ScheduleDetail."PFA Name"));
            ScheduleDetail."PFA Reference" := CopyStr(GetJsonText(RowObject, 'pfaReference'), 1, MaxStrLen(ScheduleDetail."PFA Reference"));

            ScheduleDetail.Modify();
        end;
    end;

    local procedure GetJsonText(JObj: JsonObject; KeyName: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObj.Get(KeyName, JToken) then
            if not JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsText());
        exit('');
    end;

    local procedure GetJsonInteger(JObj: JsonObject; KeyName: Text): Integer
    var
        JToken: JsonToken;
    begin
        if JObj.Get(KeyName, JToken) then
            if not JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsInteger());
        exit(0);
    end;

    local procedure GetJsonDecimal(JObj: JsonObject; KeyName: Text): Decimal
    var
        JToken: JsonToken;
    begin
        if JObj.Get(KeyName, JToken) then
            if not JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsDecimal());
        exit(0);
    end;

    local procedure GetJsonGuid(JObj: JsonObject; KeyName: Text): Guid
    var
        JToken: JsonToken;
        GuidValue: Guid;
    begin
        if JObj.Get(KeyName, JToken) then
            if not JToken.AsValue().IsNull() then
                Evaluate(GuidValue, JToken.AsValue().AsText());
        exit(GuidValue);
    end;

    local procedure GetJsonDateTime(JObj: JsonObject; KeyName: Text): DateTime
    var
        JToken: JsonToken;
    begin
        if JObj.Get(KeyName, JToken) then
            if not JToken.AsValue().IsNull() then
                exit(ParseApiDateTime(JToken.AsValue().AsText()));
        exit(0DT);
    end;


    local procedure ParseApiDateTime(DateTimeText: Text): DateTime
    var
        ParsedDateTime: DateTime;
    begin
        if DateTimeText = '' then
            exit(0DT);

        if not Evaluate(ParsedDateTime, DateTimeText) then
            Error('Invalid DateTime: %1', DateTimeText);

        exit(ParsedDateTime);
    end;



    procedure GetScheduleDetailsByReference(Reference: Text; PfaCode: Text): Text
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeaders: HttpHeaders;
        ResponseText: Text;
        Url: Text;
        BearerToken: Text;
    begin
        Url := StrSubstNo(
            'https://penremit-api.cyberpay.ng/api/v1/report/schedules/details/by-reference/%1?pageNumber=1&pageSize=20&pfaCode=%2',
            Reference, PfaCode);

        BearerToken := GetBearerToken(); // see note below - pull from IsolatedStorage, don't hardcode

        RequestMessage.Method := 'GET';
        RequestMessage.SetRequestUri(Url);
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Authorization', 'Bearer ' + BearerToken);

        if not Client.Send(RequestMessage, ResponseMessage) then
            Error('Failed to send request to PenRemit schedule details endpoint.');

        if not ResponseMessage.IsSuccessStatusCode() then
            Error('Request failed. Status code: %1', ResponseMessage.HttpStatusCode());

        ResponseMessage.Content.ReadAs(ResponseText);
        exit(ResponseText);
    end;

    local procedure GetBearerToken(): Text
    begin
        // TODO: retrieve from IsolatedStorage instead of hardcoding
        exit('');
    end;

    var
        myInt: Integer;
}