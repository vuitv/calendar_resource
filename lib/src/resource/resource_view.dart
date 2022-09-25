import 'dart:math';

import 'package:flutter/material.dart';

import '../common/typedef.dart';
import '../data/resource.dart';
import '../settings/resource_view_settings.dart';

class ResourceViewWidget extends StatelessWidget {
  const ResourceViewWidget({
    super.key,
    this.scrollController,
    this.resources = const [],
    required this.resourceViewSettings,
    required this.resourceItemWidth,
    this.resourceBuilder,
    required this.cellBorder,
  });

  final List<Resource> resources;
  final ResourceViewSettings resourceViewSettings;
  final double resourceItemWidth;
  final ResourceBuilder? resourceBuilder;
  final ScrollController? scrollController;
  final BorderSide cellBorder;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final resourceLength = resources.length;
    final offset = cellBorder.width;
    if (resourceBuilder != null) {
      for (var i = 0; i < resourceLength; i++) {
        final currentResource = resources[i];
        final child = resourceBuilder!(
          context,
          currentResource,
        );
        children.add(
          RepaintBoundary(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: resourceItemWidth,
                maxWidth: resourceItemWidth,
                minHeight: double.infinity,
              ),
              child: child,
            ),
          ),
        );
      }
      return ListView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        children: children,
      );
    } else {
      return ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: resourceLength,
        separatorBuilder: (_, __) => VerticalDivider(
          width: offset,
          thickness: offset,
          color: cellBorder.color,
        ),
        itemBuilder: (context, index) {
          final currentResource = resources[index];
          return RepaintBoundary(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: resourceItemWidth - offset,
                maxWidth: resourceItemWidth - offset,
                minHeight: double.infinity,
              ),
              child: CalendarResourceItem(
                name: currentResource.displayName,
                avatar: currentResource.image,
                subtitle: currentResource.subtitle,
              ),
            ),
          );
        },
      );
    }
  }
}

class CalendarResourceItem extends StatelessWidget {
  const CalendarResourceItem({
    super.key,
    required this.avatar,
    required this.name,
    this.subtitle = '',
  });

  final ImageProvider? avatar;
  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.04),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 20,
              foregroundImage: avatar,
              child: avatar == null && name.isNotEmpty
                  ? Text(
                      name.substring(0, 1),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    height: 1.2,
                    fontSize: 10,
                    color: Colors.black54,
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
