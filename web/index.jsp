<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<% 
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    String usuario = (String) session.getAttribute("Usuario");

    String nomeUsuario = "";
    
    String busca = request.getParameter("busca");

    String botaoAdministrativo = "";
    String botaoEditarLivro = "";
    if (usuario != null)
    {
        botaoAdministrativo = "<a href='administrativo.jsp' class='btn btn-azul'>Página administrativa</a>";
        nomeUsuario = usuario;
    }
    else
    {
        botaoAdministrativo = "<a href='login.jsp' class='btn btn-cinza'>Login</a>";                
        nomeUsuario = "Usuário não logado";
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Página Inicial - Catálogo Virtual</title>
    </head>
    <body>
      <div class="conteudo">
        <h1>Catálogo virtual</h1>
        <div class="nome-do-usuario">
          <% out.print(nomeUsuario); %>
        </div>
        <div class="row">
            <form method="get" class="col-9">
                <input class="form-control" name="busca" placeholder="buscar por título" value="<%= busca != null ? busca : "" %>">
            </form>
            <div class="text-end col-3">
                <% out.print(botaoAdministrativo); %>
            </div>
        </div>
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Capa</th>
              <th>Titulo</th>
              <th>Autor</th>
              <th>Preço</th>
              <th>Ano</th>
              <th>Editora</th>
            </tr>
          </thead>
          <tbody>
            <% 
                try {
                    int linhasRetornadas = 0;

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                    st = con.createStatement();
                    
                    String sqlQuery = "";
                    
                    if (busca != null && busca != "")
                    {
                        sqlQuery = "select * from livro l, editora e where e.id = l.id_editora and (l.titulo like '"+busca+"' or l.titulo like '%"+busca+"' or l.titulo like '"+busca+"%' or l.titulo like '%"+busca+"%')";
                    }   
                    else                    
                        sqlQuery = "select * from livro l, editora e where e.id = l.id_editora";
                    
                    rs = st.executeQuery(sqlQuery);
                    while(rs.next()){ %>

                      <tr>
                        <th>
                            <img src="imagem.jsp?id=<%=rs.getString("l.id")%>" height="100px"/>
                            </th>
                        <td><%= rs.getString("l.titulo")%></td>
                        <td><%= rs.getString("l.autor")%></td>
                        <td>R$ <%= rs.getString("l.preco")%></td>
                        <td><%= rs.getString("l.ano")%></td>
                        <td><%= rs.getString("e.nome")%></td>
                        <% if (usuario != null) { out.print("<td><a href='editarLivro.jsp?id="+rs.getString("l.id")+"'class='btn btn-cinza'>Editar</a></td>"); } %>
                      </tr>

                    <%
                    }
               } catch (Exception e) {
                   out.print(e);
               }
            %>
          </tbody>
        </table>
      </div>
    </body>
</html>