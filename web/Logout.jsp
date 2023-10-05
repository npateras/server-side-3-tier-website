<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head></head>
<body>
    <%
        //Invalidate tin session
        request.getSession().invalidate();
        //Katharise to cache
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");
        //Metafere ton xristi stin arxiki selida
        response.sendRedirect("index.jsp");
    %>
</body>
</html>
