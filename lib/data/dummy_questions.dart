import 'question.dart';

const List<Question> dummyQuestions = [
  Question(
    text: 'Bahasa pemrograman apa yang dipakai untuk membangun aplikasi Flutter?',
    options: ['Kotlin', 'Dart', 'Swift', 'JavaScript'],
    answerIndex: 1,
  ),
  Question(
    text: 'Widget mana yang tampilannya tidak berubah selama aplikasi berjalan?',
    options: ['StatefulWidget', 'InheritedWidget', 'StatelessWidget', 'AnimatedWidget'],
    answerIndex: 2,
  ),
  Question(
    text: 'Method apa yang dipanggil untuk memperbarui tampilan pada StatefulWidget?',
    options: ['setState()', 'build()', 'dispose()', 'initState()'],
    answerIndex: 0,
  ),
  Question(
    text: 'Perintah Git untuk menyimpan perubahan ke riwayat lokal adalah...',
    options: ['git push', 'git clone', 'git pull', 'git commit'],
    answerIndex: 3,
  ),
  Question(
    text: 'Struktur data yang bekerja dengan prinsip LIFO (Last In First Out) adalah...',
    options: ['Queue', 'Stack', 'Array', 'Linked List'],
    answerIndex: 1,
  ),
  Question(
    text: 'Kompleksitas waktu algoritma binary search adalah...',
    options: ['O(n)', 'O(n²)', 'O(log n)', 'O(1)'],
    answerIndex: 2,
  ),
  Question(
    text: 'Pada Flutter, perintah untuk berpindah ke halaman baru adalah...',
    options: ['Navigator.push()', 'Router.go()', 'Screen.open()', 'Page.show()'],
    answerIndex: 0,
  ),
  Question(
    text: 'Konsep OOP yang menyembunyikan detail internal sebuah objek disebut...',
    options: ['Inheritance', 'Polymorphism', 'Abstraction', 'Encapsulation'],
    answerIndex: 3,
  ),
  Question(
    text: 'Kode status HTTP 404 menandakan bahwa...',
    options: [
      'Server error',
      'Halaman tidak ditemukan',
      'Akses ditolak',
      'Permintaan berhasil',
    ],
    answerIndex: 1,
  ),
  Question(
    text: 'Kepanjangan dari singkatan OOP adalah...',
    options: [
      'Object Oriented Programming',
      'Open Order Process',
      'Output Oriented Program',
      'Online Operation Platform',
    ],
    answerIndex: 0,
  ),
];