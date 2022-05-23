class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
     this.title,
     this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: '\n Your presence \n is garanteed',
    image: 'assets/images/presence.jpg',
  ),
  OnBoarding(
    title: '\n You can scan \n images',
    image: 'assets/images/scan i .png',
  ),
  OnBoarding(
    title: '\n You can scan \n qr codes',
    image: 'assets/images/scan qr.png',
  ),
  OnBoarding(
    title: '\n You can scan \n texts',
    image: 'assets/images/scan-text.png',
  ),
];