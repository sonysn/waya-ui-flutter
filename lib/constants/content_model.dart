class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Qunot',
    image: 'assets/images/onboard1.jpg',
    description: "Welcome to Waya, the smart transportation app that simplifies your travel experience. With Waya, you can enjoy convenient and reliable rides at your fingertips, making commuting a breeze.",
  ),
  OnboardingContent(
    title: 'What we do',
    image: 'assets/images/image1.jpg',
    description: "Discover the world of Waya, where we connect you to a wide range of transportation options. From taxis and rideshares to bikes and scooters, we have it all. Say goodbye to waiting and hello to efficient journeys with Waya.",
  ),
  OnboardingContent(
    title: 'How we work',
    image: 'assets/images/img.png',
    description: "Experience the innovative approach of Waya. Our advanced technology seamlessly matches you with nearby drivers, ensuring quick and hassle-free rides. Join the Waya community and revolutionize the way you move around.",
  ),
];
