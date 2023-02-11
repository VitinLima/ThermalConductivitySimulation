# -*- coding: utf-8 -*-
"""
Created on Fri Feb 10 21:22:34 2023

@author: 160047412
"""

from ansys.dpf import core as dpf 

my_file_path = r'results.rth'
my_data_sources = dpf.DataSources(my_file_path)
my_model = dpf.Model(my_data_sources)
my_mesh = my_model.metadata.meshed_region 
temperature_op = my_model.results.temperature()
my_export = dpf.operators.serialization.vtk_export()
my_export.inputs.file_path.connect(r'fileNew.vtk')
my_export.inputs.fields1.connect(temperature_op.outputs.fields_container)
my_export.inputs.mesh.connect(my_mesh)
my_export.run()