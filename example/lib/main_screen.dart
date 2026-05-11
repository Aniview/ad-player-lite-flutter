import 'package:ad_player_lite/ad_player_controller.dart';
import 'package:ad_player_lite/ad_player_event.dart';
import 'package:ad_player_lite/ad_player_tag.dart';
import 'package:ad_player_lite/ad_player_view.dart';
import 'package:ad_player_lite_example/main.dart';
import 'package:ad_player_lite_example/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum MainScreenTab { logs, actions }

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: buildContent(context)));
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget buildContent(BuildContext context) {
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

    useEffect(() => controller.dispose, [controller]);

    return Column(
      children: [
        Expanded(child: AdPlayerView(controller: controller)),
        _buildControls(context, controller),
        Expanded(child: _buildTabsPanel(context, tag, controller)),
      ],
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildControls(BuildContext context, AdPlayerInReadController controller) {
    final state = useStream(controller.state);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Color(0x80808080),
      child: Row(
        children: [
          IconButton.outlined(onPressed: controller.resume, icon: Icon(Icons.play_arrow)),
          IconButton.outlined(onPressed: controller.pause, icon: Icon(Icons.pause)),
          const SizedBox(width: 16),
          Text("${state.data?.name}", style: TextStyle(fontSize: 24)),
          const Spacer(),
          IconButton.outlined(onPressed: controller.toggleFullscreen, icon: Icon(Icons.fullscreen)),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildTabsPanel(BuildContext context, AdPlayerTag tag, AdPlayerInReadController controller) {
    return DefaultTabController(
      length: MainScreenTab.values.length,
      child: Column(
        children: [
          TabBar(tabs: MainScreenTab.values.map((e) => Tab(text: e.name)).toList()),
          Expanded(
            child: TabBarView(
              children: MainScreenTab.values.map((e) {
                return switch (e) {
                  MainScreenTab.logs => _buildLogsPanel(context, controller),
                  MainScreenTab.actions => _buildActionsPanel(context, tag, controller),
                };
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildLogsPanel(BuildContext context, AdPlayerInReadController controller) {
    final events = useState(<AdPlayerEvent>[]);

    useEffect(() {
      final subscription = controller.events.listen((event) {
        if (event is MarkerNotLogFriendly) {
          return;
        }
        events.value = [event, ...events.value];
      });
      return subscription.cancel;
    }, [controller]);

    return ListView.builder(
      itemCount: events.value.length,
      itemBuilder: (context, index) {
        final event = events.value[index];
        return Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Text("$event"));
      },
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildActionsPanel(BuildContext context, AdPlayerTag tag, AdPlayerInReadController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final config = AdPlayerInterstitialConfig(
                dismissOnBack: true,
                showCloseButtonAfterAdDuration: true,
                noAdTimeout: Duration(seconds: 5),
                stalledVideoTimeout: Duration(seconds: 10),
                onDismissListener: (e) => e.dispose(),
              );
              final controller = await tag.newInterstitialController(config: config);
              controller.launchInterstitial();
            },
            child: const Text("Show interstitial ads"),
          ),
        ],
      ),
    );
  }
}
