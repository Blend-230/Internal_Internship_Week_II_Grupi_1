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
          seedColor: const Color(0xFFE11D48),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7FA),
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  static const _questions = [
    QuizQuestion(
      text: 'Which widget arranges children vertically?',
      options: ['Column', 'Row', 'Stack', 'Wrap'],
      correctIndex: 0,
    ),
    QuizQuestion(
      text: 'Which Flutter class moves from one screen to another?',
      options: [
        'Navigator',
        'ThemeData',
        'ScaffoldMessenger',
        'TextEditingController',
      ],
      correctIndex: 0,
    ),
    QuizQuestion(
      text: 'Which method refreshes the UI after state changes?',
      options: ['dispose', 'runApp', 'setState', 'build'],
      correctIndex: 2,
    ),
    QuizQuestion(
      text: 'Which type stores a group of quiz questions?',
      options: ['TextStyle', 'EdgeInsets', 'ColorScheme', 'List<QuizQuestion>'],
      correctIndex: 3,
    ),
    QuizQuestion(
      text: 'Which Navigator method opens the result screen?',
      options: [
        'Navigator.pop',
        'Navigator.canPop',
        'Navigator.push',
        'Navigator.maybePop',
      ],
      correctIndex: 2,
    ),
  ];

  QuizQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  void _answerQuestion(int selectedIndex) {
    final isCorrect = selectedIndex == _currentQuestion.correctIndex;
    final nextScore = _score + (isCorrect ? 1 : 0);
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    if (isLastQuestion) {
      setState(() => _score = nextScore);
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ResultScreen(
            score: nextScore,
            totalQuestions: _questions.length,
            onRestart: _restartQuiz,
          ),
        ),
      );
      return;
    }

    setState(() {
      _score = nextScore;
      _currentQuestionIndex++;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final questionNumber = _currentQuestionIndex + 1;
    final progress = questionNumber / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final useGridOptions = constraints.maxWidth >= 760;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          QuizProgressHeader(
                            questionNumber: questionNumber,
                            totalQuestions: _questions.length,
                            score: _score,
                            progress: progress,
                          ),
                          const SizedBox(height: 28),
                          Text(
                            _currentQuestion.text,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 24),
                          AnswerOptions(
                            options: _currentQuestion.options,
                            useGridOptions: useGridOptions,
                            onSelected: _answerQuestion,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.options,
    required this.correctIndex,
  });

  final String text;
  final List<String> options;
  final int correctIndex;
}

class QuizProgressHeader extends StatelessWidget {
  const QuizProgressHeader({
    required this.questionNumber,
    required this.totalQuestions,
    required this.score,
    required this.progress,
    super.key,
  });

  final int questionNumber;
  final int totalQuestions;
  final int score;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.quiz_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question $questionNumber of $totalQuestions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text('Current score: $score'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(value: progress),
      ],
    );
  }
}

class AnswerOptions extends StatelessWidget {
  const AnswerOptions({
    required this.options,
    required this.useGridOptions,
    required this.onSelected,
    super.key,
  });

  final List<String> options;
  final bool useGridOptions;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final buttons = [
      for (var index = 0; index < options.length; index++)
        AnswerOptionButton(
          index: index,
          text: options[index],
          onPressed: () => onSelected(index),
        ),
    ];

    if (useGridOptions) {
      return Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          for (final button in buttons)
            SizedBox(
              width: 386,
              child: button,
            ),
        ],
      );
    }

    return Column(
      children: [
        for (var index = 0; index < buttons.length; index++) ...[
          buttons[index],
          if (index < buttons.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class AnswerOptionButton extends StatelessWidget {
  const AnswerOptionButton({
    required this.index,
    required this.text,
    required this.onPressed,
    super.key,
  });

  final int index;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final label = String.fromCharCode('A'.codeUnitAt(0) + index);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    required this.score,
    required this.totalQuestions,
    required this.onRestart,
    super.key,
  });

  final int score;
  final int totalQuestions;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final percentage = score / totalQuestions;
    final passed = percentage >= 0.6;
    final resultColor = passed ? Colors.green : Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        passed ? Icons.emoji_events_outlined : Icons.replay,
                        color: resultColor,
                        size: 72,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Final score',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$score / $totalQuestions',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                              color: resultColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        passed
                            ? 'Great work. You completed the quiz successfully.'
                            : 'Keep practicing and try the quiz again.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        key: const ValueKey('restart_button'),
                        onPressed: onRestart,
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Restart quiz'),
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
