import 'package:flutter/material.dart';

void main() {
  runApp(const CourseDashboardApp(
  ));
}

class CourseDashboardApp extends StatelessWidget {
  const CourseDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CourseDashboardHome(),
    );
  }
}

class CourseDashboardHome extends StatefulWidget {
  const CourseDashboardHome({super.key});

  @override
  State<CourseDashboardHome> createState() => _CourseDashboardHomeState();
}

class _CourseDashboardHomeState extends State<CourseDashboardHome> {
  int _selectedIndex = 0;
  // ignore: unused_field
  final String _selectedCategory = 'Science';
  double _buttonScale = 1.0;

  // ignore: unused_field
  final List<String> _categories = ['Science', 'Arts', 'Technology', 'Business', 'Health'];
  // ignore: unused_field
  final List<Course> _courses = [
    Course('Mathematics', 'Dr. Smith', Icons.calculate),
    Course('Computer Science', 'Prof. Johnson', Icons.computer),
    Course('Physics', 'Dr. Brown', Icons.science),
    Course('Literature', 'Prof. Davis', Icons.menu_book),
    Course('History', 'Dr. Wilson', Icons.history),
  ];

  static const List<Widget> _tabPages = [
    HomeTab(),
    CoursesTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // This would typically exit the app
                // SystemNavigator.pop(); // Uncomment for real exit
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('App would exit here')),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _animateButton() {
    setState(() {
      _buttonScale = 1.2;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _buttonScale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Dashboard'),
        actions: _selectedIndex == 2
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _showExitDialog,
                  tooltip: 'Logout',
                ),
              ]
            : null,
      ),
      body: Center(
        child: _tabPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? AnimatedScale(
              scale: _buttonScale,
              duration: const Duration(milliseconds: 200),
              child: FloatingActionButton(
                onPressed: _animateButton,
                child: const Icon(Icons.add),
              ),
            )
          : null,
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to the Course Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Use the bottom navigation to explore different sections of the app.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CoursesTab extends StatefulWidget {
  const CoursesTab({super.key});

  @override
  State<CoursesTab> createState() => _CoursesTabState();
}

class _CoursesTabState extends State<CoursesTab> {
  String _selectedCategory = 'Science';
  final List<String> _categories = ['Science', 'Arts', 'Technology', 'Business', 'Health'];
  final List<Course> _courses = [
    Course('Mathematics', 'Dr. Smith', Icons.calculate),
    Course('Computer Science', 'Prof. Johnson', Icons.computer),
    Course('Physics', 'Dr. Brown', Icons.science),
    Course('Literature', 'Prof. Davis', Icons.menu_book),
    Course('History', 'Dr. Wilson', Icons.history),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Course Category',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Text(
          'Selected Category: $_selectedCategory',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: _courses.length,
            itemBuilder: (context, index) {
              return CourseCard(course: _courses[index]);
            },
          ),
        ),
      ],
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://placehold.co/400x400/blue/white?text=Profile'),
          ),
          SizedBox(height: 20),
          Text(
            'Student Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Name: John Doe'),
          Text('Email: john.doe@university.edu'),
          Text('Major: Computer Science'),
        ],
      ),
    );
  }
}

class Course {
  final String name;
  final String instructor;
  final IconData icon;

  Course(this.name, this.instructor, this.icon);
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(course.icon, size: 36, color: Colors.blue),
        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Instructor: ${course.instructor}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${course.name}')),
          );
        },
      ),
    );
  }
}