FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app
COPY *.sln .
COPY WebApplication2/*.csproj ./WebApplication2/
COPY WebApplication2/*.config ./WebApplication2/
RUN nuget restore
COPY WebApplication2/. ./WebApplication2/
RUN msbuild /p:Configuration=Release -r:False
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
WORKDIR /inetpub/wwwroot
COPY --from=build /app/WebApplication2/. ./