<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar dados</title>
    </head>
    <body>
        <%
            // Receber os dados digitados no formulário cadcli.html
            // Definir as variáveis do formulário de cadastro
            
            String nome;
            String endereco;
            String telefone;
            String cpf;

            // Coletar as variáveis que foram inseridas no formulário
            nome = request.getParameter("nome");
            endereco = request.getParameter("endereco");
            telefone = request.getParameter("telefone");
            cpf = request.getParameter("cpf");
            
            // Conectar ao Banco de Dados
            Connection conecta; // Classe utilizada para se conectar com obanco de dados 
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://mysql-db:3306/controleclientes", "root", "admin");
            
            // Alterar os dados na tebela clientes do BD
            st = conecta.prepareStatement("UPDATE clientes SET nomecli = ?, endcli = ?, telcli = ? WHERE cpfcli = ?");
            
            st.setString(1, nome);
            st.setString(2, endereco);
            st.setString(3, telefone);
            st.setString(4, cpf);
            st.executeUpdate();
            
            out.print("Os dados " + cpf + " foram alterados com sucesso");
        %>
    </body>
</html>
