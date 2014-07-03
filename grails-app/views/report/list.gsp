<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>Report List</title>
  </head>
  <body>
    <div class="nav">
      <span class="menuButton"><a href="${resource(dir:'/')}" class="home">Home</a></span>
      <span class="menuButton"><g:link class="list" action="files">Up- or download Files</g:link></span>
    </div>
    <div class="body">
      <h1>Report List</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:if test="${flash.error}">
        <div class="errors">${flash.error}</div>
      </g:if>
            <div class="list">
      <table>
        <thead>
          <tr>
            <th width="20%">Name</th>
            <th width="20%">Title</th>
            <th width="20%">Author</th>
            <th width="40%">Description</th>
          </tr>
        </thead>
        <tbody>
          <g:each var="report" in="${reportList}" status="i">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:link action="run" id="${report.name}">${report.name}</g:link></td>
            <td>${report.title}</td>
            <td>${report.author}</td>
            <td>${report.description}</td>
            </tr>
          </g:each>
        </tbody>
      </table>
</div>
    </div>
  </body>
</html>
