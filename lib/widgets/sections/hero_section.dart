import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_theme.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.sectionPadding(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Responsive.screenHeight(context) - 70,
      ),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 60),
      child: isMobile
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBadge(),
        const SizedBox(height: 28),
        _buildAvatar(context),
        const SizedBox(height: 36),
        _buildContent(context, crossAxisAlignment: CrossAxisAlignment.center),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _buildContent(
            context,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        const SizedBox(width: 60),
        _buildAvatar(context),
      ],
    );
  }

  Widget _buildBadge() {
    return FadeIn(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Available for hire',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════
  //  AVATAR  — redesigned
  // ════════════════════════════════════════════════════
  Widget _buildAvatar(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // Outer card size
    final cardW = isMobile ? 280.0 : 360.0;
    final cardH = isMobile ? 360.0 : 460.0;

    // Photo fills most of the card
    final photoW = isMobile ? 220.0 : 280.0;
    final photoH = isMobile ? 260.0 : 340.0;

    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: SizedBox(
        width: cardW,
        height: cardH,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // ── 1. Background card with code-pattern ──────────────
            Container(
              width: cardW,
              height: cardH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1A0000),
                    Color(0xFF0D0D0D),
                    Color(0xFF110808),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: AppTheme.accent.withOpacity(0.22),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.12),
                    blurRadius: 48,
                    spreadRadius: 4,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: CustomPaint(painter: _CodePatternPainter()),
              ),
            ),

            // ── 2. Red top accent bar ──────────────────────────────
            Positioned(
              top: 0,
              child: Container(
                width: cardW * 0.55,
                height: 3,
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accent.withOpacity(0.7),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),

            // ── 3. Large profile photo — rounded rect, not circle ──
            Positioned(
              bottom: 0,
              child: Container(
                width: photoW,
                height: photoH,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  border: Border.all(
                    color: AppTheme.accent.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accent.withOpacity(0.25),
                      blurRadius: 32,
                      spreadRadius: 2,
                      offset: const Offset(0, -4),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/usman.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // ── 4. Bottom gradient fade (merges photo into card) ───
            Positioned(
              bottom: 0,
              child: Container(
                width: photoW,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0D0D0D).withOpacity(0.85),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // ── 5. Top-left: experience badge ─────────────────────
            const Positioned(
              top: 20,
              left: 18,
              child: _FloatingBadge(
                icon: Icons.workspace_premium_rounded,
                value: '3+',
                label: 'Years Exp.',
              ),
            ),

            // ── 6. Top-right: projects badge ──────────────────────
            const Positioned(
              top: 20,
              right: 18,
              child: _FloatingBadge(
                icon: Icons.rocket_launch_rounded,
                value: '20+',
                label: 'Projects',
              ),
            ),

            // ── 7. Floating skill chips on left edge ──────────────
            Positioned(
              left: -14,
              top: cardH * 0.38,
              child: const _SkillChip(label: 'Flutter', icon: Icons.phone_android),
            ),
            Positioned(
              left: -14,
              top: cardH * 0.54,
              child: const _SkillChip(label: 'Firebase', icon: Icons.local_fire_department),
            ),

            // ── 8. Floating skill chips on right edge ─────────────
            Positioned(
              right: -14,
              top: cardH * 0.38,
              child: const _SkillChip(label: 'GetX', icon: Icons.electrical_services),
            ),
            Positioned(
              right: -14,
              top: cardH * 0.54,
              child: const _SkillChip(label: 'Dart', icon: Icons.code),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required CrossAxisAlignment crossAxisAlignment,
  }) {
    final isMobile = Responsive.isMobile(context);
    final isCenter = crossAxisAlignment == CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isMobile) ...[_buildBadge(), const SizedBox(height: 24)],

        FadeInLeft(
          duration: const Duration(milliseconds: 700),
          child: Text(
            'Hello, I\'m',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 8),

        FadeInLeft(
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 700),
          child: Text(
            AppConstants.name,
            textAlign: isCenter ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: Responsive.heroNameSize(context),
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 12),

        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 700),
          child: RichText(
            textAlign: isCenter ? TextAlign.center : TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '< ',
                  style: GoogleFonts.firaCode(
                    fontSize: Responsive.fontSize(context, mobile: 18, desktop: 24),
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: AppConstants.title,
                  style: GoogleFonts.poppins(
                    fontSize: Responsive.fontSize(context, mobile: 18, desktop: 24),
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accent,
                  ),
                ),
                TextSpan(
                  text: ' />',
                  style: GoogleFonts.firaCode(
                    fontSize: Responsive.fontSize(context, mobile: 18, desktop: 24),
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        FadeInLeft(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 700),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              'I craft beautiful, high-performance Flutter applications for mobile, web, and desktop. Passionate about clean architecture, seamless UX, and writing code that scales.',
              textAlign: isCenter ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppTheme.textSecondary,
                height: 1.75,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        FadeInUp(
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 700),
          child: Wrap(
            spacing: 14,
            runSpacing: 12,
            alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => _launchUrl(AppConstants.cvUrl),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download CV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _launchUrl(AppConstants.github),
                icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                label: const Text('GitHub'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textPrimary,
                  side: const BorderSide(color: AppTheme.border, width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),

        FadeInUp(
          delay: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 700),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SocialButton(
                icon: FontAwesomeIcons.github,
                onTap: () => _launchUrl(AppConstants.github),
                tooltip: 'GitHub',
              ),
              const SizedBox(width: 12),
              _SocialButton(
                icon: FontAwesomeIcons.linkedin,
                onTap: () => _launchUrl(AppConstants.linkedin),
                tooltip: 'LinkedIn',
              ),
              const SizedBox(width: 12),
              _SocialButton(
                icon: FontAwesomeIcons.whatsapp,
                onTap: () => _launchUrl(AppConstants.whatsapp),
                tooltip: 'WhatsApp',
              ),
              const SizedBox(width: 12),
              _SocialButton(
                icon: FontAwesomeIcons.envelope,
                onTap: () => _launchUrl('mailto:${AppConstants.email}'),
                tooltip: 'Email',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════
//  FLOATING BADGE  (top corners — exp & projects)
// ═══════════════════════════════════════════════════════
class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _FloatingBadge({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xF0111111),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accent.withOpacity(0.35), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppTheme.accent),
          const SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  height: 1.1,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
//  SKILL CHIP  (floating on left & right edges)
// ═══════════════════════════════════════════════════════
class _SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SkillChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xF2111111),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accent.withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withOpacity(0.15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppTheme.accent),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
//  SOCIAL BUTTON
// ═══════════════════════════════════════════════════════
class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _SocialButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _hovered ? AppTheme.accent : AppTheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _hovered ? AppTheme.accent : AppTheme.border,
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 17,
                color: _hovered ? Colors.white : AppTheme.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
//  CODE PATTERN PAINTER  (subtle bg texture on card)
// ═══════════════════════════════════════════════════════
class _CodePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Subtle dot grid
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    for (double x = 16; x < size.width; x += 28) {
      for (double y = 16; y < size.height; y += 28) {
        canvas.drawCircle(Offset(x, y), 1, dotPaint);
      }
    }

    // Red corner glow (bottom)
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFF0000).withOpacity(0.18),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height),
          radius: size.width * 0.65,
        ),
      );
    canvas.drawRect(Offset.zero & size, glowPaint);

    // Horizontal code lines (decorative)
    final linePaint = Paint()
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const lines = [
      (0.10, 0.45, true),
      (0.15, 0.30, false),
      (0.20, 0.55, false),
      (0.25, 0.20, true),
      (0.30, 0.40, false),
      (0.35, 0.25, false),
    ];

    for (final l in lines) {
      final y = size.height * l.$1;
      final w = size.width * l.$2;
      linePaint.color = l.$3
          ? const Color(0xFFFF0000).withOpacity(0.22)
          : Colors.white.withOpacity(0.06);
      canvas.drawLine(
        Offset(size.width * 0.08, y),
        Offset(size.width * 0.08 + w, y),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}