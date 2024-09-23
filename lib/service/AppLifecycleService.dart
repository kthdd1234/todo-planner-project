class AppLifecycleReactor {
  // final AppOpenAdManager appOpenAdManager;

  // AppLifecycleReactor({required this.appOpenAdManager});

  // void listenToAppStateChanges() {
  //   AppStateEventNotifier.startListening();
  //   AppStateEventNotifier.appStateStream.forEach((state) {
  //     _onAppStateChangedAd(state);
  //     // _onAppStateChangedPassword(state);
  //   });
  // }

  // void _onAppStateChangedAd(AppState appState) async {
  //   bool isPurchase = await isPurchasePremium();

  //   if (appState == AppState.foreground && isPurchase == false) {
  //     appOpenAdManager.showAdIfAvailable();
  //   }
  // }

  // void _onAppStateChangedPassword(AppState appState) async {
  //   String? passwords = userRepository.user.screenLockPasswords;

  //   try {
  //     if (passwords != null) {
  //       if (appState == AppState.foreground) {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => EnterScreenLockPage(),
  //             fullscreenDialog: true,
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     log('e => $e');
  //   }
  // }
}
