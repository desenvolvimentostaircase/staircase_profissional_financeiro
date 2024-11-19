import 'package:firebase_analytics/firebase_analytics.dart';

// Instância do Firebase Analytics
FirebaseAnalytics analytics = FirebaseAnalytics.instance;

// Função para registrar login bem-sucedido
void logLoginEvent() {
  analytics.logEvent(
    name: 'login',
    parameters: <String, Object>{
      'login_success': 'true',  // Convert boolean to string
    },
  );
}
