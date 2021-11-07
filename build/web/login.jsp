<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%
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
        <title>JSP Page</title>
    </head>
    <body>
        <div class="login">
            <h1>Realizar login</h1>
            <form method="post">
                  <label>Usuário</label>
                  <input type="text" class="form-control" id="usuario" name="usuario">
                  <label>Senha</label>
                  <input type="password" class="form-control" id="senha" name="senha">
                <button type="submit" class="btn btn-azul">Entrar</button>
              </form>
              <%
                  String usuario = request.getParameter("usuario");
                  String senha = request.getParameter("senha");
                    
                  try {
                        if (usuario != null && senha != null){
                            
                            String nomeUsuario = "";
                            int linhasRetornadas = 0;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                            st = con.createStatement();
                            String str = "select * from usuario where username = '"+usuario+"' and senha = '"+senha+"'";
                            rs = st.executeQuery(str);
                            while(rs.next()){
                                nomeUsuario = rs.getString(5);
                                rs.last();
                                linhasRetornadas = rs.getRow();
                            }
                            
                            if (linhasRetornadas > 0)
                            {
                                out.print("Usuário Logado");
                                session.setAttribute("Usuario", nomeUsuario);
                                response.sendRedirect("index.jsp");
                            }
                            else{
                                out.print("Usuário ou senha incorretos!");
                            }
                        }
                      } catch (Exception e) {
                          out.print(e);
                      }
              %>
    </body>
</html>