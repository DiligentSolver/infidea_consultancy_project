import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infidea_consultancy_app/screens/profile_details_screen.dart';

import '../core/constants/App_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/self_scrolable_bordered_carousel.dart';
import '../core/widgets/self_scrollable_carousel.dart';
import '../core/widgets/job_card.dart';

import '../core/widgets/search_bar.dart';
import '../core/widgets/success_stories_carousel.dart';
import 'application_screen.dart';
import 'interview_tips_screen.dart';
import 'job_screen.dart';


// Main Home Screen with Navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default index
  String userLocation = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }


  Future<void> _getUserLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          userLocation = "Location services disabled";
        });
        return;
      }

      // Check and request permissions if needed
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            userLocation = "Location permission denied";
          });
          return;
        }
      }

      // Set a temporary "loading" state
      setState(() {
        userLocation = "Getting your location...";
      });

      // Get precise position with a reasonable timeout
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10)
      );

      // Try to get detailed address
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        ).timeout(Duration(seconds: 5));

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          // Build the most precise location string possible
          String locationText = "";

          // Try to get neighborhood/locality first for precision
          if (place.subLocality?.isNotEmpty == true) {
            locationText = place.subLocality!;
          } else if (place.locality?.isNotEmpty == true) {
            locationText = place.locality!;
          }

          // Add the city/administrative area if we have it
          if (place.administrativeArea?.isNotEmpty == true) {
            locationText = locationText.isEmpty
                ? place.administrativeArea!
                : "$locationText, ${place.administrativeArea}";
          }

          // If we still don't have anything, use a simple fallback
          if (locationText.isEmpty) {
            locationText = [
              place.street,
              place.postalCode,
              place.country,
            ].where((e) => e?.isNotEmpty == true).join(", ");
          }

          setState(() {
            userLocation = locationText.isNotEmpty
                ? locationText
                : "Location found";
          });
        } else {
          // Fallback to coordinate-based location if geocoding returns empty
          setState(() {
            userLocation = "Near ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
          });
        }
      } catch (geocodeError) {
        // If geocoding fails, use the coordinates directly
        setState(() {
          userLocation = "Near ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
        });
        print("Geocoding error: $geocodeError");
      }
    } catch (e) {
      // Handle any errors in the location process
      setState(() {
        userLocation = "Nearby";
      });
      print("Location error: $e");
    }
  }

  List<Widget> get _screens => [
    HomeContentScreen(userLocation: userLocation),
    const JobsScreen(),
    MyApplicationsScreen(),
    InterviewTipsScreen(),
    ProfileDetailsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Applications'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Interview'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
// Main Home Screen
class HomeContentScreen extends StatelessWidget {
  final String userLocation;
  const HomeContentScreen({
    super.key,
    this.userLocation = "Unknown location"
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/app-logo/infidea_logo.png',
              height: 40,
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  userLocation,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.notification_add, color: AppColors.primary),
              onPressed: () {
                Navigator.of(context).pushNamed('/notifications');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            const SearchBarWidget(),

            const SelfScrollableBorderCarousel(
              imageUrls: [
                'https://media-hosting.imagekit.io//355556005a1241d1/screenshot_1740122814324.png?Expires=1834730815&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Cxb5pVN~7jwwCqkT~QzPno4vxnwDlL6-4sRPB1DyXdFGV8csB-xMiezo7PqjBsJDsJVodV~0zJHHTrUqR9TgCoFsaHlHlFZr498lLAnd1yf1WNQ1fYh6zzsFubshC~Q9ZEtW07rNdsMUS5SXRdmZIqJaOJ7Kp-5o~yDCdKwvSPwfAtARRV7fDOUKgQS7erUAJybMDcEht5Jq8qa2zPQLibd46qHPYJaZ~BebrvQT9PKbXPfRaW3BS2LAC0n-Qsnd6mOG6g4hvyUcSmRflKPmLeRIoD29-yhYCNCRPU5KO24uChkZ6UPXbTshwnPQn8FPaZK7Big5eFqTYGvPIU0dGQ__',
                'https://media-hosting.imagekit.io//e184111c29cd45fc/screenshot_1740122898719.png?Expires=1834730900&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Sx44LzrTOcD1kkIj1mLGJlhUMkq1RnXTSnz5w8~LeJZPu4qAPPNzjM2zmRp81xj8zbYWpG0Roq9XppKAbJm28yKH5Z6Pb067JIy53Y53~gvlMtcbZoryPaDls4heeAlkhLph2qizp0cKiQrN30OTot1HvAc~IHYYiOMcrT8KSZfGmhbtds5cGCOWTvZE65slT-E4Z4kbmIQ3NWLRRdre8bz4mrla0ZyxJ3oOTXGHz8~l0cSOXrJwrEw4ZOTXpWPA2fIXradZONKoscpQwDynvx6NCaBprdKtdKZXkWv3~GWPi-KDlpitXGndITjQm~EKfI1m1zakNzbSUn0yudodqA__',
                'https://media-hosting.imagekit.io//3c30bc5366194001/screenshot_1740122934058.png?Expires=1834730935&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=XBg0Is-2tb~puuDdvnd567eSg5YjCNSp6k8Bx2yt4LyseWfgoHVLEtqfdb1fzLVzS1rYeeQMFf2l5opdau8CvlHEz6078BDTDEVTuigU~JhAg56n1rvjs3XQ1UwR3qqAiFNjsklFlg5kSxN91tAVE~UAvN-VklmH73DeWEMQrp0Qz91Z4EEkyyZHT6WKAYN6henna0D8-Bv3Aa2iQmgwM94y8FLeYP5M2F5plqCCq5S6rDAjwriOcbJPLDCFKPpwywCAaPvwDOufcVAG4WK0UBKW096sA0xDkPj9HVfsvdBD7dPEQq5z1GELZrMlvPtMz3R5rFP4GheBNA0CHaDjSw__',

              ],

            ),

            // Featured Jobs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'Featured Jobs',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,)

              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              padding: const EdgeInsets.only(left: 16),  // Add left padding only
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85, // Make card width relative to screen
                    child: JobCard(
                      companyLogo: 'https://media-hosting.imagekit.io//c77f6c0e75f340fb/screenshot_1739772857756.png?Expires=1834380862&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=svZ1Wk81s~imruwa1QYxp0XYm6GwaZgS3U69xwtANWvv-Mus3lFX-UGD36jqyp61lQbehsoIoZlXQawKaKcxDitwO7yNlW34FDB2pK2ddcI5T36Jm15yAjIBr4KVi9-0IhqdT0YSBmvByB0GHCcGH8qnx8aGfQEqEI0Xv7RO9xfB64x2Q4bC~0FMlW7zqTplCrTkNTDUySRZmnwU1Z8rZecO4cOLUVev4AsBONYfRm1OhBWx4rpTp2pqNvNXKzs4PeG6onbfuKcHhhwoSeEONN8W3aje2uREzEjjmLOrXMkKi-vM06-1~nJ5pSreWzOLKD5B5FSPpNRXoC4wBOF4qQ__',
                      title: 'International Customer Care Executive',
                      company: 'Teleperformance',
                      location: 'Scheme 78, Indore',
                      salary: 'INR25,000 - INR35,000 Monthly',
                      workLocationType: 'Work from Office',
                      employmentType: 'Full Time',
                      experienceLevel: 'Fresher & Experienced Both Can Apply',
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
/*
            // Issue Report Banner
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(16),
              color: Colors.red.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 24), // Icon added here
                  const SizedBox(width: 8), // Space between icon and text
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        children: [
                          TextSpan(text: 'Faced an issue? report '),
                          TextSpan(
                            text: 'here',
                            style: TextStyle(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
*/

            // Success Stories
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'Success Stories',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,)

              ),
            ),

            const SelfScrollableCarousel(
              imageUrls: [
                'https://media-hosting.imagekit.io//3d4ad63b44d344c1/screenshot_1739774261223.png?Expires=1834382263&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=cbgYwiyTWIDLx3lYFOtA~Q5CMsaTYAeN-wduDmFPacrYNpQW4IcM4mWKLjo4riLd214ngVG3XRFu70sTp2c7K~B2jdyshfmirWuwpToytQPUbzSFGv7uSjSZMylTSOVamrwRVvnwC3L9UZh2X22~LkNlrwInFqIjyb~Yhu~z5vkX7bGtWOTZlFriDMYZVYhN4Y6DWvpZcfxHAIm-J~xr1V9HvpFnQ4nUMXzMaqu7ldIXRzmrYxR7Xk2qqJhi7ewO22XXiGmVM8w-71b2odEzOe65HA66QObZQqC528ZSIivgN4upgP4KgnmQCxII2EdDF-YjAhECmfFxZZHOWd5Djw__',
                'https://media-hosting.imagekit.io//732602b38d41440a/screenshot_1739774204028.png?Expires=1834382206&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=EsL25j-T~SghKwCV48LyRWLPd86gub2v7Nj3nobs7GIAd2-MTwWTGk6q4NW7U0rtgPnF692qyl67awu6czKyzZcriGGxOXBIOkWlNOeFnMuw~-wnWWkJcsSJW7-DXWo4iOhcZhDeTf62b4a-sSUtmZB9Hd1fS099ZjqXnL7aOip0mn3rlw8kcc5PsG4cu7N71cvya0FHxE8hvGlvvnptraUBrOzyEMclAM3YwPpYwTZClUAFeGE9nvbpZiN2WXQ5bBTAp7ncza-lUKYUAuHcLxMKBefrIGzaDj-xmsQERpCFjlz5lwnNhHCtCACPXrnaM9-8ZLwGHECKHXQvE64HJA__',
                'https://media-hosting.imagekit.io//a8f29a5a3943444d/screenshot_1739774125027.png?Expires=1834382130&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=U7h1tbPUNChTI6H7J1VJkCMVvt3B0nTN6MtH4uJdt94wqAB-PgkIpVKpbLZmPVNchEMG7-SGVYPBoB7k82ADH2NaXb6-nIGdR16o7MO0wVV5QLM1Okm2eb5gnUJeQqKOxzFVP3pQ9RwV0OHZrq4PRcwaes0PbMhFFMSFMws5LOngF1~Pscw-qFvO-Vz1qtrMRc7g6wzCW9rqFDJgg6HVk~kSBYXYg3FnHfRlT-9fl8l~Gu5pR05PbhTXr9OQF0hSeS6tIjYZV1Mbpx3RWJ882RXaPDieH9NHsw-Bmn7bXXcybQ0Y5H~HuI0a4694dy5aAanV4ArmtsuxWtM9vovngg__',
                'https://media-hosting.imagekit.io//45162eefb31040c7/screenshot_1739774058786.png?Expires=1834382060&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=aS9eVMrC11maKDM--FWApmt~tOr5Tb~1Pg37c~l5iYwMumJ8Hh44y~GFngl-ADcMsdCkoNb~QZLmR6gFo8Oe5NUDT2A-TJ7nR0GxkfcgYLi~yFrpLJB0An6c8552-gEOmG-r6TjmLETHmaKD3kCq7wZP0W4ky4~IGAa5eH7SornkcJlfe0leJ3~dYeMNj6lPLlFMF0MvDZtSdTSFG-oEhCIn6Tl58fvtodkZnOJJzGDBghaa0CsOzjHw7hCB0Z7DzEtv~VX6zjkU4CCuixeFZ7MDW3IKZLxfniJadjhzuMUiauO2eBdwOmWax211oYrfzfYpEfs-v2kpweK7sjoVgw__',
              ],
              scrollSpeed: 1.0,
            ),

            Container(
              margin: EdgeInsets.all(16), // Adjust margin as needed
              width: double.infinity,
              height: 150, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage('https://media-hosting.imagekit.io//67f0d5b0e83b4b1d/screenshot_1740125396896.png?Expires=1834733398&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=F2wpeMYX8VH-HV3QsEWhctHzv7HQzJxiWs68GLlHjvDNE366WwAj5XjJeOwsJC00Dka9KBDrIM4zFUrk38pJBWeTEwPvAyiJGsIMkZKR3ddB6VFx0s22cHL8mloTc279xmGpj2lnt8NiRGqG~4uP9Ogb-qS~0hW3bhHxqlHaQSoAu3Z5ICYjZs1n-iVxPgERr0CiZfbti73qI9gUWlCeja9JrrL-TFpqQdBIJCmQHs83EnBAQbwHjkMtsVBsx3~bTNwNdzdzoVGklDcbrUTTFrB036sqlkC9mEUejdHiaGcWUpYRDh-lhrbXSHPbaNUBa20jbNE22GjOe2lk5lVvdA__'),
                  fit: BoxFit.fill,
                ),
              ),
            ),


            const SizedBox(height: 10),

            // Jobs Nearby
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'Jobs Nearby',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                  )
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                  child: JobCard(
                    companyLogo: 'https://media-hosting.imagekit.io//4b0a9efa199e49c8/screenshot_1739772923905.png?Expires=1834380926&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=ZoeV-5C~02QC9CIEZ7kahGnPMLNJCvyADcI-e~GY-6ae9N-82BN2VTfgW6PQNLtyRvMh8sk7P-0xWdd1GxwnAUqnxirmhert-3onbCNiDmyU6qLUQX5zN68mCzmQ1Ub~sZbKGjEMbjXNx9qVYXc2m2Nu1oSkdRXxBXaxvAzU~mTSriUPJiX1aIckySZIXtNVFmlQWaaE4kNRF7zlKfQFc~xfwqM-udv3NCE5-9xxsYz6JGQ-0rG5gm-OpS3q00k1VSxDEDUNJMZpQxdH4hqW4w8RqZA~TaobaRaM1vCGp3YBben3g-CCOrOAPETasjNJkCS6dH9q7tpAW23WAWuu1A__',
                    title: 'Customer Relationship Manager (CRM)',
                    company: ' ICICI Lombard',
                    location: 'Brilliant Convention Center, Indore',
                    workLocationType: 'Work from Office',
                    employmentType: 'Full Time',
                    experienceLevel: 'Any experience',
                    salary: 'INR 14,500 - INR 21,000 CTC',
                  ));
                },
              ),
            ),

            // Our Clients
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'Our Clients',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,)

              ),
            ),

            const SelfScrollableCarousel(
              imageUrls: [
                'https://media-hosting.imagekit.io//9d42cd346e354dc1/screenshot_1740126158685.png?Expires=1834734160&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=oz6DOAumYc1gSt2GRYHBk9IwEqHWBAGr~BKNt8BBvCtvWM8sMEYce046P4UwsTfEE~eqSxL~Uy1KHD~SQrd-7cWsm0e~19KWL1dvJlTvydqkd1nkwq5pUffJ8qk92OBrk2mv1t~xvOQ2zRg61dOh-ni2pKXnGRNODsd-5NjIjCHIAPKv0jLnF-BauDWLjnTzTWocpmijyPZLfxUsG-TbsQdEZAncwd3TlczICf3mxHI0uQ0W50xBZgFzuG48v1TqjssywmgWEZ-Jyl2Y-IdlJRI43~wa4UlPZv93Oqaaq7j4j480HdRPKyrR491CFw0tqxaDx2tQJSLYNluOmEA-tw__',
                'https://media-hosting.imagekit.io//27bcb86567324eb0/screenshot_1740126215257.png?Expires=1834734216&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Fa-gEWeFnMhmJFSdCORGdmVRUc-pm3ZGd7PBsnm4gCEL8dmHf1jSVXaLQ-JMxs-DLB5Pt-jPZEUNjHuSIB7wgQmF~oKlSmEP~WKQxhse5KLxF~tlmxsbgJ6Sump0KCeROE1TfKrUuHwZFu3AkhYtRSKlZ9bj4wn4Vvq0VjxbUX9p2fvJb2PQxMoV-ZDTV0opVRnjJeKnzDUGXDsK3Hky-RkFa0nZZTxR92hDgThenx2H~xKDT-rHANS1x3sDQnQuQnrSwcYqOCl73I4lKitysa5e9GY6ML1HcOKwH1uRc0uqPdjIyhmeCD-kRyeGMwt2ltH58KAqXQ7PcNcf0-kkKg__',
                'https://media-hosting.imagekit.io//811463cabf8f40a8/screenshot_1740126266484.png?Expires=1834734268&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=TtjCVS4Y-JhkB2-nat~9vloViAsLzNfnD29sy1TaMOh6Ca9-afHV6mBJBVwnhTiCyuOuSmAEtf4PYHydsuPUozTzOtjZqA8yGqcAs1-dV9f06GXFUI66EhkEn8sHf~MFAf4aLHEP7LkTZO8UbBcVwEinRSoZlN-Zy0OlJFC2ClWaHP0rGYQW7Ek9WMk5FReZFAPNq~~jDXozouaoWrBuxSW8X6Xroz7J2GrlMICz4WYSNvxzNIvABLK4GsxVOkpHtoXhb2L1TtIY6k7Uc3NdcDYXIWp9mK7C6OAHklW2rOk5HceRv6-JQwZq9lFfv~I3w9kv1uukaO8R~DLsL3LfJQ__',
                'https://media-hosting.imagekit.io//c77f6c0e75f340fb/screenshot_1739772857756.png?Expires=1834380862&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=svZ1Wk81s~imruwa1QYxp0XYm6GwaZgS3U69xwtANWvv-Mus3lFX-UGD36jqyp61lQbehsoIoZlXQawKaKcxDitwO7yNlW34FDB2pK2ddcI5T36Jm15yAjIBr4KVi9-0IhqdT0YSBmvByB0GHCcGH8qnx8aGfQEqEI0Xv7RO9xfB64x2Q4bC~0FMlW7zqTplCrTkNTDUySRZmnwU1Z8rZecO4cOLUVev4AsBONYfRm1OhBWx4rpTp2pqNvNXKzs4PeG6onbfuKcHhhwoSeEONN8W3aje2uREzEjjmLOrXMkKi-vM06-1~nJ5pSreWzOLKD5B5FSPpNRXoC4wBOF4qQ__',
                'https://media-hosting.imagekit.io//4b0a9efa199e49c8/screenshot_1739772923905.png?Expires=1834380926&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=ZoeV-5C~02QC9CIEZ7kahGnPMLNJCvyADcI-e~GY-6ae9N-82BN2VTfgW6PQNLtyRvMh8sk7P-0xWdd1GxwnAUqnxirmhert-3onbCNiDmyU6qLUQX5zN68mCzmQ1Ub~sZbKGjEMbjXNx9qVYXc2m2Nu1oSkdRXxBXaxvAzU~mTSriUPJiX1aIckySZIXtNVFmlQWaaE4kNRF7zlKfQFc~xfwqM-udv3NCE5-9xxsYz6JGQ-0rG5gm-OpS3q00k1VSxDEDUNJMZpQxdH4hqW4w8RqZA~TaobaRaM1vCGp3YBben3g-CCOrOAPETasjNJkCS6dH9q7tpAW23WAWuu1A__',
              ],
              scrollSpeed: 0.6,
            ),

            const SizedBox(height: 10),

            // What People say about us?
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'What people say about us?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,)

              ),
            ),
            // Success Stories
            const SuccessStoriesCarousel(
              imageUrls: [
                'https://media-hosting.imagekit.io//bbc885e4ac584994/Screenshot%202025-02-14%20143912.png?Expires=1834132225&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=hrSVpmCYXilyTprMeAYVn80fBvOx72HADxsPXu0JjCbLt1KUrXYNGrgAnd9zyNyMspiG100kddKVoRqh6vmDiUwVLP8wAOSqoW1XdllWBHC8vHlmuBCIixYblRnmYwsHDxyFI7F3rv~0gjLE6QnG~Tmff5SMpGjBT0b~4~wbpsYXLrFRDVGrnnQMJ7Qw5HvrFN~NWtTMevgjBs5omSKcP7WMDoayFYh4iuL2RJsRClfHuXCCC4q0KcPMc6pIyLqdWsKqrUDsIJxNeC7mAgrmXpfJlqe6smhqCqhBItpxC~qAkDKZgfAiFyqdJaX6MiYsOfgDiVEimmUQKVA-oQYAQQ__',
                'https://media-hosting.imagekit.io//b33203bbd7984fd7/Screenshot%202025-02-14%20144150.png?Expires=1834132321&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=efMMgnGeidJ7ntwDCxXHDAm7Oh2gfdjh~iWZiI47uALZlVWBpFm7Abc~p3sKbVGogcm7yHgd~3luKmro8AKlx4M6QXBy7GZI68GdyvbMhZ38953cFTme3xYg4xnYzESXvDCjHK1QmC8Mhu-Bjo28LjczKpmhm9hCBTYO6yymq7tYHTTgKcP9TSNCLIAkG9Me5~B2ACBwJ06Fvj-T0d6UNgoY-1PW9E6OUCQNKFY1PteTC~iT-UfxGYLGB1C8UL7ABeUU8osWt4Fs7ozaaQ7frhuAjOsCo9sqUFJ~cuLe9FrDMcyQvU1~e492-BmgALoodDovspUfATJI4iAnHWfRWg__',
                'https://media-hosting.imagekit.io//4eb72ccc166945ad/Screenshot%202025-02-14%20144247.png?Expires=1834132381&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=DXDzql1LF1qn-dF~vj5v65x9pvAbcZUiRMmiVXgk3kKpZucSpx~u3gteyV433GjDbGvepPen-gKeYMGDn5~2bW0pfkp6CXrWHAITEVqv6hno8~dgqk3AVAJKo8DndH6ff05DpiqDGdsJskufZcIQGvB7LS-yahNL6xW7SB77~iijzkO7aij1BpsRfCwybkKALEmC87oGJkdalprfq1QWWM3eTAHjHGJVD0HSuj16gbD0ru7yl46wcWy1xCpWAefpVIDHbHs2sA9pvapoQLGScnk3Zy2vltgBhWt-dZrH~j5akGBm9yBQF-20p3FHnLRwGMJiho5iNjWrqwHhNSF1~A__',
              ],
            ),
          ],
        ),
      ),
      // BottomNavigationBar
    );
  }
}
