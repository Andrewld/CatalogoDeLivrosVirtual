package p1;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet(name = "editarLivro", urlPatterns = {"/editarLivro"})
@MultipartConfig(maxFileSize = 16177216)//1.5mb
public class editarLivro extends HttpServlet {

    PrintWriter out;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        out = response.getWriter();
        int result = 0;
        
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String ano = request.getParameter("ano");
        String preco = request.getParameter("preco");
        String id_editora = request.getParameter("editora");
        String id = request.getParameter("livroId");
        Part imagem = request.getPart("imagem");

         if  (titulo != null && autor != null && ano != null && preco != null && id_editora != null) {
            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                
                PreparedStatement ps = null;
                InputStream is = null;
                
                String test = imagem.getSubmittedFileName();
                               
                if (test != null && !test.equals("") )
                {
                    ps = con.prepareStatement("update livro set id_editora = ?, titulo = ?, ano = ?, autor = ?, preco = ?, img = ? where id = ?");
                    is = imagem.getInputStream();
                    ps.setString(1 , id_editora);
                    ps.setString(2 , titulo);
                    ps.setString(3 , ano);
                    ps.setString(4 , autor);
                    ps.setString(5 , preco);
                    ps.setBlob(6, is);
                    ps.setString(7 , id);
                }
                else
                {
                    ps = con.prepareStatement("update livro set id_editora = ?, titulo = ?, ano = ?, autor = ?, preco = ? where id = ?");
                    ps.setString(1 , id_editora);
                    ps.setString(2 , titulo);
                    ps.setString(3 , ano);
                    ps.setString(4 , autor);
                    ps.setString(5 , preco);
                    ps.setString(6 , id);
                }
                

                result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("index.jsp?message=Some+Error+Occurred");
                }
            } catch (Exception e) {
                out.println(e);
            }
        }
    }
}  