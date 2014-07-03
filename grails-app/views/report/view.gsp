<html>
  <head>
    <title>Report ${id}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
  </head>
  <body><div class="body">
	                <g:form action="run" name="paramForm">
						<input type="hidden" name="id" value="${id}">
						<input type="hidden" name="rerun" value="1">
						<g:each var="k" in="${reportParams.keySet() }">
	                    	<input type="hidden" name="${k}" value="${reportParams[k]}">
						</g:each>
	                </g:form>
                <div class="nav">
					<span class="menuButton"><g:link class="home" href="${resource(dir:'/')}">Home</g:link></span>
				    <span class="menuButton"><g:link class="list" action="list">List reports</g:link></span>
					<span class="menuButton"><g:link class="edit" action="run" onClick="javascript:document.forms.paramForm.submit();return false;">Change Parameters</g:link></span>
					<span class="menuButton"><g:link class="save" action="view" id="${id} " params="${reportParams}">
						Permanent link to this Report
					</g:link></span>
					
					<span class="menuButton"><b>Download as: </b></span>
          <!-- ${reportParams.format ="pdf" }  -->
					<span class="menuButton"><g:link class="pdf" action="downloadAs" id="${id }.pdf" params="${reportParams}">PDF</g:link></span>
					<!-- ${reportParams.format ="html" } -->
					<span class="menuButton"><g:link class="html" action="downloadAs" id="${id }.html" params="${reportParams}">HTML</g:link></span>
          <!-- ${reportParams.format ="xls" } -->
					<span class="menuButton"><g:link class="xls"  action="downloadAs" id="${id }.xls"  params="${reportParams}">XLS</g:link></span>
          <!-- ${reportParams.format ="doc" } -->
					<span class="menuButton"><g:link class="doc"  action="downloadAs" id="${id }.doc"  params="${reportParams}">DOC</g:link></span>
          <!-- ${reportParams.format ="ppt" } -->
					<span class="menuButton"><g:link class="ppt"  action="downloadAs" id="${id }.ppt"  params="${reportParams}">PPT</g:link></span>
          <!-- ${reportParams.format ="odt" } -->
          <span class="menuButton"><g:link class="odt"  action="downloadAs" id="${id }.odt"  params="${reportParams}">ODT</g:link></span>
          <!-- ${reportParams.format ="ods" } -->
          <span class="menuButton"><g:link class="ods"  action="downloadAs" id="${id }.ods"  params="${reportParams}">ODS</g:link></span>
          <!-- ${reportParams.format ="odp" } -->
          <span class="menuButton"><g:link class="odp"  action="downloadAs" id="${id }.odp"  params="${reportParams}">ODP</g:link></span>
					<!-- ${reportParams.remove('format') } -->
                 </div>
        </div>
		<div class="report">
		<div class="report-inner">
${reportContent}
		</div>
		</div>
	</body>
</html>
