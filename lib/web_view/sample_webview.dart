// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
 <!doctype html>
<html>
    <head>
        <!-- 
            このHTMLはPDFに変換する前提で書いているため、書き方として最適でない書き方となっています。
            修正する際は、PDFに変換した結果も併せて確認するようにしてください。
            ※以下で確認
            xhtml2pdf -s templates/8/001_pledge_document.html 
         -->
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <style type="text/css">
            / xhtml2pdfでのデフォルトCSS /
            html {
                font-family: Helvetica;
                font-size: 10px;
                font-weight: normal;
                color: #000000;
                background-color: transparent;
                margin: 0;
                padding: 0;
                line-height: 150%;
                border: 1px none;
                display: inline;
                width: auto;
                height: auto;
                white-space: normal;
            }

            b,
            strong {
                font-weight: bold;
            }

            i,
            em {
                font-style: italic;
            }

            u {
                text-decoration: underline;
            }

            s,
            strike {
                text-decoration: line-through;
            }

            a {
                text-decoration: underline;
                color: blue;
            }

            ins {
                color: green;
                text-decoration: underline;
            }
            del {
                color: red;
                text-decoration: line-through;
            }

            pre,
            code,
            kbd,
            samp,
            tt {
                font-family: "Courier New";
            }

            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-weight:bold;
                -pdf-outline: true;
                -pdf-outline-open: false;
            }

            h1 {
                /*18px via YUI Fonts CSS foundation*/
                font-size:138.5%;
                -pdf-outline-level: 0;
            }

            h2 {
                /*16px via YUI Fonts CSS foundation*/
                font-size:123.1%;
                -pdf-outline-level: 1;
            }

            h3 {
                /*14px via YUI Fonts CSS foundation*/
                font-size:108%;
                -pdf-outline-level: 2;
            }

            h4 {
                -pdf-outline-level: 3;
            }

            h5 {
                -pdf-outline-level: 4;
            }

            h6 {
                -pdf-outline-level: 5;
            }

            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            p,
            pre,
            hr {
                margin:1em 0;
            }

            address,
            blockquote,
            body,
            center,
            dl,
            dir,
            div,
            fieldset,
            form,
            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            hr,
            isindex,
            menu,
            noframes,
            noscript,
            ol,
            p,
            pre,
            table,
            th,
            tr,
            td,
            ul,
            li,
            dd,
            dt,
            pdftoc {
                display: block;
            }

            table {
            }

            tr,
            th,
            td {
            
                vertical-align: middle;
                width: auto;
            }

            th {
                text-align: center;
                font-weight: bold;
            }

            center {
                text-align: center;
            }

            big {
                font-size: 125%;
            }

            small {
                font-size: 75%;
            }


            ul {
                margin-left: 1.5em;
                list-style-type: disc;
            }

            ul ul {
                list-style-type: circle;
            }

            ul ul ul {
                list-style-type: square;
            }

            ol {
                list-style-type: decimal;
                margin-left: 1.5em;
            }

            pre {
                white-space: pre;
            }

            blockquote {
                margin-left: 1.5em;
                margin-right: 1.5em;
            }

            noscript {
                display: none;
            }
        </style>
        <style type="text/css">
            @page {
                size: a4 portrait;
                @frame content_frame {
                    left: 30pt;
                    right: 30pt;
                    top: 15pt;
                    bottom: 10pt;
                }
            }
            html, body {
              font-family: HeiseiMin-W3;
                font-size: 15px;
                background-color: white;
                color: black;
            }
            body{
                width: 720px;
                margin: auto;
                margin-top: 15px;
                -pdf-word-wrap: CJK;
            }
            table{
                display: table;
            }
            tr{
                  line-height: 30px;
                  display: table-row;
            }
            td{
                display: table-cell;
            }
            ul{
                list-style-type: none;
                margin-top: 0px;
                margin-bottom: 0px;
            }
            ul ul {
                list-style-type: none;
            }
            .title{
                text-align: center;
            }
            .header_row{
                line-height: 25px;
            }
            .header_row_contents{
                width: 470px;
                overflow-wrap:normal
                
            }
            .contents_row_header{
                vertical-align: top;
                width: 15px;
            }
            .footer{
                width: 100%;
                table-layout:fixed; 

            }
            .footer_row{
                line-height: 25px;
            }
            .footer_row_margin{
                text-align: left;
            }
            .footer_row_header{
                text-align: left;
                vertical-align: top;
                width:80px;
                white-space:nowrap;
            }
            .footer_row_value{
                text-align: left;
                width: 380px;
            }
        </style>
    </head>
    <body>
    <table width="100%">
            <tr class="header_row"><td class="header_row_contents">8_name　9_name</td><td style="vertical-align: top;text-align: right;" >2023年03月13日</td></tr>
            <tr class="header_row"><td class="header_row_contents">ブライセンミャンマー確認用現場あ</td><td></td></tr>
            <tr class="header_row"><td class="header_row_contents">ミャンマー所長　所長　殿<td></td></tr>
        </table>
        <p class="title">作業員用スマートフォン利用申請書（兼　誓約書）</p>
        <p>貴社から貸与されたスマートフォン（以下、貸与機器）の利用にあたり、必要事項の申請と以下注意事項へ誓約いたします。</p>
        <p>
            <table >
                <tr><td class="contents_row_header">■</td>
                    <td>貸与機器情報
                        <ul>
                            <li >電話番号　070-5404-5389</li>
                        </ul>
                    </td>
                </tr>
                <tr><td class="contents_row_header">■</td>
                    <td>貸与機器の利用時に以下の対応をします。
                        <ul>
                            <li>・パスコードは他人に教えない</li>
                            <li>・機器を改造しない</li>
                            <li>・OSのアップデートなど指示を受けた場合は、速やかに対応します。</li>
                        </ul>
                    </td>
                </tr>
                <tr><td class="contents_row_header">■</td><td>貸与機器は常に肌身離さず持ち歩き、紛失、盗難、破損等がないよう十分に注意します。また、場内では機器の落下防止措置を講じます。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貴社の許可なく、貸与された現場外に貸与機器を持ち出しません。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貴社が貸与機器の位置情報を取得することに同意します。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貸与機器の利用は現場業務に限るものとし、私的利用は行ないません。また、撮影や録音した写真・動画等、貸与機器に入力・表示したデータは業務情報として扱い、貴社の許可なくインターネット上のサービスへの投稿、第三者への転送及び他のデバイス等への保存をいたしません。</td></tr>
                <tr><td class="contents_row_header">■</td><td>情報漏洩の調査等で貴社が必要と認めた場合は、貸与機器を提出し、当該機器内に記録されている、私的なものを含む一切のデータ(復元した削除データを含む)を貴社が閲覧・複写することに応じます。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貸与機器が紛失又は盗難に遭った際は、速やかに現場担当者に報告すると共に情報漏洩を未然に防ぐ措置を講じます。また、紛失時の状況と対処について、決められた形式で直ちに報告します。</td></tr>
                <tr><td class="contents_row_header"></td><td>※意図的な紛失時には所属会社に対して弁済を求める場合があります。</td></tr>
                <tr><td class="contents_row_header">■</td><td>当現場の業務を終了する際には、貸与機器を返却いたします。</td></tr>
            </table>
        </p>

        
        <table class="footer">
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">一次会社名</td><td class="footer_row_value">BrcMM</td></tr>
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">所属会社名</td><td class="footer_row_value">BrcMM</buildee_worker_name_kana></td></tr>
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">(フリガナ)</td><td class="footer_row_value">サギョウイン メイ</buildee_worker_name></td></tr>
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">申請者   </td><td class="footer_row_value">作業員 May</td></tr>
        </table>
    </body>
</html>
''';

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
            PlatformWebViewControllerCreationParams());
    // #enddocregion platform_features

    /*    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse('https://flutter.dev')); */

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features
    controller.loadHtmlString(kTransparentBackgroundPage);
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          // NavigationControls(webViewController: _controller),
          SampleMenu(webViewController: _controller),
        ],
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 2,
              child: WebViewWidget(controller: _controller)),
        ],
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      onPressed: () async {
        final String? url = await _controller.currentUrl();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Favorited $url')),
          );
        }
      },
      child: const Icon(Icons.favorite),
    );
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,
  loadLocalFile,
  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
}

class SampleMenu extends StatelessWidget {
  SampleMenu({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.showUserAgent:
            _onShowUserAgent();
            break;
          case MenuOptions.listCookies:
            _onListCookies(context);
            break;
          case MenuOptions.clearCookies:
            _onClearCookies(context);
            break;
          case MenuOptions.addToCache:
            _onAddToCache(context);
            break;
          case MenuOptions.listCache:
            _onListCache();
            break;
          case MenuOptions.clearCache:
            _onClearCache(context);
            break;
          case MenuOptions.navigationDelegate:
            _onNavigationDelegateExample();
            break;
          case MenuOptions.doPostRequest:
            _onDoPostRequest();
            break;
          case MenuOptions.loadLocalFile:
            _onLoadLocalFileExample();
            break;
          case MenuOptions.loadFlutterAsset:
            _onLoadFlutterAssetExample();
            break;
          case MenuOptions.loadHtmlString:
            _onLoadHtmlStringExample();
            break;
          case MenuOptions.transparentBackground:
            _onTransparentBackground();
            break;
          case MenuOptions.setCookie:
            _onSetCookie();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.showUserAgent,
          child: Text('Show user agent'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCookies,
          child: Text('List cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.addToCache,
          child: Text('Add to cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCache,
          child: Text('List cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCache,
          child: Text('Clear cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.navigationDelegate,
          child: Text('Navigation Delegate example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.doPostRequest,
          child: Text('Post Request'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadHtmlString,
          child: Text('Load HTML string'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadLocalFile,
          child: Text('Load local file'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadFlutterAsset,
          child: Text('Load Flutter Asset'),
        ),
        const PopupMenuItem<MenuOptions>(
          key: ValueKey<String>('ShowTransparentBackgroundExample'),
          value: MenuOptions.transparentBackground,
          child: Text('Transparent background example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.setCookie,
          child: Text('Set cookie'),
        ),
      ],
    );
  }

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return webViewController.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  Future<void> _onListCookies(BuildContext context) async {
    final String cookies = await webViewController
        .runJavaScriptReturningResult('document.cookie') as String;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Cookies:'),
            _getCookieList(cookies),
          ],
        ),
      ));
    }
  }

  Future<void> _onAddToCache(BuildContext context) async {
    await webViewController.runJavaScript(
      'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";',
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added a test entry to cache.'),
      ));
    }
  }

  Future<void> _onListCache() {
    return webViewController.runJavaScript('caches.keys()'
        // ignore: missing_whitespace_between_adjacent_strings
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  Future<void> _onClearCache(BuildContext context) async {
    await webViewController.clearCache();
    await webViewController.clearLocalStorage();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cache cleared.'),
      ));
    }
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  Future<void> _onNavigationDelegateExample() {
    final String contentBase64 = base64Encode(
      const Utf8Encoder().convert(kNavigationExamplePage),
    );
    return webViewController.loadRequest(
      Uri.parse('data:text/html;base64,$contentBase64'),
    );
  }

  Future<void> _onSetCookie() async {
    await cookieManager.setCookie(
      const WebViewCookie(
        name: 'foo',
        value: 'bar',
        domain: 'httpbin.org',
        path: '/anything',
      ),
    );
    await webViewController.loadRequest(Uri.parse(
      'https://httpbin.org/anything',
    ));
  }

  Future<void> _onDoPostRequest() {
    return webViewController.loadRequest(
      Uri.parse('https://httpbin.org/post'),
      method: LoadRequestMethod.post,
      headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
  }

  Future<void> _onLoadLocalFileExample() async {
    final String pathToIndex = await _prepareLocalFile();
    await webViewController.loadFile(pathToIndex);
  }

  Future<void> _onLoadFlutterAssetExample() {
    return webViewController.loadFlutterAsset('assets/www/index.html');
  }

  Future<void> _onLoadHtmlStringExample() {
    return webViewController.loadHtmlString(kLocalExamplePage);
  }

  Future<void> _onTransparentBackground() {
    return webViewController.loadHtmlString(kTransparentBackgroundPage);
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }

  static Future<String> _prepareLocalFile() async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File(
        <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

    await indexFile.create(recursive: true);
    await indexFile.writeAsString(kLocalExamplePage);

    return indexFile.path;
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
