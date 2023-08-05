import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InstaDisplay extends StatefulWidget {
  const InstaDisplay({super.key});

  @override
  State<InstaDisplay> createState() => _InstaDisplayState();
}

class _InstaDisplayState extends State<InstaDisplay> {
  String? accessToken;
  List<dynamic> posts = [];
  bool isLoading = false;
  var par;

  // 'https://api.instagram.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=user_profile';

  // 'https://graph.instagram.com/me/media?fields=id,caption,media_type,media_url,permalink&access_token=$accessToken';

  authenticate() async {
    FlutterAppAuth appAuth = const FlutterAppAuth();
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        '222706187335930',
        'https://com.marvelse.onlybarter/',
        scopes: ['user_profile'],
        serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint:
                'https://api.instagram.com/oauth/authorize?response_type=code',
            tokenEndpoint: 'https://api.instagram.com/oauth/access_token'),
      ),
    );

    if (result != null) {
      print(result.accessToken);
    }
  }

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(par.toString())
        // isLoading
        //     ? const Center(child: CircularProgressIndicator())
        // : ListView.builder(
        //     itemCount: posts.length,
        //     itemBuilder: (context, index) {
        //       final post = posts[index];
        //       return InstagramPost(
        //         imageUrl: post['media_url'],
        //         caption: post['caption'],
        //       );
        //     },
        //   ),
        );
  }
}

class InstagramPost extends StatelessWidget {
  final String imageUrl;
  final String caption;

  const InstagramPost({required this.imageUrl, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imageUrl),
        Text(caption),
        const SizedBox(height: 20),
      ],
    );
  }
}
