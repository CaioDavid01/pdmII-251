import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Create table TB_ALUNO if not exists
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    )
  ''');

  print('Bem-vindo ao sistema de cadastro de alunos!');

  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Inserir novo aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Opção: ');
    final input = stdin.readLineSync();

    if (input == '1') {
      _inserirAluno(db);
    } else if (input == '2') {
      _listarAlunos(db);
    } else if (input == '0') {
      print('Saindo...');
      break;
    } else {
      print('Opção inválida. Tente novamente.');
    }
  }

  db.dispose();
}

void _inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (máx 50 caracteres): ');
  final nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome inválido. Operação cancelada.');
    return;
  }
  final nomeLimitado = nome.trim().length > 50 ? nome.trim().substring(0, 50) : nome.trim();

  try {
    final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?)');
    stmt.execute([nomeLimitado]);
    stmt.dispose();
    print('Aluno inserido com sucesso!');
  } catch (e) {
    print('Erro ao inserir aluno: $e');
  }
}

void _listarAlunos(Database db) {
  try {
    final ResultSet result = db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id');
    if (result.isEmpty) {
      print('Nenhum aluno cadastrado.');
    } else {
      print('\nLista de alunos:');
      for (final row in result) {
        print('ID: ${row['id']}, Nome: ${row['nome']}');
      }
    }
  } catch (e) {
    print('Erro ao listar alunos: $e');
  }
}
