import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:mr_samy_elmalah/widgets/videos_card.dart'; // Add Firebase Firestore dependency

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _selectedGrade;
  String? _selectedSection;
  String _searchQuery = '';
  List<String>? _sectionsList;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>>? _videos;
  bool _isLoading = false;
  bool _isLoadingSections = false;

  // final List<DropdownMenuEntry<String>> _grades = [
  //   DropdownMenuEntry(value: '1st_secondary', label: 'الصف الاول الثانوي'),
  //   DropdownMenuEntry(value: '2nd_secondary', label: 'الصف الثاني الثانوي'),
  //   DropdownMenuEntry(value: '3rd_secondary', label: 'الصف الثالث الثانوي'),
  // ];

  // final List<DropdownMenuEntry<String>> _sections = [
  //   DropdownMenuEntry(value: 'تفاضل و تكامل', label: 'Section A'),
  //   DropdownMenuEntry(value: 'B', label: 'Section B'),
  //   DropdownMenuEntry(value: 'C', label: 'Section C'),
  // ];

  Future<void> _fetchVideos() async {
    if (_selectedGrade == null || _selectedSection == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final videos = await FirebaseRetrieve()
          .getVideos(_selectedGrade!, _selectedSection!);
      setState(() {
        _videos = videos;
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString() + ' =======================');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<String>?> getSections(String grade) async {
    try {
      return FirebaseRetrieve().getSectionsNames(grade);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
        title: TextField(
          controller: _searchController,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            border: InputBorder.none,
            prefixIcon: Icon(Iconsax.search_normal_1_copy,
                color: Theme.of(context).primaryIconTheme.color),
          ),
          // style: TextStyle(color: Colors.white),
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
              onGradeSelected: (value) async {
                setState(() {
                  _selectedGrade = value;
                  _selectedSection = null; // Reset section when grade changes
                  _sectionsList = []; // Clear sections list
                  _isLoadingSections = true; // Show loading indicator
                });

                if (value != null) {
                  final sections = await getSections(value);
                  setState(() {
                    _sectionsList = sections;
                    _isLoadingSections = false; // Hide loading indicator
                  });
                } // Fetch videos when grade is selected
              },
            ),
            SizedBox(height: 16),
            // Section Dropdown
            SectionDropdownMenu(
              sectionsList: _sectionsList ?? [],
              selectedSection: _selectedSection,
              onSectionSelected: (value) {
                setState(() {
                  _selectedSection = value;
                });
                _fetchVideos(); // Fetch videos when section is selected
              },
            ),
            SizedBox(height: 16),

            // Loading Indicator
            if (_isLoading)
              LottieLoader()
            else
              Expanded(
                child: _buildSearchResults(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_videos == null) {
      return Center(
        child: Text('اختار الصف و القسم'),
      );
    }

    if (_searchQuery.isEmpty) {
      return Center(
        child: Text('اكتب للبحث'),
      );
    }

    // Filter videos based on the search query
    final filteredVideos = _videos!
        .where((video) =>
            video['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (filteredVideos.isEmpty) {
      return Center(
        child: Text('مفيش نتيجة يسطا "$_searchQuery".'),
      );
    }

    return ListView.builder(
      itemCount: filteredVideos.length,
      itemBuilder: (context, index) {
        final video = filteredVideos[index];
        return MyVideosCard(
          myVideos: video,
          isPurchased: false,
          section: '',
        );
      },
    );
  }
}

class GradeDropdownMenu extends StatelessWidget {
  final String? selectedGrade;
  final Function(String?) onGradeSelected;

  const GradeDropdownMenu({
    super.key,
    required this.selectedGrade,
    required this.onGradeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> _grades = [
      DropdownMenuEntry(
        value: '1st_secondary',
        label: 'الصف الاول الثانوي',
        labelWidget: Text(
          'الصف الاول الثانوي',
          style: TextStyle(fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
        ),
      ),
      DropdownMenuEntry(
        value: '2nd_secondary',
        label: 'الصف الثاني الثانوي',
        labelWidget: Text(
          'الصف الثاني الثانوي',
          style: TextStyle(fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
        ),
      ),
      DropdownMenuEntry(
        value: '3rd_secondary',
        label: 'الصف الثالث الثانوي',
        labelWidget: Text(
          'الصف الثالث الثانوي',
          style: TextStyle(fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
        ),
      ),
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

  SectionDropdownMenu({
    required this.selectedSection,
    required this.sectionsList,
    required this.onSectionSelected,
  });
  final List<String> sectionsList;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      dropdownMenuEntries: sectionsList
          .map((section) => DropdownMenuEntry(
                value: section,
                label: section,
                labelWidget: Text(
                  section,
                  style: TextStyle(
                      fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
                ),
              ))
          .toList(),
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
