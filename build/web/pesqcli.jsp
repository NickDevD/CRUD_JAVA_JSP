<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <style>
        body {
            font-family: sans-serif;
            background-color: ivory;
            margin: 0;
            padding: 0;
            min-height: 100vh; /* Garante que o corpo ocupe toda a altura da tela */
        }

        .container {
            width: 100%; /* Garante que o contêiner ocupe toda a largura da tela */
            margin: 0 auto; /* Centraliza o contêiner */
            background-color: ivory;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        *{
            margin: 0 auto
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: coral;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f0f0f0;
        }

        .menu {
            background-color: ivory;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .menu a {
            text-decoration: none;
            padding: 8px 15px;
            margin: 0 5px;
            border-radius: 3px;

        }

        .menu a:hover {
            background-color: #e2e6ea;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            color: #777;
        }
        
        /* Estilos para os botões Editar e Excluir */

        button[type="submit"] {
            padding: 8px 12px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease; /* Adiciona uma transição suave */
        }

        /* Estilo para o botão Editar */
        button[type="submit"]:nth-of-type(1) { /* Seleciona o primeiro botão dentro do formulário */
            background-color: #4CAF50; /* Verde */
            color: white;
        }

        button[type="submit"]:nth-of-type(1):hover {
            background-color: #45a049; /* Verde mais escuro no hover */
        }

        /* Estilo para o botão Excluir */
        button[type="submit"]:nth-of-type(2) { /* Seleciona o segundo botão dentro do formulário */
            background-color: #f44336; /* Vermelho */
            color: white;
        }

        button[type="submit"]:nth-of-type(2):hover {
            background-color: #d32f2f; /* Vermelho mais escuro no hover */
        }
        </style>
    </head>
    <body>
        
        <%
            String nome;
            nome = request.getParameter("nome");
            

            try {
                //Conectar com o banco de dados
                Connection conecta; // Classe utilizada para se conectar com obanco de dados 
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://mysql-db:3306/controleclientes", "root", "admin");

                // Consultar os dados na tabela clientes do banco de dados
                st = conecta.prepareStatement("SELECT * FROM clientes WHERE nomecli LIKE ?");
                st.setString(1, "%"+ nome + "%");
                ResultSet rs = st.executeQuery();// Variável que armazenará os dados do BD
        %>

        <!-- Abertura da tabela  -->
        <table>
            <tr>
                <th>CPF</th>
                <th>Nome</th>
                <th>Endereço</th>
                <th>Telefone</th>
                <th>Ações</th>
            </tr>

            <%
                // Laço de repetição que exibirá em tela o conteúdo da tabela enquanto tiver conteúdo na variável rs
                while (rs.next()) {
                    // espaço criado para inserir a tabela html que será mostrada em tela
%>

            <tr>
                <td> <%= rs.getString("cpfcli")%> </td>
                <td> <%= rs.getString("nomecli")%> </td>
                <td> <%= rs.getString("endcli")%> </td>
                <td> <%= rs.getString("telcli")%> </td>
                <td>
                    <form action="editarCliente.jsp" method="get">
                        <input type="hidden" name="cpf" value="<%= rs.getString("cpfcli")%>">
                        <button type="submit">Editar</button>
                    </form>
                    <form action="excli.jsp" method="get">
                        <input type="hidden" name="cpf" value="<%= rs.getString("cpfcli")%>">
                        <button type="submit">Excluir</button>
                    </form>
                </td>
            </tr>

            <%
                }
            %>
            <!-- Fechamento da tabela  -->    
        </table> 

        <%
            } catch (Exception x) {
                out.print("Erro:" + x.getMessage());
            }
        %>

    </body>
</html>
