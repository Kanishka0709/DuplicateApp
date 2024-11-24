import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'welcome_page.dart';
import 'search_page.dart';
import 'profile_page.dart';
class NavigationMainPage extends StatefulWidget {
  const NavigationMainPage({super.key});

  @override
  State<NavigationMainPage> createState() => _NavigationMainPageState();
}

class _NavigationMainPageState extends State<NavigationMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const WelcomePage(username: '',),
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Railway Navigator",
            style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 0, 20, 199),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 0, 20, 199)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CourierPrime',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.chat,
                    color: Color.fromARGB(255, 0, 20, 199)),
                title: const Text('Chatbot',
                    style: TextStyle(color: Color.fromARGB(255, 0, 20, 199))),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatbotPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contacts,
                    color: Color.fromARGB(255, 0, 20, 199)),
                title: const Text('Emergency Contacts',
                    style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyContactsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email,
                    color: Color.fromARGB(255, 0, 20, 199)),
                title: const Text('Emergency Emails',
                    style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyEmailsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // To store query-response pairs
  late GenerativeModel _model;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize the chatbot model
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey!.isEmpty) {
      stderr.writeln('No API key found in the .env file.');
      exit(1);
    }

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1.3,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
      systemInstruction: Content.system(
        'You are a bot for railway. I will provide you a dataset based on that, '
        'and you have to answer the queries. This is the dataset on which you '
        'have to answer the queries:\n'
        'THE INDIAN RAILWAY BOARD ACT, 1905\n'
        'ACT NO. 4 OF 1905.\n'
        '(22nd March, 1905)\n'
        '(Complete dataset text goes here)',
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    if (message.isEmpty) return;

    setState(() {
      _messages.add({'type': 'user', 'message': message}); // Add user message
      _isLoading = true;
    });

    try {
      final chat = _model.startChat(history: [
        Content.multi([TextPart(message)]),
      ]);

      final content = Content.text(message);
      final response = await chat.sendMessage(content);

      setState(() {
        _messages.add({'type': 'bot', 'message': response.text!}); // Add bot response
      });
    } catch (e) {
      setState(() {
        _messages.add({'type': 'bot', 'message': 'Error: ${e.toString()}'}); // Error handling
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chatbot",
          style: TextStyle(fontFamily: 'CourierPrime'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 20, 199),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['type'] == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUserMessage
                          ? Colors.blueAccent
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Move input field upward
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your query...',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    final message = _controller.text.trim();
                    _controller.clear();
                    _sendMessage(message);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts",
            style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: Color.fromARGB(255, 0, 20, 199),
      ),
      body: const Center(
        child: Text(
          'Emergency contacts will be displayed here.',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class EmergencyEmailsPage extends StatelessWidget {
  const EmergencyEmailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Emails",
            style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: Color.fromARGB(255, 0, 20, 199),
      ),
      body: const Center(
        child: Text(
          'Emergency email addresses will be displayed here.',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
