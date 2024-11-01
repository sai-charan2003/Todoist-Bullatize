import 'package:flutter/material.dart';
import 'package:todoist_bullatize/baseClient.dart';
import 'package:todoist_bullatize/tasksData.dart';

class Taskslistscreen extends StatefulWidget {
  const Taskslistscreen({super.key, required this.projectId, required this.projectName});
  final String projectId;
  final String projectName;

  @override
  State<Taskslistscreen> createState() => _TaskslistscreenState();
}

class _TaskslistscreenState extends State<Taskslistscreen> {
  List<TasksData> tasksList = [];
  String tasksString = "";
  bool isLoading = true; // Track loading state
  String errorMessage = ""; // Track error message

  @override
  void initState() {
    fetchTasksLists();
    super.initState();
  }

  Future<void> fetchTasksLists() async {
    try {
      tasksList = await Baseclient().getTasksDataBySection(widget.projectId);
      if(tasksList.isEmpty){
        tasksList = await Baseclient().getTasksData(widget.projectId);
      }
      // Using standard bullet point with proper spacing
      tasksString = tasksList.map((task) => '• ${task.content}').join('\n\n');
    } catch (e) {
      errorMessage = "Failed to load tasks. Please try again.";
    } finally {
      isLoading = false; // Set loading to false regardless of success or failure
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            title: Text(widget.projectName),
            floating: true, // Keep the app bar visible while scrolling
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        )
                      : Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SelectableText(
                              tasksString,
                              style: const TextStyle(
                                fontSize: 18, // Increased font size for readability
                                height: 1.5, // Add line spacing for better readability
                              ),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
