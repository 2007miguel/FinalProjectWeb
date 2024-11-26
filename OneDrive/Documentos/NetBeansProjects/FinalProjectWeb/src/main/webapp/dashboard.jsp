<%-- 
    Document   : dashboard
    Created on : 20/11/2024, 10:05:00 p. m.
    Author     : Alexis
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="entities.Users" %>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed; /* Ancho fijo para columnas */
        }

        thead {
            display: table;
            width: 100%;
            table-layout: fixed;
            background-color: #f8f9fa; /* Color del encabezado */
            position: sticky; /* Fija el encabezado */
            top: 0;
            z-index: 1;
        }

        .scrollable-tbody {
            display: block;
            max-height: 500px; /* Define la altura del área desplazable */
            overflow-y: auto;
            width: 100%;
        }

        .scrollable-tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        th, td {
            text-align: left;
            padding: 8px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <header>
        <form method="POST" action="LogoutServlet">
            <button class="btn btn-danger" type="submit">Cerrar Sesión</button>
        </form>
    </header>

    <section class="container mt-4">
        <h2>Agregar Libro</h2>
        <form action="DashboardServlet" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label for="title" class="form-label">Título</label>
                <input type="text" name="title" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="year_published" class="form-label">Año de Publicación</label>
                <input type="number" name="year_published" class="form-control" min="1900" max="2024" required>
            </div>
            <button type="submit" class="btn btn-primary">Guardar</button>
        </form>

        <h2 class="mt-4">Lista de Libros</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Título</th>
                    <th>Año de Publicación</th>
                    <th>Opciones</th>
                </tr>
            </thead>
            <tbody class="scrollable-tbody">
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.title}</td>
                        <td>${book.yearPublished}</td>
                        <td>
                            <form action="DashboardServlet" method="POST" style="display: inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="book_id" value="${book.bookId}">
                                <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                
                            </form>
                                <a href="EditBookServlet?book_id=${book.bookId}" class="btn btn-warning btn-sm">Editar</a>
                            
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> 
  
        <c:choose>
            <c:when test="${canViewConsultations}">
                <!-- Botón habilitado para administradores -->
                <a href="ConsultasServlet" class="btn btn-primary">Ver Consultas</a>
            </c:when>
            <c:otherwise>
                <!-- Botón deshabilitado para no administradores -->
                <button class="btn btn-primary" disabled> Deshabilitado por permisos de admin</button>
            </c:otherwise>
        </c:choose>

    </section> 
    
</body>
</html>

