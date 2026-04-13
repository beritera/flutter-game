import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const Birdle());

class Birdle extends StatelessWidget {
  const Birdle({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WordleGame(),
    );
  }
}

class WordleGame extends StatefulWidget {
  const WordleGame({super.key});
  @override
  State<WordleGame> createState() => _WordleGameState();
}

class _WordleGameState extends State<WordleGame> {
  List<String> guesses = [""]; 
  final String target = "FLUTTER"; // Palavra correta

  // Função que decide a cor de cada quadradinho
  Color getLetterColor(String char, int index, String word) {
    if (word.length < 7) return Colors.transparent; 
    if (target[index] == char) return Colors.green; 
    if (target.contains(char)) return Colors.orange; 
    return Colors.grey.shade800; 
  }

  // Função para mostrar o resultado final
  void _showFinishDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => AlertDialog(
        title: const Text("Resultado"),
        content: Text(message, style: const TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                guesses = [""]; // Reinicia as tentativas
              });
              Navigator.pop(context);
            },
            child: const Text("Jogar Novamente"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIRDLE - PROJETO FINAL'),
        centerTitle: true,
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode()..requestFocus(), // Garante que o teclado funcione ao abrir
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            setState(() {
              String key = event.logicalKey.keyLabel.toUpperCase();
              
              // Lógica para letras (A-Z)
              if (key.length == 1 && RegExp(r'[A-Z]').hasMatch(key) && guesses.last.length < 7) {
                guesses[guesses.length - 1] += key;
              } 
              // Lógica para apagar (Backspace)
              else if (event.logicalKey == LogicalKeyboardKey.backspace && guesses.last.isNotEmpty) {
                guesses[guesses.length - 1] = guesses.last.substring(0, guesses.last.length - 1);
              } 
              // Lógica para confirmar (Enter)
              else if (event.logicalKey == LogicalKeyboardKey.enter && guesses.last.length == 7) {
                if (guesses.last == target) {
                  _showFinishDialog("Parabéns! Você acertou! 🎉");
                } else if (guesses.length < 5) {
                  guesses.add(""); // Vai para a próxima linha
                } else {
                  _showFinishDialog("Fim de jogo! A palavra era: $target");
                }
              }
            });
          }
        },
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, 
                  mainAxisSpacing: 8, 
                  crossAxisSpacing: 8,
                ),
                itemCount: 35, // 5 linhas x 7 colunas
                itemBuilder: (context, index) {
                  int row = index ~/ 7;
                  int col = index % 7;
                  String char = "";
                  Color bgColor = Colors.transparent;

                  if (row < guesses.length && col < guesses[row].length) {
                    char = guesses[row][col];
                  }
                  
                  // Só pinta a cor se a linha já foi enviada ou se a palavra está completa
                  if (row < guesses.length - 1 || (row == guesses.length - 1 && guesses[row].length == 7 && guesses.length == 5)) {
                     if (row < guesses.length && col < guesses[row].length) {
                        bgColor = getLetterColor(char, col, guesses[row]);
                     }
                  } else if (row < guesses.length - 1 || (row < guesses.length && guesses[row].length == 7 && guesses[row] == target)) {
                     bgColor = getLetterColor(char, col, guesses[row]);
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(color: Colors.white24), 
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        char, 
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.black12,
              child: const Text(
                "DICA: A PALAVRA TEM 7 LETRAS\nUSE O TECLADO E APERTE ENTER",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
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
//commit 8 - Colocando o nome dos integrantes do trabalho no ReadME
//commit 9 - Colocando de volta o código do jogo que não deu Push
