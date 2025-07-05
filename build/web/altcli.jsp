<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alteração de clientes</title>
    </head>
    <body>
        <%
            // Recebe o CPF do cliente que será alterado
            String cpf;
            cpf = request.getParameter("cpf");

            try {
                // Conectar ao Banco de Dados
                Connection conecta; // Classe utilizada para se conectar com obanco de dados 
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://mysql-db:3306/controleclientes", "root", "admin");

                // Buscar CPF no banco de dados
                st = conecta.prepareStatement("SELECT * FROM clientes WHERE cpfcli = ?");

                // A linha abaixo, determina que o primeiro ?, será substituída pela variável cpf
                st.setString(1, cpf);

                // Executa o comando SELECT e armazena na variável resultado
                ResultSet resultado = st.executeQuery();

                // Se a variável resultado não tiver um usuário existente
                if (resultado.next()) {
                    out.print("Cliente encontrado com CPF: " + resultado.getString("cpfcli"));

                %>
                    <form method="post" action="alterar_dados.jsp">
                        <p>
                            <label for="cpf"> CPF </label>
                            <input type="text" name="cpf" size="15" id="cpf" value="<%=resultado.getString("cpfcli")%>" readonly>
                        </p>
                        <p>
                            <label for="nome"> Nome </label>
                            <input type="text" name="nome" size="55" id="nome" maxlength="55" value="<%=resultado.getString("nomecli")%>">
                        </p>
                        <p>
                            <label for="endereco"> Endereço </label>
                            <input type="text" name="endereco" size="55" id="endereco" maxlength="55" value="<%=resultado.getString("endcli")%>">
                        </p>
                        <p>
                            <label for="telefone"> Telefone </label>
                            <input type="tel" name="telefone" size="15" id="telefone" maxlength="15" value="<%=resultado.getString("telcli")%>">
                        </p>
                        <p>
                            <input type="submit" value="Salvar Alterações"> 
                        </p>            
                    </form>
                <%
                } else {
                    out.print("Cliente NÃO encontrado");
                    }
                %>

                <%
                } catch (Exception e) {
                    out.print(e.getMessage());
                }
            %>
    </body>
</html>
