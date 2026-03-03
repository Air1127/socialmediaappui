import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isDarkMode = false;
  Color _selectedProfileColor = const Color(0xFF527DA3);

  final List<Color> _availableColors = [
    const Color(0xFF527DA3),
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  final TextEditingController _firstNameController = TextEditingController(text: 'John');
  final TextEditingController _lastNameController = TextEditingController(text: 'Doe');
  final TextEditingController _usernameController = TextEditingController(text: 'johndoe');
  final TextEditingController _aboutController = TextEditingController(text: 'Hey there! I am using DreamLink.');

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose Profile Color',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF527DA3),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: _availableColors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProfileColor = _availableColors[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedProfileColor == _availableColors[index]
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: _availableColors[index],
                          child: const Icon(Icons.person, color: Colors.white, size: 24),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF527DA3)),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF527DA3),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save logic here
              Navigator.pop(context);
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Color(0xFF527DA3),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: GestureDetector(
              onTap: _showColorPicker,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: _selectedProfileColor,
                    child: const Icon(Icons.person, size: 70, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.palette, size: 20, color: Color(0xFF527DA3)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildTextField(_firstNameController, 'Name', Icons.person_outline),
          const SizedBox(height: 16),
          _buildTextField(_lastNameController, 'Last Name', Icons.person_outline),
          const SizedBox(height: 16),
          _buildTextField(_usernameController, 'Username', Icons.alternate_email),
          const SizedBox(height: 16),
          _buildTextField(_aboutController, 'About', Icons.info_outline, maxLines: 3),
          const SizedBox(height: 32),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF527DA3),
              ),
            ),
          ),
          SwitchListTile(
            secondary: Icon(
              _isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: const Color(0xFF527DA3),
            ),
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            activeColor: const Color(0xFF527DA3),
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF527DA3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF527DA3), width: 2),
        ),
      ),
    );
  }
}
