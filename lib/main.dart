import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyWebApp());
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Writely',
      debugShowCheckedModeBanner: false,
      home: const MyWebViewPage(),
    );
  }
}

class MyWebViewPage extends StatefulWidget {
  const MyWebViewPage({super.key});

  @override
  State<MyWebViewPage> createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => isLoading = false);
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://writelys.vercel.app/'),
      ); // 🔁 change URL here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(const MyWebApp());
// }

// class MyWebApp extends StatelessWidget {
//   const MyWebApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'WebView App',
//       debugShowCheckedModeBanner: false,
//       home: const MyWebViewPage(),
//     );
//   }
// }

// class MyWebViewPage extends StatefulWidget {
//   const MyWebViewPage({super.key});

//   @override
//   State<MyWebViewPage> createState() => _MyWebViewPageState();
// }

// class _MyWebViewPageState extends State<MyWebViewPage> {
//   late final WebViewController _controller;
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (_) {
//             setState(() => isLoading = false);
//           },
//           onWebResourceError: (WebResourceError error) {
//             setState(() {
//               isLoading = false;
//               errorMessage =
//                   "Error: ${error.description}\nCode: ${error.errorCode}";
//             });
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://writelys.vercel.app/'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             if (errorMessage == null)
//               WebViewWidget(controller: _controller)
//             else
//               Center(
//                 child: Text(
//                   errorMessage!,
//                   style: const TextStyle(color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             if (isLoading) const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }
