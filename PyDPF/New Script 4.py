

if solution.Status!='Done':
    current_analysis.Solve()

dataSource = dpf.DataSources(rthFile)
u = dpf.operators.result.temperature()
u.inputs.data_sources.Connect(dataSource)
u.
dpf_workflow = dpf.Workflow()
dpf_workflow.Add(u)
dpf_workflow.SetOutputContour(u)
dpf_workflow.Record('wf_id', False)
#this.WorkflowId = dpf_workflow.GetRecordedId()

#nodeIds=temp.ScopingIds # Get node list from results

#with open(os.path.join(working_directory,'Results','Temperature'), 'w') as f:
#    writer = csv.writer(f, quoting=csv.QUOTE_NONNUMERIC, lineterminator='\n')
#    for i in nodeIds:
#        nodeTemp = temp.GetEntityDataById(i)
#        writer.writerow([i,nodeTemp[0]])