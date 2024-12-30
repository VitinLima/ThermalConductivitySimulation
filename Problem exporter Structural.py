import csv
import os
import struct
import pickle

#Options
solve = True
export_as_binary = True

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

def write_data(f, data_type, data):
    packet_size = 1000
    data_size = len(data)
    for current_packet_idx in range(int(ceil(float(data_size)/packet_size))):
        current_data_idx = current_packet_idx*packet_size
        next_data_idx = min(current_data_idx+packet_size, data_size)
        packet = data[current_data_idx:next_data_idx]
        if data_type=='s':
            data_bin = bytes(''.join(packet), 'utf-8')
            f.write(data_bin)
        else:
            data_bin = struct.pack('{}'.format(len(packet)) + data_type, *packet)
            f.write(data_bin)

def export_properties(filename, data_object):
    with open('\\'.join([working_directory,filename]), 'w') as fp:
        for property_name in data_object.PropertyNames:
            property_value = data_object.PropertyValue(property_name)
            fp.write(property_name + ',')
            fp.write(str(property_value) + '\n')

def export_properties2(filename, data_object):
    with open('\\'.join([working_directory,filename]), 'w') as fp:
        for property_value in data_object.Properties:
            fp.write(property_value.Name + ',')
            fp.write(str(property_value) + '\n')

def write_geometry_selection(project, current_analysis, geometry, mesh_data, named_selections, data_object, geometry_selection):
    f.write(bytes('GeometrySelection' + ',', 'utf-8'))
    selection_type = geometry_selection.SelectionType
    f.write(bytes(str(selection_type) + ',' + str(geometry_selection.Ids.Count) + '\n', 'utf-8'))
    if selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.GeometryEntities:
        for id in geometry_selection:
            geoType = str(geometry.GeoEntityById(id).Type)
            mesh_region = mesh_data.MeshRegionById(id)
            f.write(bytes(geoType + ',', 'utf-8'))
            if geoType == 'GeoBody':
                f.write(bytes(str(mesh_region.ElementCount) + '\n', 'utf-8'))
                write_data(f, 'i',  [i for i in mesh_region.ElementIds])
            elif geoType == 'GeoFace':
                f.write(bytes(str(mesh_region.NodeCount) + '\n', 'utf-8'))
                write_data(f, 'i',  [i for i in mesh_region.NodeIds])
            elif geoType == 'GeoEdge':
                f.write(bytes(str(mesh_region.NodeCount) + '\n', 'utf-8'))
                write_data(f, 'i',  [i for i in mesh_region.NodeIds])
            elif geoType == 'GeoVertex':
                f.write(bytes(str(mesh_region.NodeCount) + '\n', 'utf-8'))
                write_data(f, 'i',  [i for i in mesh_region.NodeIds])
    elif selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.MeshElements:
        write_data(f, 'i', [i for i in geometry_selection.Ids])
    elif selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.MeshNodes:
        write_data(f, 'i', [i for i in geometry_selection.Ids])
    elif selection_type==Ansys.ACT.Interfaces.Common.SelectionTypeEnum.MeshElementFaces:
        write_data(f, 'i', [i for element_id in range(geometry_selection.Ids.Count) for i in [geometry_selection.Ids[element_id]] + [geometry_selection.ElementFaceIndices[element_id]] + GetElementFaceNodes(mesh_data.ElementById(geometry_selection.Ids[element_id]), geometry_selection.ElementFaceIndices[element_id])])

def write_boundary_condition(project, current_analysis, geometry, mesh_data, named_selections, data_object):
    if data_object.PropertyValue('State')=='suppressed':
        return
    f.write(bytes('BC,' + data_object.Name + '\n', 'utf-8'))
    f.write(bytes('Type,' + data_object.Type + '\n', 'utf-8'))
    geometry_selection = data_object.PropertyValue('GeometrySelection')
    write_geometry_selection(project, current_analysis, geometry, mesh_data, named_selections, data_object, geometry_selection)
    for property_name in data_object.PropertyNames:
        if property_name=='GeometrySelection':
            geometry_selection = data_object.PropertyValue(property_name)
        elif property_name=='ComponentSelection':
            component_selection = data_object.PropertyValue(property_name)
            f.write(bytes(property_name + ',' + DataModel.GetObjectById(component_selection).Name + '\n', 'utf-8'))
        elif property_name=='Type':
            pass
        else:
            f.write(bytes(property_name + ',' + str(data_object.PropertyValue(property_name)) + '\n', 'utf-8'))

engineeringToolkitPath = os.environ['EngineeringToolkit']
if not os.path.exists(engineeringToolkitPath):
    raise ValueError('Engineering toolkit path not on system variables\nExiting')

#current_analysis = project.Model.Analyses[0]
current_analysis = ExtAPI.DataModel.AnalysisByName('Steady-State Thermal 7')
working_directory = os.path.join(current_analysis.WorkingDir, 'workingDirectory')
if not os.path.exists(working_directory):
    os.mkdir(working_directory)

res = os.system('octave-gui --no-gui "' + os.path.join(engineeringToolkitPath, 'main', 'main.m') + '" pre-setup "' + working_directory + '"')
if res==1:
    raise ValueError('Setup cancelled\nExiting')

Model.Mesh.Update()

project = ExtAPI.DataModel.Project
project.UnitSystem = Ansys.Mechanical.DataModel.Enums.UserUnitSystemType.StandardNMM
solution = current_analysis.Solution

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

print('Exporting analysis')

print('\tBoundary conditions')

with open(os.path.join(working_directory,'BoundaryConditions'), 'wb') as f:
    for data_object_name in boundary_conditions:
        data_object = current_analysis.DataObjects.GetByName(data_object_name)
        write_boundary_condition(project, current_analysis, geometry, mesh_data, named_selections, data_object)

print('\tMesh')
if export_as_binary:
    #Export as Binary
    with open(os.path.join(working_directory,'Meshing'), 'wb') as f:
        f.write(bytes('ANSYS BIN\n', 'utf-8'))
        
        f.write(bytes(','.join(['Nodes', str(mesh_data.NodeCount), '\n']), 'utf-8'))
        write_data(f, 'i', [n.Id for n in mesh_data.Nodes])
        write_data(f, 'd', [i for n in mesh_data.Nodes for i in [n.X, n.Y, n.Z]])
        
        f.write(bytes(','.join(['Elements', str(mesh_data.ElementCount), '\n']), 'utf-8'))
        write_data(f, 'i', [e.Id for e in mesh_data.Elements])
        write_data(f, 'i', [i for e in mesh_data.Elements for i in [e.CornerNodeIds.Count] + [e.NodeIds.Count]])
        write_data(f, 'd', [e.Area for e in mesh_data.Elements])
        write_data(f, 'd', [e.Volume for e in mesh_data.Elements])
        write_data(f, 'i', [i for e in mesh_data.Elements for i in e.NodeIds])
        write_data(f, 'd', [i for e in mesh_data.Elements for i in e.Centroid])
else:
    #Export as ASCII
    with open('\\'.join([working_directory,'Meshing']), 'w') as f:
        f.write('ANSYS ASCII\n')
        writer = csv.writer(f, quoting=csv.QUOTE_NONNUMERIC, lineterminator='\n')
        
        f.write(','.join(['Nodes', str(mesh_data.NodeCount), '\n']))
        writer.writerow(['Node id', 'X', 'Y', 'Z'])
        writer.writerows([[n.Id] + [n.X] + [n.Y] + [n.Z] for n in mesh_data.Nodes])
        
        f.write(','.join(['Elements', str(mesh_data.ElementCount), '\n']))
        writer.writerow(['Element id', 'Element type', 'Element area', 'Element volume', 'Nodes', 'Centroid'])
        writer.writerows([[e.Id] + [str(e.Type)] + [e.Area] + [e.Volume] + [i for i in e.NodeIds] + [i for i in e.Centroid] for e in mesh_data.Elements])

print('Analysis exported.')

if solve:
    res = os.system('octave-gui --no-gui "' + os.path.join(engineeringToolkitPath, 'main', 'main.m') + '" "' + working_directory + '"')
    if res==1:
        raise ValueError('Something went wrong when solving problem.\nSee log file.\nExiting')
    else:
        solution_children = [i.GetType() for i in solution.Children]
        if Ansys.ACT.Automation.Mechanical.Results.UserDefinedResult not in solution_children:
            user_defined_result = solution.AddUserDefinedResult()
            user_defined_result.PropertyByName('CustomResultSource').InternalValue = 1
            user_defined_result.Name = 'Temperature'
            user_defined_result.PropertyByName('OutputUnitType').InternalValue = 49
        else:
            user_defined_result = solution.Children[solution_children.index(Ansys.ACT.Automation.Mechanical.Results.UserDefinedResult)]
        user_defined_result.PropertyByName('ImportedFileName').InternalValue = os.path.join(working_directory, 'octTemperature')
        user_defined_result.EvaluateAllResults()

##ExtAPI.SelectionManager
##ExtAPI.Tools.GetResultsDataFromFile