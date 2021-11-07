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
        <link href="css/style.css" rel="stylesheet">
        <title>Criar Editora</title>
    </head>
    <body>
        <div class="conteudo">
        <h1>Criar Editora</h1>
        <div class="nome-do-usuario">
            <% out.print(nomeUsuarioLogado); %>
        </div>

        <a class="btn btn-cinza btn-sm" href="administrativo.jsp">Voltar</a>
            
        <hr />
            
        <form method="post">
            <label class="form-label">Nome da editora</label>
            <input type="text" class="form-control" id="nome" name="nome" >
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
    </body>
</html>