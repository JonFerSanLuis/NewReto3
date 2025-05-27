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
<title><fmt:message key="admin.titulo" /></title>
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
</head>
<body>
	<header class="header">
		<div class="logo">
			<a href="index.jsp"><img src="img/logo.png" alt="Logo"></a>
		</div>
		<nav class="nav-container">
			<ul class="nav-links">
				<li><a href="PerfilServlet"><fmt:message
							key="admin.backToDashboard" /></a></li>
				<li><a href="AdminUsuarios?action=listar"
					<c:if test="${param.action == 'listar' || empty param.action || (param.action == 'editar') || (param.action == 'detalles') }">class="active"</c:if>><fmt:message
							key="admin.manageUsers" /></a></li>
				<li><a href="AdminUsuarios?action=listarPendientes"><fmt:message
							key="admin.pendingCenters.title" /></a></li>
			</ul>
		</nav>

		<div class="right-section">
			<div class="idiomas">
				<img src="img/idiomas.png" alt="Idiomas">
				<ul class="idioma-menu">
					<li><a
						href="CambiarIdioma?idioma=es&redirect=AdminUsuarios?action=${empty param.action ? 'listar' : param.action}${not empty param.id ? '&id=' : ''}${param.id}"><fmt:message
								key="idioma.espanol" /></a></li>
					<li><a
						href="CambiarIdioma?idioma=en&redirect=AdminUsuarios?action=${empty param.action ? 'listar' : param.action}${not empty param.id ? '&id=' : ''}${param.id}"><fmt:message
								key="idioma.ingles" /></a></li>
					<li><a
						href="CambiarIdioma?idioma=eu&redirect=AdminUsuarios?action=${empty param.action ? 'listar' : param.action}${not empty param.id ? '&id=' : ''}${param.id}"><fmt:message
								key="idioma.euskera" /></a></li>
				</ul>
			</div>
			<%
			if (username != null) {
			%>
			<a href="PerfilServlet" class="btn"><fmt:message
					key="menu.perfil" /></a> <a href="private/descargarJuego.jsp"
				class="btn"><fmt:message key="menu.descargar" /></a>
			<div class="action-buttons">
				<form action="CerrarSesionServlet" method="post">
					<button type="submit" class="btn btn-logout">Cerrar Sesión</button>
					<%-- Reverted --%>
				</form>
				<%
				} else {
				%>
				<a href="login.jsp" class="btn"><fmt:message
						key="menu.iniciarSesion" /></a>
				<%
				}
				%>
			</div>
	</header>

	<div class="main-content">
		<h1 class="page-title">
			<fmt:message key="admin.titulo" />
		</h1>

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
				<h2 class="search-title">
					<fmt:message key="admin.buscarUsuario" />
				</h2>
				<form class="search-form" action="AdminUsuarios" method="get">
					<div class="search-inputs">
						<div class="search-field">
							<label for="busqueda-id">ID:</label> <input type="text"
								id="busqueda-id" name="id" placeholder="ID" value="${param.id}">
						</div>
						<div class="search-field">
							<label for="busqueda-nombre"><fmt:message
									key="admin.nombre" />:</label> <input type="text" id="busqueda-nombre"
								name="nombre" placeholder="<fmt:message key="admin.nombre" />"
								value="${param.nombre}">
						</div>
					</div>
					<button type="submit" class="search-button">
						<fmt:message key="admin.buscar" />
					</button>
				</form>
			</section>

			<section class="users-table-section">
				<h2 class="users-table-title">
					<fmt:message key="admin.listaUsuarios" />
				</h2>
				<div class="table-container">
					<table class="users-table">
						<thead>
							<tr>
								<th><fmt:message key="admin.id" /></th>
								<th><fmt:message key="admin.nombre" /></th>
								<th><fmt:message key="admin.email" /></th>
								<th><fmt:message key="admin.tipo" /></th>
								<th><fmt:message key="admin.estado" /></th>
								<th><fmt:message key="admin.fechaAlta" /></th>
								<th><fmt:message key="admin.edad" /></th>
								<th><fmt:message key="admin.acciones" /></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty listaUsuarios}">
									<tr>
										<td colspan="8" class="no-results"><fmt:message
												key="admin.noResultados" /></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="usuario" items="${listaUsuarios}">
										<tr>
											<td>${usuario.idSuscriptor}</td>
											<td>${usuario.username}</td>
											<td>${usuario.correo}</td>
											<td>${usuario.tipo}</td>
											<td><span
												class="status-badge ${usuario.estado == 'activo' ? 'status-active' : 'status-inactive'}">
													${usuario.estado} </span></td>
											<td><fmt:formatDate value="${usuario.fechaAlta}"
													pattern="dd/MM/yyyy" /></td>
											<td>${usuario.edad}</td>
											<td class="actions"><a
												href="AdminUsuarios?action=editar&id=${usuario.idSuscriptor}"
												class="action-btn edit-btn"
												title="<fmt:message key="admin.editar" />"> <i
													class="fas fa-edit"></i>
											</a>
												<button
													onclick="confirmarEliminar(${usuario.idSuscriptor}, '${usuario.username}')"
													class="action-btn delete-btn"
													title="<fmt:message key="admin.eliminar" />">
													<i class="fas fa-trash-alt"></i>
												</button> <a
												href="AdminUsuarios?action=detalles&id=${usuario.idSuscriptor}"
												class="action-btn details-btn"
												title="<fmt:message key="admin.detalles" />"> <i
													class="fas fa-info-circle"></i>
											</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</section>

		</div>
	</div>

	<!-- Modal de confirmación para eliminar usuario -->
	<div id="modal-eliminar" class="modal">
		<div class="modal-content">
			<span class="close-modal">&times;</span>
			<h2>
				<fmt:message key="admin.confirmarEliminacion" />
			</h2>
			<p>
				<fmt:message key="admin.confirmarEliminarUsuario" />
				<span id="nombre-usuario-eliminar"></span>?
			</p>
			<div class="modal-buttons">
				<button id="btn-cancelar-eliminar" class="btn-secondary">
					<fmt:message key="admin.cancelar" />
				</button>
				<form id="form-eliminar" action="AdminUsuarios" method="post">
					<input type="hidden" name="action" value="eliminar"> <input
						type="hidden" id="id-eliminar" name="id" value="">
					<button type="submit" class="btn-danger">
						<fmt:message key="admin.eliminar" />
					</button>
				</form>
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
					<li><a href="index.jsp">Inicio</a></li>
					<li><a href="informacion.jsp"><fmt:message
								key="footer.sobreNosotros" /></a></li>
					<li><a href="contacto-exito.jsp">Contacto</a></li>
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
        // Script para el menú de idiomas
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

        // Script para el modal de confirmación de eliminación
        function confirmarEliminar(id, nombre) {
            document.getElementById('id-eliminar').value = id;
            document.getElementById('nombre-usuario-eliminar').textContent = nombre;
            document.getElementById('modal-eliminar').style.display = 'flex';
        }

        document.querySelector('.close-modal').addEventListener('click', function() {
            document.getElementById('modal-eliminar').style.display = 'none';
        });

        document.getElementById('btn-cancelar-eliminar').addEventListener('click', function() {
            document.getElementById('modal-eliminar').style.display = 'none';
        });

        window.addEventListener('click', function(event) {
            if (event.target == document.getElementById('modal-eliminar')) {
                document.getElementById('modal-eliminar').style.display = 'none';
            }
        });
    </script>
</body>
</html>