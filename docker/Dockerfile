FROM node:14-alpine

LABEL mainteiner="Pato Perpetua <patoperpetua@singletonsd.com>" \
    name="registry.gitlab.com/patricioperpetua/resume/builder" \
    architecture="x86_64" \
    vendor="SINGLETON" \
    vcs-type="git" \
    vcs-url="https://gitlab.com/registry.gitlab.com/patricioperpetua/resume.git" \
    distribution-scope="private" \
    Summary="Image to build resume using hackmyresume."

ADD scripts/install_packages.sh /

RUN apk add --no-cache bash curl git grep lftp wget wkhtmltopdf ca-certificates unzip msttcorefonts-installer fontconfig libgcc libstdc++ libx11 glib libxrender-dev libintl libgcc libcrypto1.1

RUN update-ms-fonts

# Google fonts
RUN wget https://github.com/google/fonts/archive/main.tar.gz -O gf.tar.gz
RUN tar -xf gf.tar.gz
RUN mkdir -p /usr/share/fonts/truetype/google-fonts
RUN find $PWD/fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN rm -f gf.tar.gz

# Font Awesome
RUN wget https://use.fontawesome.com/releases/v5.9.0/fontawesome-free-5.9.0-desktop.zip -O fontAwesome.zip && \
  unzip -qq fontAwesome.zip && mkdir -p /usr/share/fonts/opentype && \
  mv fontawesome-free-5.9.0-desktop/otfs /usr/share/fonts/opentype && \
  fc-cache -fv

RUN fc-cache -f && rm -rf /var/cache/*

# ADD ../scripts/installers /

# RUN ./installer_all.sh