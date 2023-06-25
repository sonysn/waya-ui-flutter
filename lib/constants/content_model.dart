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
    title: "Welcome to QuNot!",
    image: 'assets/images/onboard1.jpg',
    description:  "Commute made easier! QuNot connects you with drivers heading in the same direction, making your daily journey convenient and cost-effective. Experience hassle-free commuting today!"),
  OnboardingContent(
    title: "Effortless Rides to Your Destination",
    image: 'assets/images/image1.jpg',
    description: "Book a ride effortlessly and get matched with drivers traveling in your direction. Save time and money on your daily commute. Enjoy a comfortable and reliable ride to your workplace with QuNot."),
  OnboardingContent(
    title: "Seamless and Secure Experience",
    image: 'assets/images/img.png',
    description: "Experience a seamless ride booking process with QuNot. Our platform ensures secure transactions and provides real-time tracking of your trip. Sit back, relax, and reach your destination conveniently."),
];
