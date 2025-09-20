/// API configuration with placeholder URLs. Replace with your actual backend endpoints.
class ApiConfig {
  /// Base URL for the backend API (no trailing slash)
  static const String baseUrl = 'https://YOUR_API_BASE_URL';

  /// Endpoint path for creating a report (relative to baseUrl)
  /// e.g., '/api/reports' or '/reports'
  static const String createReportPath = '/YOUR_REPORTS_ENDPOINT';

  /// Optional: API key header name and value if needed
  static const String? apiKeyHeader = null; // e.g., 'x-api-key'
  static const String? apiKey = null; // e.g., 'abcdef123456'
}
