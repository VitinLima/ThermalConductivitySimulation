def define_dpf_workflow(analysis):
    import mech_dpf
    import Ans.DataProcessing as dpf
    
    mech_dpf.setExtAPI(ExtAPI)
    data_source = dpf.DataSources(solution.ResultFilePath)
    t = dpf.operators.result.temperature()
    t.inputs.data_sources.Connect(data_source)
    
    data_fieldc = t.outputs.getfields_container()
    
    #forward to plot
    output = dpf.operators.utility.forward()
    output.inputs.any.Connect(t)
    
    dpf_workflow = dpf.Workflow()
    dpf_workflow.Add(output)
    dpf_workflow.SetOutputContour(output)
    dpf_workflow.Record('wf_id', False)
    this.WorkflowId = dpf_workflow.GetRecordedId()

define_dpf_workflow(current_analysis)
