import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _selectedGrade;
  String? _selectedSection;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<DropdownMenuEntry<String>> _grades = [
    DropdownMenuEntry(value: '1st', label: '1st Grade'),
    DropdownMenuEntry(value: '2nd', label: '2nd Grade'),
    DropdownMenuEntry(value: '3rd', label: '3rd Grade'),
  ];

  final List<DropdownMenuEntry<String>> _sections = [
    DropdownMenuEntry(value: 'A', label: 'Section A'),
    DropdownMenuEntry(value: 'B', label: 'Section B'),
    DropdownMenuEntry(value: 'C', label: 'Section C'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grade Dropdown
            GradeDropdownMenu(
              selectedGrade: _selectedGrade,
              onGradeSelected: (value) {
                setState(() {
                  _selectedGrade = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Section Dropdown
            SectionDropdownMenu(
              selectedSection: _selectedSection,
              onSectionSelected: (value) {
                setState(() {
                  _selectedSection = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Search Results
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchQuery.isEmpty) {
      return Center(
        child: Text('Enter a search query to see results.'),
      );
    }

    // Simulate search results based on the query
    final results = [
      'Result 1 for "$_searchQuery" (Grade: $_selectedGrade, Section: $_selectedSection)',
      'Result 2 for "$_searchQuery" (Grade: $_selectedGrade, Section: $_selectedSection)',
      'Result 3 for "$_searchQuery" (Grade: $_selectedGrade, Section: $_selectedSection)',
    ];

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
        );
      },
    );
  }
}

class GradeDropdownMenu extends StatelessWidget {
  final String? selectedGrade;
  final Function(String?) onGradeSelected;

  const GradeDropdownMenu({
    required this.selectedGrade,
    required this.onGradeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> _grades = [
      DropdownMenuEntry(value: '1st', label: '1st Grade'),
      DropdownMenuEntry(value: '2nd', label: '2nd Grade'),
      DropdownMenuEntry(value: '3rd', label: '3rd Grade'),
    ];

    return DropdownMenu<String>(
      dropdownMenuEntries: _grades,
      initialSelection: selectedGrade,
      width: MediaQuery.of(context).size.width - 20,
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.bold),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(fontFamily: 'ge_ss'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      menuStyle: MenuStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      label: Text(
        'الصف الدراسي',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
      ),
      leadingIcon: Icon(Icons.book, color: Colors.grey),
      onSelected: onGradeSelected,
    );
  }
}

class SectionDropdownMenu extends StatelessWidget {
  final String? selectedSection;
  final Function(String?) onSectionSelected;

  const SectionDropdownMenu({
    required this.selectedSection,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> _sections = [
      DropdownMenuEntry(value: 'A', label: 'Section A'),
      DropdownMenuEntry(value: 'B', label: 'Section B'),
      DropdownMenuEntry(value: 'C', label: 'Section C'),
    ];

    return DropdownMenu<String>(
      dropdownMenuEntries: _sections,
      initialSelection: selectedSection,
      width: MediaQuery.of(context).size.width - 20,
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.bold),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(fontFamily: 'ge_ss'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      menuStyle: MenuStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      label: Text(
        'القسم',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
      ),
      leadingIcon: Icon(Icons.people, color: Colors.grey),
      onSelected: onSectionSelected,
    );
  }
}
