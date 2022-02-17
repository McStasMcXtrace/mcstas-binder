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
   python3-pyqt5 \
   xdg-utils \
   gedit \
   gedit-plugins \
   libopenmpi-dev
   
# install McXtrace, and make sure we use the python from the system for it
RUN apt install -y ./*.deb
RUN rm *.deb
RUN ln -s /usr/bin/python3.8 /usr/share/mcxtrace/1.7/bin/python3
RUN ln -s /usr/bin/python3.8 /usr/share/mcxtrace/1.7/bin/
# RUN ln -s /usr/share/mcxtrace/1.7/editors/mccode.lang /usr/share/gtksourceview-3.0/language-specs/

# configure McXtrace launcher to install PATH via a script
RUN echo "#!/bin/sh" > /usr/local/bin/mxgui_noconda
RUN echo "export PATH=/usr/share/mcxtrace/1.7/bin:$PATH" >> /usr/local/bin/mxgui_noconda
RUN echo "conda deactivate" >> /usr/local/bin/mxgui_noconda
RUN echo "mxgui" >> /usr/local/bin/mxgui_noconda
RUN sed -i 's|Exec=mxgui|Exec=/usr/local/bin/mxgui_noconda|' /usr/share/applications/McXtrace-1.7-py.desktop
RUN chmod a+x /usr/local/bin/mxgui_noconda
# RUN cp /usr/share/applications/McXtrace-1.7-py.desktop ~jovyan/Desktop
# RUN chmod a+x ~jovyan/Desktop/McXtrace-1.7-py.desktop

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
