<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    HttpSession sesion = request.getSession();
    com.bilbaoskp.model.Centro centro = (com.bilbaoskp.model.Centro) sesion.getAttribute("centro");
    request.setAttribute("centro", centro);
%>

<html>
<head>
    <title>Organizar Partida</title>
</head>
<body>
    <c:choose>
        <c:when test="${empty cookie.tipo || cookie.tipo.value != 'centro'}">
            <h2>El centro educativo no está registrado.</h2>
        </c:when>
        <c:otherwise>
            <h2>Organizar Partida - Escape contra el Acoso y Ciberbullying</h2>
            <form action="ProcesarPartidaServlet" method="post">
                <label>Fecha de activación:</label>
                <input type="date" name="fechaActivacion" required /><br /><br />

                <label>Nombre de la clase / descripción:</label>
                <input type="text" name="nombreClase" maxlength="100" required /><br /><br />

                <label>Cantidad:</label>
                <input type="number" name="cantidad" min="1" required /><br /><br />

                <label>Idioma:</label>
                <select name="idioma">
                    <option value="es">Español</option>
                    <option value="en">Inglés</option>
                    <option value="eu">Euskera</option>
                </select><br /><br />

                <input type="submit" value="Generar Código de Acceso" />
            </form>
        </c:otherwise>
    </c:choose>
</body>
</html>
