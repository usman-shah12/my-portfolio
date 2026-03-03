import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import '../../data/demo_data.dart';
import '../shared/project_card.dart';
import '../shared/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.sectionPadding(context);
    final columns = Responsive.gridColumns(context);

    return Container(
      width: double.infinity,
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            child: const SectionTitle(
              title: 'Featured Projects',
              subtitle: 'A selection of my recent work and personal projects.',
            ),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: _getAspectRatio(context),
            ),
            itemCount: DemoData.projects.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: index * 100),
                child: ProjectCard(project: DemoData.projects[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  double _getAspectRatio(BuildContext context) {
    if (Responsive.isMobile(context)) return 0.8;
    if (Responsive.isTablet(context)) return 0.85;
    return 0.9;
  }
}
