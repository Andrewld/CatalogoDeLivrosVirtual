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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Editar Livro</title>
    </head>
    <body>
         <div class="conteudo">
        <h1>Editar Livro</h1>
         <div class="nome-do-usuario">
                <% out.print(nomeUsuarioLogado); %>
        </div>
        
        <a class="btn btn-cinza btn-sm" href="index.jsp">Voltar</a>

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
        <form action="editarLivro" enctype="multipart/form-data" method="post">
            <input type="text" class="form-control" id="livroId" name="livroId" value="<%= rs.getString("id")%>" hidden="true" required>
            
            <label class="form-label">Título</label>
            <input type="text" class="form-control" id="titulo" name="titulo" value="<%= rs.getString("titulo")%>" required>
        
            <label class="form-label">Autor</label>
            <input type="text" class="form-control" id="autor" name="autor" value="<%= rs.getString("autor")%>" required>
        
            <label class="form-label">Ano</label>
            <input type="text" class="form-control" id="ano" name="ano" value="<%= rs.getString("ano")%>" required>
        
            <label class="form-label">Preço</label>
            <input type="text" class="form-control" id="preco" name="preco" value="<% out.print(rs.getString("preco")); %>" required>
        
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

            <label class="form-label">Imagem da capa</label>
            <input class="form-control" type="file" id="imagem" name="imagem">
            
            <button type="submit" class="btn btn-azul">Salvar</button>
        </form>
        <%
            }
            } catch (Exception e) {
            }
        %>
    </body>
</html>