import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  File? _image;
  String _caption = "Generate a caption";
  String _selectedLanguage = "English";

  final FlutterTts flutterTts = FlutterTts();

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _caption =
            "Generate a caption"; // Reset caption when a new image is picked
      }
    });
  }

  Future<void> fetchCaption() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:5000/after'),
      )..files.add(await http.MultipartFile.fromPath('file', _image!.path));

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var decodedData = json.decode(utf8.decode(responseData));

      // Handle translation based on the selected language
      await translateCaption(decodedData['caption']);
    } catch (err) {
      print(err);
    }
  }

  Future<void> translateCaption(String text) async {
    // Replace 'YOUR_TRANSLATION_API_KEY' with your actual API key
    const apiKey = '';
    const apiUrl =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'q': text,
        'target': getLanguageCode(_selectedLanguage),
      },
    );

    var responseData = json.decode(response.body);

    // Check if the required keys exist in the Map and the translation is not empty
    if (responseData.containsKey('data') &&
        responseData['data'].containsKey('translations') &&
        responseData['data']['translations'].isNotEmpty &&
        responseData['data']['translations'][0]['translatedText'] != null &&
        responseData['data']['translations'][0]['translatedText'].isNotEmpty) {
      setState(() {
        _caption = responseData['data']['translations'][0]['translatedText'];
      });

      // Speak translated caption
      await flutterTts.speak(_caption);
    } else {
      print(
          'Translation API did not provide a valid translation. Defaulting to English.');

      // Defaulting to English
      setState(() {
        _caption = text;
      });

      // Speak default caption
      await flutterTts.speak(_caption);
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case 'Nepali':
        return 'ne';
      case 'Hindi':
        return 'hi';
      default:
        return 'en';
    }
  }

  Future<void> speakCaption() async {
    await flutterTts.speak(_caption);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caption Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Upload a picture to generate caption",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(_caption, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: fetchCaption,
                  child: const Text("Generate Caption"),
                ),
                ElevatedButton.icon(
                  onPressed: speakCaption,
                  icon: const Icon(Icons.volume_up),
                  label: const Text("Text to Speech"),
                ),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: ["English", "Nepali", "Hindi"]
                      .map((lang) => DropdownMenuItem<String>(
                            value: lang,
                            child: Text(lang),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
