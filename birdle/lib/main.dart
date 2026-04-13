import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Testando o meu Birdle!'),
        ),
      ),
    );
  }
}
//commit 1 - Configuração do Projeto
//commit 2 - Criando Layout Inicial
//commit 3 - Integrando o código base e rodando navegador no navegador Chrome
//commit 4 - Testando o Hot Reload e Alterando o texto da Interface
//commit 5 - Revisão do Widget Tree e HotReload Concluidos
//commit 6 - Conclusão do Quiz sobre o runApp
//commit 7 - Organizando e Nomeando os commits
