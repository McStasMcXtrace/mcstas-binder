# McStas Binder from Jupyter Desktop Server
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/McStasMcXtrace/mcstas-binder/master?urlpath=desktop)

[McStas](http://mcstas.org/) neutron beam-line simulations in a "free" computer at Binder.

<img src="http://mcstas.org/logo-left.png"> <img src="https://mybinder.org/static/logo.svg?v=fe52c40adc69454ba7536393f76ebd715e5fb75f5feafe16a27c47483eabf3311c14ed9fda905c49915d6dbf369ae68fb855a40dd05489a7b9542a9ee532e92b">

## Usage

Click on the Binder Badge above or https://mybinder.org/v2/gh/McStasMcXtrace/mcstas-binder/master?urlpath=desktop

A full desktop, running at Binder for free, will appear in your browser after e.g. a few minutes (be patient).
The [McStas](http://mcstas.org/) software is available by opening a terminal and executing the command ```mcgui```.

You may also access the system by means of JupyterLab, use https://mybinder.org/v2/gh/McStasMcXtrace/mcstas-binder/master?urlpath=lab 

You may also run this container by means of a local Docker, podman or equivalent installation:
```podman run -p 8888:8888 docker.io/mccode/mcstas-3.4```

McStas 3.4 (with revised grammar, compilation and performance effiiency) is installed, along with the [McStasScript](https://github.com/PaNOSC-ViNYL/McStasScript) python interface. You are welcome to use MPI clustering to distribute the computations over all CPU cores. There is however no GPU support for the 3.x release.

## Credits

This tool is forked from <https://github.com/yuvipanda/jupyter-desktop-server>.
It runs a Docker container at Binder, which includes websockify, tightvnc server, and novnc.
