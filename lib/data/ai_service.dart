import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  Future<String?> generateText(String message) async {
    final apiKey = dotenv.get('API_KEY'); // Access your key
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.text(
          "You are a specialized assistant that responds **exclusively in Arabic**."
          "Only answer questions related to **mathematics** or **physics**."
          "Keep answers concise and focused on scientific accuracy."),
    );
    try {
      final response = await model.generateContent([Content.text(message)]);
      return response.text;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
