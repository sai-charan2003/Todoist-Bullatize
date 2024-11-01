import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:todoist_bullatize/projectsData.dart';
import 'package:todoist_bullatize/sectionsData.dart';
import 'package:todoist_bullatize/sharedPrefHelper.dart';
import 'package:todoist_bullatize/tasksData.dart';



const String baseURL = "https://api.todoist.com/rest/v2";


class Baseclient {
  var client = http.Client();
  
  Future<List<ProjectsData>> getProjectData() async {
    try {
      final url = Uri.parse(baseURL + "/projects");
      var response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedPreferencesHelper.getTODOISTKey()}",
        },
      );

      if (response.statusCode == 200) {   
        var decodedBody = utf8.decode(response.bodyBytes);     
        List<ProjectsData> projectsData = projectsDataFromJson(decodedBody);
        print(response.body);
        return projectsData;
      } else if(response.statusCode == 401){
        SharedPreferencesHelper.clearAll();
        return List.empty();
      }else {
        print("Failed to load projects data: ${response.statusCode}");
        return List.empty();
      }

    } catch (e) {
      print(e);
      return List.empty();
    }
  }


  Future<List<TasksData>> getTasksData(String projectId) async {
    try {
      final url = Uri.parse(baseURL + "/tasks?project_id=$projectId");
      var response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedPreferencesHelper.getTODOISTKey()}",
        },
      );

      if (response.statusCode == 200) {    
        var decodedBody = utf8.decode(response.bodyBytes);         
        List<TasksData> tasksData = tasksDataFromJson(decodedBody);
        print(tasksData);
        return tasksData;
      } else if(response.statusCode == 401){
        SharedPreferencesHelper.clearAll();
        return List.empty();
      }else {
        print("Failed to load projects data: ${response.statusCode}");
        return List.empty();
      }
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  Future<List<SectionsData>> getSections(String projectId) async{
  try {
        final url = Uri.parse(baseURL + "/Sections?project_id=$projectId");
        var response = await client.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${SharedPreferencesHelper.getTODOISTKey()}",
          },
        );

        if (response.statusCode == 200) { 
          var decodedBody = utf8.decode(response.bodyBytes);          
          List<SectionsData> sectionsData = sectionsDataFromJson(decodedBody);
          print(jsonEncode(response.body));
          return sectionsData;
        } else if(response.statusCode == 401){
        SharedPreferencesHelper.clearAll();
        return List.empty();
        }else {
          print("Failed to load projects data: ${response.statusCode}");
          return List.empty();
        }
      } catch (e) {
        print(e);
        return List.empty();
      }
    }

    Future<List<TasksData>> getTasksDataBySection(String sectionId) async {
    try {
      final url = Uri.parse(baseURL + "/tasks?section_id=$sectionId");
      var response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedPreferencesHelper.getTODOISTKey()}",
        },
      );

      if (response.statusCode == 200) {    
        var decodedBody = utf8.decode(response.bodyBytes);         
        List<TasksData> tasksData = tasksDataFromJson(decodedBody);
        print(tasksData);
        return tasksData;
      } else if(response.statusCode == 401){
        SharedPreferencesHelper.clearAll();
        return List.empty();
      }else {
        print("Failed to load projects data: ${response.statusCode}");
        return List.empty();
      }
    } catch (e) {
      print(e);
      return List.empty();
    }
  }
}

