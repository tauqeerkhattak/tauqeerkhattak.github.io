class Constants {
  static String githubUri = 'https://github.com/tauqeerkhattak/';
  static String email = 'mailto:tauqeer745@outlook.com';
  static String linkedin =
      'https://www.linkedin.com/in/tauqeer-khattak-48108017b/';
  static String facebook =
      'https://www.facebook.com/tauqeer.ahmed.khan.khattak/';
  static const uselessFactsUrl = 'https://uselessfacts.jsph.pl/api/';

  static const String summary =
      'Full Stack Flutter Developer with a strong foundation in native Android development and hands-on experience building responsive, high-performance cross-platform applications. Skilled in both frontend and backend development, with a focus on clean architecture, scalable APIs, and seamless UI/UX. Passionate about delivering innovative, user-centric mobile solutions with robust server-side integration.';

  static const List<Map<String, dynamic>> experiences = [
    {
      'role': 'Senior Associate Flutter',
      'company': 'Tafsol Technologies',
      'location': 'Karachi, Pakistan',
      'period': 'April 2025 – Present',
      'points': [
        'Collaborated with the team lead to implement features and maintain high-quality cross-platform mobile applications.',
        'Focused on delivering scalable, maintainable, and performance-optimized Flutter code within a collaborative team environment.',
        'Mentored junior developers and interns, ensuring adherence to Flutter best practices and clean architecture.',
      ],
    },
    {
      'role': 'Flutter Developer',
      'company': 'EuSopht',
      'location': 'Karachi, Pakistan',
      'period': 'January 2022 – April 2025',
      'points': [
        'Joined as a Junior Flutter Developer and progressed to taking on senior-level responsibilities.',
        'Led codebase refactoring efforts, transforming legacy/spaghetti code into maintainable architecture using the BLoC pattern.',
        'Mentored interns and juniors, promoting best practices and clean code standards across the team.',
      ],
    },
  ];

  static const List<Map<String, dynamic>> projects = [
    {
      'name': 'OrganAise',
      'company': 'EuSopht',
      'description': 'An event management application.',
      'details': [
        'Backend built with Firebase for Authentication, Firestore, and Functions.',
        'Events exported and fetched from Google, Outlook, and Apple Calendar.',
      ],
    },
    {
      'name': 'Wajba',
      'company': 'Tafsol Technologies',
      'description': 'A food wastage management application.',
      'details': [
        'Used Firebase Authentication for Google and Apple Auth.',
        'Integrated APIs across the application using GetX state management.',
      ],
    },
    {
      'name': 'MensaPay',
      'company': 'EuSopht',
      'description': 'A prepaid wallet for Mensa-issued prepaid cardholders.',
      'details': [
        'Designed and developed the application from scratch, integrating APIs using Riverpod state management.',
      ],
    },
  ];

  static const String education =
      'Bachelor\'s Degree, Software Engineering\nMUET, Jamshoro Pakistan\nOctober 2017 – October 2021\nGraduated with a 3.76 CGPA';

  static const String resumePath = 'assets/Tauqeer_Ahmed_Resume.pdf';
}
