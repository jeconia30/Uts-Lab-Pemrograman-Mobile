import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/content_frame.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_header.dart';
import '../widgets/theme_toggle.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<bool?> _confirmExit(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres jawabanmu akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Lanjut main'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleBack(BuildContext context) async {
    final leave = await _confirmExit(context);
    if (leave == true && context.mounted) {
      context.read<QuizProvider>().reset();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final cs = Theme.of(context).colorScheme;
    final question = quiz.currentQuestion;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: ContentFrame(
            child: Column(
              children: [
                SizedBox(height: context.sp(10)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _handleBack(context),
                      icon: const Icon(Icons.close_rounded),
                      tooltip: 'Keluar',
                    ),
                    Expanded(
                      child: Text(
                        'Halo, ${quiz.name}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.sp(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const ThemeToggle(),
                  ],
                ),
                SizedBox(height: context.sp(14)),
                ProgressHeader(
                  current: quiz.currentIndex + 1,
                  total: quiz.total,
                ),
                SizedBox(height: context.sp(18)),
                Expanded(
                  child: SingleChildScrollView(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Column(
                        key: ValueKey(quiz.currentIndex),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(context.sp(20)),
                            margin: EdgeInsets.only(bottom: context.sp(20)),
                            decoration: BoxDecoration(
                              color: cs.surface,
                              borderRadius:
                              BorderRadius.circular(context.sp(20)),
                              border: Border.all(
                                color: cs.outline.withAlpha(60),
                              ),
                            ),
                            child: Text(
                              question.text,
                              style: TextStyle(
                                fontSize: context.sp(18),
                                height: 1.45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          for (var i = 0; i < question.options.length; i++)
                            OptionTile(
                              letter: String.fromCharCode(65 + i),
                              text: question.options[i],
                              selected: quiz.selectedOption == i,
                              onTap: () =>
                                  context.read<QuizProvider>().select(i),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.sp(14)),
                  child: Row(
                    children: [
                      if (!quiz.isFirst) ...[
                        Expanded(
                          child: PrimaryButton(
                            label: 'Kembali',
                            outlined: true,
                            onPressed: () =>
                                context.read<QuizProvider>().previous(),
                          ),
                        ),
                        SizedBox(width: context.sp(12)),
                      ],
                      Expanded(
                        flex: 2,
                        child: PrimaryButton(
                          label: quiz.isLast ? 'Selesai' : 'Lanjut',
                          icon: quiz.isLast
                              ? Icons.flag_rounded
                              : Icons.arrow_forward_rounded,
                          onPressed: quiz.isAnswered
                              ? () {
                            if (quiz.isLast) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ResultScreen(),
                                ),
                              );
                            } else {
                              context.read<QuizProvider>().next();
                            }
                          }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}