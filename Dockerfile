FROM quay.io/jupyter/base-notebook:ubuntu-22.04

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
   libopenmpi-dev \
   libnexus1 \
   libnexus-dev \
   git \
   firefox

# install McStas, and make sure we use the python from the system for it, and let conda-based Python modules be used from with McStas
#RUN ln -s /opt/conda /usr/share/mcstas/3.4/miniconda3


# Remove light-locker to prevent screen lock
RUN wget 'https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download' -O turbovnc_2.2.5_amd64.deb && \
   apt-get install -y -q ./turbovnc_2.2.5_amd64.deb && \
   apt-get remove -y -q light-locker xfce4-screensaver && \
   rm ./turbovnc_2.2.5_amd64.deb && \
   ln -s /opt/TurboVNC/bin/* /usr/local/bin/

# apt-get may result in root-owned directories/files under $HOME
RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

# RUN /usr/bin/mcdoc -i

USER $NB_USER
RUN cd /opt/install && \
   conda env update -n base --file environment.yml

RUN /opt/conda/bin/mcdoc -i

COPY McStasScript/configuration.yaml  /opt/conda/lib/python3.10/site-packages/mcstasscript/

#### Git puller ####

RUN pip install nbgitpuller
# this used to be needed if running an old version of Jupyter Notebook
# RUN jupyter serverextension enable nbgitpuller --sys-prefix

# this is for testing whether git puller is working when running container locally
RUN jupyter labextension enable nbgitpuller

