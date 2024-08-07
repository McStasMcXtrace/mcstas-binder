FROM quay.io/jupyter/base-notebook:4d70cf8da953

USER root

RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:mozillateam/ppa \
&& echo 'Package: *' > /etc/apt/preferences.d/mozilla-firefox \
&& echo Pin: release o=LP-PPA-mozillateam >> /etc/apt/preferences.d/mozilla-firefox \
&& echo Pin-Priority: 1001 >> /etc/apt/preferences.d/mozilla-firefox \
&& apt-get install -y dbus-x11 \
   xfce4 \
   xfce4-panel \
   xfce4-session \
   xfce4-settings \
   xorg \
   xubuntu-icon-theme \
   view3dscene \
   python3-pyqt5 \
   xdg-utils \
   gedit \
   gedit-plugins \
   evince \
   gnuplot \
   octave \
   rxvt-unicode \
   git \
   firefox \
   libxm4  \
&& apt-get -y clean

# Remove light-locker to prevent screen lock
RUN wget 'https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download' -O turbovnc_2.2.5_amd64.deb && \
   apt-get install -y -q ./turbovnc_2.2.5_amd64.deb && \
   apt-get remove -y -q light-locker xfce4-screensaver && \
   rm ./turbovnc_2.2.5_amd64.deb && \
   ln -s /opt/TurboVNC/bin/* /usr/local/bin/ && \
   WORKDIR=${PWD} && wget https://www.ill.eu/sites/fullprof/downloads/FullProf_Suite_July2024_Linux64_ifx.tgz && \
   mkdir /opt/FullProf && cd /opt/FullProf && tar xzf ${WORKDIR}/FullProf_Suite_July2024_Linux64_ifx.tgz && \
   cd ${WORKDIR} && rm FullProf_Suite_July2024_Linux64_ifx.tgz && \
   chown -R $NB_UID:$NB_GID $HOME /opt/FullProf

ADD . /opt/install
RUN cd /opt/install && \
    conda config --add channels mantid && \
    fix-permissions /opt/install 

USER $NB_USER
RUN cd /opt/FullProf && /opt/FullProf/Set_FULLPROF_Envi

RUN cd /opt/install && \
   mamba env update -n base --file environment.yml && \
   mamba clean -all -y

COPY McStasScript/configuration.yaml  /opt/conda/lib/python3.10/site-packages/mcstasscript/
