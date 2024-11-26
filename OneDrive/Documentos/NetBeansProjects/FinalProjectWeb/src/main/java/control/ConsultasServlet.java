/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ConsultasServlet", urlPatterns = {"/ConsultasServlet"})
public class ConsultasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Configuración de la base de datos
        String url = "jdbc:mysql://localhost:3306/library_db"; // Cambia a tu base de datos
        String user = "root"; // Usuario de la base de datos
        String password = ""; // Contraseña de la base de datos

        ArrayList<HashMap<String, String>> consulta1 = new ArrayList<>();
        ArrayList<HashMap<String, String>> consulta2 = new ArrayList<>();
        ArrayList<HashMap<String, String>> consulta3 = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, password);

            // Consulta 1
            String query1 = "SELECT a.name AS author_name, e.name AS editorial_name, e.country AS editorial_country FROM authors a JOIN author_editorial ae ON a.author_id = ae.author_id JOIN editorial e ON ae.editorial_id = e.editorial_id";
            PreparedStatement ps1 = con.prepareStatement(query1);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                HashMap<String, String> row = new HashMap<>();
                row.put("author_name", rs1.getString("author_name"));
                row.put("editorial_name", rs1.getString("editorial_name"));
                row.put("editorial_country", rs1.getString("editorial_country"));
                consulta1.add(row);
            }

            // Consulta 2
            String query2 = "SELECT b.title AS book_title, br.name AS borrower_name, br.return_date FROM books b JOIN borrowers br ON b.book_id = br.book_id";
            PreparedStatement ps2 = con.prepareStatement(query2);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                HashMap<String, String> row = new HashMap<>();
                row.put("book_title", rs2.getString("book_title"));
                row.put("borrower_name", rs2.getString("borrower_name"));
                row.put("return_date", rs2.getString("return_date"));
                consulta2.add(row);
            }

            // Consulta 3
            String query3 = "SELECT b.title AS book_title, e.name AS editorial_name, a.name AS author_name FROM books b JOIN book_editorial be ON b.book_id = be.book_id JOIN editorial e ON be.editorial_id = e.editorial_id JOIN author_editorial ae ON e.editorial_id = ae.editorial_id JOIN authors a ON ae.author_id = a.author_id";
            PreparedStatement ps3 = con.prepareStatement(query3);
            ResultSet rs3 = ps3.executeQuery();
            while (rs3.next()) {
                HashMap<String, String> row = new HashMap<>();
                row.put("book_title", rs3.getString("book_title"));
                row.put("editorial_name", rs3.getString("editorial_name"));
                row.put("author_name", rs3.getString("author_name"));
                consulta3.add(row);
            }

            // Enviar datos al JSP 
            request.setAttribute("connectionStatus", "success"); // Éxito
            request.setAttribute("consulta1", consulta1);
            request.setAttribute("consulta2", consulta2);
            request.setAttribute("consulta3", consulta3);

        } catch (Exception e) {
            request.setAttribute("connectionStatus", "error");
            e.printStackTrace();
        }

        request.getRequestDispatcher("resultados.jsp").forward(request, response);
    }
}
