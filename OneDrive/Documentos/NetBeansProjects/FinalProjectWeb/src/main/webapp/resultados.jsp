<%-- 
    Document   : resultados
    Created on : 25/11/2024, 10:17:15 a. m.
    Author     : juan
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resultados de las Consultas</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

        h1, h2 {
            text-align: center;
            color: #4CAF50;
            margin-top: 20px;
        }

        h2 {
            font-size: 1.8em;
            margin-bottom: 10px;
        }

        /* Table Styles */
        table {
            width: 100%; /* La tabla ocupa todo el ancho disponible */
            margin: 20px auto;
            border-collapse: collapse;
            border: 1px solid #ccc;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            table-layout: fixed; /* Columnas con ancho fijo */
        }

        thead {
            background-color: #4CAF50;
            color: white;
        }

        th, td {
            text-align: left;
            padding: 12px;
            border: 1px solid #ccc;
            word-wrap: break-word; /* Permite que el texto se ajuste en la celda */
            overflow: hidden; /* Evita desbordamientos */
        }

        th {
            font-weight: bold;
        }

        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tbody tr:hover {
            background-color: #e9f5e9;
        }

        /* Ensure Tables Are Responsive */
        .table-container {
            width: 90%; /* Contenedor más pequeño para centrado */
            margin: 0 auto;
            overflow-x: auto; /* Permite desplazamiento horizontal si es necesario */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 8px;
            }

            h2 {
                font-size: 1.5em;
            }
        } 
        .modal {
            display: none; /* Por defecto, está oculta */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        .close-btn {
            color: white;
            background-color: #f44336;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    
    <div id="modal" class="modal">
        <div class="modal-content">
            <p id="modal-message"></p>
            <button class="close-btn" onclick="closeModal()">Cerrar</button>
        </div>
    </div> 
    
    <h1>Resultados de las Consultas</h1>

    <h2>Consulta 1: Autores y Editoriales</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th style="width: 33%;">Nombre de Autor</th>
                    <th style="width: 33%;">Nombre de Editorial</th>
                    <th style="width: 34%;">País de la Editorial</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${consulta1}">
                    <tr>
                        <td>${row.author_name}</td>
                        <td>${row.editorial_name}</td>
                        <td>${row.editorial_country}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h2>Consulta 2: Libros Prestados y Prestatarios</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th style="width: 40%;">Título</th>
                    <th style="width: 30%;">Prestatario</th>
                    <th style="width: 30%;">Fecha Límite</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${consulta2}">
                    <tr>
                        <td>${row.book_title}</td>
                        <td>${row.borrower_name}</td>
                        <td>${row.return_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h2>Consulta 3: Libros, Editoriales y Autores</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th style="width: 33%;">Título</th>
                    <th style="width: 33%;">Editorial</th>
                    <th style="width: 34%;">Autor</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${consulta3}">
                    <tr>
                        <td>${row.book_title}</td>
                        <td>${row.editorial_name}</td>
                        <td>${row.author_name}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div> 
    
    <script>
        // Recuperar el estado de la conexión
        const connectionStatus = '<c:out value="${connectionStatus}" />';

        // Mostrar el mensaje en función del estado
        const modal = document.getElementById('modal');
        const modalMessage = document.getElementById('modal-message');

        if (connectionStatus === 'success') {
            modalMessage.textContent = "Consultas ejecutadas correctamente.";
            modal.style.display = 'block'; // Mostrar el modal
        } else if (connectionStatus === 'error') {
            modalMessage.textContent = "Ocurrió un error al procesar la solicitud, verifica la conexión a la base de datos.";
            modal.style.display = 'block'; // Mostrar el modal
        }

        // Cerrar el modal
        function closeModal() {
            modal.style.display = 'none';
        }
    </script>
</body>
</html>
