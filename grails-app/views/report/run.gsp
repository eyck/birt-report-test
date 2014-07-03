<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Report Parameters</title>
        <g:javascript library="scriptaculous" />
        <script type="text/javascript" language="javascript">
        // <![CDATA[
	    function displayWait(){
		    Element.hide('form_pane');
		    Element.show('wait_indicator');
		    return true;
	    }
        // ]]>
        </script>
    </head>
    <body>
		<div class="nav">
		  <span class="menuButton"><a class="home" href="${resource(dir:'/')}">Home</a></span>
		  <span class="menuButton"><g:link class="list" action="list">List reports</g:link></span>
		</div>
        <div class="body">
            <div id="wait_indicator" style="display: none;text-align:center;padding-top:50px;">
                <b>Generating Report, please wait...</b><br/><br/>
      	        <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Working..." />
            </div>
            <div id="form_pane">
            <h1>Enter Parameters for the ${id } report</h1>
            <g:if test="${message}">
            	<div class="message">${message}</div>
            </g:if>
            <g:if test="${error }">
	            <div class="errors">${error}</div>
            </g:if>
            <g:form action="view" method="post" id="${id}" onSubmit="displayWait()">
            <div class="dialog">
                <table>
                    <tbody>
                    <g:each var="p" in="${parameters}">
                    <g:if test="${p.defaultVal && !reportParams[showAll]}" >
                    	<input type="hidden" name="${p.name}" value="${reportParams[p.defaultVal]}" /> 
                    </g:if><g:else>
                        <tr class="prop">
                            <td valign="top" class="name"><label for='${p.name}'>${p.promptText?:p.name}:</label></td>
                            <td valign="top" class="value">
                            	<g:if test="${p.type==7}">
									<g:if test="${showAll ||!reportParams[p.name]}">
    	                        		<g:if test="${reportParams[p.name]}">
        		          					<g:datePicker name="${p.name}" value="${reportParams[p.name]}" precision="day" />
                	            		</g:if><g:else>
                  							<g:datePicker name="${p.name}" value="" precision="day" />
                  						</g:else>
									</g:if><g:else>
										<g:textField name="${p.name}" value="${reportParams[p.name]}" class="readonly" readonly="readonly"/>
									</g:else>
                            	</g:if><g:else>
									<g:if test="${showAll!=null || reportParams[p.name]==null }">
	                            		<g:if test="${p.listEntries?.size()>0}">
                                			<g:select name="${p.name}" from="${p.listEntries}"
                										value="${reportParams[p.name]?:p.defaultVal}"
          												optionKey="value" optionValue="label"/>
                	            		</g:if><g:else>
	                           				<g:textField name="${p.name}" value="${reportParams[p.name]?:p.defaultVal}" />
	                            		</g:else>
									</g:if><g:else>
										<g:textField name="${p.name}" value="${reportParams[p.name]}" class="readonly" readonly="readonly"/>
                            		</g:else>
                            	</g:else>
                            	<g:if test="${!p.allowBlank }"><span class="unit">(Required)</span></g:if>
                            </td>
                            <td valign="top" class="value">${p.helpText}</td>
                        </tr>
                        </g:else>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
				<g:submitButton class="save" name="run" value="View Report" />&nbsp;&nbsp;&nbsp;
            </div>
            </g:form>
            </div>
        </div>
    </body>
</html>
