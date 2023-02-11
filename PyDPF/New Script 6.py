'''NOTE : All workflows will not be recorded, as recording is under development.'''


#region Context Menu Action
analysis_24 = DataModel.GetObjectById(24)
imported_load_group_157 = analysis_24.AddImportedLoadResultFile()
#endregion

#region Details View Action
imported_load_group_157.ResultFile = r'C:\Users\160047412\Desktop\workbench\cubic test\cubic test_files\dp0\SYS\MECH\workingDirectory\Results\OctaveResults'
#endregion

#region Context Menu Action
imported_load_group_150 = DataModel.GetObjectById(150)
imported_temperature_158 = imported_load_group_150.AddImportedTemperature()
#endregion

#region Details View Action
selection = ExtAPI.SelectionManager.CreateSelectionInfo(SelectionTypeEnum.GeometryEntities)
selection.Ids = [16]
imported_temperature_158.Location = selection
#endregion

#region Context Menu Action
imported_load_id_list = [158]
for imported_load_id in imported_load_id_list:
    imported_load = DataModel.GetObjectById(imported_load_id)
    imported_load.ImportLoad()
#endregion

#region Context Menu Action
temperature_162 = analysis_24.AddTemperature()
#endregion

#region Context Menu Action
solution_25 = DataModel.GetObjectById(25)
user_defined_result_163 = solution_25.AddUserDefinedResult()
#endregion

#region Details View Action
user_defined_result_163.Expression = r'TEMP'
#endregion

'''NOTE : All workflows will not be recorded, as recording is under development.'''


#region Context Menu Action
temperature_result_164 = solution_25.AddTemperature()
#endregion

#region Miscellaneous commands
user_defined_result_163.EvaluateAllResults()
#endregion

