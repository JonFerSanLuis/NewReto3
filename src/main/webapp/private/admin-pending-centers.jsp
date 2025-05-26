<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<c:set var="idioma" value="${not empty sessionScope.idioma ? sessionScope.idioma : 'es'}" scope="session" />
<fmt:setLocale value="${idioma}" />
<fmt:setBundle basename="resources.messages" />

<!DOCTYPE html>
<html lang="es"> <%-- Reverted lang to es --%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Centros Pendientes</title> <%-- Reverted --%>
    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- CSS -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/pages/admin-usuarios.css"> <%-- Reusing admin-usuarios.css for now --%>
    <style>
        /* Additional styles specific to this page if needed */
        .header-simplified {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: #f8f9fa; /* Or your header background color */
            border-bottom: 1px solid #dee2e6; /* Optional border */
        }
        .header-simplified .logo img {
            height: 40px; /* Adjust as needed */
        }
        .header-simplified .nav-links {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
        }
        .header-simplified .nav-links li a {
            text-decoration: none;
            color: #333;
            padding: 0.5rem 1rem;
            font-weight: 500;
        }
        .header-simplified .nav-links li a.active {
            color: #007bff; /* Active link color */
        }
    </style>
</head>
<body>
    <header class="header-simplified">
        <div class="logo">
            <a href="../index.jsp"><img src="../img/logo.png" alt="Logo"></a>
        </div>
        <nav class="nav-container">
            <ul class="nav-links">
                 <li><a href="../PerfilServlet">Volver al Panel</a></li> <%-- Reverted --%>
                 <li><a href="AdminUsuarios?action=listar">Gestionar Usuarios</a></li> <%-- Reverted --%>
                 <li><a href="AdminUsuarios?action=listarPendientes" class="active">Gestionar Centros Pendientes</a></li> <%-- Reverted --%>
            </ul>
        </nav>
        <div class="right-section">
             <div class="idiomas">
                <img src="../img/idiomas.png" alt="Idiomas">
                <ul class="idioma-menu">
                    <li><a href="../CambiarIdioma?idioma=es&redirect=private/AdminUsuarios?action=listarPendientes">Español</a></li> <%-- Reverted --%>
                    <li><a href="../CambiarIdioma?idioma=en&redirect=private/AdminUsuarios?action=listarPendientes">English</a></li> <%-- Reverted --%>
                    <li><a href="../CambiarIdioma?idioma=eu&redirect=private/AdminUsuarios?action=listarPendientes">Euskera</a></li> <%-- Reverted --%>
                </ul>
            </div>
            <% if (username != null) { %>
                <a href="../PerfilServlet" class="btn">Perfil</a> <%-- Reverted --%>
                <a href="../CerrarSesionServlet" class="btn">Cerrar Sesión</a> <%-- Reverted --%>
            <% } else { %>
                <a href="../login.jsp" class="btn">Iniciar Sesión</a> <%-- Reverted --%>
            <% } %>
        </div>
    </header>

    <div class="main-content">
        <h1 class="page-title">Gestionar Centros Pendientes</h1> <%-- Reverted --%>

        <!-- Mensajes de éxito o error -->
        <c:if test="${not empty sessionScope.mensaje}">
            <div class="alert alert-success">
                ${sessionScope.mensaje}
                <c:remove var="mensaje" scope="session" />
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                ${sessionScope.error}
                <c:remove var="error" scope="session" />
            </div>
        </c:if>

        <div class="admin-container">
            <section class="pending-centers-table-section">
                <c:choose>
                    <c:when test="${empty listaCentrosPendientes}">
                        <p>No hay centros pendientes de aprobación.</p> <%-- Reverted --%>
                    </c:when>
                    <c:otherwise>
                        <div class="table-container">
                            <table class="users-table">
                                <thead>
                                    <tr>
                                        <th>ID</th> <%-- Reverted --%>
                                        <th>Nombre</th> <%-- Reverted --%>
                                        <th>Correo Electrónico</th> <%-- Reverted --%>
                                        <th>Tipo</th> <%-- Reverted --%>
                                        <th>Estado</th> <%-- Reverted --%>
                                        <th>Fecha Alta</th> <%-- Reverted --%>
                                        <th>Acciones</th> <%-- Reverted --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="centro" items="${listaCentrosPendientes}">
                                        <tr>
                                            <td>${centro.idSuscriptor}</td>
                                            <td>${centro.username}</td> <%-- Asumiendo que username es el responsable --%>
                                            <td>${centro.correo}</td>
                                            <td>${centro.tipo}</td>
                                            <td>
                                                <span class="status-badge status-pending">
                                                    ${centro.estado}
                                                </span>
                                            </td>
                                            <td><fmt:formatDate value="${centro.fechaAlta}" pattern="dd/MM/yyyy" /></td>
                                            <td class="actions">
                                                <form action="../AdminUsuarios" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="aceptarCentro">
                                                    <input type="hidden" name="id" value="${centro.idSuscriptor}">
                                                    <button type="submit" class="action-btn accept-btn" title="Aceptar"> <%-- Reverted --%>
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                                <button onclick="confirmarRechazarCentro(${centro.idSuscriptor}, '${centro.username}')" class="action-btn reject-btn" title="Rechazar"> <%-- Reverted --%>
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </div>
    </div>

    <!-- Modal de confirmación para rechazar centro -->
    <div id="modal-rechazar-centro" class="modal">
        <div class="modal-content">
            <span class="close-modal-rechazar-centro">&times;</span>
            <h2>Confirmar Rechazo de Centro</h2> <%-- Reverted --%>
            <p id="mensaje-confirmacion-rechazo"></p>
            <div class="modal-buttons">
                <button id="btn-cancelar-rechazar-centro" class="btn-secondary">Cancelar</button> <%-- Reverted --%>
                <form id="form-rechazar-centro" action="../AdminUsuarios" method="post">
                    <input type="hidden" name="action" value="rechazarCentro">
                    <input type="hidden" id="id-rechazar-centro" name="id" value="">
                    <button type="submit" class="btn-danger">Rechazar</button> <%-- Reverted --%>
                </form>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-container">
            <div class="copyright">
                © 2025 Educación Divertida. Todos los derechos reservados. <%-- Reverted footer.copyright --%>
            </div>
        </div>
    </footer>

    <script>
        // Script para el menú de idiomas
        document.addEventListener('DOMContentLoaded', function() {
            const idiomas = document.querySelector('.idiomas');
            if (idiomas) { // Check if idiomas element exists
                document.addEventListener('click', function(e) {
                    if (idiomas.contains(e.target)) {
                        idiomas.classList.toggle('activo');
                    } else {
                        idiomas.classList.remove('activo');
                    }
                });
            }
        });

        // Script para el modal de confirmación de rechazo de centro
        const modalRechazar = document.getElementById('modal-rechazar-centro');
        const mensajeConfirmacionRechazo = document.getElementById('mensaje-confirmacion-rechazo');
        
        function confirmarRechazarCentro(id, nombre) {
            if (modalRechazar) { // Check if modalRechazar element exists
                document.getElementById('id-rechazar-centro').value = id;
                mensajeConfirmacionRechazo.textContent = '¿Está seguro de que desea rechazar la solicitud del centro ' + nombre + '?'; // Reverted
                modalRechazar.style.display = 'flex';
            }
        }

        const closeModalRechazarBtn = document.querySelector('.close-modal-rechazar-centro');
        if(closeModalRechazarBtn) {
            closeModalRechazarBtn.addEventListener('click', function() {
                if (modalRechazar) modalRechazar.style.display = 'none';
            });
        }


        const btnCancelarRechazarCentro = document.getElementById('btn-cancelar-rechazar-centro');
        if (btnCancelarRechazarCentro) {
            btnCancelarRechazarCentro.addEventListener('click', function() {
                if (modalRechazar) modalRechazar.style.display = 'none';
            });
        }

        window.addEventListener('click', function(event) {
            if (event.target == modalRechazar) {
                if (modalRechazar) modalRechazar.style.display = 'none';
            }
        });
    </script>
</body>
</html>
