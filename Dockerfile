FROM jupyter/base-notebook


USER root

# get McCode debian packages: release 2.7.1
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-comps-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-manuals-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-suite-python_2.7.1_all.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-matlab-mcplot-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-perl-cmdline-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mccodelib-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdisplay-pyqtgraph-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdisplay-webgl-2.7.1-deb64.deb 
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdoc-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcgui-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcplot-matplotlib-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcplot-pyqtgraph-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcplot-svg-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcrun-2.7.1-deb64.deb 
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-ncrystal-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcresplot-2.7.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdisplay-mantid-2.7.1-deb64.deb

# get McCode debian packages: release 3.1
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-comps-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-manuals-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-suite-python-ng_3.1_all.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-matlab-mcplot-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-perl-cmdline-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mccodelib-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdisplay-pyqtgraph-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdisplay-webgl-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdoc-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcgui-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcplot-matplotlib-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcplot-pyqtgraph-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcrun-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-ncrystal-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcresplot-3.1-deb64.deb
RUN wget http://packages.mccode.org/debian/dists/stable/main/binary-amd64/mcstas-tools-python-mcdisplay-mantid-3.1-deb64.deb


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
   evince \
   gnuplot \
   octave \
   libopenmpi-dev \
   libnexus1 \
   libnexus-dev
   
# install McStas, and make sure we use the python from the system for it
RUN apt install -y ./*.deb
RUN rm *.deb
RUN ln -s /usr/bin/python3.8 /usr/share/mcstas/2.7.1/bin/python3
RUN ln -s /usr/bin/python3.8 /usr/share/mcstas/2.7.1/bin/
RUN ln -s /usr/bin/python3.8 /usr/share/mcstas/3.1/bin/python3
RUN ln -s /usr/bin/python3.8 /usr/share/mcstas/3.1/bin/

# configure McStas 2.7.1 launcher to install PATH via a script
RUN echo "#!/bin/sh" > /usr/local/bin/mcgui271_noconda
RUN echo "export PATH=/usr/share/mcstas/2.7.1/bin:$PATH" >> /usr/local/bin/mcgui271_noconda
RUN echo "conda deactivate" >> /usr/local/bin/mcgui271_noconda
RUN echo "mcgui" >> /usr/local/bin/mcgui271_noconda
RUN sed -i 's|Exec=mcgui|Exec=/usr/local/bin/mcgui271_noconda|' /usr/share/applications/McStas-2.7.1-py.desktop
RUN chmod a+x /usr/local/bin/mcgui271_noconda

# configure McStas 3.1 launcher to install PATH via a script
RUN echo "#!/bin/sh" > /usr/local/bin/mcgui31_noconda
RUN echo "export PATH=/usr/share/mcstas/3.1/bin:$PATH" >> /usr/local/bin/mcgui31_noconda
RUN echo "conda deactivate" >> /usr/local/bin/mcgui31_noconda
RUN echo "mcgui" >> /usr/local/bin/mcgui31_noconda
RUN sed -i 's|Exec=mcgui|Exec=/usr/local/bin/mcgui31_noconda|' /usr/share/applications/McStas-3.1-py.desktop
RUN chmod a+x /usr/local/bin/mcgui31_noconda

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

COPY McStasScript/configuration.yaml  /opt/conda/lib/python3.9/site-packages/mcstasscript/
