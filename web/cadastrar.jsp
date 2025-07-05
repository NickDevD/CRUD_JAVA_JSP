<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Receber os dados digitados no formulário cadcli.html
            // Definir as variáveis do formulário de cadastro
            String cpf;
            String nome;
            String endereco;
            String telefone;

            // Coletar as variáveis que foram inseridas no formulário
            cpf = request.getParameter("cpf");
            nome = request.getParameter("nome");
            endereco = request.getParameter("endereco");
            telefone = request.getParameter("telefone");

            try {
                //Conectar com o banco de dados
                Connection conecta; // Classe utilizada para se conectar com obanco de dados 
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://mysql-db:3306/controleclientes", "root", "admin");

                // Inserir os dados na tabela clientes do banco de dados
                st = conecta.prepareStatement("INSERT INTO clientes VALUES (?,?,?,?)");
                st.setString(1, cpf);
                st.setString(2, nome);
                st.setString(3, endereco);
                st.setString(4, telefone);
                st.executeUpdate(); // Executa o comando INSERT
                out.print("Cadastro realizado com sucesso");

            } catch (Exception x) {
            String erro = x.getMessage();
                if(cpf.isEmpty() || nome.isEmpty() || endereco.isEmpty() || telefone.isEmpty()){
                    out.print("Um dos campos não foi preenchido");
                }else if(erro.contains("Duplicate entry")){
                    out.print("<p style='color:orange;font-size:20px'>Cliente já cadastrado!</p>");
                }else{
                    out.print("Erro:" + x.getMessage());
                }
             } 

        %>    
    </body>
</html>
