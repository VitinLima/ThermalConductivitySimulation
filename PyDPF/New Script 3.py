import mech_dpf
import Ans.DataProcessing as dpf

mech_dpf.setExtAPI(ExtAPI)
#data_sources = mech_dpf.GetDataSources()
data_sources = dpf.DataSources(solution.ResultFilePath)
nodes_scoping = mech_dpf.GetNodesScoping()
#elements_scoping = mech_dpf.GetElementScoping()

#time_scoping = dpf.data.Scoping()
#time_scoping.Ids = [1]

temp_op = dpf.operators.result.temperature()
temp_op.inputs.data_sources.Connect(data_sources)
#temp_op.inputs.time_scoping.Connect(time_scoping)
temp_op.inputs.mesh_scoping.Connect(nodes_scoping)

t_fc = temp_op.outputs.fields_container.GetData()
t_1 = t_fc.GetFieldByTimeId(1)

t_1.Scoping.Ids

t_1.Data