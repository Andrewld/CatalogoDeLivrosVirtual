<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<% 
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    
    String usuario = (String) session.getAttribute("Usuario");
    
    String nomeUsuarioLogado = "";

    if (usuario != null)
        nomeUsuarioLogado = usuario;
    else
        response.sendRedirect("login.jsp");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <title>Criar Editora</title>
    </head>
    <body>
        <div class="container">
        <h1>Criar Editora</h1>
        <% out.print(nomeUsuarioLogado); %>
            
            <div class="mt-2">
                <a class="btn btn-secondary btn-sm" href="administrativo.jsp">Voltar</a>
            </div>
            
            <hr />
            
            <div class="mt-2">
                <form method="post">
                    <div class="mb-3">
                      <label class="form-label">Nome da editora</label>
                      <input type="text" class="form-control" id="nome" name="nome" >
                    </div>
                    <button type="submit" class="btn btn-primary">Salvar</button>
              </form>
                <%
                    String nome = request.getParameter("nome");

                    try {
                          if (nome != null){
                              
                              Class.forName("com.mysql.cj.jdbc.Driver");
                              con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                              st = con.createStatement();
                              String str = "insert into editora (nome) values ('"+nome+"')";
                              st.executeUpdate(str);
                              
                              response.sendRedirect("administrativo.jsp");
                          }
                        } catch (Exception e) {
                            out.print(e);
                        }
                %>
        </<div>
    </body>
</html>
