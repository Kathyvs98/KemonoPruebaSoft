FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore ./appcomics.csproj

COPY . ./
RUN dotnet publish ./appcomics.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build-env /app/out .

# Nombre del archivo .dll generado por tu aplicación
ENV APP_NET_CORE appcomics.dll 

CMD ASPNETCORE_URLS=http://*:$PORT dotnet $APP_NET_CORE
