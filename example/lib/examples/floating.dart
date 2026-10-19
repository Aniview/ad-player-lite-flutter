import 'package:ad_player_lite/ad_player_view.dart';
import 'package:ad_player_lite_example/main.dart';
import 'package:ad_player_lite_example/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FloatingExampleScreen extends HookWidget {
  static const sideItemsCount = 10;

  const FloatingExampleScreen({super.key});

  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Floating example")),
      body: SafeArea(child: _buildContent(context)),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    final tagFuture = useMemoized(() => adPlayer.getTag(pubId: Tag.ford.pubId, tagId: Tag.ford.tagId));
    final tag = useFuture(tagFuture).data;

    if (tag == null) {
      return Center(child: CircularProgressIndicator());
    }

    final controllerFuture = useMemoized(() => tag.newInReadController());
    final controller = useFuture(controllerFuture).data;

    if (controller == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Release the native player when this widget leaves the tree.
    useEffect(() => controller.dispose, [controller]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final sideItemHeight = constraints.maxHeight / sideItemsCount * 1.2;
        return ListView.builder(
          itemCount: sideItemsCount * 2 + 1,
          itemBuilder: (context, index) {
            if (index < sideItemsCount) {
              return _buildSideItem(context, id: sideItemsCount - index, height: sideItemHeight);
            }
            if (index > sideItemsCount) {
              return _buildSideItem(context, id: index - sideItemsCount, height: sideItemHeight);
            }
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: AdPlayerView(controller: controller),
            );
          },
        );
      },
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildSideItem(BuildContext context, {required int id, required double height}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height,
      color: (id % 2 == 0) ? const Color(0x40808080) : null,
      child: Text("Item $id"),
    );
  }
}
