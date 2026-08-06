import 'package:crafty_bay/core/services/network_caller/network_caller.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
}
// UseCase
// getNetworkCaller().getRequest('https://jsonplaceholder.typicode.com/todos/1')