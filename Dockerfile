#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debuggings.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ASPMinimalAPI.csproj", "ASPMinimalAPI/"]
RUN dotnet restore "/src/ASPMinimalAPI/ASPMinimalAPI.csproj"

WORKDIR "/src/ASPMinimalAPI"
COPY . .

RUN dotnet build "ASPMinimalAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ASPMinimalAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /src/app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ASPMinimalAPI.dll"]
