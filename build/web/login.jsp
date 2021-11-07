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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    
    <body>
        <div class="container">
            <h1>Realizar login</h1>
            <form method="post">
                <div class="mb-3">
                  <label for="usuario" class="form-label">Usuário</label>
                  <input type="text" class="form-control" id="usuario" name="usuario">
                </div>
                <div class="mb-3">
                  <label for="senha" class="form-label">Senha</label>
                  <input type="password" class="form-control" id="senha" name="senha">
                </div>
                <button type="submit" class="btn btn-primary">Entrar</button>
              </form>
              <%
                  String usuario = request.getParameter("usuario");
                  String senha = request.getParameter("senha");
                  //out.print("aaaaaaaaaaaa<br>"+usuario+"<br>");
                    
                  try {
                        if (usuario != null && senha != null){
                            
                            String nomeUsuario = "";
                            int linhasRetornadas = 0;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                            st = con.createStatement();
                            // rs = st.executeQuery("select * from usuario where username = 'andrehonorio''"+usuario+"'");
                            String str = "select * from usuario where username = '"+usuario+"' and senha = '"+senha+"'";
                            rs = st.executeQuery(str);
                            while(rs.next()){
                            nomeUsuario = rs.getString(5);
                            //out.println(rs.getString(5));
                            rs.last();
                            linhasRetornadas = rs.getRow();
                            
                            }
                            
                            //out.print(linhasRetornadas+"<br>");
                            
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