import 'package:Sample/widgets/darkcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class chartpage extends StatefulWidget {
  const chartpage({Key key}) : super(key: key);

  @override
  State<chartpage> createState() => _chartpageState();
}

class _chartpageState extends State<chartpage> {
  
  //Add flutter_inappwebview Package
  // flutter_webview_plugin: ^0.3.11

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkColor.app_background,
      child:   Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 100.0,bottom: 100.0),
        child: Container(
          child: InAppWebView(
            key: webViewKey,
            gestureRecognizers: Set()
              ..add(Factory<HorizontalDragGestureRecognizer>(()=> HorizontalDragGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(()=> VerticalDragGestureRecognizer())),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(transparentBackground: true,supportZoom: true,
                javaScriptEnabled: true,preferredContentMode: UserPreferredContentMode.MOBILE,),
              android: AndroidInAppWebViewOptions(
                networkAvailable: true,
                loadWithOverviewMode: true,
                // useHybridComposition: true,
                useWideViewPort: false,
              ),
              ios: IOSInAppWebViewOptions(
                //   useOnNavigationResponse: true,
                enableViewportScale: false,
              ),
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            //data is in Script form
            //Script Widget from Trading view web
            initialData: InAppWebViewInitialData(
                data:
                """
                                         <!-- TradingView Widget BEGIN -->
                            <div class="tradingview-widget-container">
                              <div id="tradingview_34551"></div>
                              <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/BTCUSDT/?exchange=BINANCE" rel="noopener" target="_blank"><span class="blue-text">BTCUSDT Chart</span></a> by TradingView</div>
                              <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
                              <script type="text/javascript">
                              new TradingView.widget(
                              {
                              "autosize": true,
                              
                              "symbol": "BINANCE:BTCUSD",
                              "interval": "D",
                              "timezone": "Etc/UTC",
                              "theme": "dark",
                              "style": "1",
                              "locale": "en",
                              "toolbar_bg": "#f1f3f6",
                              "enable_publishing": false,
                              "hide_side_toolbar": false,
                              "allow_symbol_change": true,
                              "studies": [
                                "Volume@tv-basicstudies"
                              ],
                              "container_id": "tradingview_34551"
                            }
                              );
                              </script>
                            </div>
                            <!-- TradingView Widget END -->
                          """
            ),
          ),
        ),
      ),
    );
  }
}
