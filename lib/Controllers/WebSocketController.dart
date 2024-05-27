import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel channel;
  var time = ''.obs;

  @override
  void onInit() {
    super.onInit();
    connect();
  }

  void connect() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://time.rezultroy.workers.dev'),
    );
    channel.stream.listen((data) {
      time.value = data;
    });
  }

  void disconnect() {
    Get.snackbar("Koneksi", "Sedang Disconect",duration: const Duration(milliseconds: 500));
    time.value = "disconnect";
    channel.sink.close();
  }

  // reconnect
  void reconnect() {
    disconnect();
    Get.snackbar("Koneksi", "Sedang Reconnect",duration: const Duration(milliseconds: 500));
    connect();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
