# CardTrader API

A Dart client library for the [CardTrader API](https://www.cardtrader.com/en/docs/api).

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  cardtrader_api: ^0.1.0
```

Then run:

```bash
dart pub get
```

## Authentication

Obtain an API key from CardTrader. The key must be provided when creating a client instance.

## Usage

### Basic Setup

```dart
import 'package:cardtrader_api/cardtrader_api.dart';

void main() async {
  final client = CardTraderClient(apiKey: 'your_api_key_here');

  try {
    // Use the client
    final info = await client.getInfo();
    print('App: ${info.name}');
  } finally {
    // Always close the client when done
    client.close();
  }
}
```

### Testing Authentication

Use the `getInfo()` method to verify your API key and retrieve application details:

```dart
final info = await client.getInfo();
print('App ID: ${info.id}');
print('App Name: ${info.name}');
print('User ID: ${info.userId}');
```

### Error Handling

API errors are thrown as `CardTraderException` instances:

```dart
try {
  final info = await client.getInfo();
} on CardTraderException catch (e) {
  print('Error ${e.statusCode}: ${e.errorCode}');
  print('Message: ${e.extra.message}');
  print('Request ID: ${e.requestId}');
}
```

### Custom HTTP Client

Provide your own HTTP client for testing or custom configuration:

```dart
import 'package:http/http.dart' as http;

final httpClient = http.Client();
final client = CardTraderClient(
  apiKey: 'your_api_key_here',
  httpClient: httpClient,
);
```

## Resource Management

Always call `close()` when you're done with the client to free resources:

```dart
final client = CardTraderClient(apiKey: apiKey);
try {
  // Use the client
} finally {
  client.close();
}
```

After calling `close()`, any further requests will throw an exception.

## API Documentation

For complete API documentation, visit the [CardTrader API documentation](https://www.cardtrader.com/en/docs/api).

## Known Limitations

- **Shipping Methods** (`GET /shipping_methods`): This endpoint is currently not available — the CardTrader API returns `404 Not Found`. It will be implemented once the endpoint becomes functional.

## License

See the [LICENSE](LICENSE) file for details.

## Additional Information

This library is not official and is not affiliated with CardTrader.
