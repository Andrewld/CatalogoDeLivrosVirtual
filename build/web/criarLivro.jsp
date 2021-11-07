<%@page import="java.nio.file.Paths"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<% 
    String usuario = (String) session.getAttribute("Usuario");
    
    String nomeUsuarioLogado = "";

    if (usuario != null)
        nomeUsuarioLogado = usuario;
    else
        response.sendRedirect("login.jsp");

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Criar Livro</title>
    </head>
    <body>
        <div class="conteudo">
        <h1>Criar Livro</h1>
        <div class="nome-do-usuario">
            <% out.print(nomeUsuarioLogado); %>
        </div>

        <a class="btn btn-cinza btn-sm" href="administrativo.jsp">Voltar</a>

        <hr />
        <form action="uploadImage" enctype="multipart/form-data" method="post">
            <label class="form-label">Título</label>
            <input type="text" class="form-control" id="titulo" name="titulo" required>
        
            <label class="form-label">Autor</label>
            <input type="text" class="form-control" id="autor" name="autor"required>

            <label class="form-label">Ano</label>
            <input type="text" class="form-control" id="ano" name="ano" required>

            <label class="form-label">Preço</label>
            <input type="text" class="form-control" id="preco" name="preco" required>

            <label class="form-label">Editora</label>
            <select class="form-select" id="editora" name="editora">
                <% 
                    try {       
                        int linhasRetornadas = 0;

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                        st = con.createStatement();
                        String str = "select * from editora";
                        rs = st.executeQuery(str);
                            while(rs.next()){ %>
                            <option value="<%= rs.getString(1)%>"> <%= rs.getString(2) %> </option>
                        <%
                        }
                    } catch (Exception e) {
                        out.print(e);
                    }
                %>
            </select>

            <label class="form-label">Imagem da capa</label>
            <input class="form-control" type="file" id="imagem" name="imagem" required>
            
            <button type="submit" class="btn btn-azul">Salvar</button>
        </form>
    </body>
</html>