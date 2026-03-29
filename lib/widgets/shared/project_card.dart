import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_theme.dart';
import '../../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  AnimationController? _controller;
  Animation<double>? _scaleAnim;
  Animation<double>? _overlayAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
    );
    _overlayAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onHover(bool hovered) {
    setState(() => _hovered = hovered);
    hovered ? _controller?.forward() : _controller?.reverse();
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _hovered ? -8.0 : 0.0),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppTheme.accent.withOpacity(0.6)
                : AppTheme.cardBorder,
            width: 1.2,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.18),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ── THUMBNAIL ──
              _buildImageSection(),

              /// ── BODY ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + GitHub icon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.project.title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _GlowIconButton(
                          onTap: () => _launchUrl(widget.project.githubUrl),
                          hovered: _hovered,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// Description
                    Text(
                      widget.project.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.6,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    /// Tech chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.project.techStack
                          .map((tech) => _TechChip(label: tech))
                          .toList(),
                    ),

                    const SizedBox(height: 14),

                    /// CTA button — always visible, glows on hover
                    _buildButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── THUMBNAIL SECTION ──────────────────────────────────────────────────────
  // Fixed 220px height + BoxFit.contain → full image always visible, no crop,
  // no overflow. Dark background fills any letterbox gaps.
  Widget _buildImageSection() {
    // If no image is provided, show a stylised placeholder instead
    if (widget.project.image == null || widget.project.image!.isEmpty) {
      return _buildPlaceholder();
    }

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Dark bg fills letterbox gaps cleanly
          const ColoredBox(color: Colors.black),

          /// Image — BoxFit.contain shows 100% of the image
          _scaleAnim != null
              ? AnimatedBuilder(
                  animation: _scaleAnim!,
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnim!.value,
                    child: child,
                  ),
                  child: Image.asset(
                    widget.project.image!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : Image.asset(
                  widget.project.image!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),

          /// Subtle bottom gradient to blend into card body
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.cardColor.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          /// Accent tint overlay on hover
          if (_overlayAnim != null)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _overlayAnim!,
                builder: (context, _) => DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppTheme.accent
                        .withOpacity(0.07 * _overlayAnim!.value),
                  ),
                ),
              ),
            ),

          /// Optional "Live" badge (top-right)
          if (widget.project.liveUrl != null &&
              widget.project.liveUrl!.isNotEmpty)
            Positioned(
              top: 12,
              right: 12,
              child: _LiveBadge(
                onTap: () => _launchUrl(widget.project.liveUrl!),
              ),
            ),
        ],
      ),
    );
  }

  /// Shown when project.image is null/empty
  Widget _buildPlaceholder() {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ColoredBox(
        color: AppTheme.accent.withOpacity(0.06),
        child: Center(
          child: Icon(
            Icons.folder_outlined,
            size: 48,
            color: AppTheme.accent.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  // ── BUTTON ─────────────────────────────────────────────────────────────────
  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered
                ? AppTheme.accent
                : AppTheme.accent.withOpacity(0.35),
            width: 1.2,
          ),
          color: _hovered
              ? AppTheme.accent.withOpacity(0.12)
              : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _launchUrl(widget.project.githubUrl),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.code_rounded,
                  size: 15,
                  color: _hovered
                      ? AppTheme.accent
                      : AppTheme.accent.withOpacity(0.45),
                ),
                const SizedBox(width: 8),
                Text(
                  'View on GitHub',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _hovered
                        ? AppTheme.accent
                        : AppTheme.accent.withOpacity(0.45),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Glowing external link icon button
// ─────────────────────────────────────────────
class _GlowIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool hovered;

  const _GlowIconButton({required this.onTap, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: hovered
              ? AppTheme.accent.withOpacity(0.15)
              : AppTheme.accent.withOpacity(0.06),
          border: Border.all(
            color: hovered
                ? AppTheme.accent.withOpacity(0.7)
                : AppTheme.accent.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.25),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),
        child: Icon(
          Icons.open_in_new_rounded,
          size: 14,
          color: hovered ? AppTheme.accent : AppTheme.textSecondary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Live site badge
// ─────────────────────────────────────────────
class _LiveBadge extends StatelessWidget {
  final VoidCallback onTap;

  const _LiveBadge({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.greenAccent.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Live',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.greenAccent,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Tech chip
// ─────────────────────────────────────────────
class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.07),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppTheme.accent.withOpacity(0.18),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
          color: AppTheme.accent.withOpacity(0.9),
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}