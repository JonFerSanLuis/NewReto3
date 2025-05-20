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
    <title>Mensaje Enviado</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
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
            color: #4CAF50;
            margin-bottom: 20px;
        }
        p {
            color: #555555;
            font-size: 18px;
            margin-bottom: 30px;
        }
        a {
            text-decoration: none;
            background: #4CAF50;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background 0.3s;
        }
        a:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <div class="mensaje-container">
        <h1>¡Gracias por tu mensaje!</h1>
        <p>Nos pondremos en contacto contigo lo antes posible.</p>
        <a href="index.jsp">Volver al inicio</a>
    </div>
</body>
</html>