<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Cookie[] cookies = request.getCookies();
    String username = null;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("usuario".equals(cookie.getName())) {
                username = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error al enviar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fdecea;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .mensaje-container {
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #e53935;
            margin-bottom: 20px;
        }
        p {
            color: #555555;
            font-size: 18px;
            margin-bottom: 30px;
        }
        a {
            text-decoration: none;
            background: #e53935;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background 0.3s;
        }
        a:hover {
            background: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="mensaje-container">
        <h1>¡Ups! Algo salió mal</h1>
        <p>No pudimos enviar tu mensaje. Intenta de nuevo más tarde.</p>
        <a href="contacto.jsp">Volver al formulario</a>
    </div>
</body>
</html>