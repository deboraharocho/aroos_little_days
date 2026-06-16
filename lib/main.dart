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
              fit: BoxFit.cover,
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

                const SizedBox(height: 80),
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
  final PageController _pageController = PageController(initialPage: 2);

  final int currentEpisode = 3;
  int selectedEpisode = 2;

  final List<String> episodes = [
    "Beach Drive",
    "Pool Day",
    "Ice Cream Walk",
    "Summer Picnic",
    "Boardwalk Night",
  ];

  void goLeft() {
    if (selectedEpisode > 0) {
      selectedEpisode--;

      _pageController.animateToPage(
        selectedEpisode,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {});
    }
  }

  void goRight() {
    if (selectedEpisode < currentEpisode - 1) {
      selectedEpisode++;

      _pageController.animateToPage(
        selectedEpisode,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4DF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFF4DF),
        elevation: 0,
        title: const Text(
          "home",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),

          const Text(
            "choose your little day",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: goLeft,
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: currentEpisode,
                    onPageChanged: (index) {
                      setState(() {
                        selectedEpisode = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final bool isCompleted = index < currentEpisode - 1;
                      final bool isCurrent = index == currentEpisode - 1;

                      return EpisodeCard(
                        title: episodes[index],
                        episodeNumber: index + 1,
                        isCompleted: isCompleted,
                        isCurrent: isCurrent,
                      );
                    },
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: goRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class EpisodeCard extends StatelessWidget {
  final String title;
  final int episodeNumber;
  final bool isCompleted;
  final bool isCurrent;

  const EpisodeCard({
    super.key,
    required this.title,
    required this.episodeNumber,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isCompleted ? 0.45 : 1,
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isCompleted
              ? const Color(0xFFE0D6C6)
              : const Color(0xFFFFDFA3),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isCurrent ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ep $episodeNumber",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isCompleted ? "completed" : "continue",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}