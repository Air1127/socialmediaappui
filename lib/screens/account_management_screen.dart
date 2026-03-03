import 'package:flutter/material.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  String _userEmail = 'john.doe@example.com';
  String _userName = 'John Doe';

  void _showInfoDialog(String title, String currentVal, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentVal);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Edit $title', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter new $title',
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF527DA3))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey))
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title updated successfully!')),
              );
            },
            child: const Text('SAVE', style: TextStyle(color: Color(0xFF527DA3), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              obscureText: true, 
              decoration: InputDecoration(
                labelText: 'Current Password',
                floatingLabelStyle: TextStyle(color: Color(0xFF527DA3)),
              )
            ),
            TextField(
              obscureText: true, 
              decoration: InputDecoration(
                labelText: 'New Password',
                floatingLabelStyle: TextStyle(color: Color(0xFF527DA3)),
              )
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey))
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully!')),
              );
            },
            child: const Text('UPDATE', style: TextStyle(color: Color(0xFF527DA3), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color(0xFF527DA3)),
        title: const Text(
          'Account Management',
          style: TextStyle(
            color: Color(0xFF527DA3),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Profile details'),
          _buildListTile(
            Icons.person_outline, 
            'Personal Information', 
            () => _showInfoDialog('Name', _userName, (val) => setState(() => _userName = val)),
            subtitle: _userName,
          ),
          _buildListTile(
            Icons.email_outlined, 
            'Email Address', 
            () => _showInfoDialog('Email', _userEmail, (val) => setState(() => _userEmail = val)), 
            subtitle: _userEmail,
          ),
          const Divider(height: 32),
          _buildSectionHeader('Security'),
          _buildListTile(
            Icons.lock_outline, 
            'Change Password', 
            () => _showPasswordDialog(),
          ),
          const Divider(height: 32),
          _buildSectionHeader('Privacy & Data'),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(25), // Updated from withOpacity
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_forever_outlined, color: Colors.red),
            ),
            title: const Text(
              'Delete your data and account',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('Permanent action. Cannot be undone.'),
            onTap: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap, {String? subtitle}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF527DA3).withAlpha(25), // Updated from withOpacity
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF527DA3), size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Account?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('This action is permanent and cannot be undone. All your messages, photos, and personal data will be erased forever.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
