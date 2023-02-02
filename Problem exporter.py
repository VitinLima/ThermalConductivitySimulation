import csv
import os

#https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/corp/v231/en/act_script/act_script_examples_print_selected_element_faces.html
g_elementTypeToElemFaceNodeIndices = {
    ElementTypeEnum.kTri3 : [ [ 0, 1, 2 ] ],
    ElementTypeEnum.kTri6 : [ [ 0, 1, 2, 4, 5, 6 ] ],
    
    ElementTypeEnum.kQuad4 : [ [ 0, 1, 2, 4 ] ],
    ElementTypeEnum.kQuad8 : [ [ 0, 1, 2, 4, 5, 6, 7, 8 ] ],

    ElementTypeEnum.kTet4 : [ [ 0, 1, 3 ], [ 1, 2, 3 ], [ 2, 0, 3 ], [ 0, 2, 1 ] ],
    ElementTypeEnum.kTet10 : [ [ 0, 1, 3, 4, 8, 7 ], [ 1, 2, 3, 5, 9, 8 ], [ 2, 0, 3, 6, 7, 9 ], [ 0, 2, 1, 6, 5, 4 ] ],

    ElementTypeEnum.kPyramid5 : [ [ 0, 3, 2, 1 ], [ 0, 1, 4 ], [ 1, 2, 4 ], [ 3, 4, 2 ], [ 0, 4, 3 ] ],
    ElementTypeEnum.kPyramid13 : [ [ 0, 3, 2, 1, 8, 7, 6, 5 ], [ 0, 1, 4, 5, 10, 9 ], [ 1, 2, 4, 6, 11, 10 ], [ 3, 4, 2, 12, 11, 7 ], [ 0, 4, 3, 9, 12, 8 ] ],

    ElementTypeEnum.kWedge6 : [ [ 0, 2, 1 ], [ 3, 4, 5 ], [ 0, 1, 4, 3 ], [ 1, 2, 5, 4 ], [ 0, 3, 5, 2 ] ],
    ElementTypeEnum.kWedge15 : [ [ 0, 2, 1, 8, 7, 6 ], [ 3, 4, 5, 9, 10, 11 ], [ 0, 1, 4, 3, 6, 13, 9, 12 ], [ 1, 2, 5, 4, 7, 14, 10, 13 ], [ 0, 3, 5, 2, 12, 11, 14, 8 ] ],

    ElementTypeEnum.kHex8 : [ [ 0, 1, 5, 4 ], [ 1, 2, 6, 5 ], [ 2, 3, 7, 6 ], [ 3, 0, 4, 7 ], [ 0, 3, 2, 1 ], [ 4, 5, 6, 7 ] ],
    ElementTypeEnum.kHex20 : [ [ 0, 1, 5, 4, 8, 17, 12, 16 ], [ 1, 2, 6, 5, 9, 18, 13, 17 ], [ 2, 3, 7, 6, 10, 19, 14, 18 ], [ 3, 0, 4, 7, 11, 16, 15, 19 ], [ 0, 3, 2, 1, 11, 10, 9, 8 ], [ 4, 5, 6, 7, 12, 13, 14, 15 ] ]
}

#https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/corp/v231/en/act_script/act_script_examples_print_selected_element_faces.html (modified)
def GetElementFaceNodes(element, element_face_index):
    element_node_indices = g_elementTypeToElemFaceNodeIndices[element.Type][element_face_index]
    return [element.NodeIds[element_node_index] for element_node_index in element_node_indices]

def export_properties(filename, data_object):
    with open('\\'.join([working_directory,filename]), 'w') as fp:
        for property_name in data_object.PropertyNames:
            property_value = data_object.PropertyValue(property_name)
            fp.write(property_name + ',')
            fp.write(str(property_value) + '\n')

def write_geometry_selection(project, current_analysis, geometry, mesh_data, named_selections, data_object, geometry_selection):
    f.write('GeometrySelection' + ',')
    selection_type = geometry_selection.SelectionType
    f.write(str(selection_type) + ',' + str(geometry_selection.Ids.Count) + '\n')
    if selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.GeometryEntities:
        for id in geometry_selection:
            geoType = str(geometry.GeoEntityById(id).Type)
            mesh_region = mesh_data.MeshRegionById(id)
            f.write(geoType + ',')
            if geoType == 'GeoFace':
                f.write(str(mesh_region.NodeCount) + '\n' + str(mesh_region.NodeIds) + '\n')
            elif geoType == 'GeoBody':
                f.write(str(mesh_region.ElementCount) + '\n' + str(mesh_region.ElementIds) + '\n')
    elif selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.MeshElements:
        f.write(str(geometry_selection.Ids) + '\n')
    elif selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.MeshNodes:
        f.write(str(geometry_selection.Ids) + '\n')
    elif selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.MeshElementFaces:
        for i in range(geometry_selection.Ids.Count):
            element_id = geometry_selection.Ids[i]
            f.write(str(element_id) + ',' + str(GetElementFaceNodes(mesh_data.ElementById(element_id), geometry_selection.ElementFaceIndices[i])) + '\n')

def write_component_selection(project, current_analysis, geometry, mesh_data, named_selections, data_object, component_selection):
    geometry_selection = geometry.GeoEntityById(component_selection)
    f.write('GeometrySelection' + ',' + str(geometry_selection) + '\n')
    f.write('ComponentSelection' + ',' + str(component_selection) + '\n')
    named_selection = DataModel.GetObjectById(component_selection)
    for p in named_selection.Properties:
        f.write('\t' + p.Name + ',' + str(p.InternalValue) + '\n')

def write_boundary_condition(project, current_analysis, geometry, mesh_data, named_selections, data_object):
    if data_object.PropertyValue('State')=='suppressed':
        return
    f.write('BC,' + data_object.Name + '\n')
    geometry_selection = data_object.PropertyValue('GeometrySelection')
    write_geometry_selection(project, current_analysis, geometry, mesh_data, named_selections, data_object, geometry_selection)
    for property_name in data_object.PropertyNames:
        if property_name=='GeometrySelection':
            geometry_selection = data_object.PropertyValue(property_name)
        elif property_name=='ComponentSelection':
            component_selection = data_object.PropertyValue(property_name)
            f.write(property_name + ',' + DataModel.GetObjectById(component_selection).Name + '\n')
        else:
            f.write(property_name + ',' + str(data_object.PropertyValue(property_name)) + '\n')

working_directory = ExtAPI.DataModel.AnalysisByName('Steady-State Thermal').WorkingDir
#current_analysis = ExtAPI.DataModel.AnalysisByName('Steady-State Thermal')
#current_analysis.WriteInputFile('\\'.join([workingDir, 'workingInput.dat']))

project = ExtAPI.DataModel.Project
current_analysis = project.Model.Analyses[0]

geometry = current_analysis.GeoData
mesh_data = current_analysis.MeshData
named_selections = project.Model.NamedSelections

boundary_conditions = [i for i in current_analysis.DataObjects.NamesByType('LoadThermalTemperature')] + \
    [i for i in current_analysis.DataObjects.NamesByType('LoadThermalConvection')] + \
    [i for i in current_analysis.DataObjects.NamesByType('LoadThermalInternalHeat')] + \
    [i for i in current_analysis.DataObjects.NamesByType('LoadThermalRadiation')] + \
    [i for i in current_analysis.DataObjects.NamesByType('LoadThermalHeatFlow')] + \
    [i for i in current_analysis.DataObjects.NamesByType('LoadThermalPerfectlyInsulated')] + \
    [i for i in current_analysis.DataObjects.NamesByType('LoadThermalHeatFlux')]

bc = current_analysis.DataObjects.GetByName('Temperature 2')
export_properties('properties_T2.txt', current_analysis.DataObjects.GetByName('Temperature 3'))

try:
    with open('\\'.join([working_directory,'BoundaryConditions.txt']), 'w') as f:
        for data_object_name in boundary_conditions:
            data_object = current_analysis.DataObjects.GetByName(data_object_name)
            write_boundary_condition(project, current_analysis, geometry, mesh_data, named_selections, data_object)
    
    #for c in currentAnalysis.Children:
    #    print(c.GetType().BaseType)
        #if c.GetType().BaseType==Ansys.A).Automation.Mechanical.BoundaryConditions.GenericBoundaryCondition:
            
            #pass
    #print(DataModel.Project.Model.Analyses)
    
    #solver = os.environ['OctaveEngineeringSimulations']
    #if not os.path.exists(solver):
    #    raise ValueError('Engineering toolkit path not on system variables\nExiting')
    
    #solver += '\\' + 'tmp'
    #if not os.path.exists(solver):
    #    os.mkdir(solver)
    
    #MeshData = DataModel.MeshDataByName('Global')
    
    ##ExtAPI.SelectionManager
    ##ExtAPI.Tools.GetResultsDataFromFile
    
    with open('\\'.join([working_directory,'workingInput.csv']), 'w') as f:
        writer = csv.writer(f, quoting=csv.QUOTE_NONNUMERIC, lineterminator='\n')
        
        f.write(' '.join(['Nodes', str(mesh_data.NodeCount), '\n']))
        writer.writerow(['Node id', 'X', 'Y', 'Z'])
        writer.writerows([[n.Id] + [n.X] + [n.Y] + [n.Z] for n in mesh_data.Nodes])
        
        f.write(' '.join(['Elements', str(mesh_data.ElementCount), '\n']))
        writer.writerow(['Element id', 'Element type', 'Element area', 'Element volume', 'Nodes', 'Centroid'])
        writer.writerows([[e.Id] + [str(e.Type)] + [e.Area] + [e.Volume] + [i for i in e.NodeIds] + [i for i in e.Centroid] for e in mesh_data.Elements])
        
    
except Exception as e:
    print(e)
    