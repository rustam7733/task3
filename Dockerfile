FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["task3.sln", "./"]
COPY ["task3/task3.csproj", "task3/"]
RUN dotnet restore "task3/task3.csproj"

COPY . .
WORKDIR "/src/task3"
RUN dotnet publish "task3.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "task3.dll"]
