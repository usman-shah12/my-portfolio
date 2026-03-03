import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import '../shared/section_title.dart';


class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.sectionPadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            child: const SectionTitle(
              title: 'About Me',
              subtitle: 'A passionate developer building great digital experiences.',
            ),
          ),
          const SizedBox(height: 48),
          isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBioText(context),
        const SizedBox(height: 32),
        _buildInfoCards(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildBioText(context)),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildInfoCards(context)),
      ],
    );
  }

  Widget _buildBioText(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Passionate Flutter Developer',
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, mobile: 20, desktop: 26),
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I\'m Syed Usman Shah, a Flutter developer with a strong foundation in building cross-platform applications that run seamlessly on mobile, web, and desktop. My journey in software development began at Ilma University, where I developed a deep appreciation for clean code and elegant solutions.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppTheme.textSecondary,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I specialize in Flutter and Dart, with expertise in state management solutions like GetX and BLoC, Firebase backend services, and RESTful API integration. I follow clean architecture principles to ensure my code is maintainable, testable, and scalable.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppTheme.textSecondary,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Beyond coding, I\'m passionate about crafting pixel-perfect UIs, staying up-to-date with the latest Flutter ecosystem developments, and contributing to open-source projects.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppTheme.textSecondary,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 28),
          // Highlight stats
          const Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _StatItem(value: '1+', label: 'Year Experience'),
_StatItem(value: '15+', label: 'Practice Projects'),
_StatItem(value: 'Intern', label: 'Flutter Developer'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: const Column(
        children: [
          _InfoCard(
            icon: Icons.school_outlined,
            title: 'Education',
            content: 'Bachelor\'s in Software Engineering\nIlma University, Karachi',
            year: '2024 – 2028',
          ),
          SizedBox(height: 16),
          _InfoCard(
            icon: Icons.work_outline,
            title: 'Experience',
            content: 'Flutter Developer\nFreelance & Projects',
            year: '2023 – Present',
          ),
          SizedBox(height: 16),
         _InfoCard(
  icon: Icons.work_outline,
  title: 'Current Role',
  content: 'Flutter Developer Intern\nDevenhanced Company',
),
          SizedBox(height: 16),
          _InfoCard(
            icon: Icons.translate_outlined,
            title: 'Languages',
            content: 'Urdu (Native)\nEnglish (Professional)',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppTheme.accent,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final String? year;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.accent,
                      ),
                    ),
                    if (year != null)
                      Text(
                        year!,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    color: AppTheme.textSecondary,
                    height: 1.6,
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
