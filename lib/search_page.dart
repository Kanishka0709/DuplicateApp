import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _options = [
    {"icon": Icons.hotel, "label": "Hotels", "color": Colors.blueGrey},
    {"icon": Icons.nature_people, "label": "Picnic Spots", "color": Colors.teal},
    {"icon": Icons.shopping_cart, "label": "Shopping", "color": Colors.purple},
    {"icon": Icons.restaurant, "label": "Restaurants", "color": Colors.redAccent},
  ];

  late final AnimationController _controller;
  final List<int> _visibleItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < _options.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _visibleItems.add(i);
      });
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Search Nearby",
          style: TextStyle(fontFamily: 'CourierPrime'),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _options.length,
        itemBuilder: (context, index) {
          return _visibleItems.contains(index)
              ? _buildAnimatedOption(index, _options[index])
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAnimatedOption(int index, Map<String, dynamic> option) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0), // Start from off-screen (left)
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchResultPage(option["label"])),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: option["color"]?.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option["label"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
              Icon(option["icon"], size: 40, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final String label;

  const SearchResultPage(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    // Define the list of hotels
    final List<Map<String, String>> hotels = [
      {
        "name": "Hotel Aurora Towers",
        "rating": "7.2/10",
        "location": "Near MG Road, Pune",
        "mapLink": "https://www.google.com/maps?q=Hotel+Aurora+Towers,+MG+Road,+Pune",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/43385385.jpg?k=b00d46d759606ec73d09cab56e55f30eb62d36b83e2858ed468574d0e5256c34&o=&hp=1",
      },
      {
        "name": "Shantai Hotel",
        "rating": "8.1/10",
        "location": "Central Pune, 1 km from station",
        "mapLink": "https://www.google.com/maps?q=Shantai+Hotel,+Pune",
        "image":
            "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/a9/bb/7d/shantai-hotel.jpg?w=700&h=-1&s=1",
      },
      // More hotels...
    ];

    // Define the list of picnic spots
    final List<Map<String, String>> picnicSpots = [
      {
        "name": "Bund Garden",
        "rating": "8.0/10",
        "location": "Bund Garden Road, Pune",
        "mapLink": "https://www.google.com/maps?q=Bund+Garden,+Pune",
        "image":
            "https://www.trawell.in/admin/images/upload/306349749Bund_Garden_Main.jpg",
      },
      {
        "name": "Pashan Lake",
        "rating": "8.5/10",
        "location": "Pashan, Pune",
        "mapLink": "https://www.google.com/maps?q=Pashan+Lake,+Pune",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Pashan_Lake_-_Evening_View.jpg/1280px-Pashan_Lake_-_Evening_View.jpg",
      },
      // More picnic spots...
    ];

    // Define the list of shopping malls
    final List<Map<String, String>> shoppingMalls = [
      {
        "name": "Phoenix Marketcity",
        "rating": "9.0/10",
        "location": "Viman Nagar, Pune",
        "mapLink": "https://www.google.com/maps?q=Phoenix+Marketcity,+Pune",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/d/d8/Phoenix_Marketcity%2C_Pune.jpg",
      },
      {
        "name": "Seasons Mall",
        "rating": "8.5/10",
        "location": "Magarpatta, Pune",
        "mapLink": "https://www.google.com/maps?q=Seasons+Mall,+Pune",
        "image":
            "https://www.punekarnews.in/wp-content/uploads/2019/07/Seasons-Mall-Pune.jpg",
      },
      // More shopping malls...
    ];

    // Define the list of restaurants
    final List<Map<String, String>> restaurants = [
      {
        "name": "Malaka Spice",
        "rating": "9.2/10",
        "location": "Koregaon Park, Pune",
        "mapLink": "https://www.google.com/maps?q=Malaka+Spice,+Pune",
        "image":
            "https://b.zmtcdn.com/data/pictures/3/10593/7cbcb8bfb6b65a5cf3e69f8267e71563.jpg",
      },
      {
        "name": "Vaishali Restaurant",
        "rating": "8.9/10",
        "location": "FC Road, Pune",
        "mapLink": "https://www.google.com/maps?q=Vaishali+Restaurant,+Pune",
        "image":
            "https://static.tnn.in/photo/msid-73058580/73058580.jpg",
      },
      // More restaurants...
    ];

    // Select the list to display based on the label
    List<Map<String, String>> selectedList;
    switch (label) {
      case "Hotels":
        selectedList = hotels;
        break;
      case "Picnic Spots":
        selectedList = picnicSpots;
        break;
      case "Shopping Malls":
        selectedList = shoppingMalls;
        break;
      case "Restaurants":
        selectedList = restaurants;
        break;
      default:
        selectedList = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: Container(
        color: Colors.white,
        child: selectedList.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: selectedList.length,
                itemBuilder: (context, index) {
                  final item = selectedList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"]!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text('Rating: ${item["rating"]}'),
                          const SizedBox(height: 8.0),
                          Text('Location: ${item["location"]}'),
                          const SizedBox(height: 8.0),
                          Image.network(item["image"]!),
                          const SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () async {
                              final url = item["mapLink"]!;
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: const Text('View on Map'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No data available'),
              ),
      ),
    );
  }
}
