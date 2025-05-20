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
<html lang="${idioma}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="admin.editarUsuario" /></title>
    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- CSS -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/pages/admin-usuarios.css">
</head>
<body>
    <header class="header">
        <div class="logo">
            <a href="index.jsp"><img src="img/logo.png" alt="Logo"></a>
        </div>
        <nav class="nav-container">
            <ul class="nav-links">
                <li><a href="informacion.jsp"><fmt:message key="menu.informacion" /></a></li>
                <li><a href="Ranking"><fmt:message key="menu.ranking" /></a></li>
                <li><a href="comprarCupon.jsp"><fmt:message key="menu.comprarCupon" /></a></li>
                <li><a href="AdminUsuarios" class="active"><fmt:message key="admin.titulo" /></a></li>
            </ul>
        </nav>

        <div class="right-section">
            <div class="idiomas">
                <img src="img/idiomas.png" alt="Idiomas">
                <ul class="idioma-menu">
                    <li><a href="CambiarIdioma?idioma=es"><fmt:message key="idioma.espanol" /></a></li>
                    <li><a href="CambiarIdioma?idioma=en"><fmt:message key="idioma.ingles" /></a></li>
                    <li><a href="CambiarIdioma?idioma=eu"><fmt:message key="idioma.euskera" /></a></li>
                </ul>
            </div>
            <%   if (username != null) { 
			%>
			        <a href="../perfil.jsp" class="btn">Perfil</a>
			<% 
			    } else { 
			%>
			        <a href="../login.jsp" class="btn">Iniciar sesión</a>
			<% 
			    } 
			%>
            <%   if (username != null) { 
			%>
			        <a href="descargarJuego.jsp" class="btn"><fmt:message key="menu.descargar" /></a>
			<% 
			    } else { 
			%>
			        <!-- No se muestra el botón descargar si no hay cookie -->
			<% 
			    } 
			%>
        </div>
    </header>

    <div class="main-content">
        <h1 class="page-title"><fmt:message key="admin.editarUsuario" /></h1>

        <div class="admin-container">
            <section class="edit-section">
                <div class="breadcrumb">
                    <a href="AdminUsuarios"><fmt:message key="admin.titulo" /></a> &gt; <fmt:message key="admin.editarUsuario" />
                </div>
                
                <form class="edit-form" action="AdminUsuarios" method="post">
                    <input type="hidden" name="action" value="actualizar">
                    <input type="hidden" name="id" value="${usuario.idSuscriptor}">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username"><fmt:message key="admin.nombre" /></label>
                            <input type="text" id="username" name="username" value="${usuario.username}" required>
                        </div>
                        <div class="form-group">
                            <label for="correo"><fmt:message key="admin.email" /></label>
                            <input type="email" id="correo" name="correo" value="${usuario.correo}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="tipo"><fmt:message key="admin.tipo" /></label>
                            <select id="tipo" name="tipo" required>
                                <option value="ordinario" ${usuario.tipo == 'ordinario' ? 'selected' : ''}><fmt:message key="admin.tipoOrdinario" /></option>
                                <option value="centro" ${usuario.tipo == 'centro' ? 'selected' : ''}><fmt:message key="admin.tipoCentro" /></option>
                                <option value="admin" ${usuario.tipo == 'admin' ? 'selected' : ''}><fmt:message key="admin.tipoAdmin" /></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="estado"><fmt:message key="admin.estado" /></label>
                            <select id="estado" name="estado" required>
                                <option value="activo" ${usuario.estado == 'activo' ? 'selected' : ''}><fmt:message key="admin.estadoActivo" /></option>
                                <option value="inactivo" ${usuario.estado == 'inactivo' ? 'selected' : ''}><fmt:message key="admin.estadoInactivo" /></option>
                                <option value="suspendido" ${usuario.estado == 'suspendido' ? 'selected' : ''}><fmt:message key="admin.estadoSuspendido" /></option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="edad"><fmt:message key="admin.edad" /></label>
                            <input type="number" id="edad" name="edad" value="${usuario.edad}" min="0">
                        </div>
                        <div class="form-group">
                            <label for="fecha-alta"><fmt:message key="admin.fechaAlta" /></label>
                            <input type="text" id="fecha-alta" value="<fmt:formatDate value="${usuario.fechaAlta}" pattern="dd/MM/yyyy" />" disabled>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="nueva-password"><fmt:message key="admin.nuevaPassword" /></label>
                        <input type="password" id="nueva-password" name="nuevaPassword" placeholder="********">
                    </div>
                    
                    <div class="form-actions">
                        <a href="AdminUsuarios" class="btn-secondary"><fmt:message key="admin.volver" /></a>
                        <button type="submit" class="btn-primary"><fmt:message key="admin.guardarCambios" /></button>
                    </div>
                </form>
            </section>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-section">
                <div class="footer-logo">
                    <img src="img/logo.png" alt="Logo Educación Divertida">
                </div>
                <p class="footer-description"><fmt:message key="footer.descripcion" /></p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h3 class="footer-title"><fmt:message key="footer.enlacesRapidos" /></h3>
                <ul class="footer-links">
                    <li><a href="#"><fmt:message key="footer.sobreNosotros" /></a></li>
                    <li><a href="#"><fmt:message key="footer.nuestrosCursos" /></a></li>
                    <li><a href="#"><fmt:message key="footer.testimonios" /></a></li>
                    <li><a href="#"><fmt:message key="footer.blogEducativo" /></a></li>
                    <li><a href="#"><fmt:message key="footer.preguntasFrecuentes" /></a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3 class="footer-title"><fmt:message key="footer.contacto" /></h3>
                <div class="footer-contact">
                    <p><i class="fas fa-map-marker-alt"></i> <fmt:message key="footer.direccion" /></p>
                    <p><i class="fas fa-phone"></i> <fmt:message key="footer.telefono" /></p>
                    <p><i class="fas fa-envelope"></i> <fmt:message key="footer.email" /></p>
                    <p><i class="fas fa-clock"></i> <fmt:message key="footer.horario" /></p>
                </div>
            </div>
        </div>

        <div class="footer-container">
            <div class="copyright">
                <fmt:message key="footer.copyright" />
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const idiomas = document.querySelector('.idiomas');
            document.addEventListener('click', function(e) {
                if (idiomas.contains(e.target)) {
                    idiomas.classList.toggle('activo');
                } else {
                    idiomas.classList.remove('activo');
                }
            });
        });
    </script>
</body>
</html>