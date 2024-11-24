import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'welcome_page.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

const translations = {
  'en-US': {
    'profileTitle': 'Profile',
    'signIn': 'Sign In',
    'signUp': 'Sign Up',
    'loginTitle': 'Login',
    'signInToYourAccount': 'Sign in to your account',
    'emailAddress': 'Email Address',
    'password': 'Password',
    'forgotPassword': 'Forgot Password?',
    'confirm': 'Confirm',
    'signUpTitle': 'Sign Up',
    'name': 'Name',
    'mobileNumber': 'Mobile Number',
    'confirmPassword': 'Confirm Password',
  },
  'hi-IN': {
    'profileTitle': 'प्रोफ़ाइल',
    'signIn': 'साइन इन करें',
    'signUp': 'साइन अप करें',
    'loginTitle': 'लॉगिन',
    'signInToYourAccount': 'अपने खाते में साइन इन करें',
    'emailAddress': 'ईमेल पता',
    'password': 'पासवर्ड',
    'forgotPassword': 'पासवर्ड भूल गए?',
    'confirm': 'पुष्टि करें',
    'signUpTitle': 'साइन अप',
    'name': 'नाम',
    'mobileNumber': 'मोबाइल नंबर',
    'confirmPassword': 'पासवर्ड की पुष्टि करें',
  },
  'mr-IN': {
    'profileTitle': 'प्रोफाइल',
    'signIn': 'साइन इन',
    'signUp': 'साइन अप',
    'loginTitle': 'लॉगिन',
    'signInToYourAccount': 'तुमच्या खात्यात साइन इन करा',
    'emailAddress': 'ईमेल पत्ता',
    'password': 'पासवर्ड',
    'forgotPassword': 'पासवर्ड विसरलात?',
    'confirm': 'पुष्टी करा',
    'signUpTitle': 'साइन अप',
    'name': 'नाव',
    'mobileNumber': 'मोबाइल नंबर',
    'confirmPassword': 'पासवर्डची पुष्टी करा',
  },
  'ta-IN': {
    'profileTitle': 'சுயவிவரம்',
    'signIn': 'உள்நுழைவு',
    'signUp': 'பதிவு செய்யவும்',
    'loginTitle': 'உள்நுழையவும்',
    'signInToYourAccount': 'உங்கள் கணக்கில் உள்நுழைக',
    'emailAddress': 'மின்னஞ்சல் முகவரி',
    'password': 'கடவுச்சொல்',
    'forgotPassword': 'கடவுச்சொல் மறந்துவிட்டதா?',
    'confirm': 'உறுதிப்படுத்தவும்',
    'signUpTitle': 'பதிவு செய்யவும்',
    'name': 'பெயர்',
    'mobileNumber': 'மொபைல் எண்',
    'confirmPassword': 'கடவுச்சொல்லை உறுதிப்படுத்தவும்',
  },
  'te-IN': {
    'profileTitle': 'ప్రొఫైల్',
    'signIn': 'సైన్ ఇన్ చేయండి',
    'signUp': 'చేరండి',
    'loginTitle': 'లాగిన్',
    'signInToYourAccount': 'మీ ఖాతాలో సైన్ ఇన్ చేయండి',
    'emailAddress': 'ఇమెయిల్ చిరునామా',
    'password': 'పాస్వర్డ్',
    'forgotPassword': 'పాస్వర్డ్ మర్చిపోయారా?',
    'confirm': 'నిర్ధారించండి',
    'signUpTitle': 'చేరండి',
    'name': 'పేరు',
    'mobileNumber': 'మొబైల్ నంబర్',
    'confirmPassword': 'పాస్వర్డ్ నిర్ధారించండి',
  },
  'bn-IN': {
    'profileTitle': 'প্রোফাইল',
    'signIn': 'সাইন ইন করুন',
    'signUp': 'সাইন আপ করুন',
    'loginTitle': 'লগইন',
    'signInToYourAccount': 'আপনার অ্যাকাউন্টে সাইন ইন করুন',
    'emailAddress': 'ইমেল ঠিকানা',
    'password': 'পাসওয়ার্ড',
    'forgotPassword': 'পাসওয়ার্ড ভুলে গেছেন?',
    'confirm': 'নিশ্চিত করুন',
    'signUpTitle': 'সাইন আপ করুন',
    'name': 'নাম',
    'mobileNumber': 'মোবাইল নম্বর',
    'confirmPassword': 'পাসওয়ার্ড নিশ্চিত করুন',
  },
  'gu-IN': {
    'profileTitle': 'પ્રોફાઇલ',
    'signIn': 'સાઇન ઇન કરો',
    'signUp': 'સાઇન અપ કરો',
    'loginTitle': 'લૉગિન',
    'signInToYourAccount': 'તમારા ખાતામાં સાઇન ઇન કરો',
    'emailAddress': 'ઇમેઇલ સરનામું',
    'password': 'પાસવર્ડ',
    'forgotPassword': 'પાસવર્ડ ભૂલી ગયા છો?',
    'confirm': 'પુષ્ટિ કરો',
    'signUpTitle': 'સાઇન અપ',
    'name': 'નામ',
    'mobileNumber': 'મોબાઇલ નંબર',
    'confirmPassword': 'પાસવર્ડની પુષ્ટિ કરો',
  },
  'pa-IN': {
    'profileTitle': 'ਪ੍ਰੋਫਾਈਲ',
    'signIn': 'ਸਾਈਨ ਇਨ ਕਰੋ',
    'signUp': 'ਸਾਈਨ ਅਪ ਕਰੋ',
    'loginTitle': 'ਲਾਗਿਨ',
    'signInToYourAccount': 'ਆਪਣੇ ਖਾਤੇ ਵਿੱਚ ਸਾਈਨ ਇਨ ਕਰੋ',
    'emailAddress': 'ਈਮੇਲ ਪਤਾ',
    'password': 'ਪਾਸਵਰਡ',
    'forgotPassword': 'ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ?',
    'confirm': 'ਪੁਸ਼ਟੀ ਕਰੋ',
    'signUpTitle': 'ਸਾਈਨ ਅਪ ਕਰੋ',
    'name': 'ਨਾਮ',
    'mobileNumber': 'ਮੋਬਾਈਲ ਨੰਬਰ',
    'confirmPassword': 'ਪਾਸਵਰਡ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ',
  },
  'kn-IN': {
    'profileTitle': 'ಪ್ರೊಫೈಲ್',
    'signIn': 'ಸೈನ್ ಇನ್ ಮಾಡಿ',
    'signUp': 'ಸೈನ್ ಅಪ್ ಮಾಡಿ',
    'loginTitle': 'ಲಾಗಿನ್',
    'signInToYourAccount': 'ನಿಮ್ಮ ಖಾತೆಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ',
    'emailAddress': 'ಇಮೇಲ್ ವಿಳಾಸ',
    'password': 'ಪಾಸ್‌ವರ್ಡ್',
    'forgotPassword': 'ಪಾಸ್‌ವರ್ಡ್ ಮರೆತಿದ್ದೀರಾ?',
    'confirm': 'ದೃಢೀಕರಿಸಿ',
    'signUpTitle': 'ಸೈನ್ ಅಪ್',
    'name': 'ಹೆಸರು',
    'mobileNumber': 'ಮೊಬೈಲ್ ನಂಬರ್',
    'confirmPassword': 'ಪಾಸ್‌ವರ್ಡ್ ದೃಢೀಕರಿಸಿ',
  },
  'ml-IN': {
    'profileTitle': 'പ്രൊഫൈൽ',
    'signIn': 'സൈൻ ഇൻ ചെയ്യുക',
    'signUp': 'സൈൻ അപ്പ് ചെയ്യുക',
    'loginTitle': 'ലോഗിൻ',
    'signInToYourAccount': 'നിങ്ങളുടെ അക്കൗണ്ടിൽ സൈൻ ഇൻ ചെയ്യുക',
    'emailAddress': 'ഇമെയിൽ വിലാസം',
    'password': 'പാസ്വേഡ്',
    'forgotPassword': 'പാസ്വേഡ് മറന്നോ?',
    'confirm': 'സ്ഥിരീകരിക്കുക',
    'signUpTitle': 'സൈൻ അപ്പ് ചെയ്യുക',
    'name': 'പേര്',
    'mobileNumber': 'മൊബൈൽ നമ്പർ',
    'confirmPassword': 'പാസ്വേഡ് സ്ഥിരീകരിക്കുക',
  },
  'or-IN': {
    'profileTitle': 'ପ୍ରୋଫାଇଲ୍',
    'signIn': 'ସାଇନ୍ ଇନ୍ କରନ୍ତୁ',
    'signUp': 'ସାଇନ୍ ଅପ୍ କରନ୍ତୁ',
    'loginTitle': 'ଲଗଇନ୍',
    'signInToYourAccount': 'ଆପଣଙ୍କର ଖାତାରେ ସାଇନ୍ ଇନ୍ କରନ୍ତୁ',
    'emailAddress': 'ଇମେଲ୍ ଠିକଣା',
    'password': 'ପାସୱାର୍ଡ',
    'forgotPassword': 'ପାସୱାର୍ଡ ଭୁଲିଗଲାନି?',
    'confirm': 'ନିଶ୍ଚିତ କରନ୍ତୁ',
    'signUpTitle': 'ସାଇନ୍ ଅପ୍ କରନ୍ତୁ',
    'name': 'ନାମ',
    'mobileNumber': 'ମୋବାଇଲ୍ ନମ୍ବର',
    'confirmPassword': 'ପାସୱାର୍ଡ ନିଶ୍ଚିତ କରନ୍ତୁ',
  },
};

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedLanguage = 'en-US'; // Default to English
  final FlutterTts _flutterTts = FlutterTts();

  final List<String> languages = [
    'English',
    'हिंदी (Hindi)',
    'मराठी (Marathi)',
    'தமிழ் (Tamil)',
    'తెలుగు (Telugu)',
    'বাংলা (Bengali)',
    'ગુજરાતી (Gujarati)',
    'ਪੰਜਾਬੀ (Punjabi)',
    'ಕನ್ನಡ (Kannada)',
    'മലയാളം (Malayalam)',
    'ଓଡ଼ିଆ (Odia)',
  ];

  void _updateLanguage(String language) {
    setState(() {
      _selectedLanguage = _getLanguageCode(language);
    });
  }

  Future<void> _speak(
      String profileText, String signInText, String signUpText) async {
    final String speechText =
        '$profileText. $signInText or $signUpText? Please choose.';
    await _flutterTts.setLanguage(_selectedLanguage);
    await _flutterTts.speak(speechText);
  }

  String _getLanguageCode(String language) {
    switch (language) {
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

  @override
  Widget build(BuildContext context) {
    final translation = translations[_selectedLanguage]!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation['profileTitle']!,
          style: const TextStyle(fontFamily: 'CourierPrime'),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
        actions: [
          DropdownButtonHideUnderline(
            // Hide the underline of the dropdown
            child: DropdownButton<String>(
              value: languages.firstWhere(
                (lang) => _getLanguageCode(lang) == _selectedLanguage,
              ),
              icon: const Icon(Icons.language, color: Colors.white),
              dropdownColor: const Color.fromARGB(255, 70, 3, 255),
              onChanged: (String? newValue) => _updateLanguage(newValue!),
              items: languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(
                    language,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: () => _speak(
              translation['profileTitle']!,
              translation['signIn']!,
              translation['signUp']!,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(selectedLanguage: _selectedLanguage),
                  ),
                );
              },
              child: Text(translation['signIn']!),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SignUpPage(selectedLanguage: _selectedLanguage),
                  ),
                );
              },
              child: Text(translation['signUp']!),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final String selectedLanguage;

  const LoginPage({super.key, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    final translation = translations[selectedLanguage]!;
    return Scaffold(
      appBar: AppBar(
        title: Text(translation['loginTitle']!,
            style: const TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      backgroundColor: Colors.white,
      body: Center(
       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translation['signInToYourAccount']!,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: translation['emailAddress']!,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: translation['password']!,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot password functionality
                },
                child: Text(translation['forgotPassword']!),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Sign-in functionality
                },
                child: Text(translation['confirm']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  final String selectedLanguage;

  const SignUpPage({super.key, required this.selectedLanguage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://sih-pravaah.onrender.com/api/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'username': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out. Please try again.');
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomePage(
                username: _nameController.text,
              ),
            ),
          );
        }
      } else {
        final errorData = json.decode(response.body);
        setState(() {
          _errorMessage =
              errorData['message'] ?? 'Registration failed: ${response.statusCode}';
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        _errorMessage = 'Connection timed out. Please check your internet connection.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translation = translations[widget.selectedLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(translation['signUpTitle']!,
            style: const TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translation['signUpTitle']!,
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: translation['name']!,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: translation['emailAddress']!,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: translation['mobileNumber']!,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: translation['password']!,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: translation['confirmPassword']!,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(translation['confirm']!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
