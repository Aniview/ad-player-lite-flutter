import 'package:ad_player_lite/ad_player_controller.dart';
import 'package:ad_player_lite/ad_player_event.dart';
import 'package:ad_player_lite/ad_player_view.dart';
import 'package:ad_player_lite_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ad_player_lite/ad_player.dart';
import 'package:ad_player_lite/adplayerinterstitial_controller_config.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: buildContent(context)));
  }

  Widget buildContent(BuildContext context) {
    final snapshot = useFuture(
      useMemoized(() {
        return adPlayer.getTag(pubId: pubId, tagId: tagId).then((e) => e.newInReadController());
      }),
    );

    final controller = snapshot.data;
    if (controller == null) {
      return Center(child: CircularProgressIndicator());
    }

    useEffect(() => controller.dispose, [controller]);

    return Column(
      children: [
        Expanded(child: AdPlayerView(controller: controller)),
    
          buildControls(context, controller),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
            onPressed: () async {
            final config = InterstitialConfig(
            noAdTimeout: 5.0,
            stalledVideoTimeout: 10.0,
            showCloseButtonAfterAdDuration: true,
          );

          // Interstitial controller with config
          adPlayer.showInterstitial(
            pubId: pubId,
            tagId: tagId,
            config: config,
          );
        },
        child: const Text("Show Ad"),
      ),
    ),

      Expanded(child: buildPanel(context, controller)),
        ],
      );
    }

  Widget buildControls(BuildContext context, AdPlayerInReadController controller) {
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

  Widget buildPanel(BuildContext context, AdPlayerInReadController controller) {
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
}
