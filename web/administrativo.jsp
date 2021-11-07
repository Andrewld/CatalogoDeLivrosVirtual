<% 
    String usuario = (String) session.getAttribute("Usuario");
    
    String nomeUsuario = "";

    if (usuario != null)
        nomeUsuario = usuario;
    else
        response.sendRedirect("login.jsp");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <title>Página Administrativa</title>
    </head>
    <body>
        <div class="container">
            <h1>Página administrativa</h1>
            <% out.print(nomeUsuario); %>
            
            <div class="mt-2">
                <a class="btn btn-secondary btn-sm" href="index.jsp">Voltar</a>
            </div>
            
            <hr /> 
            
            <div class="card mb-2">
                <div class="card-header">
                  Administradores
                </div>
                <div class="card-body">
                  <h5 class="card-title">Crie usuários administradores</h5>
                  <p class="card-text">Somente usuários com permissão de administrador podem acessar a página administrativa e suas funcionalidades.</p>
                    <a class="btn btn-primary" href="criarUsuario.jsp">Criar Usuário</a>
                </div>
            </div>
            
            <div class="card mb-2">
                <div class="card-header">
                  Livros
                </div>
                <div class="card-body">
                  <h5 class="card-title">Adicione livros ao catálogo</h5>
                  <p class="card-text">Os livros adicionados serão exibidos na listagem da página inicial.</p>
                    <a class="btn btn-primary" href="criarLivro.jsp">Adicionar Livro</a>
                </div>
            </div>
            
            <div class="card mb-2">
                <div class="card-header">
                  Editoras
                </div>
                <div class="card-body">
                  <h5 class="card-title">Adicione editoras</h5>
                  <p class="card-text">As editoras adicionadas servirão para referenciar os livros do catálogo.</p>
                    <a class="btn btn-primary" href="criarEditora.jsp">Adicionar Editora</a>
                </div>
            </div>
            
        </<div>
    </body>
</html>
