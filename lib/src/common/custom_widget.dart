import 'package:flutter/rendering.dart';

class CalendarParentData extends ContainerBoxParentData<RenderBox> {}

abstract class CustomCalendarRenderObject extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, CalendarParentData> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! CalendarParentData) {
      child.parentData = CalendarParentData();
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    return;
  }

  SemanticsBuilderCallback? get semanticsBuilder => null;
}
