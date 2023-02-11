# -*- coding: utf-8 -*-
"""
Created on Fri Feb 10 21:09:02 2023

@author: 160047412
"""

from ansys.mapdl.core import launch_mapdl

# Start MAPDL as a service and disable all but error messages.
from ansys.mapdl.core.examples import vmfiles

mapdl = launch_mapdl()

# A specific property under the mapdl class is dedicated for XPL. It's
# based on the APDLMath `*XPL` command.
xpl = mapdl.xpl

# Many commands are directly accessible through the xpl class:
help(xpl)