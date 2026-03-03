import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../core/constants.dart';

class AppDrawer extends StatelessWidget {
  final List<GlobalKey> sectionKeys;

  const AppDrawer({super.key, required this.sectionKeys});

  void _scrollToSection(BuildContext context, GlobalKey key) {
    Navigator.of(context).pop();
    Future.delayed(const Duration(milliseconds: 200), () {
      final ctx = key.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'US',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.accent,
                      ),
                    ),
                    TextSpan(
                      text: 'Shah',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: AppTheme.border),
            const SizedBox(height: 8),
            ...List.generate(
              AppConstants.navItems.length,
              (index) => _DrawerItem(
                icon: _getIcon(index),
                label: AppConstants.navItems[index],
                onTap: () => _scrollToSection(context, sectionKeys[index]),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '© 2024 Syed Usman Shah',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    const icons = [
      Icons.home_outlined,
      Icons.person_outline,
      Icons.code_outlined,
      Icons.work_outline,
      Icons.mail_outline,
    ];
    return icons[index];
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: AppTheme.accent, size: 22),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
