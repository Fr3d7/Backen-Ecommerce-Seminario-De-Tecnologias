# syntax=docker/dockerfile:1

# ===== build =====
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore ./src/Api/Ecommerce.Api.csproj
RUN dotnet publish ./src/Api/Ecommerce.Api.csproj -c Release -o /app/out

# ===== runtime =====
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["sh","-c","dotnet Ecommerce.Api.dll --urls http://0.0.0.0:${PORT}"]
