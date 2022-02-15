FROM jupyter/base-notebook


USER root

# get McCode debian packages
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-comps-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-manuals-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-suite-python_1.7_all.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-matlab-mxplot-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-perl-cmdline-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mccodelib-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxdisplay-pyqtgraph-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxdisplay-webgl-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxdoc-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxplot-matplotlib-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxplot-svg-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxplot-pyqtgraph-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxrun-1.7-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcxtrace-tools-python-mxgui-1.7-deb64.deb

RUN apt-get -y update \
 && apt-get install -y dbus-x11 \
   firefox \
   xfce4 \
   xfce4-panel \
   xfce4-session \
   xfce4-settings \
   xorg \
   xubuntu-icon-theme \
   view3dscene \
   libopenmpi-dev
   
RUN apt install -y ./*.deb

# Remove light-locker to prevent screen lock
RUN wget 'https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download' -O turbovnc_2.2.5_amd64.deb && \
   apt-get install -y -q ./turbovnc_2.2.5_amd64.deb && \
   apt-get remove -y -q light-locker && \
   rm ./turbovnc_2.2.5_amd64.deb && \
   ln -s /opt/TurboVNC/bin/* /usr/local/bin/

# apt-get may result in root-owned directories/files under $HOME
RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

USER $NB_USER
RUN cd /opt/install && \
   conda env update -n base --file environment.yml
