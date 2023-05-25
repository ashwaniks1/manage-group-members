global class Exporter implements System.Schedulable {
    
    @InvocableMethod(label='Report Export' description='Add report id, recipient email, subject')
    public static void DoExport(List<ReportInput> inputs) {
        for (ReportInput input : inputs) {
            ApexPages.PageReference report = new ApexPages.PageReference('/' + input.reportId + '?csv=1&exp=1&enc=UTF-8&isdtp=p1');
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('report.csv');
            attachment.setBody(Blob.valueof(report.getContent().toString()));
            attachment.setContentType('text/csv');
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            message.setSubject('Scheduled Report: '+input.reportName);
            message.setPlainTextBody('The report is attached.');
            message.setToAddresses( new String[] { input.recipientEmail } );
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        }
    }
    global void execute(SchedulableContext sc) {
        List<ReportInput> inputs = new List<ReportInput>();
        // Add data to inputs
        DoExport(inputs);
    }
    
    public class ReportInput {
        @InvocableVariable(required=true)
        public String reportId;
        @InvocableVariable(required=true)
        public String recipientEmail;
        @InvocableVariable(required=true)
        public String reportName;
    }
}