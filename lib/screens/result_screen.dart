import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/content_frame.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _message(int score) {
    if (score >= 80) return 'Mantap, kamu jago!';
    if (score >= 50) return 'Lumayan, tinggal diasah lagi.';
    return 'Jangan menyerah, coba lagi yuk!';
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ContentFrame(
            child: Column(
              children: [
                SizedBox(height: context.sp(10)),
                const Align(
                  alignment: Alignment.centerRight,
                  child: ThemeToggle(),
                ),
                SizedBox(height: context.sp(10)),
                Text(
                  'Hasil kuis ${quiz.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.sp(16),
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface.withAlpha(180),
                  ),
                ),
                SizedBox(height: context.sp(20)),
                SizedBox(
                  width: context.sp(170),
                  height: context.sp(170),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(end: quiz.score / 100),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeOutCubic,
                        builder: (_, value, __) => CircularProgressIndicator(
                          value: value,
                          strokeWidth: context.sp(12),
                          strokeCap: StrokeCap.round,
                          backgroundColor: cs.outline.withAlpha(50),
                          color: cs.secondary,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${quiz.score}',
                              style: TextStyle(
                                fontSize: context.sp(48),
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                            Text(
                              '${quiz.correctCount}/${quiz.total} benar',
                              style: TextStyle(
                                fontSize: context.sp(13),
                                color: cs.onSurface.withAlpha(160),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.sp(20)),
                Text(
                  _message(quiz.score),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.sp(20),
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                SizedBox(height: context.sp(28)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Rincian jawaban',
                    style: TextStyle(
                      fontSize: context.sp(16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: context.sp(12)),
                for (var i = 0; i < quiz.total; i++)
                  _AnswerReview(index: i),
                SizedBox(height: context.sp(8)),
                PrimaryButton(
                  label: 'Main lagi',
                  icon: Icons.replay_rounded,
                  onPressed: () {
                    final provider = context.read<QuizProvider>();
                    provider.start(provider.name);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                ),
                SizedBox(height: context.sp(12)),
                PrimaryButton(
                  label: 'Kembali ke beranda',
                  outlined: true,
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    context.read<QuizProvider>().reset();
                  },
                ),
                SizedBox(height: context.sp(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerReview extends StatelessWidget {
  const _AnswerReview({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final cs = Theme.of(context).colorScheme;
    final q = quiz.questions[index];
    final picked = quiz.answerAt(index);
    final correct = picked == q.answerIndex;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: context.sp(10)),
      padding: EdgeInsets.all(context.sp(14)),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.sp(16)),
        border: Border.all(color: cs.outline.withAlpha(60)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: correct ? cs.primary : cs.error,
            size: context.sp(24),
          ),
          SizedBox(width: context.sp(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q.text,
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: context.sp(6)),
                Text(
                  'Jawabanmu: ${picked == null ? '-' : q.options[picked]}',
                  style: TextStyle(
                    fontSize: context.sp(13),
                    color: cs.onSurface.withAlpha(170),
                  ),
                ),
                if (!correct)
                  Text(
                    'Jawaban benar: ${q.options[q.answerIndex]}',
                    style: TextStyle(
                      fontSize: context.sp(13),
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}