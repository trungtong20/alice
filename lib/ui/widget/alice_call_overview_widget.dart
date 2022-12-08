import 'package:alice/model/alice_http_call.dart';
import 'package:alice/ui/widget/alice_base_call_details_widget.dart';
import 'package:flutter/material.dart';

import 'alice_call_request_widget.dart';
import 'alice_call_response_widget.dart';

class AliceCallOverviewWidget extends StatefulWidget {
  final AliceHttpCall call;

  const AliceCallOverviewWidget(this.call);

  @override
  State<StatefulWidget> createState() {
    return _AliceCallOverviewWidget();
  }
}

class _AliceCallOverviewWidget
    extends AliceBaseCallDetailsWidgetState<AliceCallOverviewWidget> {
  AliceHttpCall get _call => widget.call;
  bool isShowOverview = false;
  bool isShowRequest = false;
  bool isShowResponse = false;
  Widget _header(
      {required String title,
      required Widget icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];
    rows.add(getListRow("Method: ", _call.method));
    rows.add(getListRow("Server: ", _call.server));
    rows.add(getListRow("Endpoint: ", _call.endpoint));
    rows.add(getListRow("Started:", _call.request!.time.toString()));
    rows.add(getListRow("Finished:", _call.response!.time.toString()));
    rows.add(getListRow("Duration:", formatDuration(_call.duration)));
    rows.add(getListRow("Bytes sent:", formatBytes(_call.request!.size)));
    rows.add(getListRow("Bytes received:", formatBytes(_call.response!.size)));
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(
                title: "Overview",
                icon: Icon(Icons.info_outline),
                onTap: (() {
                  setState(() {
                    isShowOverview = !isShowOverview;
                  });
                })),
            isShowOverview
                ? ListView(shrinkWrap: true, children: rows)
                : const SizedBox(),
            _header(
                title: "Request",
                icon: Icon(Icons.arrow_upward),
                onTap: (() {
                  setState(() {
                    isShowRequest = !isShowRequest;
                  });
                })),
            isShowRequest
                ? AliceCallRequestWidget(
                    widget.call,
                    isWrap: true,
                  )
                : const SizedBox(),
            _header(
                title: "Response",
                icon: Icon(Icons.arrow_downward),
                onTap: (() {
                  setState(() {
                    isShowResponse = !isShowResponse;
                  });
                })),
            isShowResponse
                ? AliceCallResponseWidget(
                    widget.call,
                    isWrap: true,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
