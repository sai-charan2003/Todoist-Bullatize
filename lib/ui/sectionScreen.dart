import 'package:flutter/material.dart';
import 'package:todoist_bullatize/baseClient.dart';
import 'package:todoist_bullatize/ui/tasksListScreen.dart';

class Sectionscreen extends StatefulWidget {
  const Sectionscreen({super.key, required this.projectId, required this.projectName});
  final String projectId;
  final String projectName;

  @override
  State<Sectionscreen> createState() => _SectionscreenState();
}

class _SectionscreenState extends State<Sectionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            title: Text(widget.projectName),
            floating: true, // Keeps the app bar visible while scrolling
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: Baseclient().getSections(widget.projectId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingIndicator();
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    // If the sections list is empty, navigate to Taskslistscreen
                    _navigateToTaskList();
                    return Container(); // Return an empty container while navigating
                  } else {
                    return _buildSectionList(snapshot.data!);
                  }
                } else {
                  // If there is an error or no data, still navigate to Taskslistscreen
                  _navigateToTaskList();
                  return Container(); // Return an empty container while navigating
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

  Widget _buildSectionList(List sections) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Taskslistscreen(
                    projectId: sections[index]!.id.toString(),
                    projectName: sections[index].name.toString(),
                  ),
                ),
              );
            },
            title: Text(
              sections[index].name.toString(),
              style: const TextStyle(fontSize: 18), // Increased font size for better readability
            ),
          ),
        );
      },
    );
  }

  void _navigateToTaskList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("from replacement");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Taskslistscreen(
            projectId: widget.projectId,
            projectName: widget.projectName,
          ),
        ),
      );
    });
  }
}
