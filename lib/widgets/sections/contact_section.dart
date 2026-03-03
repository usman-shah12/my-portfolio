import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_theme.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../shared/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.sectionPadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppTheme.background,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            child: const SectionTitle(
              title: 'Get In Touch',
              subtitle: 'I\'m always open to new opportunities and collaborations.',
            ),
          ),
          const SizedBox(height: 48),
          isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
          const SizedBox(height: 60),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(context),
        const SizedBox(height: 32),
        _buildContactCards(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildText(context)),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildContactCards(context)),
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return FadeInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s Work Together',
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, mobile: 22, desktop: 28),
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Whether you have a project in mind, need a Flutter developer for your team, or just want to say hi — my inbox is always open!',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppTheme.textSecondary,
              height: 1.75,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _launchUrl('mailto:${AppConstants.email}'),
            icon: const Icon(Icons.mail_outline, size: 18),
            label: const Text('Send Email'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accent,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCards(BuildContext context) {
    final contacts = [
      _ContactItem(
        icon: FontAwesomeIcons.envelope,
        title: 'Email',
        value: AppConstants.email,
        onTap: () => _launchUrl('mailto:${AppConstants.email}'),
      ),
      _ContactItem(
        icon: FontAwesomeIcons.github,
        title: 'GitHub',
        value: '@syedusmanshah',
        onTap: () => _launchUrl(AppConstants.github),
      ),
      _ContactItem(
        icon: FontAwesomeIcons.linkedin,
        title: 'LinkedIn',
        value: 'Syed Usman Shah',
        onTap: () => _launchUrl(AppConstants.linkedin),
      ),
      _ContactItem(
        icon: FontAwesomeIcons.whatsapp,
        title: 'WhatsApp',
        value: '+92 300 1234567',
        onTap: () => _launchUrl(AppConstants.whatsapp),
      ),
    ];

    return FadeInRight(
      child: Column(
        children: contacts
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _ContactCard(item: e.value),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppTheme.border),
        const SizedBox(height: 24),
        Center(
          child: Column(
            children: [
              Text(
                '© 2024 Syed Usman Shah. All rights reserved.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Built with Flutter ❤️',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactItem {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });
}

class _ContactCard extends StatefulWidget {
  final _ContactItem item;

  const _ContactCard({required this.item});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _hovered
                ? AppTheme.accent.withOpacity(0.05)
                : AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppTheme.accent.withOpacity(0.4) : AppTheme.cardBorder,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppTheme.accent
                      : AppTheme.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: FaIcon(
                    widget.item.icon,
                    size: 18,
                    color: _hovered ? Colors.white : AppTheme.accent,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    Text(
                      widget.item.value,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: _hovered ? AppTheme.accent : AppTheme.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
