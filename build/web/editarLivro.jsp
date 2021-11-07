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
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Livro</title>
    </head>
    <body>
         <div class="container">
        <h1>Editar Livro</h1>
         <% out.print(nomeUsuarioLogado); %>
              
        <div class="mt-2">
            <a class="btn btn-secondary btn-sm" href="index.jsp">Voltar</a>
        </div>

        <hr />
        <%
        try {
        
        String id = request.getParameter("id");

        st = con.createStatement();
        String str = "select * from livro where id = '"+id+"'";
        rs = st.executeQuery(str);
        while(rs.next()){ 
        String id_editora = rs.getString("id_editora");
        %>        
          
        <div class="mt-2">
            <form action="editarLivro" enctype="multipart/form-data" method="post">
                <input type="text" class="form-control" id="livroId" name="livroId" value="<%= rs.getString("id")%>" hidden="true">
                <div class="mb-3">
                  <label class="form-label">Título</label>
                  <input type="text" class="form-control" id="titulo" name="titulo" value="<%= rs.getString("titulo")%>">
                </div>
                <div class="mb-3">
                  <label class="form-label">Autor</label>
                  <input type="text" class="form-control" id="autor" name="autor" value="<%= rs.getString("autor")%>">
                </div>
                <div class="mb-3">
                  <label class="form-label">Ano</label>
                  <input type="text" class="form-control" id="ano" name="ano" value="<%= rs.getString("ano")%>">
                </div>
                
                <div class="mb-3">
                  <label class="form-label">Preço</label>
                  <input type="text" class="form-control" id="preco" name="preco" value="<% out.print(rs.getString("preco")); %>">
                </div>
                <div class="mb-3">
                  <label class="form-label">Editora</label>

                    <select class="form-select" id="editora" name="editora">
                        <% 
                            try {       
                                int linhasRetornadas = 0;

                                st = con.createStatement();
                                str = "select * from editora";
                                rs = st.executeQuery(str);
                                  while(rs.next()){ 
                                        if (id_editora.equals(rs.getString("id")))
                                        { 
                                            out.print("<option value='"+rs.getString("id")+"' selected>"+rs.getString("nome")+"</option>");
                                        }
                                        else    
                                            out.print("<option value='"+rs.getString("id")+"'>"+rs.getString("nome")+"</option>");
                                    
                               }
                           } catch (Exception e) {
                               out.print(e);
                           }
                        %>
                    </select>
                </div>
                    
                
                <div class="mb-3">
                  <label class="form-label">Imagem da capa</label>
                  <input class="form-control" type="file" id="imagem" name="imagem">
                </div>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </form>
        </<div>
        <%
            }

            } catch (Exception e) {
            }

        %>
    </body>
</html>