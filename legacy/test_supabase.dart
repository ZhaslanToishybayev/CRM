import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  try {
    // Load environment
    final env = File('.env').readAsStringSync();
    print('✅ .env файл найден');
    
    // Get credentials from env
    final supabaseUrl = env.split('\n').firstWhere((line) => line.startsWith('SUPABASE_URL=')).split('=')[1];
    final supabaseKey = env.split('\n').firstWhere((line) => line.startsWith('SUPABASE_ANON_KEY=')).split('=')[1];
    
    print('✅ URL: $supabaseUrl');
    print('✅ Key получен (${supabaseKey.substring(0, 20)}...)');
    
    // Initialize Supabase
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    print('✅ Supabase инициализирован');
    
    // Try to query
    final response = await Supabase.instance.client.from('organizations').select('count').limit(1);
    print('✅ Подключение к БД успешно!');
    print('📊 Ответ: $response');
    
    print('\n🎉 ВСЕ РАБОТАЕТ! БД настроена и доступна.');
    
    exit(0);
  } catch (e) {
    print('❌ Ошибка: $e');
    exit(1);
  }
}
