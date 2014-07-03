<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>Report Directory List</title>
  </head>
  <body>
    <div class="nav">
      <span class="menuButton"><a class="home" href="${createLinkTo(dir:'/')}">Home</a></span>
      <span class="menuButton"><g:link class="list" action="list">List reports</g:link></span>
    </div>
    <div class="body">
      <h1>Report Directory List</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <table>
        <thead>
          <tr>
            <th>File Name</th>
          </tr>
        </thead>
        <tbody>
          <g:each var="file" in="${files}">
            <tr>
            <td><g:link action="download" params="[name:file]">${file}</g:link></td>
            </tr>
          </g:each>
        </tbody>
      </table>
      <hr/>
      <h1>Upload a new File</h1>
      <div class="dialog" id="form_pane">
        <g:form action="upload" method="post" enctype="multipart/form-data">
          <input type="file" name="reportFile" />
          <br />
          <div class="buttons">
            <span class="button">
              <input class="files" type="submit" value="Upload" />
            </span>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
