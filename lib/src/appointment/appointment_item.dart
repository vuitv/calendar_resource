import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/appointment.dart';
import '../data/resource.dart';

class DefaultAppointmentItem extends StatelessWidget {
  const DefaultAppointmentItem(
    this.item, {
    this.resources = const [],
    required this.colResource,
    super.key,
  });

  final Appointment item;
  final Resource colResource;
  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat('hh:mm a').format(item.startTime).toLowerCase();
    final minus = item.duration.inMinutes;
    final brightness = ThemeData.estimateBrightnessForColor(item.color);
    final isDark = brightness == Brightness.dark;
    final color = item.color.withOpacity(0.8);
    final textColor = isDark ? Colors.white : Colors.black87;
    final textStyle = TextStyle(fontSize: 14, color: textColor);
    final imageResources = resources.map((e) => e.image);
    final images = imageResources.whereType<ImageProvider>().toList();
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 12, 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ' $startTime - ${minus}m',
                  maxLines: 1,
                  style: textStyle,
                ),
                if (item.labels.isNotEmpty && constraint.maxHeight > 85) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: item.labels.map(LabelItem.new).toList(),
                  ),
                ],
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      colResource.displayName,
                      maxLines: 2,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MultipleAvatar(
                    images,
                    color: color,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class LabelItem extends StatelessWidget {
  const LabelItem(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
      decoration: BoxDecoration(
        color: const Color(0xff000000).withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          height: 18 / 12,
        ),
      ),
    );
  }
}

class MultipleAvatar extends StatelessWidget {
  const MultipleAvatar(this.avatars, {super.key, this.color});

  final List<ImageProvider> avatars;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    const widthFactor = 0.6;
    return Container(
      height: 20,
      width: (avatars.length + 1) * (20 * widthFactor),
      alignment: Alignment.centerRight,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: avatars.length,
        itemBuilder: (context, index) => Align(
          widthFactor: widthFactor,
          child: CircleAvatar(
            image: avatars[index],
            color: color,
          ),
        ),
      ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  const CircleAvatar({
    super.key,
    this.child,
    required this.image,
    this.color,
  });

  final ImageProvider? image;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey.withOpacity(0.08),
          border: Border.all(width: 1.5, color: color ?? Colors.transparent),
          image: image != null
              ? DecorationImage(
                  image: image!,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: child,
      ),
    );
  }
}
