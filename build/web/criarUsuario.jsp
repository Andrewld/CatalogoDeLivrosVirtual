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
        <title>Criar Usuário</title>
    </head>
    <body>
        <div class="conteudo">
            <h1>Criar usuário</h1>
            <div class="nome-do-usuario">
                <% out.print(nomeUsuarioLogado); %>
            </div>
              
            <div class="mt-2">
                <a class="btn btn-secondary btn-sm" href="administrativo.jsp">Voltar</a>
            </div>
            
            <hr />
            
            <div class="mt-2">
                <form method="post">
                    <div class="mb-3">
                      <label class="form-label">Nome completo</label>
                      <input type="text" class="form-control" id="nome" name="nome" >
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Nome de usuário</label>
                      <input type="text" class="form-control" id="username" name="username" >
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Perfil</label>
                      <input type="text" class="form-control" id="perfil" name="perfil"  value="admin" readonly>
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Senha</label>
                      <input type="password" class="form-control" id="senha" name="senha" >
                    </div>
                    <button type="submit" class="btn btn-primary">Salvar</button>
              </form>
                <%
                    String username = request.getParameter("username");
                    String senha = request.getParameter("senha");
                    String perfil = request.getParameter("perfil");
                    String nome = request.getParameter("nome");

                    try {
                          if (nome != null && username != null && perfil != null && senha != null ){
                              
                              Class.forName("com.mysql.cj.jdbc.Driver");
                              con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                              st = con.createStatement();
                              String str = "insert into usuario (username, senha, perfil, nome) values ('"+username+"', '"+senha+"', '"+perfil+"', '"+nome+"')";
                              st.executeUpdate(str);
                              
                              response.sendRedirect("administrativo.jsp");
                          }
                        } catch (Exception e) {
                            out.print(e);
                        }
                %>
            </div>
        </<div>
            
            
            
    </body>
</html>
