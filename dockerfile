FROM mcr.microsoft.com/dotnet/sdk:5.0 as dev

WORKDIR /work

COPY ./src/work.csproj /work/work.csproj
RUN dotnet restore

COPY ./src /work
RUN mkdir /out/

RUN dotnet publish --no-restore --output /out/ --configuration Release

FROM mcr.microsoft.com/dotnet/aspnet:5.0 as prod

RUN mkdir /app/
WORKDIR /app/

COPY --from=dev /out/ /app/
RUN chmod +x /app/
CMD dotnet work.dll