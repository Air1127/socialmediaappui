import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.65, // Mimicking Pinterest's vertical cards
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return PinterestPostCard(index: index);
        },
      ),
    );
  }
}

class PinterestPostCard extends StatefulWidget {
  final int index;
  const PinterestPostCard({super.key, required this.index});

  @override
  State<PinterestPostCard> createState() => _PinterestPostCardState();
}

class _PinterestPostCardState extends State<PinterestPostCard> {
  bool isLiked = false;

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5))),
          ListTile(leading: const Icon(Icons.save, color: Colors.red), title: const Text('Save to board'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.download), title: const Text('Download image'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.share), title: const Text('Share'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.report), title: const Text('Hide Pin'), onTap: () => Navigator.pop(context)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- The Pin Image ---
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/id/${widget.index + 20}/400/600',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // "Save" Button Overlay
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              // More Button Overlay
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: _showImageOptions,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.more_horiz, size: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        // --- Pin Info ---
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Beautiful inspiration for your project',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.2),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'Creator Name',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isLiked = !isLiked),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: isLiked ? Colors.red : Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
