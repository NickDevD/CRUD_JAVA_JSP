# Dockerfile
# Coloque este arquivo na raiz do seu projeto 'formulario_web' (ao lado de 'build/', 'Web Pages/', etc.)

# Estágio de Build (ambiente temporário para acesso aos arquivos do projeto)
# Usaremos um JDK 17 para este estágio.
FROM openjdk:17-jdk-slim AS build_env

WORKDIR /app

# Copie TODO o conteúdo do seu projeto (incluindo 'build/') para o contêiner no estágio de build.
COPY . .

# Estágio de Execução (imagem final mais leve com Tomcat e JRE)
# A versão do Tomcat e JRE deve ser compatível com seu JDK (ex: Tomcat 9.x com JDK 17).
FROM tomcat:9.0.80-jdk17-temurin

# Defina o diretório de trabalho padrão dentro da imagem do Tomcat.
# Sua aplicação será implantada na raiz do servidor web.
WORKDIR /usr/local/tomcat/webapps/ROOT/

# Remove qualquer conteúdo padrão que possa existir no diretório ROOT
# da imagem base do Tomcat para evitar conflitos.
RUN rm -rf *

# Copie a saída da sua build do NetBeans (o "exploded WAR" da pasta build/web/)
# para o diretório ROOT do Tomcat no contêiner.
# O caminho 'build/web/' é relativo ao contexto do build (a raiz do seu projeto 'formulario_web').
COPY --from=build_env /app/build/web/ .

# Exponha a porta padrão do Tomcat
EXPOSE 8080

