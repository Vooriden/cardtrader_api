import 'package:cardtrader_api/src/models/job.dart';
import 'package:test/test.dart';

void main() {
  group('JobStats', () {
    final json = {'ok': 2, 'warning': 1, 'error': 0};

    group('fromJson', () {
      test('parses JSON correctly', () {
        final stats = JobStats.fromJson(json);

        expect(
          stats,
          isA<JobStats>()
              .having((s) => s.ok, 'ok', 2)
              .having((s) => s.warning, 'warning', 1)
              .having((s) => s.error, 'error', 0),
        );
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final stats = JobStats.fromJson(json);
        final jsonOutput = stats.toJson();

        expect(jsonOutput, {'ok': 2, 'warning': 1, 'error': 0});
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final stats = JobStats(ok: 5, warning: 2, error: 1);

        expect(stats.ok, 5);
        expect(stats.warning, 2);
        expect(stats.error, 1);
      });
    });
  });

  group('JobResult', () {
    final json = {'result': 'ok', 'job_index': 0, 'product_id': 123456};

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final result = JobResult.fromJson(json);

        expect(
          result,
          isA<JobResult>()
              .having((r) => r.result, 'result', 'ok')
              .having((r) => r.jobIndex, 'jobIndex', 0)
              .having((r) => r.productId, 'productId', 123456),
        );
      });

      test('parses JSON with errors and warnings', () {
        final errorJson = {
          'result': 'error',
          'job_index': 1,
          'errors': {
            'price': ['must be greater than 0'],
          },
          'warnings': {
            'quantity': ['Quantity is high'],
          },
        };

        final result = JobResult.fromJson(errorJson);

        expect(result.result, 'error');
        expect(result.productId, isNull);
        expect(result.errors, {
          'price': ['must be greater than 0'],
        });
        expect(result.warnings, {
          'quantity': ['Quantity is high'],
        });
      });

      test('parses JSON with nullable fields missing', () {
        final minimalJson = {'result': 'ok', 'job_index': 0};

        final result = JobResult.fromJson(minimalJson);

        expect(result.productId, isNull);
        expect(result.errors, isNull);
        expect(result.warnings, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final result = JobResult.fromJson(json);
        final jsonOutput = result.toJson();

        expect(jsonOutput['result'], 'ok');
        expect(jsonOutput['job_index'], 0);
        expect(jsonOutput['product_id'], 123456);
      });
    });
  });

  group('Job', () {
    final json = {
      'uuid': '550e8400-e29b-41d4-a716-446655440000',
      'state': 'completed',
      'spawned_children': 3,
      'stats': {'ok': 2, 'warning': 1, 'error': 0},
      'results': [
        {'result': 'ok', 'job_index': 0, 'product_id': 123456},
        {'result': 'ok', 'job_index': 1, 'product_id': 123457},
        {
          'result': 'warning',
          'job_index': 2,
          'product_id': 123458,
          'warnings': {
            'price': ['Price is below market average'],
          },
        },
      ],
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final job = Job.fromJson(json);

        expect(
          job,
          isA<Job>()
              .having(
                (j) => j.uuid,
                'uuid',
                '550e8400-e29b-41d4-a716-446655440000',
              )
              .having((j) => j.state, 'state', 'completed')
              .having((j) => j.spawnedChildren, 'spawnedChildren', 3)
              .having((j) => j.stats.ok, 'stats.ok', 2)
              .having((j) => j.stats.warning, 'stats.warning', 1)
              .having((j) => j.stats.error, 'stats.error', 0)
              .having((j) => j.results.length, 'results.length', 3),
        );
      });

      test('parses results correctly', () {
        final job = Job.fromJson(json);

        expect(job.results[0].result, 'ok');
        expect(job.results[0].jobIndex, 0);
        expect(job.results[0].productId, 123456);

        expect(job.results[2].result, 'warning');
        expect(job.results[2].warnings, isNotNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final job = Job.fromJson(json);
        final jsonOutput = job.toJson();

        expect(jsonOutput['uuid'], '550e8400-e29b-41d4-a716-446655440000');
        expect(jsonOutput['state'], 'completed');
        expect(jsonOutput['spawned_children'], 3);
        expect(jsonOutput['stats'], isA<Map<String, dynamic>>());
        expect(jsonOutput['results'], isA<List>());
        expect((jsonOutput['results'] as List).length, 3);
      });
    });

    group('state getters', () {
      test('isCompleted returns true when state is completed', () {
        final job = Job.fromJson(json);
        expect(job.isCompleted, true);
        expect(job.isPending, false);
        expect(job.isRunning, false);
        expect(job.isUnprocessable, false);
      });

      test('isPending returns true when state is pending', () {
        final pendingJson = Map<String, dynamic>.from(json);
        pendingJson['state'] = 'pending';
        final job = Job.fromJson(pendingJson);

        expect(job.isPending, true);
        expect(job.isCompleted, false);
      });

      test('isRunning returns true when state is running', () {
        final runningJson = Map<String, dynamic>.from(json);
        runningJson['state'] = 'running';
        final job = Job.fromJson(runningJson);

        expect(job.isRunning, true);
        expect(job.isCompleted, false);
      });

      test('isUnprocessable returns true when state is unprocessable', () {
        final unprocessableJson = Map<String, dynamic>.from(json);
        unprocessableJson['state'] = 'unprocessable';
        final job = Job.fromJson(unprocessableJson);

        expect(job.isUnprocessable, true);
        expect(job.isCompleted, false);
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final job = Job(
          uuid: 'test-uuid',
          state: 'pending',
          spawnedChildren: 0,
          stats: JobStats(ok: 0, warning: 0, error: 0),
          results: [],
        );

        expect(job.uuid, 'test-uuid');
        expect(job.state, 'pending');
        expect(job.spawnedChildren, 0);
        expect(job.results, isEmpty);
      });
    });
  });
}
