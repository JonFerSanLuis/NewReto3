<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

request.setAttribute("username", username);

// Verificar si el usuario es administrador
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
boolean userIsAdmin = (isAdmin != null && isAdmin);
%>

<c:set var="idioma"
	value="${not empty sessionScope.idioma ? sessionScope.idioma : 'es'}"
	scope="session" />
<fmt:setLocale value="${idioma}" />
<fmt:setBundle basename="resources.messages" />

<!DOCTYPE html>
<html lang="${idioma}">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tu Perfil</title> <%-- Reverted --%>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- CSS -->
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/pages/admin-usuarios.css">
<link rel="stylesheet" href="css/pages/admin-dashboard.css">
<style>
.admin-menu {
	background-color: #f5f5f5;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 30px;
}

.admin-menu h2 {
	color: #333;
	margin-bottom: 15px;
}

.admin-menu ul {
	list-style: none;
	padding: 0;
}

.admin-menu li {
	margin-bottom: 10px;
}

.admin-menu a {
	display: block;
	padding: 10px 15px;
	background-color: #4a6cf7;
	color: white;
	border-radius: 5px;
	text-decoration: none;
	transition: background-color 0.3s;
}

.admin-menu a:hover {
	background-color: #3a5bd9;
}

.btn-danger {
	background-color: #dc3545;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn-danger:hover {
	background-color: #c82333;
}
/* Menu confirmacion */
.simple-modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
}

.simple-modal-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    width: 300px;
    text-align: center;
}

.simple-modal-buttons {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    gap: 10px;
}

.simple-modal-buttons button {
    padding: 8px 16px;
    border-radius: 5px;
    cursor: pointer;
}

.simple-modal-confirm {
    background-color: #dc3545;
    color: white;
    border: none;
}

.simple-modal-cancel {
    background-color: #f8f9fa;
    border: 1px solid #ccc;
}
</style>
</head>
<body>
	<header class="header">
		<div class="logo">
			<a href="index.jsp"><img src="img/logo.png" alt="Logo"></a>
		</div>
		<nav class="nav-container">
			<ul class="nav-links">
				<li><a href="informacion.jsp"><fmt:message
							key="menu.informacion" /></a></li>
				<li><a href="Ranking"><fmt:message key="menu.ranking" /></a></li>
				<li><a href="comprarCupon.jsp"><fmt:message
							key="menu.comprarCupon" /></a></li>
			</ul>
		</nav>

		<div class="right-section">
			<div class="idiomas">
				<img src="img/idiomas.png" alt="Idiomas">
				<ul class="idioma-menu">
					<li><a href="CambiarIdioma?idioma=es"><fmt:message
								key="idioma.espanol" /></a></li>
					<li><a href="CambiarIdioma?idioma=en"><fmt:message
								key="idioma.ingles" /></a></li>
					<li><a href="CambiarIdioma?idioma=eu"><fmt:message
								key="idioma.euskera" /></a></li>
				</ul>
			</div>
			<%
			if (username != null) {
			%>
			<a href="PerfilServlet" class="btn">Perfil</a>
			<%
			} else {
			%>
			<a href="login.jsp" class="btn">Iniciar sesión</a>
			<%
			}
			%>
			<%
			if (username != null) {
			%>
			<!-- No se muestra el botón descargar si no hay cookie -->
			<%
			} else {
			%>
			<a href="suscribirse.jsp" class="btn"><fmt:message
					key="menu.suscribirse" /></a>
			<%
			}
			%>
			<%
			if (username != null) {
			%>
			<a href="private/descargarJuego.jsp" class="btn"><fmt:message
					key="menu.descargar" /></a>
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
		<h1 class="page-title">Su Perfil</h1> <%-- Reverted --%>

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
			<section class="search-section">
				<h2 class="search-title">¡BIENVENIDO ${username}!</h2> <%-- Reverted --%>
			</section>

			<%
			if (userIsAdmin) {
			%>
			<!-- Panel de Administrador con estilos mejorados -->
			<section class="admin-panel">
				<h2 class="admin-panel-title">Panel de Administrador</h2> <%-- Reverted --%>
				
				<!-- Tarjetas de información estilo AdminLTE -->
				<div class="info-box-container">
					<!-- Tarjeta 1: Usuarios Activos -->
					<div class="info-box bg-info">
						<div class="info-box-content">
							<div>
								<div class="info-box-number">${usuariosActivos}</div>
								<div class="info-box-text">Usuarios Activos</div> <%-- Reverted --%>
							</div>
						</div>
						<div class="info-box-icon">
							<i class="fas fa-user-check"></i>
						</div>
						<a href="AdminUsuarios?filtro=activos" class="info-box-footer">
							Más información <i class="fas fa-arrow-circle-right"></i> <%-- Reverted --%>
						</a>
					</div>

					<!-- Tarjeta 2: Usuarios Inactivos -->
					<div class="info-box bg-warning">
						<div class="info-box-content">
							<div>
								<div class="info-box-number">${usuariosInactivos}</div>
								<div class="info-box-text">Usuarios Inactivos</div> <%-- Reverted --%>
							</div>
						</div>
						<div class="info-box-icon">
							<i class="fas fa-user-slash"></i>
						</div>
						<a href="AdminUsuarios?filtro=inactivos" class="info-box-footer">
							Más información <i class="fas fa-arrow-circle-right"></i> <%-- Reverted --%>
						</a>
					</div>

					<!-- Tarjeta 3: Centros Pendientes (antes Centros Registrados) -->
					<div class="info-box bg-success"> <%-- Consider changing bg-success to bg-warning or another color if more appropriate for "pending" --%>
						<div class="info-box-content">
							<div>
								<div class="info-box-number">${centrosPendientes}</div>
								<div class="info-box-text">Centros Pendientes</div> <%-- Reverted (key admin.dashboard.pendingCenters was used) --%>
							</div>
						</div>
						<div class="info-box-icon">
							<i class="fas fa-hourglass-half"></i> <%-- Icon changed --%>
						</div>
						<a href="AdminUsuarios?action=listarPendientes" class="info-box-footer">
							Más información <i class="fas fa-arrow-circle-right"></i> <%-- Reverted --%>
						</a>
					</div>

					<!-- Tarjeta 4: Total Cupones -->
					<div class="info-box bg-danger">
						<div class="info-box-content">
							<div>
								<div class="info-box-number">${totalCupones}</div>
								<div class="info-box-text">Cupones Totales</div> <%-- Reverted --%>
							</div>
						</div>
						<div class="info-box-icon">
							<i class="fas fa-ticket-alt"></i>
						</div>
						<a href="comprarCupon.jsp" class="info-box-footer">
							Más información <i class="fas fa-arrow-circle-right"></i> <%-- Reverted --%>
						</a>
					</div>
				</div>
				
				<!-- Botones de administrador mejorados -->
				<div class="admin-buttons-container">
					<a href="AdminUsuarios" class="btn admin-btn admin-btn-usuarios">
						<i class="fas fa-users-cog"></i> GESTIONAR USUARIOS <%-- Reverted --%>
					</a>
					<a href="finalizar-ranking.jsp" class="btn admin-btn admin-btn-ranking">
						<i class="fas fa-trophy"></i> FINALIZAR RANKING <%-- Reverted --%>
					</a>
				</div>
			</section>
			<%
			} else {
			%>
			<!-- Mostrar la lista de cupones solo si NO es administrador -->
			<section class="users-table-section">
				<h2 class="users-table-title">Lista de cupones</h2> <%-- Reverted --%>
				<div class="table-container">
					<table class="users-table">
						<thead>
							<tr>
								<th>TIPO</th> <%-- Reverted --%>
								<th>FECHA CADUCIDAD</th> <%-- Reverted --%>
								<th>ESTADO</th> <%-- Reverted --%>
								<th>DEVOLVER</th> <%-- Reverted --%>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty listaCupones}">
									<tr>
										<td colspan="5" class="no-results"><fmt:message
												key="admin.noResultados" /></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="cupon" items="${listaCupones}">
										<tr>
											<td>${cupon.tipo}</td>
											<td><fmt:formatDate value="${cupon.fechaCaducidad}"
													pattern="dd/MM/yyyy" /></td>
											<td><span
												class="status-badge ${cupon.estado == 'disponible' ? 'status-active' : 'status-inactive'}">
													${cupon.estado} </span></td>
											<td>
												<!-- Formulario para borrar el cupón -->
												<form action="BorrarCuponServlet" method="post">
													<input type="hidden" name="idCupon"
														value="${cupon.idCupon}">
													<button type="submit" class="btn btn-danger">DEVOLVER</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</section>
			<%
			}
			%>

			<div class="action-buttons">
			    <form action="CerrarSesionServlet" method="post">
			        <button type="submit" class="btn btn-logout">Cerrar Sesión</button> <%-- Reverted --%>
			    </form>
			    
			    <% if (!userIsAdmin) { %>
			    <!-- Mostrar el botón de eliminar suscripción solo si NO es administrador -->
			    <form id="eliminarForm" action="EliminarSuscripcionServlet" method="post">
				    <input type="hidden" name="username" value="<%= username %>">
				    <button type="button" onclick="mostrarConfirmacion()" class="btn btn-danger">Dar de baja</button> <%-- Reverted --%>
				</form>
				<% } %>
			</div>
			
			<!-- Menu confirmacion -->
			<div id="simpleModal" class="simple-modal">
			    <div class="simple-modal-content">
			        <h3>Confirmar</h3> <%-- Reverted --%>
			        <p>¿Seguro que quieres darte de baja?</p> <%-- Reverted --%>
			        <div class="simple-modal-buttons">
			            <button id="simpleCancel" class="simple-modal-cancel">Cancelar</button> <%-- Reverted --%>
			            <button id="simpleConfirm" class="simple-modal-confirm">Eliminar</button> <%-- Reverted --%>
			        </div>
			    </div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="footer">
		<div class="footer-container">
			<div class="footer-section">
				<div class="footer-logo">
					<img src="img/logo.png" alt="Logo Educación Divertida">
				</div>
				<p class="footer-description">
					<fmt:message key="footer.descripcion" />
				</p>
				<div class="social-links">
					<a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
						class="fab fa-twitter"></i></a> <a href="#"><i
						class="fab fa-instagram"></i></a> <a href="#"><i
						class="fab fa-youtube"></i></a>
				</div>
			</div>

			<div class="footer-section">
				<h3 class="footer-title">
					<fmt:message key="footer.enlacesRapidos" />
				</h3>
				<ul class="footer-links">
					<li><a href="#"><fmt:message key="footer.sobreNosotros" /></a></li>
					<li><a href="#"><fmt:message key="footer.nuestrosCursos" /></a></li>
					<li><a href="#"><fmt:message key="footer.testimonios" /></a></li>
					<li><a href="#"><fmt:message key="footer.blogEducativo" /></a></li>
					<li><a href="#"><fmt:message key="footer.preguntasFrecuentes" /></a></li>
				</ul>
			</div>

			<div class="footer-section">
				<h3 class="footer-title">
					<fmt:message key="footer.contacto" />
				</h3>
				<div class="footer-contact">
					<p>
						<i class="fas fa-map-marker-alt"></i>
						<fmt:message key="footer.direccion" />
					</p>
					<p>
						<i class="fas fa-phone"></i>
						<fmt:message key="footer.telefono" />
					</p>
					<p>
						<i class="fas fa-envelope"></i>
						<fmt:message key="footer.email" />
					</p>
					<p>
						<i class="fas fa-clock"></i>
						<fmt:message key="footer.horario" />
					</p>
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
		
	    function mostrarConfirmacion() {
	        document.getElementById('simpleModal').style.display = 'block';
	    }
	    
	    document.addEventListener('DOMContentLoaded', function() {
	        // Botón cancelar
	        document.getElementById('simpleCancel').onclick = function() {
	            document.getElementById('simpleModal').style.display = 'none';
	        };
	        
	        // Botón confirmar
	        document.getElementById('simpleConfirm').onclick = function() {
	            document.getElementById('eliminarForm').submit();
	        };
	    });
	</script>
</body>
</html>
