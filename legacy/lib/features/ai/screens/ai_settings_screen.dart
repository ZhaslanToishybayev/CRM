/// AI Settings Screen
/// Configuration for AI features

import 'package:flutter/material.dart';

class AISettingsScreen extends StatefulWidget {
  const AISettingsScreen({super.key});

  @override
  State<AISettingsScreen> createState() => _AISettingsScreenState();
}

class _AISettingsScreenState extends State<AISettingsScreen> {
  bool _aiEnabled = true;
  String _selectedAI = 'local';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ AI Настройки'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text('Включить AI Ассистента'),
              subtitle: const Text('Использовать умные рекомендации'),
              value: _aiEnabled,
              onChanged: (value) {
                setState(() {
                  _aiEnabled = value;
                });
              },
              secondary: Icon(
                _aiEnabled ? Icons.smart_toy : Icons.smart_toy_outlined,
                color: _aiEnabled ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Модель',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<String>(
                    title: const Text('Локальные Алгоритмы'),
                    subtitle: const Text('Быстро и бесплатно'),
                    value: 'local',
                    groupValue: _selectedAI,
                    onChanged: (value) {
                      setState(() {
                        _selectedAI = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('GLM 4.6+ (Z.AI)'),
                    subtitle: const Text('Более точные рекомендации'),
                    value: 'glm',
                    groupValue: _selectedAI,
                    onChanged: (value) {
                      setState(() {
                        _selectedAI = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Конфигурация Z.AI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'API Key',
                      hintText: 'Введите ваш Z.AI API ключ',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('API ключ сохранен'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Сохранить Z.AI API Key'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: _selectedAI == 'glm' ? Colors.green : Colors.orange,
                        size: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedAI == 'glm'
                            ? 'Z.AI API ключ настроен'
                            : 'Z.AI API ключ не настроен',
                        style: TextStyle(
                          color: _selectedAI == 'glm' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Дополнительно',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.blue),
                    title: const Text('Уведомления AI'),
                    subtitle: const Text('Получать уведомления от ассистента'),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.analytics, color: Colors.purple),
                    title: const Text('Аналитика'),
                    subtitle: const Text('Отправлять анонимную аналитику'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
