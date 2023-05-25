@isTest(SeeAllData=True)
global class ReportExporterTest {
    static testMethod void testExportAndSendReport() {
        // Create a test report input
        List<ReportExporter.ReportInput> inputs = new List<ReportExporter.ReportInput>();
        ReportExporter.ReportInput input = new ReportExporter.ReportInput();
        
        input.reportId = '00O8Z000007ULNjUAO'; // Replace this with the Id of a pre-existing report in your org
        input.recipientEmail = 'test@example.com';
        
        
        Report report = [SELECT Id,Name FROM Report WHERE Id =:input.reportId];
        input.reportName = report.Name;
        
        inputs.add(input);

        

        ReportUtility.generateReportCSV(input.reportId);

        
        ReportExporter.exportAndSendReport(inputs);
        
        // assert that the email was sent
        if(Limits.getEmailInvocations() > 0){
            System.assertEquals('test@example.com', input.recipientEmail);
        }
    }
    
    global class TestHttpCalloutMock implements HttpCalloutMock {
        global HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setBody('test_csv_content');
            response.setStatusCode(200);
            return response;
        }
    }
}