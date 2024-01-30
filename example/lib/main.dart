import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GifView Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> gifList = [
    'assets/gif1.gif',
    'https://www.showmetech.com.br/wp-content/uploads/2015/09/happy-minion-gif.gif',
    'https://gifs.eco.br/wp-content/uploads/2021/08/engracados-memes-gif-19.gif'
  ];

  late List<GifController> gifControllerList;

  @override
  void initState() {
    gifControllerList = List.generate(
      gifList.length,
      (index) => GifController(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildList(),
      // body: ListView(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(
      //         'Gif load from asset',
      //         style: Theme.of(context).textTheme.headlineSmall,
      //       ),
      //     ),
      //     const Divider(),
      //     GifView.asset(
      //       'assets/gif1.gif',
      //       height: 200,
      //       frameRate: 30,
      //     ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(
      //     'Gif load from network',
      //     style: Theme.of(context).textTheme.headlineSmall,
      //   ),
      // ),
      //     const Divider(),
      //     GifView.network(
      //       'https://www.showmetech.com.br/wp-content/uploads/2015/09/happy-minion-gif.gif',
      //       height: 200,
      //       onError: (error) {
      //         return const Center(
      //           child: Text("onError"),
      //         );
      //       },
      //     ),
      //     GifView.network(
      //       'https://gifs.eco.br/wp-content/uploads/2022/05/gifs-de-homem-aranha-no-aranhaverso-20.gif',
      //       height: 200,
      //       progress: const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     ),
      //     GifView.network(
      //       'https://gifs.eco.br/wp-content/uploads/2021/08/engracados-memes-gif-19.gif',
      //       height: 200,
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: gifList.length,
      itemBuilder: (context, index) {
        String gif = gifList[index];
        GifController controller = gifControllerList[index];
        return InkWell(
          onTap: () {
            if (controller.isPaused) {
              controller.play();
            } else if (controller.isPlaying) {
              controller.pause();
            }
          },
          child: _buildGif(gif, controller),
        );
      },
    );
  }

  Widget _buildGif(String gif, GifController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                gif.contains('http')
                    ? 'Gif load from network'
                    : 'Gif load from asset',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (gif.contains('http'))
              GifView.network(
                gif,
                controller: controller,
                height: 200,
                onError: (error) {
                  return const Center(
                    child: Text("onError"),
                  );
                },
                progress: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              GifView.asset(
                gif,
                controller: controller,
                height: 200,
                frameRate: 30,
              )
          ],
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final controller = GifController();
  MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GifView.network(
        'https://www.showmetech.com.br/wp-content/uploads/2015/09/happy-minion-gif.gif',
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.status == GifStatus.playing) {
            controller.pause();
          } else {
            controller.play();
          }
        },
      ),
    );
  }
}
