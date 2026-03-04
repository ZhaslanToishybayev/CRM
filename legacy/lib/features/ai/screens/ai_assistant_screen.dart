/// AI Assistant Screen
/// Smart assistant for task management

import 'package:flutter/material.dart';

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤖 AI Ассистент'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'AI Ассистент',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Умные советы и рекомендации\nдля эффективного управления задачами',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.lightbulb_outline, color: Colors.orange),
                      title: Text('Умные предложения'),
                      subtitle: Text('Анализ загруженности и оптимизация'),
                    ),
                    ListTile(
                      leading: Icon(Icons.recommend, color: Colors.blue),
                      title: Text('Рекомендации задач'),
                      subtitle: Text('Автоматические предложения'),
                    ),
                    ListTile(
                      leading: Icon(Icons.insights, color: Colors.purple),
                      title: Text('Инсайты'),
                      subtitle: Text('Анализ продуктивности'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('AI анализирует ваши данные...'),
              backgroundColor: Colors.blue,
            ),
          );
        },
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.psychology, color: Colors.white),
      ),
    );
  }
}
