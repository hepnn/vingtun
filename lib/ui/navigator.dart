// import 'package:flutter/material.dart';
// import 'package:vingtun/ui/menu_screen.dart';
// import 'package:vingtun/widgets/appbar.dart';

// class NavigatorScreen extends StatefulWidget {
//   const NavigatorScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<NavigatorScreen> createState() => _NavigatorScreenState();
// }

// class _NavigatorScreenState extends State<NavigatorScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var keyAppBar = GlobalKey<NavigatorState>();
//     var keyMenu = GlobalKey<NavigatorState>();
//     return Column(
//       children: [
//         ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: 60),
//           child: Container(
//             child: Navigator(
//               key: keyAppBar,
//               onGenerateRoute: (routeSettings) {
//                 return MaterialPageRoute(
//                   builder: (context) => CustomAppBar(),
//                 );
//               },
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             height: 800,
//             child: Navigator(
//               key: keyMenu,
//               onGenerateRoute: (routeSettings) {
//                 return MaterialPageRoute(
//                   builder: (context) => MenuScreen(),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
