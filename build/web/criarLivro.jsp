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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <title>Criar Livro</title>
    </head>
    <body>
        <div class="container">
        <h1>Criar Livro</h1>
         <% out.print(nomeUsuarioLogado); %>
              
        <div class="mt-2">
            <a class="btn btn-secondary btn-sm" href="administrativo.jsp">Voltar</a>
        </div>

        <hr />

        <div class="mt-2">
            <form action="uploadImage" enctype="multipart/form-data" method="post">
                <div class="mb-3">
                  <label class="form-label">Título</label>
                  <input type="text" class="form-control" id="titulo" name="titulo" >
                </div>
                <div class="mb-3">
                  <label class="form-label">Autor</label>
                  <input type="text" class="form-control" id="autor" name="autor">
                </div>
                <div class="mb-3">
                  <label class="form-label">Ano</label>
                  <input type="text" class="form-control" id="ano" name="ano" >
                </div>
                <div class="mb-3">
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
                </div>
                <div class="mb-3">
                  <label class="form-label">Preço</label>
                  <input type="text" class="form-control" id="preco" name="preco" >
                </div>
                <div class="mb-3">
                  <label class="form-label">Imagem da capa</label>
                  <input class="form-control" type="file" id="imagem" name="imagem">
                </div>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </form>
        </<div>
    </body>
</html>


