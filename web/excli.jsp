<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir clientes</title>
    </head>
    <body>
        <%
            String cpf;
            cpf = request.getParameter("cpf");

            try {

                //Conectar com o banco de dados
                Connection conecta; // Classe utilizada para se conectar com obanco de dados 
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://mysql-db:3306/controleclientes", "root", "admin");

                // Exclui clientes da tabela
                st = conecta.prepareStatement("DELETE FROM clientes WHERE cpfcli=?");
                st.setString(1, cpf);

                // Executa o comando DELETE e obtém o número de linhas afetadas
                int linhasAfetadas = st.executeUpdate();

                if (linhasAfetadas == 0) {
                    out.print("Cliente com CPF " + cpf + " não encontrado.");
                } else {
                    out.print("Cliente com CPF " + cpf + " excluído com sucesso.");
                }

            } catch (Exception e) {
                out.print("Parece que estamos com problemas: " + e.getMessage());
            }
        %>
    </body>
</html>
