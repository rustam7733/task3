FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Копируем файл решения и проект из подпапки
COPY ["task3.sln", "./"]
COPY ["task3/task3.csproj", "task3/"]

RUN dotnet restore "task3/task3.csproj"

# Копируем всё остальное
COPY . .
WORKDIR "/src/task3"
RUN dotnet publish "task3.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Установка порта для Render
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "task3.dll"]
