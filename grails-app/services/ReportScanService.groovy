class ReportScanService {
	
    boolean transactional = true

    def birtReportService
    
    def scan() {
        def reports = birtReportService.listReports()
        def dbReports = Report.list()
		log.debug "Found reports: ${reports}"
        reports.each{
        	def report = Report.findByName(it.name)
        	if(!report)
				report = new Report()
        	else {
        		dbReports.remove(report)
        	}
        	report.author = it.author?:""
        	report.title = it.title?:""
        	report.createdBy = it.createdBy?:""
        	report.description = it.description?:""
        	report.comment=it.comment?:""
            report.units = it.units?:""
        	report.name = it.name?:""
        	report.file = it.file?:""
        	report.fullfile = it.fullfile?:""
        	report.helpGuide = it.helpGuide?:""
        	report.save()
        	def params = birtReportService.getReportParams(report.name)
        	log.debug "Found paramters: ${params}"
            params.each {
        		def param = ReportParameter.findByReportAndName(report, it[0] )
        		if(!param){
        			param = new ReportParameter()
        			param.report = report
            		param.name= it.name?:""
        		}
        		param.datatype = it.type?:"";
        		param.prompttext = it.promptText?:it.name;
        		param.allowblank = it.allowBlank?:"";
        		param.save()
        	}
			dbReports.each{
				log.warn "Deleting non-existing report from db: ${it.title}"
				it.delete()
			}
        }

    }
    
    def listReportForParameter(parameterName){
    	return Report.createCriteria().list{
    		reportParameters {
    			like('name', parameterName)
    		}
    	}
    }
}