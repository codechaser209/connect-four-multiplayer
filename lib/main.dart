import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect Four',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(42, '');

  bool blueTurn = true;
  bool isWin = false;
  bool isDraw = false;
  bool isMoving = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color(0xFFA05DFB),
          const Color(0xFFA05DFB).withOpacity(0.5)
        ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10 * MediaQuery.of(context).size.height / 740,
                horizontal: 10 * MediaQuery.of(context).size.height / 740),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Connect Four',
                    style: TextStyle(
                        color: const Color(0xFFFEFEFE),
                        fontFamily: GoogleFonts.rubikIso().fontFamily,
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    'Multiplayer Game',
                    style: TextStyle(
                        color: const Color(0xFFFEFEFE),
                        fontFamily: GoogleFonts.macondo().fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                    height: 100 * MediaQuery.of(context).size.height / 740),
                SizedBox(
                  height: 350 * MediaQuery.of(context).size.height / 740,
                  width: 350 * MediaQuery.of(context).size.height / 740,
                  child: Center(
                    child: GridView.builder(
                      itemCount: board.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            if (!isWin &&
                                !isDraw &&
                                !isMoving &&
                                board[index] == '') {
                              isMoving = true;
                              await dropPiece(index);
                              setState(() {
                                isWin = checkForWinner();
                                isDraw = checkDraw();
                              });
                              isMoving = false;
                            }
                          },
                          child: GlassmorphicContainer(
                              height:
                                  80 * MediaQuery.of(context).size.height / 740,
                              width:
                                  80 * MediaQuery.of(context).size.width / 360,
                              borderRadius: 10,
                              linearGradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(214, 255, 255, 255)
                                        .withOpacity(0.2),
                                    const Color.fromARGB(13, 255, 255, 255)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              border:
                                  2 * MediaQuery.of(context).size.height / 740,
                              blur: 40,
                              borderGradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(102, 255, 255, 255),
                                    Color.fromARGB(13, 255, 255, 255)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              child: Center(
                                  child: board[index] == ''
                                      ? Text(index.toString())
                                      : board[index] == 'B'
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Image.asset(
                                                  'assets/images/blue.png'),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Image.asset(
                                                  'assets/images/red.png'),
                                            ))),
                        );
                      },
                    ),
                  ),
                ),
                GlassmorphicContainer(
                    width: 320 * MediaQuery.of(context).size.width / 360,
                    height: 80 * MediaQuery.of(context).size.height / 740,
                    borderRadius: 10 * MediaQuery.of(context).size.height / 740,
                    linearGradient: const LinearGradient(colors: [
                      Color.fromARGB(102, 255, 255, 255),
                      Color.fromARGB(13, 255, 255, 255)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    border: 2 * MediaQuery.of(context).size.height / 740,
                    blur: 40,
                    borderGradient: const LinearGradient(colors: [
                      Color.fromARGB(102, 255, 255, 255),
                      Color.fromARGB(13, 255, 255, 255)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                                isDraw
                                    ? 'Game Tie! Board is Full'
                                    : isWin
                                        ? blueTurn
                                            ? 'Winner! Player 02 '
                                            : 'Winner! Player 01'
                                        : blueTurn
                                            ? 'Turn of Player 01'
                                            : 'Turn of Player 02',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFF6F4F4)))),
                        Center(
                            child: Text(
                                isDraw
                                    ? 'Better luck for the next Time!'
                                    : isWin
                                        ? 'Congratulations on your well-deserved success! You\'re an inspiration!'
                                        : 'Find the best possible block to win the game!',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFF6F4F4)))),
                      ],
                    )),
                SizedBox(height: 10 * MediaQuery.of(context).size.height / 740),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        board = List.filled(42, '');
                        setState(() {
                          blueTurn = true;
                          isWin = false;
                          isDraw = false;
                        });
                      });
                    },
                    child: GlassmorphicContainer(
                        margin: EdgeInsets.only(
                            right:
                                10 * MediaQuery.of(context).size.width / 360),
                        padding: EdgeInsets.all(
                            5 * MediaQuery.of(context).size.height / 740),
                        width: 120 * MediaQuery.of(context).size.width / 360,
                        height: 35 * MediaQuery.of(context).size.height / 740,
                        borderRadius:
                            10 * MediaQuery.of(context).size.height / 740,
                        linearGradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(102, 255, 255, 255),
                              Color.fromARGB(13, 255, 255, 255)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        border: 2 * MediaQuery.of(context).size.height / 740,
                        blur: 40,
                        borderGradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(102, 255, 255, 255),
                              Color.fromARGB(13, 255, 255, 255)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.restart_alt,
                                color: Color(0xFFF6F4F4)),
                            SizedBox(
                                width: 5 *
                                    MediaQuery.of(context).size.width /
                                    360),
                            Text('Restart',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFF6F4F4))),
                          ],
                        ))),
                  ),
                )
              ],
            ),
          )),
        ));
  }

  Future<void> dropPiece(int block) async {
    int iteration = block % 7;
    while (iteration < 42) {
      setState(() {
        board[iteration] = blueTurn ? 'B' : 'R';
        if (iteration > 6) {
          board[iteration - 7] = '';
        }
      });
      await Future.delayed(const Duration(milliseconds: 200));
      iteration = iteration + 7;

      if (iteration < 42) {
        if (board[iteration] != '') {
          blueTurn = !blueTurn;
        }

        if (board[iteration] != '') {
          break;
        }
      } else {
        blueTurn = !blueTurn;
      }
    }
  }

  bool checkForWinner() {
    for (int i = 0; i < 6; i++) {
      for (int j = 0 + (7 * i); j < 4 + (7 * i); j++) {
        if (board[j] != '' &&
            board[j] == board[j + 1] &&
            board[j] == board[j + 2] &&
            board[j] == board[j + 3]) {
          return true;
        }
      }
    }

    for (int i = 0; i < 7; i++) {
      for (int j = (0 * 7) + i; j < (3 * 7) + i; j = j + 7) {
        if (board[j] != '' &&
            board[j] == board[j + 7] &&
            board[j] == board[j + 14] &&
            board[j] == board[j + 21]) {
          return true;
        }
      }
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0 + (i * 7); j < 4 + (7 * i); j++) {
        if (board[j] != '' &&
            board[j] == board[j + 8] &&
            board[j] == board[j + 16] &&
            board[j] == board[j + 24]) {
          return true;
        }
      }
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 6 + (i * 7); j >= 3 + (7 * i); j--) {
        if (board[j] != '' &&
            board[j] == board[j + 6] &&
            board[j] == board[j + 12] &&
            board[j] == board[j + 18]) {
          return true;
        }
      }
    }

    return false;
  }

  bool checkDraw() {
    for (int i = 0; i < 42; i++) {
      if (board[i] == '') {
        return false;
      }
    }
    return true;
  }
}
