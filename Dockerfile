FROM mediawiki:1.42

COPY ./extensions ./extensions
COPY ./tools ./tools
RUN ["curl", "-L", "https://github.com/42-Community/FTOAuth/archive/refs/tags/v0.1.1.tar.gz", "-o", "./extensions/FTOAuth.tgz"]

# Extract extensions 
RUN ["./tools/extract-extensions.sh"]

RUN mv ./extensions/FTOAuth-* ./extensions/FTOAuth

COPY ./ExtraLocalSettings.php ./

# Startup script
CMD ["./tools/start.sh"]
