// Apex class to download Salesforce report via API
public class SalesforceReportDownloader {
    
    @InvocableMethod(label='Download Salesforce Report' description='Download Salesforce report via API')
    // Method to download report given the report ID or URL
    public static void downloadReport(List<ReportInput> reportInputs) {
        // Set the Salesforce REST API endpoint for reports
        String endpoint = '/services/data/v53.0/analytics/reports/';
        
        for (ReportInput reportInput : reportInputs) {
            // Append the report ID or URL to the endpoint
            String reportIdOrUrl = reportInput.reportIdOrUrl;
            String reportEndpoint = endpoint + reportIdOrUrl;
        
            // Create an HTTP request
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + reportEndpoint);
            request.setMethod('GET');
        
            // Set the authorization header with the access token
            request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        
            // Create a new HTTP instance
            Http http = new Http();
        
            // Send the HTTP request
            HttpResponse response = http.send(request);
        
            // Parse the JSON response
            Map<String, Object> reportData = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        
            // Extract the download link from the response
            Map<String, Object> factMap = (Map<String, Object>)reportData.get('factMap');
            Map<String, Object> tt = (Map<String, Object>)factMap.get('T!T');
            Map<String, Object> aggregates = (Map<String, Object>)tt.get('aggregates');
            List<Object> records = (List<Object>)aggregates.get('records');
            Map<String, Object> record = (Map<String, Object>)records[0];
            Map<String, Object> downloadUrls = (Map<String, Object>)record.get('downloadUrls');
            String downloadLink = (String)downloadUrls.get('csv');

            // Create a new HTTP request to download the report
            HttpRequest downloadRequest = new HttpRequest();
            downloadRequest.setEndpoint(downloadLink);
            downloadRequest.setMethod('GET');
        
            // Send the download request
            HttpResponse downloadResponse = http.send(downloadRequest);
        
            // Save the report data to a local file
            Blob reportBlob = downloadResponse.getBodyAsBlob();
            String fileName = 'report.csv';
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.Title = fileName;
            contentVersion.PathOnClient = fileName;
            contentVersion.VersionData = reportBlob;
            insert contentVersion;
        
            System.debug('Report downloaded successfully. ContentVersionId: ' + contentVersion.Id);
        }
    }
    
    public class ReportInput {
        @InvocableVariable(required=true label='Report ID or URL' description='The ID or URL of the report to download')
        public String reportIdOrUrl;
    }
}