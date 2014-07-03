class ReportScanJob {
    static triggers = {
        simple(name:'someuniquename', startDelay:15000, repeatInterval: 60000, repeatCount: 0)
    }

    def group = "StartupGroup"

    def reportScanService
    
	def execute() {	
    	log.warn "Running report scan"
    	reportScanService.scan()
	}
}
