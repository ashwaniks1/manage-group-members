import { LightningElement, track } from 'lwc';
import getReportData from '@salesforce/apex/ReportController.getReportData';

export default class rs_selectreporttoschedule_lwc extends LightningElement {
    @track data;
    @track nameFilter = '';
    @track statusFilter = '';
    @track error;

    exportToCSV() {
        getReportData({ nameFilter: this.nameFilter, statusFilter: this.statusFilter, exportType: 'csv' })
            .then(result => {
                var file = new Blob([result], { type: 'application/csv' });
                var fileURL = URL.createObjectURL(file);
                var link = document.createElement('a');
                link.href = fileURL;
                link.download = 'report.csv';
                link.click();
            })
            .catch(error => {
                this.error = error;
            });
    }

    exportToExcel() {
        getReportData({ nameFilter: this.nameFilter, statusFilter: this.statusFilter, exportType: 'excel' })
            .then(result => {
                var file = new Blob([result], { type: 'application/vnd.ms-excel' });
                var fileURL = URL.createObjectURL(file);
                var link = document.createElement('a');
                link.href = fileURL;
                link.download = 'report.xls';
                link.click();
            })
            .catch(error => {
                this.error = error;
            });
    }

    exportToPDF() {
        getReportData({ nameFilter: this.nameFilter, statusFilter: this.statusFilter, exportType: 'pdf' })
            .then(result => {
                var file = new Blob([result], { type: 'application/pdf' });
                var fileURL = URL.createObjectURL(file);
                var link = document.createElement('a');
                link.href = fileURL;
                link.download = 'report.pdf';
                link.click();
            })
            .catch(error => {
                this.error = error;
            });
    }
}