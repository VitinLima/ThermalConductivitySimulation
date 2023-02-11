import mech_dpf
import Ans.DataProcessing as dpf

mech_dpf.setExtAPI(ExtAPI)
data_source = dpf.DataSources(current_analysis.ResultFileName)
t = dpf.operators.result.temperature()
t.inputs.data_sources.Connect(data_source)
field = t.outputs.fields_container
temperature_data = field.GetData()[0]
temperature_data.Data = [float(i) for i in range(1623)]

wkf = dpf.Workflow()
wkf.Add(t)
wkf.SetOutputContour(t)
wkf.Record('wf_id', False)
wkf.WriteToFile(os.path.join(working_directory, 'new_file.rth'))