import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DepositWebView extends StatefulWidget {
  final dynamic authorizationUrl;

  const DepositWebView({super.key, required this.authorizationUrl});

  @override
  _DepositWebViewState createState() => _DepositWebViewState();
}

class _DepositWebViewState extends State<DepositWebView> {
  late InAppWebViewController _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.authorizationUrl),
                ),
                onLoadStop: (controller, url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
