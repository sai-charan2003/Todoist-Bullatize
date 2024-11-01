import 'package:flutter/material.dart';
import 'package:todoist_bullatize/baseClient.dart';
import 'package:todoist_bullatize/sharedPrefHelper.dart';
import 'package:todoist_bullatize/ui/sectionScreen.dart';

class ProjectsListScreen extends StatefulWidget {
  const ProjectsListScreen({super.key});

  @override
  State<ProjectsListScreen> createState() => _ProjectsListScreenState();
}

class _ProjectsListScreenState extends State<ProjectsListScreen> {
  bool _hasShownDialog = false; // Flag to track dialog display

  @override
  void initState() {
    super.initState();
    _checkForTodoistKey();
  }

  Future<void> _checkForTodoistKey() async {
    if (SharedPreferencesHelper.getTODOISTKey() == null && !_hasShownDialog) {
      _hasShownDialog = true; // Set the flag to prevent duplicate dialogs
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showInputDialog(context, onSubmitted: (string) {
          SharedPreferencesHelper.setTODOISTKey(string);
          _hasShownDialog = false; // Reset the flag after submission
          setState(() {}); // Trigger UI update
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            title: const Text("Projects"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton.outlined(
                  onPressed: () {
                    showInputDialog(context, onSubmitted: (string) {
                      SharedPreferencesHelper.setTODOISTKey(string);
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.key),
                ),
              ),
            ],
            floating: true,
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: Baseclient().getProjectData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingIndicator();
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    _checkForTodoistKey(); // Call it only if there's no data
                    return Container();
                  } else {
                    return _buildProjectList(snapshot.data!);
                  }
                } else if (snapshot.hasError) {
                  return _buildErrorMessage(snapshot.error.toString());
                } else {
                  return const Center(
                    child: Text("No projects found."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildProjectList(List projects) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sectionscreen(
                    projectId: projects[index].id.toString(),
                    projectName: projects[index].name.toString(),
                  ),
                ),
              );
            },
            title: Text(
              projects[index].name.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Error: $errorMessage", style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}

void showInputDialog(BuildContext context, {required Function(String) onSubmitted}) {
  final TextEditingController _textController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Enter your Todoist API token.\n"+
          "This key is stored locally.We do not collect any key."
          "\nIf you feel your key has been compromised, you can refresh your token.",
          style: Theme.of(context).textTheme.bodyLarge,
          ),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: "key"),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                onSubmitted(_textController.text); // Pass the input back
              }
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}
