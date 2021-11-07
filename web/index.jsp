<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<% 
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    String usuario = (String) session.getAttribute("Usuario");

    String nomeUsuario = "";

    String botaoAdministrativo = "";
    String botaoEditarLivro = "";
    if (usuario != null)
    {
        botaoAdministrativo = "<a href='administrativo.jsp' class='btn btn-primary'>Página administrativa</a>";
        nomeUsuario = usuario;
    }
    else
    {
        botaoAdministrativo = "<a href='login.jsp' class='btn btn-secondary'>Login</a>";                
        nomeUsuario = "Usuário não logado";
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página Inicial - Catálogo Virtual</title>
    </head>
    <body>
      <div class="container">
        <h1>Catálogo virtual</h1>
        <% out.print(nomeUsuario); %>
        
        <div class="row mt-3">
            <form method="get" class="col-9">
                <input class="form-control" name="busca" placeholder="buscar por título">
            </form>
            <div class="text-end col-3">
                <% out.print(botaoAdministrativo); %>
            </div>
        </div>
            
        <table class="table table-striped">
          <thead>
            <tr>
              <th scope="col">Capa</th>
              <th scope="col">Titulo</th>
              <th scope="col">Autor</th>
              <th scope="col">Preço</th>
              <th scope="col">Ano</th>
              <th scope="col">Editora</th>
            </tr>
          </thead>
          <tbody>
            <% 
                try {       
                    int linhasRetornadas = 0;
                    
                    String busca = request.getParameter("busca");
                    
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
                        <th scope="row">
                            <img src="imagem.jsp?id=<%=rs.getString("l.id")%>" height="100px"/>
                            </th>
                        <td><%= rs.getString("l.titulo")%></td>
                        <td><%= rs.getString("l.autor")%></td>
                        <td>R$ <%= rs.getString("l.preco")%></td>
                        <td><%= rs.getString("l.ano")%></td>
                        <td><%= rs.getString("e.nome")%></td>
                        <% if (usuario != null) { out.print("<td><a href='editarLivro.jsp?id="+rs.getString("l.id")+"'class='btn btn-secondary'>Editar</a></td>"); } %>
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