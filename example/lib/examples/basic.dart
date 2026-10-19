import 'package:ad_player_lite/ad_player_controller.dart';
import 'package:ad_player_lite/ad_player_event.dart';
import 'package:ad_player_lite/ad_player_tag.dart';
import 'package:ad_player_lite/ad_player_view.dart';
import 'package:ad_player_lite_example/ad_config.dart';
import 'package:ad_player_lite_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum BasicExampleTab { logs, actions }

class BasicExampleScreen extends HookWidget {
  const BasicExampleScreen({super.key});

  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final selectedConfig = useState(AdConfigs.video);

    return Scaffold(
      appBar: AppBar(title: Text("Basic example")),
      body: SafeArea(
        child: Column(
          children: [
            _buildConfigSelector(context, selectedConfig),
            Expanded(
              child: _AdContent(key: ValueKey(selectedConfig.value.label), config: selectedConfig.value),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildConfigSelector(BuildContext context, ValueNotifier<AdConfig> selectedConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<AdConfig>(
        isExpanded: true,
        value: selectedConfig.value,
        items: AdConfigs.all.map((config) {
          return DropdownMenuItem(value: config, child: Text(config.label));
        }).toList(),
        onChanged: (config) {
          if (config != null) {
            selectedConfig.value = config;
          }
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
// Everything below renders a single ad profile. It's a separate HookWidget,
// keyed by the selected config in the parent, so each profile switch gets a
// brand new element and clean hook state instead of reusing stale futures.
class _AdContent extends HookWidget {
  final AdConfig config;

  const _AdContent({required super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final tagFuture = useMemoized(() => adPlayer.getTag(pubId: config.pubId, tagId: config.tagId));
    final tag = useFuture(tagFuture).data;

    if (tag == null) {
      return Center(child: CircularProgressIndicator());
    }

    final controllerFuture = useMemoized(() => tag.newInReadController(), [tag]);
    final controller = useFuture(controllerFuture).data;

    if (controller == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Release the native player when this widget leaves the tree.
    useEffect(() => controller.dispose, [controller]);

    return Column(
      children: [
        _buildPlayerFrame(controller),
        _buildControls(context, controller),
        Expanded(child: _buildTabsPanel(context, tag, controller)),
      ],
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  // Video fills the available space (and can go fullscreen); display ads keep
  // their own fixed frame instead of being stretched to fit.
  Widget _buildPlayerFrame(AdPlayerInReadController controller) {
    if (config.type == AdType.display) {
      return SizedBox(width: 300, height: 250, child: AdPlayerView(controller: controller));
    }
    return Expanded(child: AdPlayerView(controller: controller));
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
      length: BasicExampleTab.values.length,
      child: Column(
        children: [
          TabBar(tabs: BasicExampleTab.values.map((e) => Tab(text: e.name)).toList()),
          Expanded(
            child: TabBarView(
              children: BasicExampleTab.values.map((e) {
                return switch (e) {
                  BasicExampleTab.logs => _buildLogsPanel(context, controller),
                  BasicExampleTab.actions => _buildActionsPanel(context, tag, controller),
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
