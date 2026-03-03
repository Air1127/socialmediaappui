import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FeedScreen(),
    const NotificationScreen(),
    const ChatListContent(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showFabMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.group, color: Color(0xFF527DA3)),
                title: const Text('New Group'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat, color: Color(0xFF527DA3)),
                title: const Text('New Chat'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String titleText = 'Newsfeed';
    if (_selectedIndex == 1) titleText = 'Notifications';
    if (_selectedIndex == 2) titleText = 'DreamLink';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          titleText,
          style: const TextStyle(
            color: Color(0xFF527DA3),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF527DA3)),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Color(0xFF527DA3),
                child: Icon(Icons.person, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF527DA3),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () => _showFabMenu(context),
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}

class ChatListContent extends StatelessWidget {
  const ChatListContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> avatarColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: avatarColors[index % avatarColors.length],
            child: const Icon(Icons.person, color: Colors.white),
          ),
          title: Text(index % 2 == 0 ? 'Friend Name $index' : 'Group Chat $index'),
          subtitle: const Text('Last message preview...'),
          trailing: Text('10:3$index AM', style: const TextStyle(fontSize: 12)),
          onTap: () {
            Navigator.pushNamed(context, '/chat', arguments: index % 2 == 0 ? 'Friend Name $index' : 'Group Chat $index');
          },
        );
      },
    );
  }
}
