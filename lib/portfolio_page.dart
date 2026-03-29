import 'package:flutter/material.dart';
import 'package:portfolio/core/app_theme.dart';
import 'package:portfolio/core/responsive.dart';
import 'package:portfolio/widgets/sections/about_section.dart';
import 'package:portfolio/widgets/sections/contact_section.dart';
import 'package:portfolio/widgets/sections/hero_section.dart';
import 'package:portfolio/widgets/sections/projects_section.dart';
import 'package:portfolio/widgets/sections/skills_section.dart';
import 'package:portfolio/widgets/shared/app_drawer.dart';
import 'package:portfolio/widgets/shared/navbar.dart';


class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _heroKey,
      _aboutKey,
      _skillsKey,
      _projectsKey,
      _contactKey,
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.background,
      drawer: Responsive.isMobile(context)
          ? AppDrawer(sectionKeys: _sectionKeys)
          : null,
      appBar: NavBar(
        sectionKeys: _sectionKeys,
        scrollController: _scrollController,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(key: _heroKey, child: const HeroSection()),
            SizedBox(key: _aboutKey, child: const AboutSection()),
            SizedBox(key: _skillsKey, child: const SkillsSection()),
            SizedBox(key: _projectsKey, child: const ProjectsSection()),
            SizedBox(key: _contactKey, child: const ContactSection()),
          ],
        ),
      ),
    );
  }
}
