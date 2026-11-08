import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/content_frame.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<QuizProvider>().start(_nameController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = context.read<QuizProvider>().total;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: ContentFrame(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.sp(14)),
                      Row(
                        children: [
                          AppLogo(size: context.sp(46)),
                          SizedBox(width: context.sp(12)),
                          Text(
                            'Tebak Kode',
                            style: TextStyle(
                              fontSize: context.sp(18),
                              fontWeight: FontWeight.w700,
                              color: cs.primary,
                            ),
                          ),
                          const Spacer(),
                          const ThemeToggle(),
                        ],
                      ),
                      SizedBox(height: context.sp(48)),
                      Text(
                        'Seberapa jago\nkamu soal dasar\nngoding?',
                        style: TextStyle(
                          fontSize: context.sp(34),
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: context.sp(14)),
                      Text(
                        'Jawab $total pertanyaan singkat, lalu lihat skor akhirmu.',
                        style: TextStyle(
                          fontSize: context.sp(15),
                          height: 1.5,
                          color: cs.onSurface.withAlpha(170),
                        ),
                      ),
                      SizedBox(height: context.sp(20)),
                      Wrap(
                        spacing: context.sp(8),
                        runSpacing: context.sp(8),
                        children: [
                          Chip(
                            avatar: const Icon(Icons.quiz_rounded, size: 18),
                            label: Text('$total soal'),
                          ),
                          const Chip(
                            avatar: Icon(Icons.timer_off_rounded, size: 18),
                            label: Text('Tanpa batas waktu'),
                          ),
                        ],
                      ),
                      SizedBox(height: context.sp(40)),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _nameController,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _startQuiz(),
                          style: TextStyle(fontSize: context.sp(16)),
                          decoration: const InputDecoration(
                            labelText: 'Nama kamu',
                            hintText: 'Contoh: Jeconia',
                            prefixIcon: Icon(Icons.person_rounded),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().length < 2) {
                              return 'Isi nama dulu ya (minimal 2 huruf)';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: context.sp(18)),
                      PrimaryButton(
                        label: 'Mulai Kuis',
                        icon: Icons.play_arrow_rounded,
                        onPressed: _startQuiz,
                      ),
                      SizedBox(height: context.sp(24)),
                    ],
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