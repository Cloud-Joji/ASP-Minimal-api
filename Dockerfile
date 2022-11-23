#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debuggings.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# Copia el archivo de project a una carpeta (1)
COPY ["ASPMinimalAPI.csproj", "ASPMinimalAPI/"]
# Este comando RUN genera una nueva carpeta (2), en este caso se llama obj
RUN dotnet restore "/src/ASPMinimalAPI/ASPMinimalAPI.csproj"
# Copia todo del local a la carpeta base (1)
COPY . .
# Se trabaja ahora en la carpeta base (1)
WORKDIR "/src/ASPMinimalAPI"
RUN dotnet build "ASPMinimalAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ASPMinimalAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /src/app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ASPMinimalAPI.dll"]
