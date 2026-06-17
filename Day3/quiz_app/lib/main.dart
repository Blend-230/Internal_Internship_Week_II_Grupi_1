import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  final String question;
  final List<String> options;
  final int correctAnswerIndex;
}

const quizQuestions = [
  QuizQuestion(
    question: 'Which widget is commonly used to create a scrollable list?',
    options: ['Container', 'ListView', 'Stack', 'SizedBox'],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'Which method refreshes the UI in a StatefulWidget?',
    options: ['setState', 'runApp', 'dispose', 'buildContext'],
    correctAnswerIndex: 0,
  ),
  QuizQuestion(
    question: 'Which class is used to move to another screen in Flutter?',
    options: ['SnackBar', 'Navigator', 'TextField', 'Scaffold'],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'How many options does every question in this quiz have?',
    options: ['2', '3', '4', '5'],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    question: 'Which language is used to write Flutter apps?',
    options: ['Dart', 'Python', 'Swift only', 'SQL'],
    correctAnswerIndex: 0,
  ),
];

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(int selectedIndex) {
    final currentQuestion = quizQuestions[currentQuestionIndex];
    final isCorrect = selectedIndex == currentQuestion.correctAnswerIndex;

    setState(() {
      if (isCorrect) {
        score++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Correct answer!' : 'Wrong answer.'),
        duration: const Duration(milliseconds: 650),
      ),
    );

    final hasNextQuestion = currentQuestionIndex < quizQuestions.length - 1;
    if (hasNextQuestion) {
      setState(() {
        currentQuestionIndex++;
      });
      return;
    }

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: score,
            totalQuestions: quizQuestions.length,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / quizQuestions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Multi-screen Quiz'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                    style: const TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 9,
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: const Color(0xFFE2E8F0),
                  ),
                  const SizedBox(height: 22),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question.question,
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 22),
                          ...List.generate(question.options.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: FilledButton.tonalIcon(
                                onPressed: () => answerQuestion(index),
                                icon: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: const Color(0xFF0F766E),
                                  foregroundColor: Colors.white,
                                  child: Text('${index + 1}'),
                                ),
                                label: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(question.options[index]),
                                ),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 15,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Current score: $score',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF334155),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  final int score;
  final int totalQuestions;

  String get resultMessage {
    final percentage = score / totalQuestions;
    if (percentage == 1) {
      return 'Perfect result!';
    }
    if (percentage >= 0.7) {
      return 'Great job!';
    }
    if (percentage >= 0.4) {
      return 'Good effort, keep practicing.';
    }
    return 'Try again and improve your score.';
  }

  void restartQuiz(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Quiz Result'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 68,
                        color: Color(0xFFF59E0B),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        resultMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'You scored $score out of $totalQuestions.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () => restartQuiz(context),
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Restart Quiz'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF0F766E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
