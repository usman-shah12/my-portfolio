import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;
  final VoidCallback onMenuTap;

  const NavBar({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
    required this.onMenuTap,
  });

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Color(0xE60D0D0D),
        border: Border(
          bottom: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.sectionPadding(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'US',
            //         style: GoogleFonts.poppins(
            //           fontSize: 22,
            //           fontWeight: FontWeight.w800,
            //           color: AppTheme.accent,
            //         ),
            //       ),
            //       TextSpan(
            //         text: 'Shah',
            //         style: GoogleFonts.poppins(
            //           fontSize: 22,
            //           fontWeight: FontWeight.w800,
            //           color: AppTheme.textPrimary,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const AppLogo(),

            if (isMobile)
              IconButton(
                icon: const Icon(Icons.menu, color: AppTheme.textPrimary, size: 26),
                onPressed: onMenuTap,
              )
            else
              Row(
                children: List.generate(
                  AppConstants.navItems.length,
                  (index) => _NavItem(
                    label: AppConstants.navItems[index],
                    onTap: () => _scrollToSection(sectionKeys[index]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: _hovered
                ? AppTheme.accent.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _hovered ? AppTheme.accent : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}



class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // ── Logo image ────────────────────────────────────────
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withOpacity(0.35),
                blurRadius: 14,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              // Shown if logo.png is missing — remove once you add the file
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'S',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 11),

        // ── Name + tagline ────────────────────────────────────
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Full name with accent on last name
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Syed Usman ',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.3,
                      height: 1.15,
                    ),
                  ),
                  TextSpan(
                    text: 'Shah',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.accent,
                      letterSpacing: -0.3,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
            // Subtle tagline
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppTheme.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'Flutter Developer',
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textMuted,
                    letterSpacing: 0.6,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
