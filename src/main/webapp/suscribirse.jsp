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
    <title><fmt:message key="suscribirse.titulo" /></title>
    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- CSS -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/pages/suscribirse.css">
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
			        <a href="PerfilServlet" class="btn">Perfil</a>
			<% 
			    } else { 
			%>
			        <a href="login.jsp" class="btn">Iniciar sesión</a>
			<% 
			    } 
			%>
			<%   if (username != null) { 
			%>
			        <!-- No se muestra el botón descargar si no hay cookie -->
			<% 
			    } else { 
			%>
			        <a href="suscribirse.jsp" class="btn"><fmt:message key="menu.suscribirse" /></a>
			<% 
			    } 
			%>
            <%   if (username != null) { 
			%>
			        <a href="private/descargarJuego.jsp" class="btn"><fmt:message key="menu.descargar" /></a>
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
        <div class="auth-container">
            <div class="auth-image2">
                <div class="auth-image-content">
                    <h2 class="auth-image-title"><fmt:message key="suscribirse.unete" /></h2>
                    <p class="auth-image-text"><fmt:message key="suscribirse.uneteDesc" /></p>
                    <a href="#" class="btn" style="margin-top: 15px; background-color: white; color: #333;"><fmt:message key="suscribirse.conoceMas" /></a>
                </div>
            </div>
            <div class="auth-forms">
                <div class="auth-tabs">
                    <div class="auth-tab active" onclick="switchTab('centro')"><fmt:message key="suscribirse.centroEducativo" /></div>
                    <div class="auth-tab" onclick="switchTab('individual')"><fmt:message key="suscribirse.usuarioIndividual" /></div>
                </div>

                <div id="centro-form" class="auth-form active">
                    <h2 class="form-title"><fmt:message key="suscribirse.suscripcionCentros" /></h2>
                    <form action="AltaSuscriptor" method="post">
                    	<input type="hidden" name="tipo" value="centro">
                        <div class="form-group">
                            <label for="centro-nombre"><fmt:message key="suscribirse.nombreCentro" /></label>
                            <input type="text" id="centro-nombre" name="nombre" placeholder="Nombre del centro educativo" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-codigo"><fmt:message key="suscribirse.codigoCentro" /></label>
                            <input type="text" id="centro-codigo" name="codigo" placeholder="Codigo del centro educativo" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-responsable"><fmt:message key="suscribirse.responsable" /></label>
                            <input type="text" id="centro-responsable" name="responsable" placeholder="Nombre y apellidos" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-email"><fmt:message key="cupon.email" /></label>
                            <input type="email" id="centro-email" name="email" placeholder="ejemplo@centro.edu" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-telefono"><fmt:message key="suscribirse.telefono" /></label>
                            <input type="tel" id="centro-telefono" name="telefono" placeholder="Teléfono" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-tipo"><fmt:message key="suscribirse.tipoCentro" /></label>
                            <select id="centro-tipo" name="tipo" required>
                                <option value=""><fmt:message key="suscribirse.seleccioneOpcion" /></option>
                                <option value="publico"><fmt:message key="suscribirse.publico" /></option>
                                <option value="concertado"><fmt:message key="suscribirse.concertado" /></option>
                                <option value="privado"><fmt:message key="suscribirse.privado" /></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="centro-alumnos"><fmt:message key="suscribirse.numAlumnos" /></label>
                            <input type="number" id="centro-alumnos" name="alumnos" min="1" placeholder="Número de alumnos" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-password"><fmt:message key="suscribirse.password" /></label>
                            <input type="password" id="centro-password" name="password" placeholder="Crea una contraseña" required>
                        </div>
                        <div class="form-group">
                            <label for="centro-confirm"><fmt:message key="suscribirse.confirmPassword" /></label>
                            <input type="password" id="centro-confirm" name="confirm" placeholder="Confirma tu contraseña" required>
                        </div>
                        <% 
							    String errorMensaje = (String) request.getAttribute("errorMensaje");
							    if (errorMensaje != null) { 
							%>
							    <p style="color: red;"><%= errorMensaje %></p>
							<% 
							    } 
							%>
                        <div class="form-submit">
                            <button type="submit"><fmt:message key="suscribirse.registrarCentro" /></button>
                        </div>
                    </form>
                </div>

                <div id="individual-form" class="auth-form">
                    <h2 class="form-title"><fmt:message key="suscribirse.suscripcionIndividual" /></h2>
                    <form action="AltaSuscriptor" method="post">
                    	<input type="hidden" name="tipo" value="ordinario">
                        <div class="form-group">
                            <label for="individual-nombre"><fmt:message key="suscribirse.nombreCompleto" /></label>
                            <input type="text" id="individual-nombre" name="username" placeholder="Tu nombre y apellidos" required>
                        </div>
                        <div class="form-group">
                            <label for="individual-email"><fmt:message key="cupon.email" /></label>
                            <input type="email" id="individual-email" name="correo" placeholder="ejemplo@correo.com" required>
                        </div>
                        <div class="form-group">
                            <label for="individual-edad"><fmt:message key="suscribirse.edad" /></label>
                            <input type="number" id="individual-edad" name="edad" min="1" placeholder="Tu edad" required>
                        </div>
                        <div class="form-group">
                            <label for="individual-password"><fmt:message key="suscribirse.password" /></label>
                            <input type="password" id="individual-password" name="password" placeholder="Crea una contraseña" required>
                        </div>
                        <div class="form-group">
                            <label for="individual-confirm"><fmt:message key="suscribirse.confirmPassword" /></label>
                            <input type="password" id="individual-confirm" name="confirm" placeholder="Confirma tu contraseña" required>
                        </div>
                        <% 
							    if (errorMensaje != null) { 
							%>
							    <p style="color: red;"><%= errorMensaje %></p>
							<% 
							    } 
							%>
                        <div class="form-submit">
                            <button type="submit"><fmt:message key="suscribirse.registrarse" /></button>
                        </div>
                    </form>

                    <div class="social-login">
                        <div class="social-login-title"><fmt:message key="suscribirse.registrateCon" /></div>
                        <div class="social-buttons">
                            <div class="social-button">F</div>
                            <div class="social-button">G</div>
                            <div class="social-button">T</div>
                        </div>
                    </div>

                    <div class="switch-form">
                        <fmt:message key="suscribirse.tieneCuenta" /> <a href="#" onclick="showLogin()"><fmt:message key="suscribirse.iniciarSesion" /></a>
                    </div>
                </div>

                <div id="login-form" class="auth-form" style="display: none;">
                    <h2 class="form-title"><fmt:message key="suscribirse.iniciarSesionTitulo" /></h2>
                    <form action="LoginServlet" method="post"> <%-- Added action and method --%>
                        <div class="form-group">
                            <label for="login-email"><fmt:message key="cupon.email" /></label>
                            <input type="email" id="login-email" name="email" placeholder="ejemplo@correo.com" required>
                        </div>
                        <div class="form-group">
                            <label for="login-password"><fmt:message key="suscribirse.password" /></label>
                            <input type="password" id="login-password" name="password" placeholder="Tu contraseña" required>
                        </div>
                        <div class="form-options">
                            <div class="remember-me">
                                <input type="checkbox" id="remember" name="remember">
                                <label for="remember"><fmt:message key="suscribirse.recordarme" /></label>
                            </div>
                            <a href="#" class="forgot-password"><fmt:message key="suscribirse.olvidoPassword" /></a>
                        </div>
                        <div class="form-submit">
                            <button type="submit"><fmt:message key="suscribirse.iniciarSesionTitulo" /></button>
                        </div>
                    </form>

                    <div class="social-login">
                        <div class="social-login-title"><fmt:message key="suscribirse.iniciarSesionCon" /></div>
                        <div class="social-buttons">
                            <div class="social-button">F</div>
                            <div class="social-button">G</div>
                            <div class="social-button">T</div>
                        </div>
                    </div>

                    <div class="switch-form">
                        <fmt:message key="suscribirse.noTieneCuenta" /> <a href="#" onclick="showRegister()"><fmt:message key="suscribirse.registrarse" /></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Reemplazar el footer actual por el nuevo diseño -->
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
        function switchTab(tab) {
            // Hide all forms
            document.getElementById('centro-form').classList.remove('active');
            document.getElementById('individual-form').classList.remove('active');
            document.getElementById('login-form').style.display = 'none';
            
            // Show selected form
            if (tab === 'centro' || tab === 'individual') {
                document.getElementById(tab + '-form').classList.add('active');
            }
            
            // Update tabs
            const tabs = document.querySelectorAll('.auth-tab');
            tabs.forEach(t => t.classList.remove('active'));
            
            if (tab === 'centro') {
                tabs[0].classList.add('active');
            } else if (tab === 'individual') {
                tabs[1].classList.add('active');
            }
        }

        function showLogin() {
            document.getElementById('centro-form').classList.remove('active');
            document.getElementById('individual-form').classList.remove('active');
            document.getElementById('login-form').style.display = 'block';
            
            const tabs = document.querySelectorAll('.auth-tab');
            tabs.forEach(t => t.classList.remove('active'));
        }

        function showRegister() {
            document.getElementById('login-form').style.display = 'none';
            document.getElementById('individual-form').classList.add('active');
            
            const tabs = document.querySelectorAll('.auth-tab');
            tabs.forEach(t => t.classList.remove('active'));
            tabs[1].classList.add('active');
        }

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
        document.addEventListener("DOMContentLoaded", function () {
            const header = document.querySelector(".header");

            function toggleHeader() {
                if (window.scrollY > 50) {
                    header.classList.remove("transparent");
                    header.classList.add("solid");
                } else {
                    header.classList.remove("solid");
                    header.classList.add("transparent");
                }
            }

            toggleHeader(); // Ejecutar al cargar
            window.addEventListener("scroll", toggleHeader);
        });

    </script>
</body>
</html>