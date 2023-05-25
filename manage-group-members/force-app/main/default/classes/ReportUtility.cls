public class ReportUtility {
        @testVisible static Map<Id, String> testReportCsvMap = new Map<Id, String>();
    
    public static void createTestReportCsv(Id reportId, String csvContent) {
        testReportCsvMap.put(reportId, csvContent);
    }
    
    public static String getTestReportCsv(Id reportId) {
        return testReportCsvMap.get(reportId);
    }
    public static Blob generateReportCSV(Id reportId) {
        ApexPages.PageReference report = new ApexPages.PageReference('/'+reportId+'?csv=1&exp=1&enc=UTF-8&isdtp=p1');
        return Blob.valueof(report.getContent().toString());
    }
}