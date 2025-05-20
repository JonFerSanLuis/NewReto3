<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Confirmación de Partida</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            text-align: center;
            padding-top: 50px;
        }
        .card {
            background-color: white;
            padding: 30px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            max-width: 400px;
        }
        .codigo {
            font-size: 24px;
            font-weight: bold;
            color: #007BFF;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Partida creada con éxito</h2>
    
    <p>Tu código de acceso es:</p>
    <p class="codigo">${param.codigo}</p>

    <p>Se ha enviado un correo al responsable del centro con los detalles de la partida.</p>

    <br/>
    <a href="organizarPartida.jsp">← Volver a organizar otra partida</a>
</div>

</body>
</html>
