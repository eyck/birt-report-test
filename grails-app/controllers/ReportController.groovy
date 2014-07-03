
class ReportController {

    def birtReportService
    
    def reportScanService

    def index = { redirect(action:list) }
	def list = {
		["reportList":Report.list()]
	}

	def run = {
		if(params.id==null) {
			redirect(action:list)
		} else {
			def rerun = params.remove('rerun')
			def reportName = params.remove('id')
			params.remove('controller')
			params.remove('action')
			params.remove('run')
			params.remove('submit')
			def reportParams = params
			def missing = []
			def pars = birtReportService.getReportParams(reportName)
			if(pars==null) {
				flash.error = "Could not find the Report ${reportName}!"
				redirect(action:list)
			} else {
				pars.each { p ->
					if( !(reportParams[p.name] || p.allowBlank) ) missing << p.name
				}
				if(missing.size == 0 && rerun==null) {
					log.debug "No parameter missing, running report"
					redirect(action:view, id:reportName, params:reportParams)
				} else {
					if(rerun)
						return ['id':reportName, 'reportParams':reportParams, 'parameters':pars, 'showAll':1]
					else
						return ['id':reportName, 'reportParams':reportParams, 'parameters':pars]
				}
			}
		}
    }
    
	def	view = {
    	if(params.list) {
    		redirect(action:list)
		} else {
	    	log.debug "Generating report with ${params}"
			def reportName=params.remove('id')
			params.remove('controller')
			params.remove('action')
	    	params.remove('view')
	    	params.remove('run')
			HashMap reportParams = []
			// Set the values of the parameter.
			def missing = []
			def pars = birtReportService.getReportParams(reportName)
			if(pars==null) {
				flash.error = "Could not find the Report ${reportName}!"
				redirect(action:list)
			} else {
				pars.each { p ->
                    switch(p.type){
                    case 4: // DateTime
                    case 7: // Date
                        if(params[p.name]=="struct")
                            reportParams[p.name] = params[p.name+"_month"] + "/" + params[p.name+"_day"] + "/" + params[p.name+"_year"]
                        else {
                            if(!params[p.name] && !p.allowBlank ) missing << p.name
                        }
                        break
                     case 5: // Boolean
                        if(params[p.name])
                            reportParams[p.name] = true
                        else
                            reportParams[p.name] = false
                        break
                     default:
                        reportParams[p.name] = params[p.name]
                        if( !(params[p.name] || p.allowBlank) ) missing << p.name
                    }
				}
				if(missing.size) {
					flash.error ="Report ${params.reportName} is missing the required parameters: ${missing.join(',')}"
					reportParams['rerun']=true
					redirect(action:run, id:reportName, params:reportParams)
				} else {
					//get report name and launch the engine
					def htmlOptions = birtReportService.getRenderOption(request, "html")
					htmlOptions.setEmbeddable(true)
					try {
						return ['reportContent':birtReportService.runAndRender(reportName, reportParams, htmlOptions).toString(), 'id':reportName, 'reportParams':reportParams]
                    } catch(Exception e){
                        flash.error = "Report ${reportName} encountered an error: ${e.message}"
                        reportParams['rerun']=true
                        redirect(action:run, id:reportName, params:reportParams)
                    }
				}
			}
		}
	}

	def files = {
		def reportDir = new File(servletContext.getRealPath("/Reports"))
		def files = []
		reportDir.eachFile{ if(!it.directory) files<<it.name }
		["fileList":files]
	}

    def upload = {
        def f = request.getFile('reportFile')
        if(!f?.empty) {
        	f.transferTo( new File(servletContext.getRealPath("/Reports")+"/"+ f.getOriginalFilename().replaceAll(' ', '_')))
        	flash.message = "File '${f.getOriginalFilename()}' successfully uploaded"
        } else {
        	flash.message = "Uploaded file cannot be empty"
        }
    	reportScanService.scan()
        redirect('action':'list')
    }

    def downloadAs = {
		// get report name and launch the engine
		String reportName = params.id
		String reportExt = params.format?:'html'
		log.debug "Extenstion is ${reportExt}"
		def format = grailsApplication.config.grails.mime.types[reportExt]?reportExt:'html'
		// Set the value of the parameter.
		HashMap reportParams = params
		reportParams.remove('action')
	    reportParams.remove('controller')
	    reportParams.remove('name')
	    reportParams.remove('id')
		def options = birtReportService.getRenderOption(request, format)
		def result=birtReportService.runAndRender(reportName, reportParams, options)
		if(format=="html")
			render(contentType:'text/html',encoding:"UTF-8", text:result.toString())
		else {
		    response.setHeader("Content-disposition", "attachment; filename=\"${reportName}.${reportExt}\"");
		    response.contentType = grailsApplication.config.grails.mime.types[format.toLowerCase()]
		    response.outputStream << result.toByteArray()
			return false
		}
	}
}