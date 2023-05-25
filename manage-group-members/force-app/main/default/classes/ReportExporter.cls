global class ReportExporter {
    @InvocableMethod(label='Send Report Export' description='Add report id,report name and recipient email addresses')
    public static void exportAndSendReport(List<ReportInput> inputs) {

        Set<Id> reportIds = new Set<Id>();
        Set<String> recipientEmails = new Set<String>();
        Set<String> reportName = new Set<String>();
        for (ReportInput input : inputs) {
            reportIds.add(input.reportId);
            recipientEmails.add(input.recipientEmail);
            reportName.add(input.reportName);
        }
        exportAndSendReports(reportIds, recipientEmails, reportName);
    }
    
    @future(callout=true)
    public static void exportAndSendReports(Set<Id> reportIds, Set<String> recipientEmails, Set<String> reportName){
        for (Id reportId : reportIds) {
            // Get the report content as a CSV
            ApexPages.PageReference report = new ApexPages.PageReference('/'+reportId+'?csv=1&exp=1&enc=UTF-8&isdtp=p1');
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName(reportName+'.csv');
            attachment.setBody(Blob.valueof(report.getContent().toString()));
            attachment.setContentType('text/csv');
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            message.setSubject('Scheduled Report- '+reportName);
            message.setPlainTextBody('The report is attached.');
            message.setToAddresses( new List<String>(recipientEmails) );
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        }
    }
    
    public class ReportInput {
        @InvocableVariable(required=true)
        public String recipientEmail;
        
        @InvocableVariable(required=true)
        public String reportName;
        
        @InvocableVariable(required=true)
        public Id reportId;
    }
}