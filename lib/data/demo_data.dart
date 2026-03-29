import 'package:flutter/material.dart';

import '../models/project_model.dart';
import '../models/skill_model.dart';

class DemoData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'E-Commerce App',
      description:
          'A full-featured e-commerce mobile application with product listings, cart management, secure checkout, and real-time order tracking. Built with GetX state management and Firebase backend.',
      techStack: ['Flutter', 'GetX', 'Firebase', ],
      githubUrl: 'https://github.com/usman-shah12/luxe_E_commerce-app.git',
      liveUrl: 'https://luxe-online-store.web.app/#/login',
      image: 'assets/images/luxe.png',
    ),
   ProjectModel(
  title: 'Usman Dev Portfolio',
  description:
      'My personal Flutter developer portfolio showcasing my projects, skills, and experience. Built with Flutter, featuring clean UI, project showcase, and interactive UI components. Demonstrates state management, reusable widgets, and responsive design.',
  techStack: ['Flutter', 'Dart', 'Firebase', 'Responsive UI'],
  githubUrl: 'https://github.com/syedusmanshah/portfolio',
  liveUrl: 'https://usman-dev.web.app', // if hosted online
  image: 'assets/images/portfolio.png', // a screenshot of your portfolio
),
    ProjectModel(
      title: 'Chat Application',
      description:
          'Real-time messaging application with one-on-one and group chats, media sharing, read receipts, and push notifications. Implemented with Firebase Realtime Database and Cloud Messaging.',
      techStack: ['Flutter', 'Firebase', 'GetX', 'FCM'],
      githubUrl: 'https://github.com/syedusmanshah/chat-app',
      liveUrl: null,
      image: 'assets/images/comingsoon.png',
    ),
    ProjectModel(
      title: 'Weather Dashboard',
      description:
          'A beautiful weather application with hourly and weekly forecasts, location-based weather, interactive charts, and animated weather icons. Integrates OpenWeatherMap REST API.',
      techStack: ['Flutter', 'REST API', 'GetX', 'Charts'],
      githubUrl: 'https://github.com/syedusmanshah/weather-app',
      liveUrl: null,
       image: 'assets/images/comingsoon.png',
    ),
    ProjectModel(
      title: 'Fitness Tracker',
      description:
          'Health and fitness tracking app with workout logging, progress charts, calorie counter, and personalized workout plans. Features local notifications and data persistence with Hive.',
      techStack: ['Flutter', 'Hive', 'Provider', 'FL Chart'],
      githubUrl: 'https://github.com/syedusmanshah/fitness-tracker',
      liveUrl: null,
       image: 'assets/images/comingsoon.png',
    ),
    ProjectModel(
      title: 'News Reader',
      description:
          'Modern news aggregator app with category filtering, bookmarking, offline reading, and a clean card-based UI. Consumes multiple news REST APIs and supports dark/light mode.',
      techStack: ['Flutter', 'REST API', 'Riverpod', 'SQLite'],
      githubUrl: 'https://github.com/syedusmanshah/news-reader',
      liveUrl: null,
       image: 'assets/images/comingsoon.png',
    ),
  ];

  static final List<SkillModel> skills = [
    const SkillModel(
      name: 'Flutter',
      icon: Icons.phone_android,
      level: 'Expert',
    ),
    const SkillModel(
      name: 'Dart',
      icon: Icons.code,
      level: 'Expert',
    ),
    const SkillModel(
      name: 'GetX',
      icon: Icons.electrical_services,
      level: 'Advanced',
    ),
    const SkillModel(
      name: 'Firebase',
      icon: Icons.local_fire_department,
      level: 'Advanced',
    ),
    const SkillModel(
      name: 'REST APIs',
      icon: Icons.api,
      level: 'Advanced',
    ),
    const SkillModel(
      name: 'GitHub',
      icon: Icons.source,
      level: 'Advanced',
    ),
    const SkillModel(
      name: 'Clean Architecture',
      icon: Icons.architecture,
      level: 'Intermediate',
    ),
  ];
}
