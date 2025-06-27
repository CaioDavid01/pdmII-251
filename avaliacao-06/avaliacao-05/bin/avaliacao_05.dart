import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = gmail('carvalho.urano05@aluno.ifce.edu.br', 'senha');

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address('carvalho.urano05@aluno.ifce.edu.br', 'Caio David Urano de Carvalho')
    ..recipients.add('carvalhocaio809@gmail.com')
    ..subject = 'Teste'
    ..text = 'Teste';

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    final sendReport = await send(message, smtpServer);

    // Exibe o resultado do envio do e-mail
    print('E-mail enviado: ${sendReport}');
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}