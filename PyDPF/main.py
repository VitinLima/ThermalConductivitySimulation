# -*- coding: utf-8 -*-
"""
Created on Mon Feb  6 01:06:07 2023

@author: 160047412
"""

from ansys.dpf import core as dpf
from ansys.dpf.core import examples

rthFile = 'file.rth'

model = dpf.Model('results.rth')
# print(model)
#model.plot()

# temp = model.results.temperature()
# fields_container = temp.outputs.fields_container()
# field = fields_container[0]
# field.data = range(len(field))
# temp = model.results.temperature()
# fields_container = temp.outputs.fields_container()
# field = fields_container[0]
# print(field.data)
# print(len(field))
# print(field.component_count)
# print(field.elementary_data_count)

new_field = dpf.Field(10, dpf.natures.scalar, dpf.locations.nodal)
new_field.data = [float(i) for i in range(10)]
new_field.Scoping = range(10)
api = model.metadata.data_sources._api

data_source = dpf.DataSources('new_field.rth')


# dataSource = dpf.DataSources(rthFile)
# temperatures = dpf.operators.result.temperature()
# temperatures.inputs.data_sources(dataSource)
# temp=temperatures.outputs.fields_container.get_data()[0]
# temp.sub_results
