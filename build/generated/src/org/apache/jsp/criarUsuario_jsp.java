package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import com.mysql.jdbc.Driver;

public final class criarUsuario_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("\r\n");
 
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    
    String usuario = (String) session.getAttribute("Usuario");
    
    String nomeUsuarioLogado = "";

    if (usuario != null)
        nomeUsuarioLogado = usuario;
    else
        response.sendRedirect("login.jsp");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3\" crossorigin=\"anonymous\">\r\n");
      out.write("        <title>Criar Usuário</title>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        <div class=\"container\">\r\n");
      out.write("            <h1>Criar Usuário</h1>\r\n");
      out.write("            ");
 out.print(nomeUsuarioLogado); 
      out.write("\r\n");
      out.write("            <hr />\r\n");
      out.write("            <div class=\"mt-2\">\r\n");
      out.write("                <form method=\"post\">\r\n");
      out.write("                    <div class=\"mb-3\">\r\n");
      out.write("                      <label for=\"exampleInputEmail1\" class=\"form-label\">Nome completo</label>\r\n");
      out.write("                      <input type=\"text\" class=\"form-control\" id=\"nome\">\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"mb-3\">\r\n");
      out.write("                      <label for=\"exampleInputEmail1\" class=\"form-label\">Nome de usuário</label>\r\n");
      out.write("                      <input type=\"text\" class=\"form-control\" id=\"username\">\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"mb-3\">\r\n");
      out.write("                      <label for=\"exampleInputEmail1\" class=\"form-label\">Perfil</label>\r\n");
      out.write("                      <input type=\"text\" class=\"form-control\" id=\"perfil\" value=\"admin\" disabled>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"mb-3\">\r\n");
      out.write("                      <label for=\"exampleInputPassword1\" class=\"form-label\">Senha</label>\r\n");
      out.write("                      <input type=\"password\" class=\"form-control\" id=\"senha\">\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-primary\">Salvar</button>\r\n");
      out.write("              </form>\r\n");
      out.write("                 ");

                    String username = request.getParameter("username");
                    String senha = request.getParameter("senha");
                    String perfil = request.getParameter("perfil");
                    String nome = request.getParameter("nome");

                    try {
                          if (nome != null && username != null && perfil != null && senha != null ){
                              
                              out.print("não estão nulos");
                              String nomeUsuario = "";
                              int linhasRetornadas = 0;
                              Class.forName("com.mysql.cj.jdbc.Driver");
                              con = DriverManager.getConnection("jdbc:mysql://localhost/catalogo_biblioteca?useTimeZone=true&serverTimezone=UTC&user=root&password=");
                              st = con.createStatement();
                              String str = "insert into usuario (username, senha, perfil, nome) values ('"+username+"', '"+senha+"', '"+perfil+"', '"+nome+"')";
                              rs = st.executeQuery(str);
                              while(rs.next()){
                              //nomeUsuario = rs.getString(5);
                              //out.println(rs.getString(5));
                              rs.last();
                              linhasRetornadas = rs.getRow();

                              }

                              out.print(linhasRetornadas+"<br>");

//                              if (linhasRetornadas > 0)
//                              {
//                                  out.print("Usuário Logado");
//                                  session.setAttribute("Usuario", nomeUsuario);
//                                  response.sendRedirect("index.jsp");
//                              }
//                              else{
//                                  out.print("Usuário ou senha incorretos!");
//                              }
                          }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    
              
      out.write("\r\n");
      out.write("            </div>\r\n");
      out.write("        </<div>\r\n");
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("    </body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
