import 'package:bloc/bloc.dart';

enum CounterEvent { increment }

const delay = Duration(milliseconds: 30);

Future<void> wait() => Future.delayed(delay);
Future<void> tick() => Future.delayed(Duration.zero);

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(EventTransformer<CounterEvent> transformer) : super(0) {
    on<CounterEvent>(
      (event, emit) {
        onCalls.add(event);
        return Future<void>.delayed(delay, () {
          if (emit.isDone) return;
          onEmitCalls.add(event);
          emit(state + 1);
        });
      },
      transformer: transformer,
    );
  }

  final onCalls = <CounterEvent>[];
  final onEmitCalls = <CounterEvent>[];
}
