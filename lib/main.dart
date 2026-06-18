import 'package:flutter/material.dart';

void main() {
  runApp(const AroosLittleDays());
}

class AroosLittleDays extends StatelessWidget {
  const AroosLittleDays({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aroo's Little Days",
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/loading_screen.png',
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDDF4EE),
                    foregroundColor: const Color(0xFF5B7C8A),
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0xFFC6E6DD),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "tap to start",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.72);

  final int currentEpisode = 1;
  int selectedEpisode = 0;

  final List<Map<String, String>> episodes = [
    {
      "title": "Pool Days",
      "image": "assets/images/episode1_pool_color.png",
    },
    {
      "title": "Beach Drive",
      "image": "assets/images/episode1_pool_color.png",
    },
    {
      "title": "Ice Cream Walk",
      "image": "assets/images/episode1_pool_color.png",
    },
  ];

  void startEpisode() {
    if (selectedEpisode == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EpisodeOneScreen(),
        ),
      );
    }
  }

  void goLeft() {
    if (selectedEpisode > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goRight() {
    if (selectedEpisode < currentEpisode - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF7DBEAE), size: 32),
            onPressed: () {},
          ),
          const SizedBox(width: 18),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 40),

          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: currentEpisode,
                  onPageChanged: (index) {
                    setState(() {
                      selectedEpisode = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedEpisode == index;

                    return AnimatedScale(
                      scale: isSelected ? 1.0 : 0.88,
                      duration: const Duration(milliseconds: 250),
                      child: EpisodeCard(
                        episodeNumber: index + 1,
                        title: episodes[index]["title"]!,
                        imagePath: episodes[index]["image"]!,
                        onPlay: startEpisode,
                      ),
                    );
                  },
                ),

                Positioned(
                  left: 18,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: goLeft,
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF7DBEAE),
                        size: 34,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 18,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: goRight,
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF7DBEAE),
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(currentEpisode, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedEpisode == index
                      ? const Color(0xFF7DBEAE)
                      : Colors.grey.shade300,
                ),
              );
            }),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final int episodeNumber;
  final String title;
  final String imagePath;
  final VoidCallback onPlay;

  const EpisodeCard({
    super.key,
    required this.episodeNumber,
    required this.title,
    required this.imagePath,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPlay,
          child: Container(
            width: 330,
            height: 330,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 22,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    imagePath,
                    width: 330,
                    height: 330,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.90),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFF7DBEAE),
                    size: 58,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),

        Text(
          "Episode $episodeNumber",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7DBEAE),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF7DBEAE),
          ),
        ),
      ],
    );
  }
}

class EpisodeOneScreen extends StatefulWidget {
  const EpisodeOneScreen({super.key});

  @override
  State<EpisodeOneScreen> createState() => _EpisodeOneScreenState();
}

class _EpisodeOneScreenState extends State<EpisodeOneScreen> {
  final List<Offset> hearts = [
    const Offset(260, 470),
    const Offset(455, 850),
    const Offset(570, 695),
    const Offset(835, 690),
    const Offset(670, 1185),
    const Offset(555, 1470),
    const Offset(1035, 1415),
    const Offset(135, 1615),
    const Offset(665, 1745),
    const Offset(555, 1888),
  ];

  final Set<int> foundHearts = {};

  void findHeart(int index) {
    if (!foundHearts.contains(index)) {
      setState(() {
        foundHearts.add(index);
      });

      if (foundHearts.length == hearts.length) {
        Future.delayed(const Duration(milliseconds: 400), () {
          showCompletionPopup();
        });
      }
    }
  }

  void showCompletionPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("You found all the hearts!"),
          content: const Text("Wallpaper unlocked 🎉"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("return home"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("next episode"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double imageWidth = 1080;
    const double imageHeight = 1920;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Episode 1",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: imageWidth / imageHeight,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double scaleX = constraints.maxWidth / imageWidth;
                    final double scaleY = constraints.maxHeight / imageHeight;

                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            foundHearts.length == hearts.length
                                ? 'assets/images/episode1_pool_color.png'
                                : 'assets/images/episode1_pool_gray.png',
                            fit: BoxFit.fill,
                          ),
                        ),

                        ClipPath(
                          clipper: SplashClipper(
                            hearts: foundHearts.map((index) {
                              return Offset(
                                hearts[index].dx * scaleX,
                                hearts[index].dy * scaleY,
                              );
                            }).toList(),
                          ),
                          child: SizedBox.expand(
                            child: Opacity(
                              opacity: 0.85,
                              child: Image.asset(
                                'assets/images/episode1_pool_color.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),

                        for (int i = 0; i < hearts.length; i++)
                          if (!foundHearts.contains(i))
                            Positioned(
                              left: hearts[i].dx * scaleX - 65,
                              top: hearts[i].dy * scaleY - 65,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => findHeart(i),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(10, (index) {
                  final bool found = foundHearts.contains(index);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: found
                          ? const SizedBox(
                              key: ValueKey("empty"),
                              width: 24,
                              height: 30,
                            )
                          : const Text(
                              "♡",
                              key: ValueKey("heart"),
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF5B7C8A),
                              ),
                            ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashClipper extends CustomClipper<Path> {
  final List<Offset> hearts;

  SplashClipper({required this.hearts});

  @override
  Path getClip(Size size) {
    final path = Path();

    for (final heart in hearts) {
      path.addOval(Rect.fromCircle(center: heart, radius: 28));

path.addOval(
  Rect.fromCircle(
    center: heart + const Offset(-18, -10),
    radius: 16,
  ),
);

path.addOval(
  Rect.fromCircle(
    center: heart + const Offset(16, -12),
    radius: 14,
  ),
);

path.addOval(
  Rect.fromCircle(
    center: heart + const Offset(-14, 16),
    radius: 12,
  ),
);

path.addOval(
  Rect.fromCircle(
    center: heart + const Offset(18, 12),
    radius: 14,
  ),
);
    }

    return path;
  }

  @override
  bool shouldReclip(SplashClipper oldClipper) => true;
}
