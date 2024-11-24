import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart'as stt;
import 'package:flutter_cube/flutter_cube.dart';

class LocalizationService {
  static final Map<String, Map<String, String>> _localizedStrings = {
    'English': {
      'welcome': 'Welcome',
      'namaste': 'Namaste',
      'select_station': 'Select Station',
      'start_navigation': 'Start Navigation',
      'navigation_started': 'Navigation Started',
      'view_3d_model': 'View 3D Model',
      'welcome_message':
          'Welcome to Railway Navigation App. Select your station to start.',
    },
    'हिंदी (Hindi)': {
      'welcome': 'स्वागत है',
      'namaste': 'नमस्ते',
      'select_station': 'स्टेशन चुनें',
      'start_navigation': 'नेविगेशन शुरू करें',
      'navigation_started': 'नेविगेशन शुरू हुआ',
      'view_3d_model': '3D मॉडल देखें',
      'welcome_message':
          'रेलवे नेविगेशन ऐप में आपका स्वागत है। शुरू करने के लिए अपना स्टेशन चुनें।',
    },
    'मराठी (Marathi)': {
      'welcome': 'स्वागत आहे',
      'namaste': 'नमस्कार',
      'select_station': 'स्टेशन निवडा',
      'start_navigation': 'नेव्हिगेशन सुरू करा',
      'navigation_started': 'नेव्हिगेशन सुरू झाले',
      'view_3d_model': '3D मॉडेल पहा',
      'welcome_message':
          'रेल्वे नेव्हिगेशन अॅपमध्ये तुमचे स्वागत आहे. सुरू करण्यासाठी तुमचे स्टेशन निवडा.',
    },
    'தமிழ் (Tamil)': {
      'welcome': 'வரவேற்கிறோம்',
      'namaste': 'வணக்கம்',
      'select_station': 'நிலையத்தைத் தேர்ந்தெடுக்கவும்',
      'start_navigation': 'வழிகாட்டியை தொடங்கவும்',
      'navigation_started': 'வழிகாட்டி தொடங்கப்பட்டது',
      'view_3d_model': '3D மாதிரியை காண்க',
      'welcome_message':
          'ரயில் வழிகாட்டு செயலியில் உங்களை வரவேற்கிறோம். தொடங்க உங்கள் நிலையத்தைத் தேர்ந்தெடுக்கவும்.',
    },
    'తెలుగు (Telugu)': {
      'welcome': 'స్వాగతం',
      'namaste': 'నమస్తే',
      'select_station': 'స్టేషన్‌ను ఎంచుకోండి',
      'start_navigation': 'నావిగేషన్‌ను ప్రారంభించండి',
      'navigation_started': 'నావిగేషన్ ప్రారంభమైంది',
      'view_3d_model': '3D మోడల్ చూడండి',
      'welcome_message':
          'రైల్వే నావిగేషన్ యాప్‌కి స్వాగతం. ప్రారంభించడానికి మీ స్టేషన్‌ను ఎంచుకోండి.',
    },
    'বাংলা (Bengali)': {
      'welcome': 'স্বাগত',
      'namaste': 'নমস্তে',
      'select_station': 'স্টেশন নির্বাচন করুন',
      'start_navigation': 'নেভিগেশন শুরু করুন',
      'navigation_started': 'নেভিগেশন শুরু হয়েছে',
      'view_3d_model': '3D মডেল দেখুন',
      'welcome_message':
          'রেলওয়ে নেভিগেশন অ্যাপে আপনাকে স্বাগত। শুরু করতে আপনার স্টেশন নির্বাচন করুন।',
    },
    'ગુજરાતી (Gujarati)': {
      'welcome': 'સ્વાગત છે',
      'namaste': 'નમસ્તે',
      'select_station': 'સ્ટેશન પસંદ કરો',
      'start_navigation': 'નેવિગેશન શરૂ કરો',
      'navigation_started': 'નેવિગેશન શરૂ થયું',
      'view_3d_model': '3D મોડલ જુઓ',
      'welcome_message':
          'રેલવે નેવિગેશન એપમાં તમારું સ્વાગત છે. શરૂ કરવા માટે તમારું સ્ટેશન પસંદ કરો.',
    },
    'ਪੰਜਾਬੀ (Punjabi)': {
      'welcome': 'ਸਵਾਗਤ ਹੈ',
      'namaste': 'ਨਮਸਤੇ',
      'select_station': 'ਸਟੇਸ਼ਨ ਚੁਣੋ',
      'start_navigation': 'ਨੇਵੀਗੇਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ',
      'navigation_started': 'ਨੇਵੀਗੇਸ਼ਨ ਸ਼ੁਰੂ ਹੋ ਗਿਆ ਹੈ',
      'view_3d_model': '3D ਮਾਡਲ ਵੇਖੋ',
      'welcome_message':
          'ਰੇਲਵੇ ਨੇਵੀਗੇਸ਼ਨ ਐਪ ਵਿੱਚ ਤੁਹਾਡਾ ਸਵਾਗਤ ਹੈ। ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਆਪਣਾ ਸਟੇਸ਼ਨ ਚੁਣੋ।',
    },
    'ಕನ್ನಡ (Kannada)': {
      'welcome': 'ಸ್ವಾಗತ',
      'namaste': 'ನಮಸ್ಕಾರ',
      'select_station': 'ನಿಲ್ದಾಣವನ್ನು ಆಯ್ಕೆಮಾಡಿ',
      'start_navigation': 'ನಾವಿಗೇಶನ್ ಪ್ರಾರಂಭಿಸಿ',
      'navigation_started': 'ನಾವಿಗೇಶನ್ ಪ್ರಾರಂಭವಾಯಿತು',
      'view_3d_model': '3D ಮಾದರಿಯನ್ನು ವೀಕ್ಷಿಸಿ',
      'welcome_message':
          'ರೈಲು ನಾವಿಗೇಶನ್ ಅಪ್ಲಿಕೇಶನ್‌ಗೆ ಸ್ವಾಗತ. ಪ್ರಾರಂಭಿಸಲು ನಿಮ್ಮ ನಿಲ್ದಾಣವನ್ನು ಆಯ್ಕೆಮಾಡಿ.',
    },
    'മലയാളം (Malayalam)': {
      'welcome': 'സ്വാഗതം',
      'namaste': 'നമസ്കാരം',
      'select_station': 'സ്റ്റേഷൻ തിരഞ്ഞെടുക്കുക',
      'start_navigation': 'നാവിഗേഷൻ ആരംഭിക്കുക',
      'navigation_started': 'നാവിഗേഷൻ ആരംഭിച്ചു',
      'view_3d_model': '3D മോഡൽ കാണുക',
      'welcome_message':
          'റെയിൽവേ നാവിഗേഷൻ ആപ്പിലേക്ക് സ്വാഗതം. ആരംഭിക്കാൻ നിങ്ങളുടെ സ്റ്റേഷൻ തിരഞ്ഞെടുക്കുക.',
    },
    'ଓଡ଼ିଆ (Odia)': {
      'welcome': 'ସ୍ୱାଗତ',
      'namaste': 'ନମସ୍କାର',
      'select_station': 'ସ୍ଟେସନ୍ ବାଛନ୍ତୁ',
      'start_navigation': 'ନେଭିଗେସନ୍ ଆରମ୍ଭ କରନ୍ତୁ',
      'navigation_started': 'ନେଭିଗେସନ୍ ଆରମ୍ଭ ହେଲା',
      'view_3d_model': '3D ମୋଡେଲ୍ ଦେଖନ୍ତୁ',
      'welcome_message':
          'ରେଲୱେ ନେଭିଗେସନ୍ ଆପ୍ରେ ଆପଣଙ୍କୁ ସ୍ୱାଗତ। ଆରମ୍ଭ କରିବାକୁ ଆପଣଙ୍କର ସ୍ଟେସନ୍ ବାଛନ୍ତୁ।',
    },

    // Add more languages here
  };

  static String _currentLanguage = 'English';

  static Future<void> loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('selected_language') ?? 'English';
  }

  static Future<void> setLanguage(String language) async {
    _currentLanguage = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
  }

  static String translate(String key) {
    return _localizedStrings[_currentLanguage]?[key] ?? key;
  }

  static String get currentLanguage => _currentLanguage;
}

// Welcome Page
// Welcome Page
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required String username});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    LocalizationService.loadLanguagePreference().then((_) => setState(() {}));
    _setTtsLanguage();
  }

  void _setTtsLanguage() async {
    String ttsLanguage = _getTtsLanguage();
    await _flutterTts.setLanguage(ttsLanguage);
  }

  String _getTtsLanguage() {
    switch (LocalizationService.currentLanguage) {
      case 'हिंदी (Hindi)':
        return 'hi-IN';
      case 'मराठी (Marathi)':
        return 'mr-IN';
      case 'தமிழ் (Tamil)':
        return 'ta-IN';
      case 'తెలుగు (Telugu)':
        return 'te-IN';
      case 'বাংলা (Bengali)':
        return 'bn-IN';
      case 'ગુજરાતી (Gujarati)':
        return 'gu-IN';
      case 'ਪੰਜਾਬੀ (Punjabi)':
        return 'pa-IN';
      case 'ಕನ್ನಡ (Kannada)':
        return 'kn-IN';
      case 'മലയാളം (Malayalam)':
        return 'ml-IN';
      case 'ଓଡ଼ିଆ (Odia)':
        return 'or-IN';
      default:
        return 'en-US';
    }
  }

  void _readAloud(String key) async {
    _setTtsLanguage();
    await _flutterTts.speak(LocalizationService.translate(key));
  }

  void _startListening() async {
    if (!_isListening && await _speechToText.initialize()) {
      setState(() => _isListening = true);
      _speechToText.listen(onResult: (result) {
        setState(() => _searchText = result.recognizedWords);
      });
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalizationService.translate('welcome'),
          style: const TextStyle(fontFamily: 'CourierPrime'),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (value) {
              setState(() {
                LocalizationService.setLanguage(value);
                _setTtsLanguage();
              });
            },
            itemBuilder: (context) {
              return LocalizationService._localizedStrings.keys
                  .map((lang) => PopupMenuItem(value: lang, child: Text(lang)))
                  .toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: () {
              _readAloud('welcome_message');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocalizationService.translate('welcome'),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 20, 199),
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'CourierPrime',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              LocalizationService.translate('namaste'),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 20, 199),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'CourierPrime',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _searchText),
                      decoration: InputDecoration(
                        labelText:
                            LocalizationService.translate('select_station'),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 20, 199)),
                        prefixIcon: const Icon(Icons.train,
                            color: Color.fromARGB(255, 0, 20, 199)),
                        suffixIcon: const Icon(Icons.search,
                            color: Color.fromARGB(255, 0, 20, 199)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 20, 199)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 20, 199)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: const Color.fromARGB(255, 0, 20, 199),
                    ),
                    onPressed: _isListening ? _stopListening : _startListening,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                _readAloud('navigation_started');
              },
              child: Text(
                LocalizationService.translate('start_navigation'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.view_in_ar),
              label: Text(LocalizationService.translate('view_3d_model')),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModelViewerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ModelViewerScreen extends StatelessWidget {
  const ModelViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Model Viewer'),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Center(
          child: Cube(
            onSceneCreated: (Scene scene) {
              final object = Object(fileName: 'assets/models/model.obj');
              object.scale.setValues(100.0, 100.0, 100.0);
              scene.world.add(object);
            },
          ),
        ),
      ),
    );
  }
}

enum TtsState { playing, stopped }